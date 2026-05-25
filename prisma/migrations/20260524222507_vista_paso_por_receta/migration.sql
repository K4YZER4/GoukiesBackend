CREATE VIEW receta.vista_pasos_por_receta AS 
SELECT rr.id AS id_receta, p.paso,p.orden
FROM receta.receta AS rr 
INNER JOIN receta.receta_pasos AS p   
  ON p.id_receta=rr.id