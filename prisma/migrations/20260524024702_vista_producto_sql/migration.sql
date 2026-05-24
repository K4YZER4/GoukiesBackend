CREATE VIEW receta.vista_producto AS
SELECT
  p.id,
  i.nombre        AS ingrediente,
  m.nombre        AS marca,
  t.nombre        AS tipo,
  u.nombre        AS unidad,
  p.pzas,
  p.precio_medio,
  p.cantidad_inventario,
  p.cantidad_unitario
FROM receta.producto p
JOIN receta.ingrediente i ON p.id_ingrediente = i.id
JOIN receta.marca       m ON p.id_marca       = m.id
JOIN receta.tipo        t ON p.id_tipo         = t.id
JOIN receta.unidad      u ON p.id_unidad       = u.id;