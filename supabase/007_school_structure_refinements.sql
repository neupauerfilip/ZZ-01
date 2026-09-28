-- ZZ-01 / Zkouškomat
-- Fáze 2b: samostatný katalog předmětů učitele + zpřesnění budoucího bodového ledgeru.

create table if not exists public.teacher_subjects (
  school_id uuid not null references public.schools(id) on delete cascade,
  teacher_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid not null,
  created_at timestamptz not null default now(),
  primary key (teacher_id, subject_id),
  foreign key (subject_id, school_id) references public.subjects(id, school_id) on delete cascade
);

create index if not exists teacher_subjects_school_teacher_idx
  on public.teacher_subjects(school_id, teacher_id);

alter table public.teacher_subjects enable row level security;
revoke all on table public.teacher_subjects from anon;
grant select,insert,delete on table public.teacher_subjects to authenticated;

create policy "teacher_subjects_select_member"
on public.teacher_subjects for select to authenticated
using (private.is_school_member(school_id));

create policy "teacher_subjects_insert_self_or_admin"
on public.teacher_subjects for insert to authenticated
with check (
  (teacher_id = auth.uid() and private.has_school_permission(school_id,'manageSubjects'))
  or private.is_school_admin(school_id)
);

create policy "teacher_subjects_delete_self_or_admin"
on public.teacher_subjects for delete to authenticated
using (
  (teacher_id = auth.uid() and private.has_school_permission(school_id,'manageSubjects'))
  or private.is_school_admin(school_id)
);

-- U volitelných vazeb class/subject necháváme při smazání záznamu NULL pouze v daném sloupci.
-- ID tříd i předmětů jsou globálně unikátní UUID, takže jednoduchý FK je zde bezpečnější.
alter table public.student_point_events
  drop constraint if exists student_point_events_class_id_school_id_fkey;
alter table public.student_point_events
  drop constraint if exists student_point_events_subject_id_school_id_fkey;

alter table public.student_point_events
  add constraint student_point_events_class_id_fkey
  foreign key (class_id) references public.school_classes(id) on delete set null;

alter table public.student_point_events
  add constraint student_point_events_subject_id_fkey
  foreign key (subject_id) references public.subjects(id) on delete set null;
