-- ZZ-01 / Zkouškomat
-- Fáze 1b: bezpečnostní zpřísnění pomocných funkcí.

create schema if not exists private;

create or replace function private.handle_new_user()
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

revoke all on function private.handle_new_user() from public;

create or replace function private.is_school_member(p_school_id uuid)
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

create or replace function private.is_school_admin(p_school_id uuid)
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

create or replace function private.shares_school_with(p_other_user uuid)
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

revoke all on function private.is_school_member(uuid) from public;
revoke all on function private.is_school_admin(uuid) from public;
revoke all on function private.shares_school_with(uuid) from public;
grant usage on schema private to authenticated;
grant execute on function private.is_school_member(uuid) to authenticated;
grant execute on function private.is_school_admin(uuid) to authenticated;
grant execute on function private.shares_school_with(uuid) to authenticated;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute function private.handle_new_user();

drop policy if exists "profiles_select_self_or_colleague" on public.profiles;
create policy "profiles_select_self_or_colleague"
on public.profiles for select
to authenticated
using (id = auth.uid() or private.shares_school_with(id));

drop policy if exists "schools_select_member_or_creator" on public.schools;
create policy "schools_select_member_or_creator"
on public.schools for select
to authenticated
using (created_by = auth.uid() or private.is_school_member(id));

drop policy if exists "schools_update_admin" on public.schools;
create policy "schools_update_admin"
on public.schools for update
to authenticated
using (private.is_school_admin(id))
with check (private.is_school_admin(id));

drop policy if exists "memberships_select_self_or_school_member" on public.school_memberships;
create policy "memberships_select_self_or_school_member"
on public.school_memberships for select
to authenticated
using (user_id = auth.uid() or private.is_school_member(school_id));

drop policy if exists "memberships_update_admin" on public.school_memberships;
create policy "memberships_update_admin"
on public.school_memberships for update
to authenticated
using (private.is_school_admin(school_id))
with check (private.is_school_admin(school_id));

drop policy if exists "memberships_delete_admin_or_self_pending" on public.school_memberships;
create policy "memberships_delete_admin_or_self_pending"
on public.school_memberships for delete
to authenticated
using (
  private.is_school_admin(school_id)
  or (user_id = auth.uid() and status = 'pending')
);

drop function if exists public.handle_new_user();
drop function if exists public.is_school_member(uuid);
drop function if exists public.is_school_admin(uuid);
drop function if exists public.shares_school_with(uuid);

revoke all on function public.create_school(text,text,text,text) from public;
revoke all on function public.create_school(text,text,text,text) from anon;
grant execute on function public.create_school(text,text,text,text) to authenticated;
