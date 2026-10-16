-- ZZ-01: podpora žákovských ABCD testů.
-- Tato migrace už byla aplikována do produkčního Supabase projektu.

alter table public.student_learning_challenges
  add column if not exists challenge_type text not null default 'text',
  add column if not exists options jsonb not null default '[]'::jsonb;

alter table public.student_learning_challenges
  drop constraint if exists student_learning_challenges_type_check;
alter table public.student_learning_challenges
  add constraint student_learning_challenges_type_check
  check (challenge_type in ('text','abcd'));

-- Studentovi vrací možnosti A-D, správnou odpověď až po odevzdání pokusu.
drop function if exists public.student_game_challenges(text);
create function public.student_game_challenges(p_session_token text)
returns table(
  challenge_id uuid,
  title text,
  prompt text,
  reward_points integer,
  teacher_name text,
  class_name text,
  attempted boolean,
  correct boolean,
  points_awarded integer,
  active boolean,
  challenge_type text,
  options jsonb,
  correct_answer text
)
language sql
stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  with me as (select * from private.student_from_session(p_session_token))
  select
    ch.id,
    ch.title,
    ch.prompt,
    ch.reward_points,
    coalesce(nullif(p.nickname,''),nullif(p.display_name,''),'Učitel') as teacher_name,
    c.display_name as class_name,
    (a.challenge_id is not null) as attempted,
    coalesce(a.correct,false) as correct,
    coalesce(a.points_awarded,0) as points_awarded,
    ch.active,
    ch.challenge_type,
    ch.options,
    case when a.challenge_id is not null then ch.answer else null end as correct_answer
  from me
  join public.student_learning_challenges ch
    on ch.school_id=me.school_id
   and ch.active=true
   and ch.available_from<=now()
   and (ch.available_until is null or ch.available_until>now())
  left join public.profiles p on p.id=ch.created_by
  left join public.school_classes c on c.id=ch.class_id
  left join public.student_challenge_attempts a
    on a.challenge_id=ch.id and a.student_id=me.student_id
  where ch.class_id is null
     or exists(
       select 1 from public.class_enrollments ce
       where ce.school_id=me.school_id
         and ce.class_id=ch.class_id
         and ce.student_id=me.student_id
         and ce.active=true
     )
  order by ch.created_at desc;
$function$;

create or replace function public.student_submit_learning_challenge(
  p_session_token text,
  p_challenge_id uuid,
  p_answer text
)
returns table(correct boolean, points_awarded integer, available_points integer)
language plpgsql
security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
declare
  v_student_id uuid;
  v_school_id uuid;
  v_ch public.student_learning_challenges%rowtype;
  v_correct boolean;
  v_awarded integer:=0;
  v_available integer:=0;
  v_answer text:=trim(coalesce(p_answer,''));
begin
  select m.student_id,m.school_id into v_student_id,v_school_id
  from private.student_from_session(p_session_token) m;
  if v_student_id is null then raise exception 'student_session_missing'; end if;

  select * into v_ch
  from public.student_learning_challenges ch
  where ch.id=p_challenge_id and ch.school_id=v_school_id
  for update;

  if v_ch.id is null or not v_ch.active or v_ch.available_from>now()
     or (v_ch.available_until is not null and v_ch.available_until<=now()) then
    raise exception 'challenge_not_available';
  end if;

  if v_ch.class_id is not null and not exists(
    select 1 from public.class_enrollments ce
    where ce.school_id=v_school_id and ce.class_id=v_ch.class_id
      and ce.student_id=v_student_id and ce.active=true
  ) then
    raise exception 'challenge_not_available';
  end if;

  if exists(
    select 1 from public.student_challenge_attempts a
    where a.challenge_id=p_challenge_id and a.student_id=v_student_id
  ) then
    raise exception 'challenge_already_attempted';
  end if;

  if v_ch.challenge_type='abcd' then
    if upper(v_answer) not in ('A','B','C','D') then
      raise exception 'challenge_answer_invalid';
    end if;
    v_correct := upper(v_answer)=upper(trim(v_ch.answer));
  else
    v_correct :=
      lower(regexp_replace(v_answer,'[[:space:]]+',' ','g'))
      =
      lower(regexp_replace(trim(coalesce(v_ch.answer,'')),'[[:space:]]+',' ','g'));
  end if;

  if v_correct then v_awarded:=v_ch.reward_points; end if;

  insert into public.student_challenge_attempts(
    challenge_id,school_id,student_id,answer,correct,points_awarded
  ) values(
    v_ch.id,v_school_id,v_student_id,v_answer,v_correct,v_awarded
  );

  if v_awarded>0 then
    insert into public.student_game_wallets(
      student_id,school_id,available_points,score_points,earned_total,spent_total,updated_at
    ) values(
      v_student_id,v_school_id,v_awarded,0,v_awarded,0,now()
    )
    on conflict(student_id) do update set
      available_points=public.student_game_wallets.available_points+excluded.available_points,
      earned_total=public.student_game_wallets.earned_total+excluded.earned_total,
      updated_at=now();
  end if;

  select coalesce(w.available_points,0) into v_available
  from public.student_game_wallets w where w.student_id=v_student_id;

  return query select v_correct,v_awarded,coalesce(v_available,0);
end;
$function$;

drop function if exists public.teacher_student_challenges(uuid);
create function public.teacher_student_challenges(p_school_id uuid)
returns table(
  challenge_id uuid,
  title text,
  prompt text,
  answer text,
  reward_points integer,
  class_id uuid,
  class_name text,
  active boolean,
  attempts integer,
  correct_answers integer,
  created_at timestamptz,
  challenge_type text,
  options jsonb
)
language sql
stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  select
    ch.id,ch.title,ch.prompt,ch.answer,ch.reward_points,ch.class_id,c.display_name,ch.active,
    count(a.student_id)::integer,
    count(a.student_id) filter(where a.correct)::integer,
    ch.created_at,
    ch.challenge_type,
    ch.options
  from public.student_learning_challenges ch
  left join public.school_classes c on c.id=ch.class_id
  left join public.student_challenge_attempts a on a.challenge_id=ch.id
  where ch.school_id=p_school_id
    and private.is_school_member(p_school_id)
    and (ch.created_by=auth.uid() or private.is_school_admin(p_school_id))
  group by ch.id,c.display_name
  order by ch.created_at desc;
$function$;

create or replace function public.create_student_learning_quiz(
  p_school_id uuid,
  p_title text,
  p_prompt text,
  p_options jsonb,
  p_correct_option text,
  p_reward_points integer,
  p_class_id uuid default null
)
returns table(challenge_id uuid)
language plpgsql
security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
declare
  v_id uuid;
  v_correct text:=upper(trim(coalesce(p_correct_option,'')));
begin
  if not private.is_school_member(p_school_id) then raise exception 'school_access_denied'; end if;
  if char_length(trim(coalesce(p_title,'')))<3 then raise exception 'challenge_title_invalid'; end if;
  if char_length(trim(coalesce(p_prompt,'')))<3 then raise exception 'challenge_prompt_invalid'; end if;
  if p_reward_points is null or p_reward_points<1 or p_reward_points>20 then raise exception 'challenge_reward_invalid'; end if;
  if v_correct not in ('A','B','C','D') then raise exception 'challenge_correct_option_invalid'; end if;
  if jsonb_typeof(p_options)<>'array' or jsonb_array_length(p_options)<>4 then raise exception 'challenge_options_invalid'; end if;
  if exists(
    select 1 from jsonb_array_elements_text(p_options) x(value)
    where char_length(trim(value))<1 or char_length(trim(value))>200
  ) then raise exception 'challenge_options_invalid'; end if;

  if p_class_id is not null then
    if not exists(
      select 1 from public.school_classes c
      where c.id=p_class_id and c.school_id=p_school_id and c.active=true
    ) then raise exception 'challenge_class_invalid'; end if;

    if not private.is_school_admin(p_school_id) and not exists(
      select 1 from public.teacher_class_assignments tca
      where tca.school_id=p_school_id and tca.class_id=p_class_id and tca.teacher_id=auth.uid()
    ) then raise exception 'challenge_class_not_assigned'; end if;
  end if;

  insert into public.student_learning_challenges(
    school_id,created_by,class_id,title,prompt,answer,reward_points,challenge_type,options
  ) values(
    p_school_id,auth.uid(),p_class_id,trim(p_title),trim(p_prompt),v_correct,p_reward_points,'abcd',p_options
  )
  returning id into v_id;

  return query select v_id;
end;
$function$;

revoke all on function public.student_game_challenges(text) from public;
grant execute on function public.student_game_challenges(text) to anon,authenticated;
revoke all on function public.teacher_student_challenges(uuid) from public;
grant execute on function public.teacher_student_challenges(uuid) to authenticated;
revoke all on function public.create_student_learning_quiz(uuid,text,text,jsonb,text,integer,uuid) from public;
grant execute on function public.create_student_learning_quiz(uuid,text,text,jsonb,text,integer,uuid) to authenticated;
