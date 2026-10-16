-- ZZ-01: žákovský herní scoring, výzvy a hodnocení učitelů
-- Produkční migrace byla aplikována 2026-10-16.

create table if not exists public.student_game_wallets (
  student_id uuid primary key,
  school_id uuid not null,
  available_points integer not null default 0 check (available_points >= 0),
  score_points integer not null default 0 check (score_points >= 0),
  earned_total integer not null default 0 check (earned_total >= 0),
  spent_total integer not null default 0 check (spent_total >= 0),
  updated_at timestamptz not null default now(),
  constraint student_game_wallets_student_school_fkey
    foreign key (student_id,school_id) references public.students(id,school_id) on delete cascade
);
alter table public.student_game_wallets enable row level security;

create table if not exists public.student_learning_challenges (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  created_by uuid not null references auth.users(id) on delete cascade,
  class_id uuid null references public.school_classes(id) on delete cascade,
  title text not null check (char_length(trim(title)) between 3 and 80),
  prompt text not null check (char_length(trim(prompt)) between 3 and 1000),
  answer text not null check (char_length(trim(answer)) between 1 and 200),
  reward_points integer not null default 1 check (reward_points between 1 and 20),
  active boolean not null default true,
  available_from timestamptz not null default now(),
  available_until timestamptz null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists student_learning_challenges_school_active_idx
  on public.student_learning_challenges(school_id,active,created_at desc);
alter table public.student_learning_challenges enable row level security;

create table if not exists public.student_challenge_attempts (
  challenge_id uuid not null references public.student_learning_challenges(id) on delete cascade,
  school_id uuid not null references public.schools(id) on delete cascade,
  student_id uuid not null,
  answer text not null default '',
  correct boolean not null default false,
  points_awarded integer not null default 0 check (points_awarded >= 0),
  attempted_at timestamptz not null default now(),
  primary key (challenge_id,student_id),
  constraint student_challenge_attempts_student_school_fkey
    foreign key (student_id,school_id) references public.students(id,school_id) on delete cascade
);
create index if not exists student_challenge_attempts_student_idx
  on public.student_challenge_attempts(student_id,attempted_at desc);
alter table public.student_challenge_attempts enable row level security;

create table if not exists public.student_score_investments (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  student_id uuid not null,
  points integer not null check (points > 0),
  created_at timestamptz not null default now(),
  constraint student_score_investments_student_school_fkey
    foreign key (student_id,school_id) references public.students(id,school_id) on delete cascade
);
create index if not exists student_score_investments_student_idx
  on public.student_score_investments(student_id,created_at desc);
alter table public.student_score_investments enable row level security;

create table if not exists public.teacher_feedback_votes (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  student_id uuid not null,
  teacher_id uuid not null references auth.users(id) on delete cascade,
  value integer not null check (value in (-1,1)),
  cost_points integer not null default 1 check (cost_points > 0),
  period_key text not null,
  created_at timestamptz not null default now(),
  constraint teacher_feedback_votes_student_school_fkey
    foreign key (student_id,school_id) references public.students(id,school_id) on delete cascade,
  constraint teacher_feedback_votes_week_uidx unique(student_id,teacher_id,period_key)
);
create index if not exists teacher_feedback_votes_school_teacher_idx
  on public.teacher_feedback_votes(school_id,teacher_id,created_at desc);
alter table public.teacher_feedback_votes enable row level security;

create or replace function public.student_game_wallet(p_session_token text)
returns table(available_points integer,score_points integer,earned_total integer,spent_total integer)
language sql stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  with me as (select * from private.student_from_session(p_session_token))
  select coalesce(w.available_points,0),coalesce(w.score_points,0),coalesce(w.earned_total,0),coalesce(w.spent_total,0)
  from me left join public.student_game_wallets w on w.student_id=me.student_id and w.school_id=me.school_id;
$function$;

create or replace function public.student_game_scoreboard(p_session_token text)
returns table(scope_type text,scope_id uuid,scope_name text,rank_position integer,student_id uuid,student_name text,score_points integer,is_me boolean)
language sql stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  with me as (select * from private.student_from_session(p_session_token)),
  my_classes as (
    select ce.class_id,c.display_name from me
    join public.class_enrollments ce on ce.student_id=me.student_id and ce.school_id=me.school_id and ce.active=true
    join public.school_classes c on c.id=ce.class_id and c.school_id=ce.school_id and c.active=true
  ),
  school_ranked as (
    select 'school'::text,me.school_id,s.name,
      dense_rank() over(order by coalesce(w.score_points,0) desc)::integer,
      st.id,st.display_name,coalesce(w.score_points,0)::integer,(st.id=me.student_id)
    from me join public.schools s on s.id=me.school_id
    join public.students st on st.school_id=me.school_id and st.active=true
    left join public.student_game_wallets w on w.student_id=st.id and w.school_id=st.school_id
  ),
  class_ranked as (
    select 'class'::text,mc.class_id,mc.display_name,
      dense_rank() over(partition by mc.class_id order by coalesce(w.score_points,0) desc)::integer,
      st.id,st.display_name,coalesce(w.score_points,0)::integer,(st.id=me.student_id)
    from me join my_classes mc on true
    join public.class_enrollments ce on ce.class_id=mc.class_id and ce.school_id=me.school_id and ce.active=true
    join public.students st on st.id=ce.student_id and st.school_id=ce.school_id and st.active=true
    left join public.student_game_wallets w on w.student_id=st.id and w.school_id=st.school_id
  )
  select * from class_ranked union all select * from school_ranked
  order by scope_type,scope_name,rank_position,student_name;
$function$;

create or replace function public.student_game_challenges(p_session_token text)
returns table(challenge_id uuid,title text,prompt text,reward_points integer,teacher_name text,class_name text,attempted boolean,correct boolean,points_awarded integer,active boolean)
language sql stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  with me as (select * from private.student_from_session(p_session_token))
  select ch.id,ch.title,ch.prompt,ch.reward_points,
    coalesce(nullif(p.nickname,''),nullif(p.display_name,''),'Učitel'),c.display_name,
    (a.challenge_id is not null),coalesce(a.correct,false),coalesce(a.points_awarded,0),ch.active
  from me join public.student_learning_challenges ch
    on ch.school_id=me.school_id and ch.active=true and ch.available_from<=now() and (ch.available_until is null or ch.available_until>now())
  left join public.profiles p on p.id=ch.created_by
  left join public.school_classes c on c.id=ch.class_id
  left join public.student_challenge_attempts a on a.challenge_id=ch.id and a.student_id=me.student_id
  where ch.class_id is null or exists(
    select 1 from public.class_enrollments ce where ce.school_id=me.school_id and ce.class_id=ch.class_id and ce.student_id=me.student_id and ce.active=true
  )
  order by ch.created_at desc;
$function$;

create or replace function public.student_submit_learning_challenge(p_session_token text,p_challenge_id uuid,p_answer text)
returns table(correct boolean,points_awarded integer,available_points integer)
language plpgsql security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
declare
  v_student_id uuid; v_school_id uuid; v_ch public.student_learning_challenges%rowtype;
  v_correct boolean; v_awarded integer:=0; v_available integer:=0;
begin
  select m.student_id,m.school_id into v_student_id,v_school_id from private.student_from_session(p_session_token) m;
  if v_student_id is null then raise exception 'student_session_missing'; end if;
  select * into v_ch from public.student_learning_challenges ch where ch.id=p_challenge_id and ch.school_id=v_school_id for update;
  if v_ch.id is null or not v_ch.active or v_ch.available_from>now() or (v_ch.available_until is not null and v_ch.available_until<=now()) then raise exception 'challenge_not_available'; end if;
  if v_ch.class_id is not null and not exists(select 1 from public.class_enrollments ce where ce.school_id=v_school_id and ce.class_id=v_ch.class_id and ce.student_id=v_student_id and ce.active=true) then raise exception 'challenge_not_available'; end if;
  if exists(select 1 from public.student_challenge_attempts a where a.challenge_id=p_challenge_id and a.student_id=v_student_id) then raise exception 'challenge_already_attempted'; end if;
  v_correct:=lower(regexp_replace(trim(coalesce(p_answer,'')),'[[:space:]]+',' ','g'))=lower(regexp_replace(trim(coalesce(v_ch.answer,'')),'[[:space:]]+',' ','g'));
  if v_correct then v_awarded:=v_ch.reward_points; end if;
  insert into public.student_challenge_attempts(challenge_id,school_id,student_id,answer,correct,points_awarded)
  values(v_ch.id,v_school_id,v_student_id,trim(coalesce(p_answer,'')),v_correct,v_awarded);
  if v_awarded>0 then
    insert into public.student_game_wallets(student_id,school_id,available_points,score_points,earned_total,spent_total,updated_at)
    values(v_student_id,v_school_id,v_awarded,0,v_awarded,0,now())
    on conflict(student_id) do update set available_points=public.student_game_wallets.available_points+excluded.available_points,earned_total=public.student_game_wallets.earned_total+excluded.earned_total,updated_at=now();
  end if;
  select coalesce(w.available_points,0) into v_available from public.student_game_wallets w where w.student_id=v_student_id;
  return query select v_correct,v_awarded,coalesce(v_available,0);
end;
$function$;

create or replace function public.student_invest_game_score(p_session_token text,p_points integer)
returns table(available_points integer,score_points integer)
language plpgsql security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
declare v_student_id uuid; v_school_id uuid; v_available integer; v_score integer;
begin
  if p_points is null or p_points<=0 or p_points>999 then raise exception 'invalid_point_amount'; end if;
  select m.student_id,m.school_id into v_student_id,v_school_id from private.student_from_session(p_session_token) m;
  if v_student_id is null then raise exception 'student_session_missing'; end if;
  insert into public.student_game_wallets(student_id,school_id) values(v_student_id,v_school_id) on conflict(student_id) do nothing;
  select w.available_points,w.score_points into v_available,v_score from public.student_game_wallets w where w.student_id=v_student_id for update;
  if v_available<p_points then raise exception 'not_enough_game_points'; end if;
  update public.student_game_wallets set available_points=available_points-p_points,score_points=score_points+p_points,spent_total=spent_total+p_points,updated_at=now()
  where student_id=v_student_id returning student_game_wallets.available_points,student_game_wallets.score_points into v_available,v_score;
  insert into public.student_score_investments(school_id,student_id,points) values(v_school_id,v_student_id,p_points);
  return query select v_available,v_score;
end;
$function$;

create or replace function public.student_feedback_teachers(p_session_token text)
returns table(teacher_id uuid,teacher_name text,positive_votes integer,negative_votes integer,net_score integer,voted_this_period boolean)
language sql stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  with me as (select * from private.student_from_session(p_session_token)), allowed as (
    select distinct tca.teacher_id from me
    join public.class_enrollments ce on ce.student_id=me.student_id and ce.school_id=me.school_id and ce.active=true
    join public.teacher_class_assignments tca on tca.school_id=ce.school_id and tca.class_id=ce.class_id
    join public.school_memberships sm on sm.school_id=tca.school_id and sm.user_id=tca.teacher_id and sm.status='approved'
  )
  select a.teacher_id,coalesce(nullif(p.nickname,''),nullif(p.display_name,''),'Učitel'),
    count(v.id) filter(where v.value=1)::integer,count(v.id) filter(where v.value=-1)::integer,coalesce(sum(v.value),0)::integer,
    exists(select 1 from public.teacher_feedback_votes x join me m2 on x.school_id=m2.school_id where x.student_id=m2.student_id and x.teacher_id=a.teacher_id and x.period_key=to_char(now(),'IYYY-IW'))
  from allowed a left join public.profiles p on p.id=a.teacher_id join me on true
  left join public.teacher_feedback_votes v on v.school_id=me.school_id and v.teacher_id=a.teacher_id
  group by a.teacher_id,p.nickname,p.display_name order by teacher_name;
$function$;

create or replace function public.student_cast_teacher_feedback(p_session_token text,p_teacher_id uuid,p_value integer)
returns table(available_points integer,teacher_net_score integer)
language plpgsql security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
declare v_student_id uuid; v_school_id uuid; v_available integer; v_period text:=to_char(now(),'IYYY-IW'); v_net integer;
begin
  if p_value not in (-1,1) then raise exception 'invalid_teacher_feedback'; end if;
  select m.student_id,m.school_id into v_student_id,v_school_id from private.student_from_session(p_session_token) m;
  if v_student_id is null then raise exception 'student_session_missing'; end if;
  if not exists(select 1 from public.class_enrollments ce join public.teacher_class_assignments tca on tca.school_id=ce.school_id and tca.class_id=ce.class_id join public.school_memberships sm on sm.school_id=tca.school_id and sm.user_id=tca.teacher_id and sm.status='approved' where ce.school_id=v_school_id and ce.student_id=v_student_id and ce.active=true and tca.teacher_id=p_teacher_id) then raise exception 'teacher_feedback_not_allowed'; end if;
  if exists(select 1 from public.teacher_feedback_votes v where v.student_id=v_student_id and v.teacher_id=p_teacher_id and v.period_key=v_period) then raise exception 'teacher_feedback_already_voted'; end if;
  insert into public.student_game_wallets(student_id,school_id) values(v_student_id,v_school_id) on conflict(student_id) do nothing;
  select w.available_points into v_available from public.student_game_wallets w where w.student_id=v_student_id for update;
  if coalesce(v_available,0)<1 then raise exception 'not_enough_game_points'; end if;
  update public.student_game_wallets set available_points=available_points-1,spent_total=spent_total+1,updated_at=now() where student_id=v_student_id returning student_game_wallets.available_points into v_available;
  insert into public.teacher_feedback_votes(school_id,student_id,teacher_id,value,cost_points,period_key) values(v_school_id,v_student_id,p_teacher_id,p_value,1,v_period);
  select coalesce(sum(v.value),0)::integer into v_net from public.teacher_feedback_votes v where v.school_id=v_school_id and v.teacher_id=p_teacher_id;
  return query select v_available,coalesce(v_net,0);
end;
$function$;

create or replace function public.school_teacher_feedback_scores(p_school_id uuid)
returns table(teacher_id uuid,teacher_name text,positive_votes integer,negative_votes integer,net_score integer,total_votes integer)
language sql stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  select sm.user_id,coalesce(nullif(p.nickname,''),nullif(p.display_name,''),'Učitel'),
    count(v.id) filter(where v.value=1)::integer,count(v.id) filter(where v.value=-1)::integer,coalesce(sum(v.value),0)::integer,count(v.id)::integer
  from public.school_memberships sm left join public.profiles p on p.id=sm.user_id
  left join public.teacher_feedback_votes v on v.school_id=sm.school_id and v.teacher_id=sm.user_id
  where sm.school_id=p_school_id and sm.status='approved' and private.is_school_member(p_school_id)
  group by sm.user_id,p.nickname,p.display_name order by teacher_name;
$function$;

create or replace function public.teacher_student_challenges(p_school_id uuid)
returns table(challenge_id uuid,title text,prompt text,answer text,reward_points integer,class_id uuid,class_name text,active boolean,attempts integer,correct_answers integer,created_at timestamptz)
language sql stable security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
  select ch.id,ch.title,ch.prompt,ch.answer,ch.reward_points,ch.class_id,c.display_name,ch.active,
    count(a.student_id)::integer,count(a.student_id) filter(where a.correct)::integer,ch.created_at
  from public.student_learning_challenges ch left join public.school_classes c on c.id=ch.class_id
  left join public.student_challenge_attempts a on a.challenge_id=ch.id
  where ch.school_id=p_school_id and private.is_school_member(p_school_id) and (ch.created_by=auth.uid() or private.is_school_admin(p_school_id))
  group by ch.id,c.display_name order by ch.created_at desc;
$function$;

create or replace function public.create_student_learning_challenge(p_school_id uuid,p_title text,p_prompt text,p_answer text,p_reward_points integer,p_class_id uuid default null)
returns table(challenge_id uuid)
language plpgsql security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
declare v_id uuid;
begin
  if not private.is_school_member(p_school_id) then raise exception 'school_access_denied'; end if;
  if char_length(trim(coalesce(p_title,'')))<3 then raise exception 'challenge_title_invalid'; end if;
  if char_length(trim(coalesce(p_prompt,'')))<3 then raise exception 'challenge_prompt_invalid'; end if;
  if char_length(trim(coalesce(p_answer,'')))<1 then raise exception 'challenge_answer_invalid'; end if;
  if p_reward_points is null or p_reward_points<1 or p_reward_points>20 then raise exception 'challenge_reward_invalid'; end if;
  if p_class_id is not null then
    if not exists(select 1 from public.school_classes c where c.id=p_class_id and c.school_id=p_school_id and c.active=true) then raise exception 'challenge_class_invalid'; end if;
    if not private.is_school_admin(p_school_id) and not exists(select 1 from public.teacher_class_assignments tca where tca.school_id=p_school_id and tca.class_id=p_class_id and tca.teacher_id=auth.uid()) then raise exception 'challenge_class_not_assigned'; end if;
  end if;
  insert into public.student_learning_challenges(school_id,created_by,class_id,title,prompt,answer,reward_points)
  values(p_school_id,auth.uid(),p_class_id,trim(p_title),trim(p_prompt),trim(p_answer),p_reward_points) returning id into v_id;
  return query select v_id;
end;
$function$;

create or replace function public.set_student_learning_challenge_active(p_school_id uuid,p_challenge_id uuid,p_active boolean)
returns boolean
language plpgsql security definer
set search_path to 'public','private','extensions','pg_temp'
as $function$
begin
  if not private.is_school_member(p_school_id) then raise exception 'school_access_denied'; end if;
  update public.student_learning_challenges ch set active=coalesce(p_active,false),updated_at=now()
  where ch.id=p_challenge_id and ch.school_id=p_school_id and (ch.created_by=auth.uid() or private.is_school_admin(p_school_id));
  if not found then raise exception 'challenge_access_denied'; end if;
  return true;
end;
$function$;

revoke all on function public.student_game_wallet(text) from public;
revoke all on function public.student_game_scoreboard(text) from public;
revoke all on function public.student_game_challenges(text) from public;
revoke all on function public.student_submit_learning_challenge(text,uuid,text) from public;
revoke all on function public.student_invest_game_score(text,integer) from public;
revoke all on function public.student_feedback_teachers(text) from public;
revoke all on function public.student_cast_teacher_feedback(text,uuid,integer) from public;
grant execute on function public.student_game_wallet(text) to anon,authenticated;
grant execute on function public.student_game_scoreboard(text) to anon,authenticated;
grant execute on function public.student_game_challenges(text) to anon,authenticated;
grant execute on function public.student_submit_learning_challenge(text,uuid,text) to anon,authenticated;
grant execute on function public.student_invest_game_score(text,integer) to anon,authenticated;
grant execute on function public.student_feedback_teachers(text) to anon,authenticated;
grant execute on function public.student_cast_teacher_feedback(text,uuid,integer) to anon,authenticated;

revoke all on function public.school_teacher_feedback_scores(uuid) from public;
revoke all on function public.teacher_student_challenges(uuid) from public;
revoke all on function public.create_student_learning_challenge(uuid,text,text,text,integer,uuid) from public;
revoke all on function public.set_student_learning_challenge_active(uuid,uuid,boolean) from public;
grant execute on function public.school_teacher_feedback_scores(uuid) to authenticated;
grant execute on function public.teacher_student_challenges(uuid) to authenticated;
grant execute on function public.create_student_learning_challenge(uuid,text,text,text,integer,uuid) to authenticated;
grant execute on function public.set_student_learning_challenge_active(uuid,uuid,boolean) to authenticated;
