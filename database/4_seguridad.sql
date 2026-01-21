UPDATE usuarios 
SET password = SHA2(password, 256)
WHERE LENGTH(password) < 60;

DELIMITER //

CREATE PROCEDURE sp_login_seguro(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT id_usuario, nombre_completo, id_rol
    FROM usuarios
    WHERE username = p_username 
      AND password = SHA2(p_password, 256);
END //

DELIMITER ;

/* EVITAR INJECCIÓN */

DELIMITER //
CREATE PROCEDURE buscarInsumos(IN in_id INT)
BEGIN
    SELECT * FROM insumos WHERE id_insumo = in_id;
END //
DELIMITER ;

DELIMITER //

CREATE FUNCTION obtenerInsumo(in_id INT) 
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_insumo VARCHAR(100);
    
    SELECT nombre INTO v_insumo 
    FROM insumos 
    WHERE id_insumo = in_id 
    LIMIT 1;
    
    RETURN v_insumo;
END //

DELIMITER ;

/* VIEW */

CREATE VIEW v_info_usuarios_publica AS
SELECT 
    id_usuario,
    nombre_completo,
    username
FROM usuarios;

/* COMPRA SEGURA */

DELIMITER //

CREATE PROCEDURE sp_registrar_compra_segura(
    IN p_id_proveedor INT,
    IN p_id_usuario INT,
    IN p_id_insumo INT,
    IN p_cantidad DECIMAL(10,2),
    IN p_costo_unitario DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: Transacción cancelada.' AS mensaje;
    END;

    START TRANSACTION;

    INSERT INTO compras_cabecera (id_proveedor, id_usuario) 
    VALUES (p_id_proveedor, p_id_usuario);
    
    SET @id_nueva_compra = LAST_INSERT_ID();

    INSERT INTO detalle_compras (id_compra, id_insumo, cantidad, costo_unitario)
    VALUES (@id_nueva_compra, p_id_insumo, p_cantidad, p_costo_unitario);

    UPDATE insumos 
    SET stock_actual = stock_actual + p_cantidad 
    WHERE id_insumo = p_id_insumo;

    COMMIT;
    
    SELECT 'Éxito: Compra registrada y stock actualizado.' AS mensaje;
END //

DELIMITER ;