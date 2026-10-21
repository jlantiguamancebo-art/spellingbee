alter table public.words add column if not exists position integer;

with ranked as (
  select id,
         row_number() over (partition by language, list_name order by created_at, id) as pos
  from public.words
)
update public.words w
set position = ranked.pos
from ranked
where w.id = ranked.id;

alter table public.words alter column position set default 0;
alter table public.words alter column position set not null;

delete from public.words
where language = 'en'
  and is_active = true
  and list_name = 'Lista actual';

insert into public.words
  (language, word, sentence, distractors, blanks, list_name, is_active, position)
values
  ('en', 'heel', 'My ___ hurts when I walk.', '["heal", "heell"]'::jsonb, '[{"pos":1,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 1),
  ('en', 'week', 'There are seven days in a ___.', '["weak", "wekk"]'::jsonb, '[{"pos":1,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 2),
  ('en', 'creek', 'The fish swims in the ___.', '["creak", "creekk"]'::jsonb, '[{"pos":2,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 3),
  ('en', 'free', 'The library is ___ to visit.', '["frea", "freee"]'::jsonb, '[{"pos":2,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 4),
  ('en', 'green', 'The grass is ___.', '["grean", "greenn"]'::jsonb, '[{"pos":2,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 5),
  ('en', 'street', 'Our house is on this ___.', '["streat", "streeet"]'::jsonb, '[{"pos":3,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 6),
  ('en', 'freeze', 'Water can ___ in winter.', '["freese", "freezze"]'::jsonb, '[{"pos":2,"length":2,"options":["ee","ee"]}]'::jsonb, 'Lista actual', true, 7),
  ('en', 'seal', 'The ___ swims in the ocean.', '["seel", "seall"]'::jsonb, '[{"pos":1,"length":2,"options":["ea","ee"]}]'::jsonb, 'Lista actual', true, 8),
  ('en', 'weak', 'I feel ___ when I am sick.', '["week", "weakk"]'::jsonb, '[{"pos":1,"length":2,"options":["ea","ee"]}]'::jsonb, 'Lista actual', true, 9),
  ('en', 'bean', 'I ate a green ___.', '["been", "beann"]'::jsonb, '[{"pos":1,"length":2,"options":["ea","ee"]}]'::jsonb, 'Lista actual', true, 10),
  ('en', 'speaks', 'She ___ English at school.', '["speeks", "speakks"]'::jsonb, '[{"pos":2,"length":2,"options":["ea","ee"]}]'::jsonb, 'Lista actual', true, 11),
  ('en', 'team', 'Our ___ won the game.', '["teem", "teamm"]'::jsonb, '[{"pos":1,"length":2,"options":["ea","ee"]}]'::jsonb, 'Lista actual', true, 12),
  ('en', 'clean', 'Please keep your room ___.', '["cleen", "cleann"]'::jsonb, '[{"pos":2,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 13),
  ('en', 'cream', 'I put ___ in my coffee.', '["creem", "creamm"]'::jsonb, '[{"pos":2,"length":2,"options":["ee","ea"]}]'::jsonb, 'Lista actual', true, 14),
  ('en', 'field', 'The players run across the ___.', '["feeld", "fielld"]'::jsonb, '[{"pos":2,"length":1,"options":["ie","ee"]}]'::jsonb, 'Lista actual', true, 15),
  ('en', 'tight', 'My shoes are too ___.', '["tite", "tightt"]'::jsonb, '[{"pos":2,"length":2,"options":["gh","t"]}]'::jsonb, 'Lista actual', true, 16),
  ('en', 'tied', 'Mom ___ my shoes.', '["tide", "tieed"]'::jsonb, '[{"pos":2,"length":1,"options":["e","d"]}]'::jsonb, 'Lista actual', true, 17),
  ('en', 'cute', 'The puppy is very ___.', '["cuta", "cutte"]'::jsonb, '[{"pos":1,"length":1,"options":["u","a"]}]'::jsonb, 'Lista actual', true, 18),
  ('en', 'sixteen', 'The number after fifteen is ___.', '["sixtene", "sixteenn"]'::jsonb, '[{"pos":3,"length":2,"options":["ee","e"]}]'::jsonb, 'Lista actual', true, 19),
  ('en', 'peanut', 'A ___ is a type of nut.', '["peenut", "peanutt"]'::jsonb, '[{"pos":1,"length":2,"options":["ea","ee"]}]'::jsonb, 'Lista actual', true, 20);

update public.words
set created_at = timestamptz '2026-10-21 00:00:00+00' + (position * interval '1 second')
where language = 'en' and is_active = true and list_name = 'Lista actual';

create or replace function public.assign_spelling_position()
returns trigger
language plpgsql
as $$
begin
  if new.is_active and coalesce(new.position, 0) = 0 then
    select coalesce(max(position), 0) + 1
      into new.position
      from public.words
     where language = new.language
       and list_name = new.list_name
       and is_active = true;
  end if;
  if new.is_active then
    new.created_at := clock_timestamp() + (new.position * interval '1 second');
  end if;
  return new;
end;
$$;

drop trigger if exists set_spelling_position on public.words;
create trigger set_spelling_position
before insert on public.words
for each row execute function public.assign_spelling_position();
