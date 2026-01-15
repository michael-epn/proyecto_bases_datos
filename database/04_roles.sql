
CREATE USER 'admin_panaderia'@'localhost' IDENTIFIED BY 'AdminSecurePass2025!';
GRANT ALL PRIVILEGES ON panaderia_db.* TO 'admin_panaderia'@'localhost';


CREATE USER 'app_vendedor'@'localhost' IDENTIFIED BY 'VentaUser123!';


GRANT SELECT ON panaderia_db.productos TO 'app_vendedor'@'localhost';
GRANT SELECT ON panaderia_db.insumos TO 'app_vendedor'@'localhost';

GRANT INSERT ON panaderia_db.ventas_cabecera TO 'app_vendedor'@'localhost';
GRANT INSERT ON panaderia_db.detalle_ventas TO 'app_vendedor'@'localhost';

GRANT UPDATE ON panaderia_db.usuarios TO 'app_vendedor'@'localhost';


CREATE USER 'auditor_gerente'@'localhost' IDENTIFIED BY 'AuditPass2025!';
GRANT SELECT ON panaderia_db.* TO 'auditor_gerente'@'localhost';


FLUSH PRIVILEGES;
