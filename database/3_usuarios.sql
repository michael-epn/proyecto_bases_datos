CREATE USER 'admin_panaderia'@'localhost' IDENTIFIED BY 'Admin2025';
GRANT ALL PRIVILEGES ON panaderia.* TO 'admin_panaderia'@'localhost';

CREATE USER 'vendedor'@'localhost' IDENTIFIED BY 'Ventas123';
GRANT SELECT ON panaderia.productos TO 'vendedor'@'localhost';
GRANT SELECT ON panaderia.insumos TO 'vendedor'@'localhost';
GRANT INSERT ON panaderia.ventas_cabecera TO 'vendedor'@'localhost';
GRANT INSERT ON panaderia.detalle_ventas TO 'vendedor'@'localhost';

CREATE USER 'auditor_gerente'@'localhost' IDENTIFIED BY 'Auditor2026';
GRANT SELECT ON panaderia.* TO 'auditor_gerente'@'localhost';

FLUSH PRIVILEGES;
