-- Primero llena los NULLs con la fecha actual
UPDATE "receta"."receta" SET "fecha_modificacion" = NOW() WHERE "fecha_modificacion" IS NULL;

-- Luego sí lo pones NOT NULL
ALTER TABLE "receta"."receta" ALTER COLUMN "fecha_modificacion" SET NOT NULL;