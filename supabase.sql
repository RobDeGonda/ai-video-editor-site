-- Run in the Supabase SQL Editor.
create table public.waitlist (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  email text not null unique
    check (char_length(email) <= 254 and email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  footage_type text not null
    check (footage_type in ('action','event','vlog','other')),
  hours_per_month text not null
    check (hours_per_month in ('under_1','1_to_5','5_to_20','over_20'))
);

alter table public.waitlist enable row level security;

-- Insert-only for the public anon role. No select, update or delete policies.
create policy "anon can insert waitlist"
  on public.waitlist
  for insert
  to anon
  with check (true);

grant insert on public.waitlist to anon;
