create extension if not exists pgcrypto;

create table if not exists public.admin_users (
  email text primary key,
  created_at timestamptz not null default now()
);

create table if not exists public.words (
  id uuid primary key default gen_random_uuid(),
  language text not null check (language in ('es', 'en')),
  word text not null,
  sentence text not null default '',
  distractors jsonb not null default '[]'::jsonb,
  blanks jsonb not null default '[]'::jsonb,
  list_name text not null default 'Lista actual',
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.admin_users enable row level security;
alter table public.words enable row level security;

create or replace function public.is_spelling_admin()
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.admin_users
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

drop policy if exists "Anyone can read words" on public.words;
create policy "Anyone can read words" on public.words
  for select using (true);

drop policy if exists "Admins can insert words" on public.words;
create policy "Admins can insert words" on public.words
  for insert with check (public.is_spelling_admin());

drop policy if exists "Admins can update words" on public.words;
create policy "Admins can update words" on public.words
  for update using (public.is_spelling_admin()) with check (public.is_spelling_admin());

drop policy if exists "Admins can delete words" on public.words;
create policy "Admins can delete words" on public.words
  for delete using (public.is_spelling_admin());

-- Ejecuta esto sustituyendo el correo real de tu esposa:
-- insert into public.admin_users (email) values ('correo@ejemplo.com');
