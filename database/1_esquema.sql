DROP DATABASE IF EXISTS panaderia;
CREATE DATABASE panaderia;
USE panaderia;

CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(100) NOT NULL,
    contacto_nombre VARCHAR(100),
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE insumos (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL,
    stock_actual DECIMAL(10,2) DEFAULT 0 CHECK (stock_actual >= 0),
    costo_unitario DECIMAL(10,2) DEFAULT 0 CHECK (costo_unitario >= 0)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_venta DECIMAL(10,2) NOT NULL CHECK (precio_venta >= 0)
);

CREATE TABLE recetas (
    id_receta INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad_requerida DECIMAL(10,4) NOT NULL CHECK (cantidad_requerida > 0),
    CONSTRAINT fk_receta_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT fk_receta_insumo FOREIGN KEY (id_insumo) REFERENCES insumos(id_insumo),
    CONSTRAINT uk_receta_ingrediente UNIQUE (id_producto, id_insumo)
);

CREATE TABLE compras_cabecera (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_proveedor INT NOT NULL,
    id_usuario INT NOT NULL,
    CONSTRAINT fk_compra_prov FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    CONSTRAINT fk_compra_usu FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE detalle_compras (
    id_detalle_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_compra INT NOT NULL,
    id_insumo INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL CHECK (cantidad > 0),
    costo_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_det_compra_cab FOREIGN KEY (id_compra) REFERENCES compras_cabecera(id_compra),
    CONSTRAINT fk_det_compra_ins FOREIGN KEY (id_insumo) REFERENCES insumos(id_insumo)
);

CREATE TABLE ventas_cabecera (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT NOT NULL,
    total_venta DECIMAL(10,2) DEFAULT 0,
    CONSTRAINT fk_venta_usu FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE detalle_ventas (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    CONSTRAINT fk_det_venta_cab FOREIGN KEY (id_venta) REFERENCES ventas_cabecera(id_venta),
    CONSTRAINT fk_det_venta_prod FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO roles (nombre_rol) VALUES 
('Administrador'), 
('Vendedor'), 
('Panadero');

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
(1, 2, 5, 0.25),
(1, 3, 1, 1.50);