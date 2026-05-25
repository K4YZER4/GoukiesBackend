

-- Moneda MXN
INSERT INTO "user_schema"."moneda" (codigo, nombre) VALUES 
('MXN', 'Peso Mexicano')
ON CONFLICT (codigo) DO NOTHING;

-- Usuario dueño de todo
INSERT INTO "user_schema"."usuario" (
  id, nombre, correo_electronico, contrasena_hash, moneda_codigo
) VALUES (
  '550e8400-e29b-41d4-a716-446655440000',
  'Panadería La Güera',
  'admin@panaderialaguera.mx',
  'hashed_password_123',
  'MXN'
)
ON CONFLICT (id) DO NOTHING;

-- =========================================
-- CATÁLOGOS RECETA
-- =========================================

-- Unidades (id autoincrement)
INSERT INTO "receta"."unidad" (nombre, cantidad_gramos) VALUES
('gramo', 1),
('mililitro', 1),
('kilogramo', 1000),
('taza', 240),
('pieza', NULL),
('cucharada', 15);

-- Ingredientes (id autoincrement)
INSERT INTO "receta"."ingrediente" (nombre) VALUES
('Harina de trigo'),
('Azúcar refinada'),
('Mantequilla'),
('Huevo'),
('Vainilla líquida'),
('Polvo para hornear'),
('Sal fina'),
('Chocolate semiamargo'),
('Leche entera'),
('Canela en polvo');

-- Marcas (id autoincrement)
INSERT INTO "receta"."marca" (nombre) VALUES
('La Costeña'),
('Gamesa'),
('Lala'),
('Great Value'),
('San Marcos'),
('Pilgrims');

-- Tipos de producto
INSERT INTO "receta"."tipo" (nombre) VALUES
('Materia prima'),
('Producto terminado'),
('Decoración');

-- Tags
INSERT INTO "receta"."tags" (nombre) VALUES
('Dulce'),
('Desayuno'),
('Postre'),
('Chocolate'),
('Tradicional');

-- =========================================
-- PROVEEDORES
-- =========================================

INSERT INTO "user_schema"."proveedor" (id, nombre, num_celular) VALUES
('660e8400-e29b-41d4-a716-446655440001', 'Distribuidora Harinera del Pacífico', '6671234567'),
('660e8400-e29b-41d4-a716-446655440002', 'Lácteos y Más S.A.', '6672345678'),
('660e8400-e29b-41d4-a716-446655440003', 'Abarrotes Don Chuy', '6673456789');

-- =========================================
-- PRODUCTOS (INVENTARIO)
-- =========================================
-- OJO: aquí sí necesitamos saber los IDs generados arriba.
-- Asumo que quedaron así:
-- unidad: 1=gramo, 3=kilogramo, 5=pieza
-- ingrediente: 1=Harina, 2=Azúcar, 3=Mantequilla, 4=Huevo, 8=Chocolate
-- marca: 3=Lala, 4=Great Value, 2=Gamesa

-- Harina de trigo 25kg marca Great Value
INSERT INTO "receta"."producto" (
  id, id_ingrediente, id_marca, id_unidad,
  pzas, precio_medio, cantidad_inventario, cantidad_unitario,
  id_tipo, id_usuario
) VALUES (
  '650e8400-e29b-41d4-a716-446655440001',
  1, 4, 3,
  1, 450.00, 25, 1000,
  1, '550e8400-e29b-41d4-a716-446655440000'
);

-- Azúcar refinada 10kg marca Great Value
INSERT INTO "receta"."producto" (
  id, id_ingrediente, id_marca, id_unidad,
  pzas, precio_medio, cantidad_inventario, cantidad_unitario,
  id_tipo, id_usuario
) VALUES (
  '650e8400-e29b-41d4-a716-446655440002',
  2, 4, 3,
  1, 320.00, 10, 1000,
  1, '550e8400-e29b-41d4-a716-446655440000'
);

-- Mantequilla 1kg marca Lala
INSERT INTO "receta"."producto" (
  id, id_ingrediente, id_marca, id_unidad,
  pzas, precio_medio, cantidad_inventario, cantidad_unitario,
  id_tipo, id_usuario
) VALUES (
  '650e8400-e29b-41d4-a716-446655440003',
  3, 3, 3,
  1, 165.00, 5, 1000,
  1, '550e8400-e29b-41d4-a716-446655440000'
);

-- Huevo cartera 30pzas (≈50g c/u)
INSERT INTO "receta"."producto" (
  id, id_ingrediente, id_marca, id_unidad,
  pzas, precio_medio, cantidad_inventario, cantidad_unitario,
  id_tipo, id_usuario
) VALUES (
  '650e8400-e29b-41d4-a716-446655440004',
  4, 6, 5,
  30, 85.00, 120, 50,
  1, '550e8400-e29b-41d4-a716-446655440000'
);

-- Chocolate semiamargo 1kg marca Gamesa
INSERT INTO "receta"."producto" (
  id, id_ingrediente, id_marca, id_unidad,
  pzas, precio_medio, cantidad_inventario, cantidad_unitario,
  id_tipo, id_usuario
) VALUES (
  '650e8400-e29b-41d4-a716-446655440005',
  8, 2, 3,
  1, 190.00, 3, 1000,
  1, '550e8400-e29b-41d4-a716-446655440000'
);

-- =========================================
-- INSUMOS (PREPARACIONES INTERMEDIAS)
-- =========================================

INSERT INTO "receta"."insumo" (
  id, nombre, precio_unitario, id_unidad, id_usuario
) VALUES
('750e8400-e29b-41d4-a716-446655440001', 'Mezcla base para galletas', 6.50, 1, '550e8400-e29b-41d4-a716-446655440000'),
('750e8400-e29b-41d4-a716-446655440002', 'Cobertura de chocolate', 9.80, 1, '550e8400-e29b-41d4-a716-446655440000');

-- =========================================
-- RECETAS + TAGS + PASOS
-- =========================================

-- Receta 1: Galletas de vainilla
INSERT INTO "receta"."receta" (
  id, profit, nombre, porciones_totales, imagen_url, id_usuario
) VALUES (
  '850e8400-e29b-41d4-a716-446655440001',
  160.00,
  'Galletas de vainilla',
  24,
  'https://example.com/galletas-vainilla.jpg',
  '550e8400-e29b-41d4-a716-446655440000'
);

-- Receta 2: Galletas de chocolate
INSERT INTO "receta"."receta" (
  id, profit, nombre, porciones_totales, imagen_url, id_usuario
) VALUES (
  '850e8400-e29b-41d4-a716-446655440002',
  200.00,
  'Galletas de chocolate',
  20,
  'https://example.com/galletas-chocolate.jpg',
  '550e8400-e29b-41d4-a716-446655440000'
);

-- Tags de las recetas (tags.id asumido en orden de inserción)
-- 1=Dulce, 3=Postre, 4=Chocolate, 5=Tradicional
INSERT INTO "receta"."tags_receta" (id_receta, id_tags) VALUES
('850e8400-e29b-41d4-a716-446655440001', 1),
('850e8400-e29b-41d4-a716-446655440001', 3),
('850e8400-e29b-41d4-a716-446655440001', 5),
('850e8400-e29b-41d4-a716-446655440002', 1),
('850e8400-e29b-41d4-a716-446655440002', 3),
('850e8400-e29b-41d4-a716-446655440002', 4);

-- Pasos receta 1 (id autoincrement, no se especifica)
INSERT INTO "receta"."receta_pasos" (id_receta, paso, orden) VALUES
('850e8400-e29b-41d4-a716-446655440001', 'Batir mantequilla con azúcar hasta acremar.', 1),
('850e8400-e29b-41d4-a716-446655440001', 'Agregar huevo y vainilla, mezclar bien.', 2),
('850e8400-e29b-41d4-a716-446655440001', 'Incorporar harina, sal y polvo para hornear.', 3),
('850e8400-e29b-41d4-a716-446655440001', 'Formar bolitas y hornear a 180°C por 12 minutos.', 4);

-- Pasos receta 2
INSERT INTO "receta"."receta_pasos" (id_receta, paso, orden) VALUES
('850e8400-e29b-41d4-a716-446655440002', 'Preparar la mezcla base para galletas.', 1),
('850e8400-e29b-41d4-a716-446655440002', 'Agregar chocolate derretido a la mezcla.', 2),
('850e8400-e29b-41d4-a716-446655440002', 'Formar galletas y hornear a 180°C por 10–12 minutos.', 3);

-- =========================================
-- RELACIONES RECETA–PRODUCTO E INSUMO
-- =========================================

-- Receta 1: Galletas de vainilla (usa productos de inventario)
INSERT INTO "receta"."receta_producto" (
  id_receta, id_producto, cantidad
) VALUES
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', 500.00), -- harina 500 g
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440002', 300.00), -- azúcar 300 g
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440003', 250.00), -- mantequilla 250 g
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440004', 4.00);   -- 4 huevos

-- Receta 2: Galletas de chocolate (usa insumos intermedios)
INSERT INTO "receta"."receta_insumo" (
  id_receta, id_insumo, cantidad
) VALUES
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', 300.00),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 150.00);

-- =========================================
-- ENTRADAS (COMPRAS) + DETALLE (id autoincrement)
-- =========================================

-- Entrada 1 de proveedor harinera
INSERT INTO "receta"."entrada" (
  id, fecha, estado, total, id_proveedor
) VALUES (
  '990e8400-e29b-41d4-a716-446655440001',
  CURRENT_DATE - INTERVAL '10 days',
  TRUE,
  450.00,
  '660e8400-e29b-41d4-a716-446655440001'
);

INSERT INTO "receta"."detalle_entrada" (
  id_producto, id_entrada, precio, cantidad
) VALUES (
  '650e8400-e29b-41d4-a716-446655440001',
  '990e8400-e29b-41d4-a716-446655440001',
  450.00,
  1.00
);

-- Entrada 2 de lácteos
INSERT INTO "receta"."entrada" (
  id, fecha, estado, total, id_proveedor
) VALUES (
  '990e8400-e29b-41d4-a716-446655440002',
  CURRENT_DATE - INTERVAL '5 days',
  TRUE,
  165.00,
  '660e8400-e29b-41d4-a716-446655440002'
);

INSERT INTO "receta"."detalle_entrada" (
  id_producto, id_entrada, precio, cantidad
) VALUES (
  '650e8400-e29b-41d4-a716-446655440003',
  '990e8400-e29b-41d4-a716-446655440002',
  165.00,
  1.00
);

-- =========================================
-- SALIDAS (VENTAS) + DETALLE (id autoincrement)
-- =========================================

INSERT INTO "receta"."salida" (
  id, fecha, estado, total, id_receta
) VALUES (
  'a10e8400-e29b-41d4-a716-446655440001',
  CURRENT_DATE - INTERVAL '1 days',
  TRUE,
  480.00,
  '850e8400-e29b-41d4-a716-446655440001'
);

INSERT INTO "receta"."detalle_salida" (
  id_salida, id_producto, cantidad
) VALUES (
  'a10e8400-e29b-41d4-a716-446655440001',
  '650e8400-e29b-41d4-a716-446655440001',
  1
);