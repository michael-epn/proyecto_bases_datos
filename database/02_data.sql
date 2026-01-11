INSERT INTO roles (nombre_rol) VALUES ('Administrador'), ('Vendedor'), ('Panadero');

INSERT INTO usuarios (nombre_completo, username, password, id_rol) VALUES 
('Juan Perez', 'admin', '12345', 1),
('Maria Lopez', 'vendedora1', '12345', 2),
('Carlos Panadero', 'panadero1', '12345', 3);

INSERT INTO proveedores (empresa, contacto_nombre, telefono) VALUES 
('Molino Superior', 'Roberto Gomez', '0991234567'),
('Distribuidora Lacteos', 'Ana Silva', '0987654321');

INSERT INTO insumos (nombre, unidad_medida, stock_actual, costo_unitario) VALUES 
('Harina de Trigo', 'kg', 100.00, 1.50),
('Levadura Fresca', 'gr', 5000.00, 0.05),
('Azúcar', 'kg', 50.00, 1.20),
('Huevos', 'unidad', 200.00, 0.15),
('Leche', 'litros', 40.00, 0.90);

INSERT INTO productos (nombre, descripcion, precio_venta) VALUES 
('Pan de Agua', 'Pan tradicional pequeño', 0.15),
('Pan Enrollado', 'Pan con mantequilla y azúcar', 0.25),
('Pastel de Chocolate', 'Porción individual', 2.50);

INSERT INTO recetas (id_producto, id_insumo, cantidad_requerida) VALUES 
(2, 1, 0.1000),
(2, 2, 5.0000),
(2, 3, 0.0200);

INSERT INTO ventas_cabecera (id_usuario, total_venta) VALUES (2, 2.75);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES 
(1, 2, 5, 0.25), -- 5 * 0.25 = 1.25
(1, 3, 1, 1.50); -- 1 * 1.50 = 1.50  (Total 2.75)