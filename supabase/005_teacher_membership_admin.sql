-- ZZ-01 / Zkouškomat
-- Fáze 5: skutečné schvalování učitelů a opakování zamítnuté žádosti

create or replace function private.can_view_profile(p_other_user uuid)
returns boolean
language sql
stable
security definer
set search_path = public, private
as $$
  select
    private.shares_school_with(p_other_user)
    or exists (
      select 1
      from public.school_memberships mine
      join public.school_memberships theirs
        on theirs.school_id = mine.school_id
      where mine.user_id = auth.uid()
        and mine.status = 'approved'
        and mine.role = 'admin'
        and theirs.user_id = p_other_user
        and theirs.status in ('pending','approved')
    );
$$;

revoke all on function private.can_view_profile(uuid) from public;
grant execute on function private.can_view_profile(uuid) to authenticated;

drop policy if exists "profiles_select_self_or_colleague" on public.profiles;
create policy "profiles_select_self_or_colleague"
on public.profiles for select
to authenticated
using (id = auth.uid() or private.can_view_profile(id));

-- Zamítnutý učitel smí později stejnou žádost znovu odeslat.
drop policy if exists "memberships_update_self_reapply" on public.school_memberships;
create policy "memberships_update_self_reapply"
on public.school_memberships for update
to authenticated
using (user_id = auth.uid() and status = 'rejected')
with check (
  user_id = auth.uid()
  and role = 'teacher'
  and status = 'pending'
  and approved_at is null
  and approved_by is null
);
