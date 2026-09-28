-- ZZ-01 / Zkouškomat
-- Fáze 2: sdílená školní struktura (třídy, žáci, předměty)
-- + příprava na budoucí žákovské účty a bodový ledger.

create or replace function private.has_school_permission(p_school_id uuid, p_permission text)
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
      and (
        m.role = 'admin'
        or coalesce(
          (m.permissions ->> p_permission)::boolean,
          case p_permission
            when 'manageClasses' then true
            when 'manageStudents' then true
            when 'manageSubjects' then true
            when 'viewSchoolScoring' then true
            else false
          end
        )
      )
  );
$$;

revoke all on function private.has_school_permission(uuid,text) from public;
revoke all on function private.has_school_permission(uuid,text) from anon;
grant execute on function private.has_school_permission(uuid,text) to authenticated;

create table if not exists public.school_classes (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  client_key text not null,
  display_name text not null,
  school_year text not null,
  previous_class_id uuid references public.school_classes(id) on delete set null,
  created_by uuid not null references auth.users(id) on delete restrict,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (school_id, client_key),
  unique (id, school_id)
);

create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  client_key text not null,
  display_name text not null,
  active boolean not null default true,
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (school_id, client_key),
  unique (id, school_id)
);

create table if not exists public.class_enrollments (
  school_id uuid not null references public.schools(id) on delete cascade,
  class_id uuid not null,
  student_id uuid not null,
  active boolean not null default true,
  joined_at timestamptz not null default now(),
  left_at timestamptz,
  primary key (class_id, student_id),
  foreign key (class_id, school_id) references public.school_classes(id, school_id) on delete cascade,
  foreign key (student_id, school_id) references public.students(id, school_id) on delete cascade
);

create table if not exists public.teacher_class_assignments (
  school_id uuid not null references public.schools(id) on delete cascade,
  class_id uuid not null,
  teacher_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (class_id, teacher_id),
  foreign key (class_id, school_id) references public.school_classes(id, school_id) on delete cascade
);

create table if not exists public.subjects (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  name text not null,
  active boolean not null default true,
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (school_id, name),
  unique (id, school_id)
);

create table if not exists public.teacher_class_subjects (
  school_id uuid not null references public.schools(id) on delete cascade,
  class_id uuid not null,
  teacher_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid not null,
  created_at timestamptz not null default now(),
  primary key (class_id, teacher_id, subject_id),
  foreign key (class_id, school_id) references public.school_classes(id, school_id) on delete cascade,
  foreign key (subject_id, school_id) references public.subjects(id, school_id) on delete cascade
);

-- Budoucí propojení školního žáka se skutečným Supabase Auth účtem.
-- Zatím bez klientských oprávnění; zapojí se až při tvorbě žákovské verze aplikace.
create table if not exists public.student_accounts (
  student_id uuid primary key references public.students(id) on delete cascade,
  user_id uuid not null unique references auth.users(id) on delete cascade,
  status text not null default 'linked' check (status in ('pending','linked','disabled')),
  linked_at timestamptz not null default now(),
  linked_by uuid references auth.users(id) on delete set null
);

-- Neměnná historie budoucích bodových událostí žáka.
-- Zdroj může být např. locker, rule, exam, test, challenge, manual.
create table if not exists public.student_point_events (
  id uuid primary key default gen_random_uuid(),
  school_id uuid not null references public.schools(id) on delete cascade,
  student_id uuid not null,
  class_id uuid,
  subject_id uuid,
  points integer not null check (points <> 0),
  source text not null,
  note text not null default '',
  metadata jsonb not null default '{}'::jsonb,
  created_by uuid not null references auth.users(id) on delete restrict,
  created_at timestamptz not null default now(),
  foreign key (student_id, school_id) references public.students(id, school_id) on delete cascade,
  foreign key (class_id, school_id) references public.school_classes(id, school_id) on delete set null,
  foreign key (subject_id, school_id) references public.subjects(id, school_id) on delete set null
);

create index if not exists school_classes_school_year_idx on public.school_classes(school_id, school_year, active);
create index if not exists students_school_active_idx on public.students(school_id, active);
create index if not exists class_enrollments_school_active_idx on public.class_enrollments(school_id, active);
create index if not exists teacher_class_assignments_teacher_idx on public.teacher_class_assignments(teacher_id, school_id);
create index if not exists subjects_school_active_idx on public.subjects(school_id, active);
create index if not exists teacher_class_subjects_teacher_idx on public.teacher_class_subjects(teacher_id, school_id);
create index if not exists student_point_events_student_idx on public.student_point_events(student_id, created_at desc);
create index if not exists student_point_events_school_idx on public.student_point_events(school_id, created_at desc);

alter table public.school_classes enable row level security;
alter table public.students enable row level security;
alter table public.class_enrollments enable row level security;
alter table public.teacher_class_assignments enable row level security;
alter table public.subjects enable row level security;
alter table public.teacher_class_subjects enable row level security;
alter table public.student_accounts enable row level security;
alter table public.student_point_events enable row level security;

revoke all on table public.school_classes from anon;
revoke all on table public.students from anon;
revoke all on table public.class_enrollments from anon;
revoke all on table public.teacher_class_assignments from anon;
revoke all on table public.subjects from anon;
revoke all on table public.teacher_class_subjects from anon;
revoke all on table public.student_accounts from anon;
revoke all on table public.student_point_events from anon;

revoke all on table public.student_accounts from authenticated;

grant select,insert,update on table public.school_classes to authenticated;
grant select,insert,update on table public.students to authenticated;
grant select,insert,update,delete on table public.class_enrollments to authenticated;
grant select,insert,delete on table public.teacher_class_assignments to authenticated;
grant select,insert,update on table public.subjects to authenticated;
grant select,insert,delete on table public.teacher_class_subjects to authenticated;
grant select,insert on table public.student_point_events to authenticated;

-- SCHOOL CLASSES
create policy "school_classes_select_member"
on public.school_classes for select to authenticated
using (private.is_school_member(school_id));

create policy "school_classes_insert_manager"
on public.school_classes for insert to authenticated
with check (
  created_by = auth.uid()
  and private.has_school_permission(school_id,'manageClasses')
);

create policy "school_classes_update_manager"
on public.school_classes for update to authenticated
using (private.has_school_permission(school_id,'manageClasses'))
with check (private.has_school_permission(school_id,'manageClasses'));

-- STUDENTS
create policy "students_select_member"
on public.students for select to authenticated
using (private.is_school_member(school_id));

create policy "students_insert_manager"
on public.students for insert to authenticated
with check (
  created_by = auth.uid()
  and private.has_school_permission(school_id,'manageStudents')
);

create policy "students_update_manager"
on public.students for update to authenticated
using (private.has_school_permission(school_id,'manageStudents'))
with check (private.has_school_permission(school_id,'manageStudents'));

-- CLASS ENROLLMENTS
create policy "class_enrollments_select_member"
on public.class_enrollments for select to authenticated
using (private.is_school_member(school_id));

create policy "class_enrollments_insert_manager"
on public.class_enrollments for insert to authenticated
with check (private.has_school_permission(school_id,'manageStudents'));

create policy "class_enrollments_update_manager"
on public.class_enrollments for update to authenticated
using (private.has_school_permission(school_id,'manageStudents'))
with check (private.has_school_permission(school_id,'manageStudents'));

create policy "class_enrollments_delete_manager"
on public.class_enrollments for delete to authenticated
using (private.has_school_permission(school_id,'manageStudents'));

-- TEACHER <-> CLASS
create policy "teacher_class_assignments_select_member"
on public.teacher_class_assignments for select to authenticated
using (private.is_school_member(school_id));

create policy "teacher_class_assignments_insert_self_or_manager"
on public.teacher_class_assignments for insert to authenticated
with check (
  (teacher_id = auth.uid() and private.is_school_member(school_id))
  or private.has_school_permission(school_id,'manageClasses')
);

create policy "teacher_class_assignments_delete_self_or_manager"
on public.teacher_class_assignments for delete to authenticated
using (
  (teacher_id = auth.uid() and private.is_school_member(school_id))
  or private.has_school_permission(school_id,'manageClasses')
);

-- SUBJECTS
create policy "subjects_select_member"
on public.subjects for select to authenticated
using (private.is_school_member(school_id));

create policy "subjects_insert_manager"
on public.subjects for insert to authenticated
with check (
  created_by = auth.uid()
  and private.has_school_permission(school_id,'manageSubjects')
);

create policy "subjects_update_manager"
on public.subjects for update to authenticated
using (private.has_school_permission(school_id,'manageSubjects'))
with check (private.has_school_permission(school_id,'manageSubjects'));

-- TEACHER <-> CLASS <-> SUBJECT
create policy "teacher_class_subjects_select_member"
on public.teacher_class_subjects for select to authenticated
using (private.is_school_member(school_id));

create policy "teacher_class_subjects_insert_self_or_manager"
on public.teacher_class_subjects for insert to authenticated
with check (
  (teacher_id = auth.uid() and private.has_school_permission(school_id,'manageSubjects'))
  or private.is_school_admin(school_id)
);

create policy "teacher_class_subjects_delete_self_or_manager"
on public.teacher_class_subjects for delete to authenticated
using (
  (teacher_id = auth.uid() and private.has_school_permission(school_id,'manageSubjects'))
  or private.is_school_admin(school_id)
);

-- FUTURE POINT LEDGER
create policy "student_point_events_select_member"
on public.student_point_events for select to authenticated
using (private.is_school_member(school_id));

create policy "student_point_events_insert_member"
on public.student_point_events for insert to authenticated
with check (
  created_by = auth.uid()
  and private.is_school_member(school_id)
);
