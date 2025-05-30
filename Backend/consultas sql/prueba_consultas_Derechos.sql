
--probando tablas

INSERT INTO Personas (DPI, Nombre, Direccion, Telefono, Email, Rol, Estado)
VALUES 
('1234567890123', 'Darwin López', 'Calle Principal 123', '555123456', 'darwin@email.com', 'Presidente', 1),
('9876543210987', 'Ana Pérez', 'Avenida Central 456', '555987654', NULL, 'Secretario', 1);


INSERT INTO Derechos (Nombre)
VALUES 
('Agua potable'),
('Agua de riego');

INSERT INTO Persona_Derecho (ID_Persona, ID_Derecho, Fecha_Inicio)
VALUES 
(4, 1, '2023-01-01'), -- Darwin López tiene agua potable desde el 1 de enero de 2023
(4, 2, '2023-02-01'), -- Darwin López tiene agua de riego desde el 1 de febrero de 2023
(5, 1, '2023-03-01'); -- Ana Pérez tiene agua potable desde el 1 de marzo de 2023

SELECT  * FROM  Personas;
SELECT  * FROM  Derechos;


SELECT 
    p.Nombre AS Persona,
    d.Nombre AS Derecho,
    pd.Fecha_Inicio,
    pd.Fecha_Fin
FROM 
    Persona_Derecho pd
INNER JOIN Personas p ON pd.ID_Persona = p.ID_Persona
INNER JOIN Derechos d ON pd.ID_Derecho = d.ID_Derecho;


UPDATE Persona_Derecho
SET Fecha_Fin = '2023-06-01'
WHERE ID_Persona = 4 AND ID_Derecho = 1;

SELECT d.Nombre AS Derecho
FROM Persona_Derecho pd
INNER JOIN Derechos d ON pd.ID_Derecho = d.ID_Derecho
WHERE pd.ID_Persona = 4; -- Derechos de Darwin López


USE COCODE_Gestion;
-- PRUEBA INSERCION DE DATOS CUOTAS

INSERT INTO Cuotas (Descripcion, Monto, Fecha_Limite)
VALUES 
('Agua potable', 50.00, '2023-07-01'),
('Limpieza', 20.00, '2023-07-15'),
('Electricidad', 100.00, '2023-07-30');


INSERT INTO Pagos (ID_Persona, ID_Cuota, Fecha_Pago, Monto_Pagado, Estado)
VALUES 
(4, 1, '2023-06-30', 50.00, 'Completado'),  -- Darwin paga agua potable
(4, 2, '2023-06-29', 10.00, 'Pendiente'),   -- Darwin paga limpieza parcialmente
(5, 1, '2023-07-01', 50.00, 'Completado');  -- Ana paga agua potable

SELECT 
    p.Nombre AS Persona,
    c.Descripcion AS Cuota,
    pg.Fecha_Pago,
    pg.Monto_Pagado,
    pg.Estado
FROM 
    Pagos pg
INNER JOIN Personas p ON pg.ID_Persona = p.ID_Persona
INNER JOIN Cuotas c ON pg.ID_Cuota = c.ID_Cuota;


---PARA INGRESOS

INSERT INTO Ingresos (Fecha, Monto, Fuente, Observaciones)
VALUES 
('2023-06-30', 50.00, 'Pago de agua potable', NULL),
('2023-07-01', 100.00, 'Donación de comunidad', 'Para proyecto de limpieza');

INSERT INTO Egresos (Fecha, Monto, Descripcion)
VALUES 
('2023-06-28', 30.00, 'Compra de materiales para reparación'),
('2023-07-02', 20.00, 'Pago por servicio de limpieza');



SELECT * FROM Personas;


USE COCODE_Gestion;

TRUNCATE TABLE Personas;
TRUNCATE TABLE Pagos;
TRUNCATE TABLE Personas_Derecho;
TRUNCATE TABLE Cuotas;
TRUNCATE TABLE Derechos;
TRUNCATE TABLE Egresos;
TRUNCATE TABLE Ingresos;


EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT ALL"
EXEC sp_MSforeachtable "DELETE FROM ?"
EXEC sp_MSforeachtable "DBCC CHECKIDENT ('?', RESEED, 0)"

EXEC sp_MSforeachtable "ALTER TABLE ? CHECK CONSTRAINT ALL"
