CREATE OR REPLACE FUNCTION receta.get_dashboard_data(
  p_usuario_id       UUID,
  p_numero_recetas   INT DEFAULT 3,
  p_numero_ingredientes INT DEFAULT 5
)
RETURNS JSON AS $$
DECLARE
  v_stats        JSON;
  v_recetas      JSON;
  v_ingredientes JSON;
BEGIN
  -- Stats del header
  SELECT json_build_object(
    'total_recetas',      COUNT(DISTINCT rr.id),
    'total_ingredientes', COUNT(DISTINCT rp.id)
  ) INTO v_stats
  FROM user_schema.usuario uu
  LEFT JOIN receta.receta rr          ON rr.id_usuario = uu.id
  LEFT JOIN receta.producto rp        ON rp.id_usuario = uu.id
  LEFT JOIN receta.vista_producto rvp ON rvp.id = rp.id
  WHERE uu.id = p_usuario_id;

  -- Últimas N recetas
  SELECT json_agg(r) INTO v_recetas FROM (
    SELECT id, nombre, descripcion, imagen_url
    FROM receta.receta
    WHERE id_usuario = p_usuario_id
    ORDER BY fecha_creacion DESC
    LIMIT p_numero_recetas
  ) r;

  -- Últimos N ingredientes
  SELECT json_agg(i) INTO v_ingredientes FROM (
    SELECT rp.id, rvp.ingrediente, rvp.tipo AS categoria,
           rvp.cantidad_inventario AS stock, rvp.unidad
    FROM receta.producto rp
    INNER JOIN receta.vista_producto rvp ON rvp.id = rp.id
    WHERE rp.id_usuario = p_usuario_id
    ORDER BY rp.id DESC
    LIMIT p_numero_ingredientes
  ) i;

  RETURN json_build_object(
    'stats',        v_stats,
    'recetas',      v_recetas,
    'ingredientes', v_ingredientes
  );
END;
$$ LANGUAGE plpgsql;