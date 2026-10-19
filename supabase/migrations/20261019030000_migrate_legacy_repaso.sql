-- Migra el pool de repaso que estaba incrustado en bee.html.
-- Estas palabras quedan disponibles junto con todos los spellings que se
-- archiven posteriormente desde el panel.
insert into public.words (language, word, sentence, distractors, blanks, list_name, is_active)
values
  ('es', 'cazo', 'Mi abuela cocina la sopa en un ___ de metal.', '["caso", "casso"]'::jsonb, '[{"pos":2,"options":["s","z","c"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'xilografía', 'La ___ es una técnica de grabado en madera.', '["silografía", "xylografía"]'::jsonb, '[{"pos":0,"options":["x","s"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'zócalo', 'Pintaron el ___ de la pared de color blanco.', '["sócalo", "zóccalo"]'::jsonb, '[{"pos":0,"options":["z","s"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'segundo', 'Espera un ___, ya casi termino.', '["cegundo", "zegundo"]'::jsonb, '[{"pos":0,"options":["s","c","z"]},{"pos":2,"options":["g","j"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'cerdo', 'El granjero tiene un ___ en el corral.', '["serdo", "zerdo"]'::jsonb, '[{"pos":0,"options":["c","s","z"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'zanja', 'Cavaron una ___ para el tubo de agua.', '["sanja", "zamja"]'::jsonb, '[{"pos":0,"options":["z","s"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'ciudad', 'Vivimos en una ___ muy grande.', '["siudad", "cuidad"]'::jsonb, '[{"pos":1,"options":["i","u"]},{"pos":2,"options":["u","i"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'sartén', 'Frió los huevos en una ___ nueva.', '["zartén", "sartem"]'::jsonb, '[{"pos":0,"options":["s","z"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'zafiro', 'El anillo tenía un ___ azul brillante.', '["safiro", "zafyro"]'::jsonb, '[{"pos":0,"options":["z","s"]},{"pos":3,"options":["i","y"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'seto', 'El jardinero podó el ___ del jardín.', '["ceto", "zeto"]'::jsonb, '[{"pos":0,"options":["s","c","z"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'pesar', 'A ___ de la lluvia, fuimos al parque.', '["pezar", "pessar"]'::jsonb, '[{"pos":2,"options":["s","z","c"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'traducir', 'Necesito ___ este texto al inglés.', '["tradusir", "traduzir"]'::jsonb, '[{"pos":5,"options":["c","s","z"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'xilófono', 'Tocó una melodía alegre en el ___.', '["silófono", "xilóphono"]'::jsonb, '[{"pos":0,"options":["x","s"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'xerófilo', 'El cactus es una planta ___a.', '["serófilo", "xerophilo"]'::jsonb, '[{"pos":0,"options":["x","s"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'mascota', 'Mi ___ favorita es mi perro.', '["macota", "mazcota"]'::jsonb, '[{"pos":2,"options":["s","z"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'empezar', 'Vamos a ___ la tarea ahora mismo.', '["empesar", "enpezar"]'::jsonb, '[{"pos":1,"options":["m","n"]},{"pos":4,"options":["z","s","c"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'diez', 'Tengo ___ años.', '["dies", "diex"]'::jsonb, '[{"pos":3,"options":["z","s"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'cerebro', 'El ___ controla todo el cuerpo.', '["serebro", "cerevro"]'::jsonb, '[{"pos":0,"options":["c","s","z"]},{"pos":4,"options":["b","v"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'país', 'México es un ___ muy grande.', '["paíz", "paíc"]'::jsonb, '[{"pos":3,"options":["s","z"]}]'::jsonb, 'Spelling anterior histórico', false),
  ('es', 'bostezar', 'El niño empezó a ___ de sueño.', '["bostesar", "vostezar"]'::jsonb, '[{"pos":0,"options":["b","v"]},{"pos":5,"options":["z","s","c"]}]'::jsonb, 'Spelling anterior histórico', false)
on conflict do nothing;
