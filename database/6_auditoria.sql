CREATE TABLE auditoria_insumos (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(20) NOT NULL, 
    id_insumo INT NOT NULL,
    nombre_insumo VARCHAR(100),
    valor_anterior DECIMAL(10,2),
    valor_nuevo DECIMAL(10,2),
    usuario VARCHAR(100),
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER audit_insumos_update
AFTER UPDATE ON insumos
FOR EACH ROW
BEGIN
    IF OLD.stock_actual <> NEW.stock_actual OR OLD.costo_unitario <> NEW.costo_unitario THEN
        INSERT INTO auditoria_insumos 
        (accion, id_insumo, nombre_insumo, valor_anterior, valor_nuevo, usuario)
        VALUES 
        ('UPDATE', OLD.id_insumo, OLD.nombre, OLD.stock_actual, NEW.stock_actual, CURRENT_USER());
    END IF;
END //

CREATE TRIGGER audit_insumos_delete
AFTER DELETE ON insumos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_insumos 
    (accion, id_insumo, nombre_insumo, valor_anterior, valor_nuevo, usuario)
    VALUES 
    ('DELETE', OLD.id_insumo, OLD.nombre, OLD.stock_actual, NULL, CURRENT_USER());
END //

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


UPDATE insumos SET stock_actual = 500 WHERE nombre = 'Harina de Trigo';
SELECT * FROM auditoria_insumos;