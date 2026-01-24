DROP PROCEDURE IF EXISTS pruebas;

DELIMITER //

CREATE PROCEDURE pruebas()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 10000 DO
        INSERT INTO ventas_cabecera (id_usuario, total_venta) VALUES (2, RAND() * 100);
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL pruebas();
