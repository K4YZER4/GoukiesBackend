CREATE VIEW receta.vista_producto_receta AS
SELECT i.nombre AS ingrediente_nombre,m.nombre AS marca_nombre,rp.cantidad,rr.id AS id_receta
FROM receta.receta as  rr 
  Inner JOIN receta.receta_producto  as rp
    ON rp.id_receta=rr.id
  INNER JOIN receta.producto AS P
    ON P.id=rp.id_producto
  INNER JOIN receta.marca AS m 
    ON m.id=p.id_marca
  INNER JOIN receta.ingrediente AS i 
    ON i.id=p.id_ingrediente