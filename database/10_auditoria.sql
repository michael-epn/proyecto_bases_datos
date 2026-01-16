CREATE TABLE auditoria_insumos (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(20) NOT NULL, -- 'INSERT', 'UPDATE' o 'DELETE'
    id_insumo INT NOT NULL,
    nombre_insumo VARCHAR(100),
    valor_anterior DECIMAL(10,2), -- Cuánto había antes
    valor_nuevo DECIMAL(10,2),    -- Cuánto hay ahora
    usuario VARCHAR(100),         -- Quién hizo el cambio
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //

CREATE TRIGGER audit_insumos_update
AFTER UPDATE ON insumos
FOR EACH ROW
BEGIN
    -- Solo registramos si cambió el stock o el precio
    IF OLD.stock_actual <> NEW.stock_actual OR OLD.costo_unitario <> NEW.costo_unitario THEN
        INSERT INTO auditoria_insumos 
        (accion, id_insumo, nombre_insumo, valor_anterior, valor_nuevo, usuario)
        VALUES 
        ('UPDATE', OLD.id_insumo, OLD.nombre, OLD.stock_actual, NEW.stock_actual, CURRENT_USER());
    END IF;
END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER audit_insumos_delete
AFTER DELETE ON insumos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_insumos 
    (accion, id_insumo, nombre_insumo, valor_anterior, valor_nuevo, usuario)
    VALUES 
    ('DELETE', OLD.id_insumo, OLD.nombre, OLD.stock_actual, NULL, CURRENT_USER());
END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER audit_insumos_insert
AFTER INSERT ON insumos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_insumos 
    (accion, id_insumo, nombre_insumo, valor_anterior, valor_nuevo, usuario)
    VALUES 
    ('INSERT', NEW.id_insumo, NEW.nombre, NULL, NEW.stock_actual, CURRENT_USER());
END //

DELIMITER ;
-- 1. Modificar el stock de la Harina (Simular un ajuste manual)
UPDATE insumos SET stock_actual = 90 WHERE nombre = 'Harina de Trigo';

-- 2. Ver qué pasó en la tabla de auditoría
SELECT * FROM auditoria_insumos;