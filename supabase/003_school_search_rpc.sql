-- ZZ-01 / Zkouškomat
-- Bezpečné vyhledávání škol během onboardingu.

create or replace function public.search_schools(p_query text default '')
returns table (
  id uuid,
  name text,
  city text,
  address text,
  school_year text,
  teacher_count bigint
)
language sql
stable
security definer
set search_path = public
as $$
  select
    s.id,
    s.name,
    s.city,
    s.address,
    s.school_year,
    count(m.user_id) filter (where m.status = 'approved') as teacher_count
  from public.schools s
  left join public.school_memberships m on m.school_id = s.id
  where auth.uid() is not null
    and (
      coalesce(trim(p_query),'') = ''
      or s.name ilike '%' || trim(p_query) || '%'
      or s.city ilike '%' || trim(p_query) || '%'
      or s.address ilike '%' || trim(p_query) || '%'
    )
  group by s.id, s.name, s.city, s.address, s.school_year
  order by s.name, s.city
  limit 50;
$$;

revoke all on function public.search_schools(text) from public;
revoke all on function public.search_schools(text) from anon;
grant execute on function public.search_schools(text) to authenticated;
