
SELECT 
    v.fecha_venta,
    u.nombre_completo AS vendedor,
    p.nombre AS producto,
    d.cantidad,
    d.precio_unitario,
    d.subtotal
FROM ventas_cabecera v
JOIN usuarios u ON v.id_usuario = u.id_usuario
JOIN detalle_ventas d ON v.id_venta = d.id_ventarmdir /s /q .git
JOIN productos p ON d.id_producto = p.id_producto
ORDER BY v.fecha_venta DESC;


SELECT 
    p.nombre AS producto,
    i.nombre AS ingrediente,
    r.cantidad_requerida,
    i.unidad_medida
FROM recetas r
JOIN productos p ON r.id_producto = p.id_producto
JOIN insumos i ON r.id_insumo = i.id_insumo
WHERE p.nombre = 'Pan Enrollado';


SELECT 
    pr.empresa AS proveedor,
    i.nombre AS materia_prima,
    dc.cantidad,
    dc.costo_unitario,
    cc.fecha_compra
FROM detalle_compras dc
JOIN compras_cabecera cc ON dc.id_compra = cc.id_compra
JOIN insumos i ON dc.id_insumo = i.id_insumo
JOIN proveedores pr ON cc.id_proveedor = pr.id_proveedor;

SELECT 
    p.nombre,
    SUM(d.cantidad) AS total_unidades_vendidas,
    SUM(d.subtotal) AS dinero_generado
FROM detalle_ventas d
JOIN productos p ON d.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY dinero_generado DESC;

SELECT 
    u.nombre_completo,
    u.username,
    r.nombre_rol
FROM usuarios u
JOIN roles r ON u.id_rol = r.id_rol;

SELECT 
    nombre,
    stock_actual,
    costo_unitario,
    (stock_actual * costo_unitario) AS valor_total_inventario
FROM insumos
ORDER BY valor_total_inventario DESC;

SELECT 
    DATE(fecha_venta) AS dia,
    COUNT(id_venta) AS numero_facturas,
    SUM(total_venta) AS cierre_caja
FROM ventas_cabecera
WHERE DATE(fecha_venta) = CURDATE()
GROUP BY DATE(fecha_venta);

SELECT 
    UPPER(nombre) AS INSUMO_MAYUSCULAS,
    CONCAT(stock_actual, ' ', unidad_medida) AS stock_formateado
FROM insumos;

SELECT nombre, precio_venta
FROM productos
WHERE precio_venta > (
    SELECT AVG(precio_venta) FROM productos
);

SELECT nombre, stock_actual
FROM insumos
WHERE stock_actual < 10;

CREATE VIEW v_resumen_diario AS
SELECT 
    v.fecha_venta,
    u.nombre_completo AS vendedor,
    v.total_venta
FROM ventas_cabecera v
JOIN usuarios u ON v.id_usuario = u.id_usuario;



UPDATE productos
SET precio_venta = precio_venta * 1.05
WHERE nombre = 'Pan de Agua';

UPDATE insumos
SET stock_actual = stock_actual - 10
WHERE nombre = 'Harina de Trigo';

DELETE FROM productos
WHERE nombre = 'Galleta de Avena Experimental';

INSERT INTO usuarios (nombre_completo, username, password, id_rol) 
VALUES ('Pedro El Panadero', 'pedropan', 'secreto123', 3);

