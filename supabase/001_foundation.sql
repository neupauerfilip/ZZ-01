-- ZZ-01 / Zkouškomat
-- Fáze 1: účty, školy a členství uživatelů
-- Spusť v Supabase SQL Editoru jako jeden celek.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  nickname text not null default '',
  avatar text not null default 'px:cyan',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.schools (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  city text not null default '',
  address text not null default '',
  school_year text not null default '',
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.school_memberships (
  school_id uuid not null references public.schools(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role text not null default 'teacher' check (role in ('admin','teacher')),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  permissions jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  approved_at timestamptz,
  approved_by uuid references auth.users(id) on delete set null,
  primary key (school_id,user_id)
);

create index if not exists school_memberships_user_idx
  on public.school_memberships(user_id);
create index if not exists school_memberships_school_status_idx
  on public.school_memberships(school_id,status);

-- Profil se vytvoří automaticky při založení účtu.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id,display_name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'display_name',new.raw_user_meta_data->>'full_name','')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();

-- Pomocné funkce pro RLS. SECURITY DEFINER zabraňuje rekurzi politik
-- nad tabulkou school_memberships.
create or replace function public.is_school_member(p_school_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.school_memberships m
    where m.school_id = p_school_id
      and m.user_id = auth.uid()
      and m.status = 'approved'
  );
$$;

create or replace function public.is_school_admin(p_school_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.school_memberships m
    where m.school_id = p_school_id
      and m.user_id = auth.uid()
      and m.status = 'approved'
      and m.role = 'admin'
  );
$$;

create or replace function public.shares_school_with(p_other_user uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.school_memberships mine
    join public.school_memberships theirs
      on theirs.school_id = mine.school_id
    where mine.user_id = auth.uid()
      and mine.status = 'approved'
      and theirs.user_id = p_other_user
      and theirs.status = 'approved'
  );
$$;

-- Bezpečnost na úrovni řádků.
alter table public.profiles enable row level security;
alter table public.schools enable row level security;
alter table public.school_memberships enable row level security;

revoke all on table public.profiles from anon;
revoke all on table public.schools from anon;
revoke all on table public.school_memberships from anon;

grant select,update on table public.profiles to authenticated;
grant select,insert,update on table public.schools to authenticated;
grant select,insert,update,delete on table public.school_memberships to authenticated;

-- PROFILES
create policy "profiles_select_self_or_colleague"
on public.profiles for select
to authenticated
using (id = auth.uid() or public.shares_school_with(id));

create policy "profiles_update_self"
on public.profiles for update
to authenticated
using (id = auth.uid())
with check (id = auth.uid());

-- SCHOOLS
create policy "schools_select_member_or_creator"
on public.schools for select
to authenticated
using (created_by = auth.uid() or public.is_school_member(id));

create policy "schools_insert_creator"
on public.schools for insert
to authenticated
with check (created_by = auth.uid());

create policy "schools_update_admin"
on public.schools for update
to authenticated
using (public.is_school_admin(id))
with check (public.is_school_admin(id));

-- MEMBERSHIPS
-- Uživatel vidí svou žádost; schválení členové školy vidí sbor.
create policy "memberships_select_self_or_school_member"
on public.school_memberships for select
to authenticated
using (user_id = auth.uid() or public.is_school_member(school_id));

-- Učitel může požádat o vstup sám za sebe.
-- Zakladatel školy může zároveň vložit své počáteční admin členství.
create policy "memberships_insert_self_request_or_creator_admin"
on public.school_memberships for insert
to authenticated
with check (
  (
    user_id = auth.uid()
    and role = 'teacher'
    and status = 'pending'
  )
  or
  (
    user_id = auth.uid()
    and role = 'admin'
    and status = 'approved'
    and exists (
      select 1 from public.schools s
      where s.id = school_id and s.created_by = auth.uid()
    )
  )
);

create policy "memberships_update_admin"
on public.school_memberships for update
to authenticated
using (public.is_school_admin(school_id))
with check (public.is_school_admin(school_id));

create policy "memberships_delete_admin_or_self_pending"
on public.school_memberships for delete
to authenticated
using (
  public.is_school_admin(school_id)
  or (user_id = auth.uid() and status = 'pending')
);

-- RPC: bezpečně založí školu i prvního admina v jedné transakci.
create or replace function public.create_school(
  p_name text,
  p_city text default '',
  p_address text default '',
  p_school_year text default ''
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_school_id uuid;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;
  if length(trim(coalesce(p_name,''))) = 0 then
    raise exception 'School name is required';
  end if;

  insert into public.schools(name,city,address,school_year,created_by)
  values(trim(p_name),coalesce(p_city,''),coalesce(p_address,''),coalesce(p_school_year,''),auth.uid())
  returning id into v_school_id;

  insert into public.school_memberships(school_id,user_id,role,status,approved_at,approved_by)
  values(v_school_id,auth.uid(),'admin','approved',now(),auth.uid());

  return v_school_id;
end;
$$;

grant execute on function public.create_school(text,text,text,text) to authenticated;
