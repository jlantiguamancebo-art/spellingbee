-- Reemplaza únicamente el spelling español activo con el orden del CSV.
delete from public.words
where language = 'es'
  and is_active = true
  and list_name = 'Lista actual';

insert into public.words
  (language, word, sentence, distractors, blanks, list_name, is_active, position)
values
  ('es', 'vacuna', 'El doctor me puso una ___.', '["bacuna", "vacunna"]'::jsonb, '[{"pos":3,"length":1,"options":["u","o"]}]'::jsonb, 'Lista actual', true, 1),
  ('es', 'cuenco', 'El perro bebe agua del ___.', '["quenco", "cuenko"]'::jsonb, '[{"pos":4,"length":1,"options":["c","k"]}]'::jsonb, 'Lista actual', true, 2),
  ('es', 'buque', 'El ___ navega por el mar.', '["buqe", "buce"]'::jsonb, '[{"pos":2,"length":1,"options":["q","c"]}]'::jsonb, 'Lista actual', true, 3),
  ('es', 'quieto', 'Quédate ___ mientras te peino.', '["queto", "kieto"]'::jsonb, '[{"pos":4,"length":1,"options":["t","d"]}]'::jsonb, 'Lista actual', true, 4),
  ('es', 'tanque', 'El agua está guardada en el ___.', '["tanqe", "tankue"]'::jsonb, '[{"pos":3,"length":1,"options":["q","g"]}]'::jsonb, 'Lista actual', true, 5),
  ('es', 'canas', 'Mi abuelo tiene ___ en el cabello.', '["kanas", "canaz"]'::jsonb, '[{"pos":1,"length":1,"options":["a","o"]}]'::jsonb, 'Lista actual', true, 6),
  ('es', 'corona', 'La princesa lleva una ___.', '["korona", "corrona"]'::jsonb, '[{"pos":3,"length":1,"options":["o","a"]}]'::jsonb, 'Lista actual', true, 7),
  ('es', 'manteca', 'La receta lleva ___.', '["manteka", "mantteca"]'::jsonb, '[{"pos":3,"length":1,"options":["t","c"]}]'::jsonb, 'Lista actual', true, 8),
  ('es', 'chico', 'El ___ juega en el parque.', '["chiko", "chicco"]'::jsonb, '[{"pos":3,"length":1,"options":["c","k"]}]'::jsonb, 'Lista actual', true, 9),
  ('es', 'flaco', 'El gato está muy ___.', '["flako", "flacco"]'::jsonb, '[{"pos":3,"length":1,"options":["c","k"]}]'::jsonb, 'Lista actual', true, 10),
  ('es', 'equivocarse', 'Es normal ___ cuando aprendemos.', '["equibocarse", "equivocarce"]'::jsonb, '[{"pos":4,"length":1,"options":["v","b"]}]'::jsonb, 'Lista actual', true, 11),
  ('es', 'querido', 'Mi ___ amigo vino a visitarme.', '["kerido", "querrido"]'::jsonb, '[{"pos":5,"length":1,"options":["d","t"]}]'::jsonb, 'Lista actual', true, 12),
  ('es', 'cuchillo', 'Cortamos el pan con un ___.', '["cuchiyo", "kuchillo"]'::jsonb, '[{"pos":5,"length":1,"options":["l","y"]}]'::jsonb, 'Lista actual', true, 13),
  ('es', 'etiquetas', 'Las ___ tienen información del producto.', '["etiqetas", "etiquettas"]'::jsonb, '[{"pos":6,"length":1,"options":["t","d"]}]'::jsonb, 'Lista actual', true, 14),
  ('es', 'corneta', 'El músico toca la ___.', '["korneta", "cornetta"]'::jsonb, '[{"pos":5,"length":1,"options":["t","d"]}]'::jsonb, 'Lista actual', true, 15),
  ('es', 'queja', 'Ella presentó una ___ en la oficina.', '["keja", "quegga"]'::jsonb, '[{"pos":3,"length":1,"options":["j","g"]}]'::jsonb, 'Lista actual', true, 16),
  ('es', 'calambre', 'Me dio un ___ en la pierna.', '["kalambre", "calanbre"]'::jsonb, '[{"pos":4,"length":1,"options":["m","n"]}]'::jsonb, 'Lista actual', true, 17),
  ('es', 'koala', 'El ___ vive en Australia.', '["coala", "koalla"]'::jsonb, '[{"pos":3,"length":1,"options":["l","y"]}]'::jsonb, 'Lista actual', true, 18),
  ('es', 'izquierda', 'Gira a la ___ en la esquina.', '["isquierda", "izquierdda"]'::jsonb, '[{"pos":7,"length":1,"options":["d","t"]}]'::jsonb, 'Lista actual', true, 19),
  ('es', 'cacao', 'El chocolate se hace con ___.', '["kakao", "cacau"]'::jsonb, '[{"pos":1,"length":1,"options":["a","o"]}]'::jsonb, 'Lista actual', true, 20);

update public.words
set created_at = timestamptz '2026-10-21 00:00:00+00' + (position * interval '1 second')
where language = 'es' and is_active = true and list_name = 'Lista actual';
