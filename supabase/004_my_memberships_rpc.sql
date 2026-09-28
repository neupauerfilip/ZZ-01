-- ZZ-01 / Zkouškomat
-- Vrací pouze členství právě přihlášeného uživatele včetně názvu školy.

create or replace function public.my_school_memberships()
returns table (
  school_id uuid,
  school_name text,
  city text,
  address text,
  school_year text,
  role text,
  status text,
  permissions jsonb,
  created_at timestamptz
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
    m.role,
    m.status,
    m.permissions,
    m.created_at
  from public.school_memberships m
  join public.schools s on s.id = m.school_id
  where auth.uid() is not null
    and m.user_id = auth.uid()
  order by m.created_at desc;
$$;

revoke all on function public.my_school_memberships() from public;
revoke all on function public.my_school_memberships() from anon;
grant execute on function public.my_school_memberships() to authenticated;
