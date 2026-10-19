grant usage on schema public to anon, authenticated;
grant select on table public.words to anon, authenticated;
grant insert, update, delete on table public.words to authenticated;

drop policy if exists "Anyone can read words" on public.words;
create policy "Anyone can read words" on public.words
  for select using (true);

drop policy if exists "Admins can insert words" on public.words;
create policy "Admins can insert words" on public.words
  for insert to authenticated with check (public.is_spelling_admin());

drop policy if exists "Admins can update words" on public.words;
create policy "Admins can update words" on public.words
  for update to authenticated using (public.is_spelling_admin()) with check (public.is_spelling_admin());

drop policy if exists "Admins can delete words" on public.words;
create policy "Admins can delete words" on public.words
  for delete to authenticated using (public.is_spelling_admin());
