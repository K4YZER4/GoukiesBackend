-- V7: Datos semilla (seed) iniciales
-- Moneda
INSERT INTO user_schema.moneda (codigo, nombre) VALUES ('MXN', 'Peso Mexicano');

-- Usuario de prueba
INSERT INTO user_schema.usuario (id, nombre, correo_electronico, contrasena_hash, moneda_codigo)
VALUES ('550e8400-e29b-41d4-a716-446655440000', 'Galletas Deliciosas', 'admin@galletasdeliciosas.com', 'hashed_password_123', 'MXN');

-- Unidades
INSERT INTO receta.unidad (id, nombre, cantidad_gramos) VALUES
(1, 'gramo', 1),
(2, 'mililitro', 1),
(3, 'libra', 454),
(4, 'kilogramo', 1000),
(5, 'cucharada', 15),
(6, 'taza', 240);

-- Ingredientes
INSERT INTO receta.ingrediente (id, nombre) VALUES
(1, 'Harina'), (2, 'Azúcar'), (3, 'Mantequilla'),
(4, 'Huevo'), (5, 'Vainilla'), (6, 'Polvo de Hornear'),
(7, 'Sal'), (8, 'Chocolate');

-- Marcas
INSERT INTO receta.marca (id, nombre) VALUES
(1, 'Genérica'), (2, 'Premium'), (3, 'La Costeña');

-- Tipos
INSERT INTO receta.tipo (id, nombre) VALUES
(1, 'Ingrediente'), (2, 'Acabado');

-- Tags
INSERT INTO receta.tags (id, nombre) VALUES
(1, 'Dulce'), (2, 'Integral'), (3, 'Sin Gluten');

-- Productos
INSERT INTO receta.producto (id, id_ingrediente, id_marca, id_unidad, pzas, precio_medio, cantidad_inventario, cantidad_unitario, id_tipo, id_usuario) VALUES
('650e8400-e29b-41d4-a716-446655440001', 1, 1, 4, 1, 30.00, 100, 1000, 1, '550e8400-e29b-41d4-a716-446655440000'),
('650e8400-e29b-41d4-a716-446655440002', 3, 1, 1, 1, 60.00, 50, 500, 1, '550e8400-e29b-41d4-a716-446655440000'),
('650e8400-e29b-41d4-a716-446655440003', 2, 1, 4, 1, 25.00, 80, 1000, 1, '550e8400-e29b-41d4-a716-446655440000'),
('650e8400-e29b-41d4-a716-446655440004', 4, 1, 1, 12, 45.00, 100, 50, 1, '550e8400-e29b-41d4-a716-446655440000'),
('650e8400-e29b-41d4-a716-446655440005', 6, 1, 1, 1, 12.00, 30, 100, 1, '550e8400-e29b-41d4-a716-446655440000'),
('650e8400-e29b-41d4-a716-446655440006', 8, 2, 1, 1, 80.00, 40, 500, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Insumos
INSERT INTO receta.insumo (id, nombre, precio_unitario, id_unidad, id_usuario) VALUES
('750e8400-e29b-41d4-a716-446655440001', 'Mezcla Base', 5.50, 1, '550e8400-e29b-41d4-a716-446655440000'),
('750e8400-e29b-41d4-a716-446655440002', 'Decoración de Azúcar', 2.00, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Recetas
INSERT INTO receta.receta (id, profit, nombre, porciones_totales, imagen_url, id_usuario) VALUES
('850e8400-e29b-41d4-a716-446655440001', 150.00, 'Galletas de Vainilla', 24, 'https://example.com/galletas-vainilla.jpg', '550e8400-e29b-41d4-a716-446655440000'),
('850e8400-e29b-41d4-a716-446655440002', 225.00, 'Galletas de Chocolate', 20, 'https://example.com/galletas-chocolate.jpg', '550e8400-e29b-41d4-a716-446655440000'),
('850e8400-e29b-41d4-a716-446655440003', 200.00, 'Galletas de Mantequilla', 18, 'https://example.com/galletas-mantequilla.jpg', '550e8400-e29b-41d4-a716-446655440000'),
('850e8400-e29b-41d4-a716-446655440004', 150.00, 'Galletas Integrales', 22, 'https://example.com/galletas-integrales.jpg', '550e8400-e29b-41d4-a716-446655440000'),
('850e8400-e29b-41d4-a716-446655440005', 225.00, 'Galletas Decoradas', 16, 'https://example.com/galletas-decoradas.jpg', '550e8400-e29b-41d4-a716-446655440000');

-- Receta-Insumo
INSERT INTO receta.receta_insumo (id_receta, id_insumo, cantidad) VALUES
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 200.00),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', 250.00),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440001', 180.00),
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440001', 220.00),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440001', 200.00),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440002', 30.00);

-- Receta-Producto
INSERT INTO receta.receta_producto (id_receta, id_producto, cantidad) VALUES
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', 300.00),
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440003', 150.00),
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440002', 100.00),
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440004', 100.00),
('850e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', 350.00),
('850e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440006', 80.00);

-- Tags receta
INSERT INTO receta.tags_receta (id_receta, id_tags) VALUES
('850e8400-e29b-41d4-a716-446655440001', 1),
('850e8400-e29b-41d4-a716-446655440002', 1),
('850e8400-e29b-41d4-a716-446655440004', 2),
('850e8400-e29b-41d4-a716-446655440005', 1);
