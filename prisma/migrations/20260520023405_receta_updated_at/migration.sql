CREATE OR REPLACE FUNCTION receta_set_fecha_modificacion()
RETURNS TRIGGER AS $$
BEGIN
  NEW.fecha_modificacion := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER receta_update_fecha_modificacion
BEFORE UPDATE ON "receta"."receta"
FOR EACH ROW
EXECUTE FUNCTION receta_set_fecha_modificacion();