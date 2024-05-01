-- Eliminar todos los datos de las tablas existentes para evitar duplicados
DELETE FROM `FOURPARKSDATABASE`.`USER`;
DELETE FROM `FOURPARKSDATABASE`.`DOCUMENTTYPE`;
DELETE FROM `FOURPARKSDATABASE`.`PARKING`;
DELETE FROM `FOURPARKSDATABASE`.`CITY`;
DELETE FROM `FOURPARKSDATABASE`.`ADDRESS`;
DELETE FROM `FOURPARKSDATABASE`.`PARKINGTYPE`;
DELETE FROM `FOURPARKSDATABASE`.`SCHEDULE`;

-- Insertar tipos de documento primero
INSERT INTO `FOURPARKSDATABASE`.`DOCUMENTTYPE` (`IDDOCTYPE`, `DESCDOCTYPE`) 
VALUES 
    ('1', 'DNI'),
    ('2', 'Pasaporte'),
    ('3', 'Carnet de conducir');

-- Insertar usuarios después de los tipos de documento
INSERT INTO `FOURPARKSDATABASE`.`USER` (`IDUSER`, `FIRSTNAME`, `LASTNAME`, `IDDOCTYPEFK`, `EMAIL`, `PHONE`)
VALUES 
    ('1234567890123', 'Juan', 'Pérez', '1', 'juan@example.com', '123456789'),    -- DNI
    ('9876543210987', 'María', 'Gómez', '2', 'maria@example.com', '987654321'),    -- Pasaporte
    ('4567890123456', 'Pedro', 'Martínez', '1', 'pedro@example.com', '456789012'), -- DNI
    ('7890123456789', 'Ana', 'López', '3', 'ana@example.com', '789012345'),      -- Carnet de conducir
    ('6543210987654', 'Luis', 'Rodríguez', '2', 'luis@example.com', '654321098'); -- Pasaporte
    
-- Insertar Autenticacion de usuarios después de los usuarios
INSERT INTO `FOURPARKSDATABASE`.`USER_AUTHENTICATION` (`IDUSER`, `IDDOCTYPEFK`, `USERNAME`, `PASSWORD`, `ROLE`)
VALUES
    ('1234567890123', '1', 'juanperez', 'contraseña1','CLIENT'),
    ('9876543210987', '2', 'mariagomez', 'contraseña2','CLIENT'),
    ('4567890123456', '1', 'pedromartinez', 'contraseña3','CLIENT'),
    ('7890123456789', '3', 'analopez', 'contraseña4','CLIENT'),
    ('6543210987654', '2', 'luisrodriguez', 'contraseña5','CLIENT');

-- Insertar administradores después de los usuarios y autenticaciones
INSERT INTO `FOURPARKSDATABASE`.`ADMINISTRATOR` (`USER_IDUSER`, `USER_IDDOCTYPEFK`)
VALUES
    ('9876543210987', '2'), -- María Gómez - Pasaporte
    ('4567890123456', '1'); -- Pedro Martínez - DNI

-- Insertar ciudades
ALTER TABLE CITY AUTO_INCREMENT = 1; 
INSERT INTO `FOURPARKSDATABASE`.`CITY` (`NAME`,`B_TOP`,`B_BOTTOM`,`B_LEFT`,`B_RIGHT`) 
VALUES 
    ('Bogota',-74.7800,-74.8100,4.2900,4.3100),
    ('Medellin',-75.7800,-75.8100,4.2900,4.3100),
    ('Cali',-76.7800,-76.8100,4.2900,4.3100);

-- Insertar direcciones en la tabla ADDRESS
INSERT INTO `FOURPARKSDATABASE`.`ADDRESS` (`DESCADDRESS`, `COORDINATESX`, `COORDINATESY`) 
VALUES 
    ('Dirección 1', 4.2989, -74.8096),
    ('Dirección 2', 4.3034, -74.8080),
    ('Dirección 3', 4.3030, -74.7996),
    ('Dirección 4', 4.29792, -74.80894);


-- Insertar tipos de estacionamiento
INSERT INTO `FOURPARKSDATABASE`.`PARKINGTYPE` (`IDPARKINGTYPE`, `DESCPARKINGTYPE`) 
VALUES 
    (1, 'Uncovered'),
    (2, 'SemiCovered'),
    (3, 'Covered');

-- Insertar horarios
INSERT INTO `FOURPARKSDATABASE`.`SCHEDULE` (`IDSCHEDULE`, `STARTTIME`, `ENDTIME`, `SCHEDULETYPE`) 
VALUES 
    (1, '08:00:00', '18:00:00', 'Weekdays'),
    (2, '08:00:00', '20:00:00', 'Weekends'),
    (3, '00:00:00', '23:59:59', 'Full Time');

-- Insertar estacionamientos
INSERT INTO `FOURPARKSDATABASE`.`PARKING` (`NAMEPARK`, `CAPACITY`, `ADDRESS_COORDINATESX`, `ADDRESS_COORDINATESY`, `PARKINGTYPE_IDPARKINGTYPE`, `PHONE`, `EMAIL`, `CITY_IDCITY`, `SCHEDULE_IDSCHEDULE`, `ADMINISTRADOR_USER_IDUSER`, `ADMINISTRADOR_USER_IDDOCTYPEFK`) 
VALUES 
    ('Parking Lot A', 100, 4.2989, -74.8096, 1, '123-4567', 'parkinglotA@example.com', 1, 1,'9876543210987', '2'),
    ('Outdoor Park B', 200, 4.3034, -74.8080, 2, '987-6543', 'outdoorparkB@example.com', 2, 2,'9876543210987', '2'),
    ('Covered Park C', 30, 4.3030, -74.7996, 3, '601-8877', 'parkingexample@example.com', 1, 2,'9876543210987', '2'),
    ('Outdoor Park A', 56, 4.29792, -74.80894, 2, '312-1233', 'outdorfp@example.com', 1, 1,'4567890123456', '1');

