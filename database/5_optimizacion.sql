/* CREACIÓN DE ÍNDICES PARA OPTIMIZACIÓN */

CREATE INDEX idx_productos_nombre ON productos(nombre);

CREATE INDEX idx_insumos_nombre ON insumos(nombre);

CREATE INDEX idx_ventas_fecha ON ventas_cabecera(fecha_venta);

CREATE INDEX idx_usuarios_rol ON usuarios(id_rol);


/* ANÁLISIS DE RENDIMIENTO */

EXPLAIN SELECT * FROM productos WHERE nombre = 'Pan Enrollado';

EXPLAIN SELECT * FROM ventas_cabecera WHERE fecha_venta BETWEEN '2025-01-01' AND '2025-12-31';

EXPLAIN SELECT p.nombre, d.cantidad 
FROM detalle_ventas d 
JOIN productos p ON d.id_producto = p.id_producto;