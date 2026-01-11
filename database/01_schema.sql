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
    CONSTRAINT fk_receta_insumo FOREIGN KEY (id_insumo) REFERENCES insumos(id_insumo)
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