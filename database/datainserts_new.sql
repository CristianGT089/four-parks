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
    ('CC', 'Cedula'),
    ('TI', 'Tarjeta de identidad'),
    ('CI', 'Cedula de extranjeria');

-- Insertar usuarios después de los tipos de documento
INSERT INTO `FOURPARKSDATABASE`.`USER` (`IDUSER`, `FIRSTNAME`, `LASTNAME`, `FK_IDDOCTYPE`, `EMAIL`, `PHONE`)
VALUES
    ('1234567890123', 'Juan', 'Perez', 'CC', 'juan@example.com', '123456789'),    -- Cedula
    ('9876543210987', 'Maria', 'Gomez', 'TI', 'maria@example.com', '987654321'),    -- Tarjeta de identidad
    ('4567890123456', 'Pedro', 'Martinez', 'CC', 'pedro@example.com', '456789012'), -- Cedula
    ('7890123456789', 'Ana', 'Lopez', 'CI', 'ana@example.com', '789012345'),      -- Cedula de extranjeria
    ('6543210987654', 'Luis', 'Rodriguez', 'TI', 'luis@example.com', '654321098'); -- Tarjeta de identidad

-- Insertar Autenticacion de usuarios después de los usuarios
INSERT INTO `FOURPARKSDATABASE`.`USER_AUTHENTICATION` (`IDUSER`, `FK_IDDOCTYPE`, `USERNAME`, `PASSWORD`, `ROLE`, `ATTEMPTS`,`ISBLOCKED`)
VALUES
    ('1234567890123', 'CC', 'juanperez', '$2a$10$QaazF..XTCslpdfjsNS.ZO3O6VhyG4roY6JJcE9TYc93W5ZbMbfwa','CLIENT',0,0),
    ('9876543210987', 'TI', 'mariagomez', '$2a$10$QaazF..XTCslpdfjsNS.ZO3O6VhyG4roY6JJcE9TYc93W5ZbMbfwa','ADMIN',0,0),
    ('4567890123456', 'CC', 'pedromartinez', '$2a$10$QaazF..XTCslpdfjsNS.ZO3O6VhyG4roY6JJcE9TYc93W5ZbMbfwa','ADMIN',0,0),
    ('7890123456789', 'CI', 'analopez', '$2a$10$QaazF..XTCslpdfjsNS.ZO3O6VhyG4roY6JJcE9TYc93W5ZbMbfwa','CLIENT',0,0),
    ('6543210987654', 'TI', 'luisrodriguez', '$2a$10$QaazF..XTCslpdfjsNS.ZO3O6VhyG4roY6JJcE9TYc93W5ZbMbfwa','CLIENT',0,0);

-- Insertar ciudades
INSERT INTO `FOURPARKSDATABASE`.`CITY` (`IDCITY`, `NAME`, `B_TOP`, `B_BOTTOM`, `B_LEFT`, `B_RIGHT`, `X_CENTER`, `Y_CENTER`)
VALUES
    ('CAL', 'Cali', 3.4961, 3.3611, -76.5716, -76.4647, 3.4301, -76.5129),
    ('BAQ', 'Barranquilla', 11.0405, 10.9231, -74.8785, -74.7571, 10.9725, -74.8018),
    ('BGT', 'Bogota', 4.7694, 4.4861, -74.2034, -74.0232, 4.6596, -74.0915),
    ('MED', 'Medellin', 6.3139, 6.1729, -75.6478, -75.5190, 6.2385, -75.5760),
    ('CTG', 'Cartagena', 10.4494, 10.3931, -75.4338, -75.5619, 10.3956, -75.5008),
    ('MQR', 'Mosquera', 4.7238, 4.6958, -74.2491, -74.2102, 4.7041, -74.2339),
    ('VIL', 'Villavicencio', 4.1722, 4.1054, -73.6642, -73.5853, 4.1374, -73.6247),
    ('BCM', 'Bucaramanga', 7.1521, 7.0861, -73.1455, -73.0790, 7.1244, -73.1183),
    ('PAS', 'Pasto', 1.2341, 1.1796, -77.3032, -77.2431, 1.2134, -77.2782),
    ('SOA', 'Soacha', 4.6116, 4.5564, -74.2496, -74.1722, 4.5817, -74.2197),
    ('MTR', 'Monteria', 8.7842, 8.7129, -75.8341, -75.9153, 8.7507, -75.8784),
    ('MZS', 'Manizales', 5.0820, 5.0505, -75.4832, -75.5320, 5.0656, -75.5068),
    ('PER', 'Pereira', 4.7955, 5.0505, -75.6667, -75.7332, 4.8147, -75.6989);



-- Insertar direcciones en la tabla ADDRESS
INSERT INTO `FOURPARKSDATABASE`.`ADDRESS` (`COORDINATESX`, `COORDINATESY`, `DESCADDRESS`)
VALUES
    (3.4433, -76.5248, 'Calle 16, Sucre, Comuna 9, Cali, Sur, Valle del Cauca'),
    (10.99364, -74.80474, 'Carrera 46, Barrio Colombia, Localidad Norte - Centro Historico, Barranquilla'),
    (6.2421, -75.5688, 'Calle 42, Colon, Comuna 10 - La Candelaria, Medellin, Valle de Aburra, Antioquia'),
    (10.4238, -75.5453, 'Avenida Daniel Lemaitre, Getsemani, Cartagena, Dique, Bolivar'),
    (4.7075, -74.2298, 'Calle 5, Centro Mosquera, Mosquera, Sabana Occidente, Cundinamarca'),
    (4.1350, -73.6219, 'Avenida 19, Bello Horizonte, Comuna 5, Villavicencio, Meta'),
    (7.1254, -73.1180, 'Carrera 27, Comuna 13 - Oriental, Bucaramanga, Metropolitana'),
    (1.2138, -77.2820, 'Carrera 25, Las Cuadras, Comuna 1, Pasto, Centro, Nariño'),
    (4.5804, -74.2183, 'Carrera 6, San Luis, Soacha Central, Soacha ciudad, Soacha, Cundinamarca'),
    (4.6514, -74.0676, 'Calle 63A, Localidad Barrios Unidos, Bogota'),
    (4.6478, -74.0622, 'Carrera 9A, Chapinero, Localidad Chapinero'),
    (4.6606, -74.0732, 'Carrera 28, Siete de Agosto, Localidad Barrios Unidos, Bogota'),
    (4.6645, -74.0914, 'Avenida Calle 63, Parque Simon Bolivar-CAN, Localidad Teusaquillo, Bogota'),
    (4.6780, -74.1179, 'Carrera 85D, Localidad Engativa, Bogota'),
    (4.6301, -74.1551, 'Calle 35 Sur, Ciudad Kennedy Norte, Localidad Kennedy, Bogota'),
    (4.5756, -74.1112, 'Carrera 13B, Gustavo Restrepo, Localidad Rafael Uribe Uribe, Bogota'),
    (4.5369, -74.0866, 'Transversal 13D Este, Los Pinares, Localidad San Cristobal, Bogota'),
    (4.5031, -74.1068, 'Carrera 4, Chico Sur, Localidad Usme, Bogota'),
    (4.6172, -74.1937, 'Calle 69B Sur, La Esmeralda, Localidad Bosa, Bogota'),
    (8.7533, -75.8838, 'zona 8, Carrera 8, Comuna 5, Montería'),
    (8.7545, -75.8834, 'Calle 29, Comuna 5, Montería'),
    (8.7605, -75.8665, 'Calle 50A, Urb. Villa Campestre, Comuna 8, Montería'),
    (8.7360, -75.8627, 'Carrera 37, Comuna 6, Montería'),
    (5.0689, -75.5160, 'Carrera 26, Versalles, Comuna La Estación, Manizales'),
    (5.0702, -75.4962, 'Carrera 16A, El Sol, Comuna La Estación, Manizales'),
    (5.0673, -75.5010, 'Carrera 20, San Jorge, Comuna La Estación, Manizales'),
    (5.0670, -75.5053, 'Avenida del Río, Santa Helena, Comuna La Estación, Manizales'),
    (5.0664, -75.5141, 'Carrera 24 del Ruiz, Centro, Comuna Cumanday, Manizales'),
    (4.8147, -75.6970, 'Carrera 7, Centro, Sector Lago Uribe, Centro, AMCO, Area Metropolitana Centro Occidente, Pereira'),
    (4.8131, -75.6955, '20-26, Carrera 9, Centro, Perimetro Urbano Pereira'),
    (4.8107, -75.6977, 'Carrera 12, Centro, Sector Lago Uribe, Centro, AMCO, Area Metropolitana Centro Occidente, Pereira'),
    (4.8083, -75.6792, 'La Rebeca Mall Plaza, #1-14, Carrera 13, Popular Modelo, Universidad, Perimetro Urbano Pereira'),
    (4.8034, -75.6862, 'Coco Parking, Carrera 18, Pinares de San Martin, Area Metropolitana Centro Occidente, Pereira'),
    (3.4310, -76.5274, 'Carrera 29A 1, Colseguros Andes, Comuna 10, Cali'),
    (3.4338, -76.5444, 'Carulla, Carrera 34, Viejo San Fernando, Comuna 19, Cali'),
    (3.4349, -76.5445, 'Carrera 34, Viejo San Fernando, Comuna 19, Cali'),
    (3.4444, -76.5460, 'Carrera 14, Acueducto San Antonio, Comuna 3, Cali'),
    (10.9542, -74.8076, 'Parqueo Sao Macarena, Avenida Cordialidad - Calle 56, La Sierra, Barranquilla'),
    (10.9268, -74.8020, 'Metropolitano, Vía Estadio, Ciudadela 20 de Julio, Barranquilla'),
    (10.9236, -74.8016, 'Parqueadero Velodromo, Avenida Circunvalar, Ciudadela 20 de Julio, Barranquilla'),
    (10.9222, -74.8062, 'Calle 47C, Ciudadela 20 de Julio, Barranquilla'),
    (6.2462, -75.5945, 'Calle 39D, Bolivariana, Comuna 11 - Laureles-Estadio, Medellín'),
    (6.2586, -75.6090, 'Parqueadero Santa Lucia, Calle 48C, La Pradera, Comuna 13 - San Javier, Medellín'),
    (6.2620, -75.6071, 'Parqueadero de Santa Rosa de Lima, Carrera 93, Metropolitano, Comuna 13 - San Javier, Medellín'),
    (6.2770, -75.5976, 'Calle 65, Robledo, Comuna 7 - Robledo, Medellín'),
    (8.7521, -75.8820, '27-62, Carrera 10, Comuna 5, Montería');


-- Insertar tipos de estacionamiento
INSERT INTO `FOURPARKSDATABASE`.`PARKINGTYPE` (`IDPARKINGTYPE`, `DESCPARKINGTYPE`)
VALUES
    ('UNC', 'Sin cubrir'),
    ('SEC', 'Semi cubierto'),
    ('COV', 'Cubierto');

-- Insertar horarios
INSERT INTO `FOURPARKSDATABASE`.`SCHEDULE` (`IDSCHEDULE`, `SCHEDULETYPE`)
VALUES
    (1, 'Dias de semana'),
    (2, 'Fines de semana'),
    (3, 'Todos los dias');

-- Insertar estacionamientos
INSERT INTO `FOURPARKSDATABASE`.`PARKING` (`NAMEPARK`, `CAPACITY`, `OCUPABILITY`, `PHONE`, `EMAIL`, `FK_COORDINATESX`, `FK_COORDINATESY`, `FK_IDCITY`, `FK_IDSCHEDULE`, `FK_ADMIN_IDUSER`, `FK_ADMIN_IDDOCTYPE`, `FK_IDPARKINGTYPE`, `STARTTIME`, `ENDTIME`)
VALUES
    ('Parqueadero 1', 0, 1, '1234567890', 'parqueadero1@example.com', 3.4433, -76.5248, 'CAL', 1, '9876543210987', 'TI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 2', 0, 1, '1234567890', 'parqueadero2@example.com', 10.9936, -74.8047, 'BAQ', 2, '4567890123456', 'CC', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 3', 0, 1, '1234567890', 'parqueadero3@example.com', 6.2421, -75.5688, 'MED', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 4', 0, 1, '1234567890', 'parqueadero4@example.com', 10.4238, -75.5453, 'CTG', 3, '4567890123456', 'CC', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 5', 0, 1,'1234567890', 'parqueadero_a@example.com', 4.7075, -74.2298, 'MQR', 3, '9876543210987', 'TI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 6', 0, 1, '1234567890', 'parqueadero_b@example.com', 4.1350, -73.6219, 'VIL', 1, '4567890123456', 'CC', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 7', 0, 1, '1234567890', 'parqueadero_c@example.com', 7.1254, -73.1180, 'BCM', 1, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 8', 0, 1, '1234567890', 'parqueadero_d@example.com', 1.2138, -77.2820, 'PAS', 2, '4567890123456', 'CC', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 9', 0, 1, '1234567890', 'parqueadero_e@example.com', 4.5804, -74.2183, 'SOA', 3, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 10', 0, 1, '1234567890', 'parqueadero10@example.com', 4.6514, -74.0676, 'BGT', 3, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 11', 0, 1, '1234567890', 'parqueadero11@example.com', 4.6478, -74.0622, 'BGT', 2, '4567890123456', 'CC', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 12', 0, 1, '1234567890', 'parqueadero12@example.com', 4.6606, -74.0732, 'BGT', 2, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 13', 0, 1, '1234567890', 'parqueadero13@example.com', 4.6645, -74.0914, 'BGT', 1, '4567890123456', 'CC', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 14', 0, 1, '1234567890', 'parqueadero14@example.com', 4.6780, -74.1179, 'BGT', 1, '9876543210987', 'TI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 15', 0, 1, '1234567890', 'parqueadero15@example.com', 4.6301, -74.1551, 'BGT', 1, '4567890123456', 'CC', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 16', 0, 1, '1234567890', 'parqueadero16@example.com', 4.5756, -74.1112, 'BGT', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 17', 0, 1, '1234567890', 'parqueadero17@example.com', 4.5369, -74.0866, 'BGT', 2, '4567890123456', 'CC', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 18', 0, 1, '1234567890', 'parqueadero18@example.com', 4.5031, -74.1068, 'BGT', 2, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 19', 0, 1, '1234567890', 'parqueadero19@example.com', 4.6172, -74.1937, 'BGT', 1, '4567890123456', 'CC', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 20', 0, 1, '1234567890', 'parqueadero20@example.com', 8.7533, -75.8838, 'MTR', 1, '7890123456789', 'CI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 21', 0, 1, '1234567890', 'parqueadero21@example.com', 8.7545, -75.8834, 'MTR', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 22', 0, 1, '1234567890', 'parqueadero22@example.com', 8.7605, -75.8665, 'MTR', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 23', 0, 1, '1234567890', 'parqueadero23@example.com', 8.7360, -75.8627, 'MTR', 3, '7890123456789', 'CI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 24', 0, 1, '1234567890', 'parqueadero24@example.com', 5.0689, -75.5160, 'MZS', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 25', 0, 1, '1234567890', 'parqueadero25@example.com', 5.0702, -75.4962, 'MZS', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 26', 0, 1, '1234567890', 'parqueadero26@example.com', 5.0673, -75.5010, 'MZS', 3, '7890123456789', 'CI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 27', 0, 1, '1234567890', 'parqueadero27@example.com', 5.0670, -75.5053, 'MZS', 3, '7890123456789', 'CI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 28', 0, 1, '1234567890', 'parqueadero28@example.com', 5.0664, -75.5141, 'MZS', 1, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 29', 0, 1, '1234567890', 'parqueadero29@example.com', 4.8147, -75.6970, 'PER', 1, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 30', 0, 1, '1234567890', 'parqueadero30@example.com', 4.8131, -75.6955, 'PER', 1, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 31', 0, 1, '1234567890', 'parqueadero31@example.com', 4.8107, -75.6977, 'PER', 1, '7890123456789', 'CI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 32', 0, 1, '1234567890', 'parqueadero32@example.com', 4.8083, -75.6792, 'PER', 2, '7890123456789', 'CI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 33', 0, 1, '1234567890', 'parqueadero33@example.com', 4.8034, -75.6862, 'PER', 2, '9876543210987', 'TI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 34', 0, 1, '1234567890', 'parqueadero34@example.com', 3.4310, -76.5274, 'CAL', 1, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 35', 0, 1, '1234567890', 'parqueadero35@example.com', 3.4338, -76.5444, 'CAL', 1, '7890123456789', 'CI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 36', 0, 1, '1234567890', 'parqueadero36@example.com', 3.4349, -76.5445, 'CAL', 2, '7890123456789', 'CI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 37', 0, 1, '1234567890', 'parqueadero37@example.com', 3.4444, -76.5460, 'CAL', 2, '7890123456789', 'CI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 38', 0, 1, '1234567890', 'parqueadero38@example.com', 10.9542, -74.8076, 'BAQ', 3, '9876543210987', 'TI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 39', 0, 1, '1234567890', 'parqueadero39@example.com', 10.9268, -74.8020, 'BAQ', 1, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 40', 0, 1, '1234567890', 'parqueadero40@example.com', 10.9236, -74.8016, 'BAQ', 3, '9876543210987', 'TI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 41', 0, 1, '1234567890', 'parqueadero41@example.com', 10.9222, -74.8062, 'BAQ', 1, '7890123456789', 'CI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 42', 0, 1, '1234567890', 'parqueadero42@example.com', 6.2462, -75.5945, 'MED', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 43', 0, 1, '1234567890', 'parqueadero43@example.com', 6.2586, -75.6090, 'MED', 1, '7890123456789', 'CI', 'UNC', '08:00:00', '18:00:00'),
    ('Parqueadero 44', 0, 1, '1234567890', 'parqueadero44@example.com', 6.2620, -75.6071, 'MED', 2, '9876543210987', 'TI', 'COV', '08:00:00', '18:00:00'),
    ('Parqueadero 45', 0, 1, '1234567890', 'parqueadero45@example.com', 6.2770, -75.5976, 'MED', 1, '7890123456789', 'CI', 'SEC', '08:00:00', '18:00:00'),
    ('Parqueadero 46', 0, 1, '1234567890', 'parqueadero19@example.com', 8.7521, -75.8820, 'MTR', 1, '7890123456789', 'CI', 'SEC', '08:00:00', '18:00:00');

    
-- Insertar Tipos de Vehiculos
INSERT INTO `FOURPARKSDATABASE`.`VEHICLETYPE` (`IDVEHICLETYPE`,`DESCVEHICLETYPE`)
VALUES
    ('CAR', 'AUTOMOVIL'),
    ('MOT', 'MOTOCICLETA'),
    ('BIC', 'BICICLETA');
    
-- Insertar espacios de estacionamiento
INSERT INTO `FOURPARKSDATABASE`.`PARKINGSPACE` (`IDPARKINGSPACE`, `FK_IDPARKING`, `FK_IDCITY`, `FK_IDVEHICLETYPE`, `ISUNCOVERED`) 
VALUES
    -- Parqueadero 1 
    (1, 1, 'CAL', 'CAR', 1),
    (2, 1, 'CAL', 'CAR', 1),   
    (3, 1, 'CAL', 'CAR', 1),
    (4, 1, 'CAL', 'MOT', 1),   
    -- Parqueadero 2
    (1, 2, 'BAQ', 'CAR', 0),
    (4, 2, 'BAQ', 'CAR', 1),
    (2, 2, 'BAQ', 'CAR', 0),   
    (8, 2, 'BAQ', 'MOT', 0),
    (3, 2, 'BAQ', 'CAR', 0),   
    (5, 2, 'BAQ', 'CAR', 1),
    (6, 2, 'BAQ', 'CAR', 1),   
    (7, 2, 'BAQ', 'MOT', 0),   
    (9, 2, 'BAQ', 'MOT', 0),
    (10, 2, 'BAQ', 'MOT', 0),
    (11, 2, 'BAQ', 'MOT', 1),
    (12, 2, 'BAQ', 'MOT', 1),
    (13, 2, 'BAQ', 'MOT', 1),
    (14, 2, 'BAQ', 'MOT', 1),
    -- Parqueadero 3
    (1, 3, 'MED', 'CAR', 0),
    (2, 3, 'MED', 'CAR', 0),   
    (3, 3, 'MED', 'CAR', 0),   
    (4, 3, 'MED', 'CAR', 0),
    -- Parqueadero 4
    (1, 4, 'CTG', 'CAR', 1),
    (2, 4, 'CTG', 'CAR', 1),   
    (3, 4, 'CTG', 'CAR', 1),   
    (4, 4, 'CTG', 'CAR', 1),
    -- parqueadero 5
    (1, 5, 'MQR', 'MOT', 1),
    (2, 5, 'MQR', 'MOT', 1),   
    (3, 5, 'MQR', 'MOT', 1),   
    (4, 5, 'MQR', 'MOT', 1),
    -- parqueadero 6
    (1, 6, 'VIL', 'MOT', 1),
    (2, 6, 'VIL', 'MOT', 1),   
    (3, 6, 'VIL', 'MOT', 1),   
    (4, 6, 'VIL', 'MOT', 0),
    (5, 6, 'VIL', 'MOT', 0),   
    (6, 6, 'VIL', 'MOT', 0),   
    (7, 6, 'VIL', 'MOT', 0),
    -- parqueadero 7
    (1, 7, 'BCM', 'CAR', 0),
    (2, 7, 'BCM', 'MOT', 0),   
    (3, 7, 'BCM', 'CAR', 0),   
    (4, 7, 'BCM', 'MOT', 0),
    (5, 7, 'BCM', 'CAR', 0),
    (6, 7, 'BCM', 'MOT', 0),
    (7, 7, 'BCM', 'CAR', 0),
    (8, 7, 'BCM', 'MOT', 0),
    (9, 7, 'BCM', 'CAR', 0),
    (10, 7, 'BCM', 'MOT', 0),
    (11, 7, 'BCM', 'CAR', 0),
    (12, 7, 'BCM', 'MOT', 0),
    -- parqueadero 8
    (1, 8, 'PAS', 'CAR', 1),
    (2, 8, 'PAS', 'MOT', 1),   
    (3, 8, 'PAS', 'CAR', 1),   
    (4, 8, 'PAS', 'MOT', 1),
    (5, 8, 'PAS', 'CAR', 1),
    (6, 8, 'PAS', 'MOT', 1),
    (7, 8, 'PAS', 'CAR', 1),
    (8, 8, 'PAS', 'MOT', 1),
    (9, 8, 'PAS', 'CAR', 1),
    (10, 8, 'PAS', 'MOT', 1),
    (11, 8, 'PAS', 'CAR', 1),
    (12, 8, 'PAS', 'MOT', 1),
    (13, 8, 'PAS', 'CAR', 1),
    (14, 8, 'PAS', 'MOT', 1),
    -- parqueadero 9
    (1, 9, 'SOA', 'BIC', 1),
    (2, 9, 'SOA', 'BIC', 1),   
    (3, 9, 'SOA', 'BIC', 1),   
    (4, 9, 'SOA', 'BIC', 1),
    (5, 9, 'SOA', 'BIC', 0),
    (6, 9, 'SOA', 'BIC', 0),
    (7, 9, 'SOA', 'BIC', 0),
    -- parqueadero 10
    (1, 10, 'BGT', 'CAR', 0),
    (2, 10, 'BGT', 'MOT', 0),   
    (3, 10, 'BGT', 'CAR', 0),   
    (4, 10, 'BGT', 'MOT', 0),
    (5, 10, 'BGT', 'CAR', 0),
    (6, 10, 'BGT', 'MOT', 0),
    (7, 10, 'BGT', 'CAR', 0),
    -- parqueadero 11
    (1, 11, 'BGT', 'MOT', 1),
    (2, 11, 'BGT', 'CAR', 1),   
    (3, 11, 'BGT', 'MOT', 1),   
    (4, 11, 'BGT', 'CAR', 1),
    (5, 11, 'BGT', 'MOT', 1),
    (6, 11, 'BGT', 'CAR', 1),
    (7, 11, 'BGT', 'MOT', 1),
    -- parqueadero 12
    (1, 12, 'BGT', 'CAR', 1),
    (2, 12, 'BGT', 'MOT', 1),   
    (3, 12, 'BGT', 'CAR', 1),   
    (4, 12, 'BGT', 'MOT', 1),
    (5, 12, 'BGT', 'CAR', 0),
    (6, 12, 'BGT', 'MOT', 0),
    (7, 12, 'BGT', 'CAR', 0),
    -- Parqueadero 13
    (1, 13, 'BGT', 'CAR', 0),
    (2, 13, 'BGT', 'CAR', 0),   
    (3, 13, 'BGT', 'CAR', 0),   
    (4, 13, 'BGT', 'CAR', 0),
    (5, 13, 'BGT', 'CAR', 0),
    (6, 13, 'BGT', 'CAR', 0),
    (7, 13, 'BGT', 'CAR', 0),
    (8, 13, 'BGT', 'CAR', 0),
    (9, 13, 'BGT', 'CAR', 0),
    -- Parqueadero 14
    (1, 14, 'BGT', 'MOT', 1),
    (2, 14, 'BGT', 'MOT', 1),   
    (3, 14, 'BGT', 'MOT', 1),   
    (4, 14, 'BGT', 'MOT', 1), 
    (5, 14, 'BGT', 'MOT', 1),
    (6, 14, 'BGT', 'MOT', 1),
    (7, 14, 'BGT', 'MOT', 1),
    (8, 14, 'BGT', 'MOT', 1),
    -- Parqueadero 15
    (1, 15, 'BGT', 'BIC', 1),
    (2, 15, 'BGT', 'BIC', 1),   
    (3, 15, 'BGT', 'BIC', 1),   
    (4, 15, 'BGT', 'BIC', 1),
    (5, 15, 'BGT', 'BIC', 1),
    (6, 15, 'BGT', 'BIC', 1),
    (7, 15, 'BGT', 'BIC', 1),
    (8, 15, 'BGT', 'BIC', 1),
    (9, 15, 'BGT', 'BIC', 1),
    (10, 15, 'BGT', 'BIC', 0),
    (11, 15, 'BGT', 'BIC', 0),
    (12, 15, 'BGT', 'BIC', 0),
    (13, 15, 'BGT', 'BIC', 0),
    -- Parqueadero 16
    (1, 16, 'BGT', 'MOT', 0),
    (2, 16, 'BGT', 'CAR', 0),   
    (3, 16, 'BGT', 'BIC', 0),   
    (4, 16, 'BGT', 'MOT', 0),
    (5, 16, 'BGT', 'CAR', 0),
    (6, 16, 'BGT', 'BIC', 0),
    (7, 16, 'BGT', 'MOT', 0),
    -- parqueadero 17
    (1, 17, 'BGT', 'BIC', 1),
    (2, 17, 'BGT', 'MOT', 1),
    (3, 17, 'BGT', 'CAR', 1),
    (4, 17, 'BGT', 'CAR', 1),
    (5, 17, 'BGT', 'BIC', 1),
    (6, 17, 'BGT', 'MOT', 1),
    (7, 17, 'BGT', 'BIC', 1),
    (8, 17, 'BGT', 'BIC', 1),
    (9, 17, 'BGT', 'CAR', 1),
    (10, 17, 'BGT', 'MOT', 1),
    (11, 17, 'BGT', 'BIC', 1),
    (12, 17, 'BGT', 'CAR', 1),
    (13, 17, 'BGT', 'BIC', 1),
    (14, 17, 'BGT', 'MOT', 1),
    (15, 17, 'BGT', 'MOT', 1),
    (16, 17, 'BGT', 'CAR', 1),
    (17, 17, 'BGT', 'BIC', 1),
    (18, 17, 'BGT', 'CAR', 1),
    (19, 17, 'BGT', 'MOT', 1),
    (20, 17, 'BGT', 'BIC', 1),
    (21, 17, 'BGT', 'MOT', 1),
    (22, 17, 'BGT', 'CAR', 1),
    (23, 17, 'BGT', 'BIC', 1),
    (24, 17, 'BGT', 'CAR', 1),
    (25, 17, 'BGT', 'MOT', 1),
    (26, 17, 'BGT', 'BIC', 1),
    (27, 17, 'BGT', 'CAR', 1),
    (28, 17, 'BGT', 'MOT', 1),
    (29, 17, 'BGT', 'CAR', 1),
    (30, 17, 'BGT', 'BIC', 1),
    -- parqueadero 18
    (1, 18, 'BGT', 'MOT', 1),
    (2, 18, 'BGT', 'CAR', 1),
    (3, 18, 'BGT', 'BIC', 1),
    (4, 18, 'BGT', 'MOT', 1),
    (5, 18, 'BGT', 'CAR', 1),
    (6, 18, 'BGT', 'BIC', 1),
    (7, 18, 'BGT', 'MOT', 1),
    (8, 18, 'BGT', 'CAR', 1),
    (9, 18, 'BGT', 'BIC', 1),
    (10, 18, 'BGT', 'MOT', 1),
    (11, 18, 'BGT', 'CAR', 1),
    (12, 18, 'BGT', 'BIC', 1),
    (13, 18, 'BGT', 'MOT', 1),
    (14, 18, 'BGT', 'CAR', 1),
    (15, 18, 'BGT', 'BIC', 1),
    (16, 18, 'BGT', 'MOT', 1),
    (17, 18, 'BGT', 'CAR', 1),
    (18, 18, 'BGT', 'BIC', 1),
    (19, 18, 'BGT', 'MOT', 1),
    (20, 18, 'BGT', 'CAR', 0),
    (21, 18, 'BGT', 'BIC', 0),
    (22, 18, 'BGT', 'MOT', 0),
    (23, 18, 'BGT', 'CAR', 0),
    (24, 18, 'BGT', 'BIC', 0),
    (25, 18, 'BGT', 'MOT', 0),
    (26, 18, 'BGT', 'CAR', 0),
    (27, 18, 'BGT', 'BIC', 0),
    (28, 18, 'BGT', 'MOT', 0),
    (29, 18, 'BGT', 'CAR', 0),
    (30, 18, 'BGT', 'BIC', 0),
    (31, 18, 'BGT', 'MOT', 0),
    (32, 18, 'BGT', 'CAR', 0),
    (33, 18, 'BGT', 'BIC', 0),
    (34, 18, 'BGT', 'MOT', 0),
    (35, 18, 'BGT', 'CAR', 0),
    -- parqueadero 19
    (1, 19, 'BGT', 'MOT', 0),
    (2, 19, 'BGT', 'MOT', 0),
    (3, 19, 'BGT', 'MOT', 0),
    (4, 19, 'BGT', 'MOT', 0),
    (5, 19, 'BGT', 'MOT', 0),
    (6, 19, 'BGT', 'MOT', 0),
    (7, 19, 'BGT', 'MOT', 0),
    -- parqueadero 20
   (1, 20, 'MTR', 'CAR', 1),
   (2, 20, 'MTR', 'CAR', 1),
   (3, 20, 'MTR', 'CAR', 1),
   (4, 20, 'MTR', 'CAR', 1),
   (5, 20, 'MTR', 'CAR', 0),
   (6, 20, 'MTR', 'CAR', 0),
   (7, 20, 'MTR', 'CAR', 0),
   -- parqueadero 21
   (1, 21, 'MTR', 'MOT', 0),
   (2, 21, 'MTR', 'MOT', 0),
   (3, 21, 'MTR', 'MOT', 0),
   (4, 21, 'MTR', 'MOT', 0),
   (5, 21, 'MTR', 'MOT', 0),
   (6, 21, 'MTR', 'MOT', 0),
   (7, 21, 'MTR', 'MOT', 0),
   -- parqueadero 22
   (1, 22, 'MTR', 'CAR', 0),
   (2, 22, 'MTR', 'MOT', 0),
   (3, 22, 'MTR', 'BIC', 0),
   (4, 22, 'MTR', 'CAR', 0),
   (5, 22, 'MTR', 'MOT', 0),
   (6, 22, 'MTR', 'BIC', 0),
   (7, 22, 'MTR', 'CAR', 0),
   -- parqueadero 23
   (1, 23, 'MTR', 'MOT', 1),
   (2, 23, 'MTR', 'CAR', 1),
   (3, 23, 'MTR', 'BIC', 1),
   (4, 23, 'MTR', 'MOT', 1),
   (5, 23, 'MTR', 'CAR', 1),
   (6, 23, 'MTR', 'BIC', 1),
   (7, 23, 'MTR', 'MOT', 1),
   -- Parqueadero 24
   (1, 24, 'MZS', 'CAR', 0),
   (2, 24, 'MZS', 'CAR', 0),
   (3, 24, 'MZS', 'CAR', 0),
   (4, 24, 'MZS', 'CAR', 0),
   (5, 24, 'MZS', 'CAR', 0),
   (6, 24, 'MZS', 'CAR', 0),
   (7, 24, 'MZS', 'CAR', 0),
   -- Parqueadero 25
   (1, 25, 'MZS', 'MOT', 0),
   (2, 25, 'MZS', 'MOT', 0),
   (3, 25, 'MZS', 'MOT', 0),
   (4, 25, 'MZS', 'MOT', 0),
   (5, 25, 'MZS', 'MOT', 0),
   (6, 25, 'MZS', 'MOT', 0),
   (7, 25, 'MZS', 'MOT', 0),
   -- Parqueadero 26
   (1, 26, 'MZS', 'MOT', 1),
   (2, 26, 'MZS', 'CAR', 1),
   (3, 26, 'MZS', 'BIC', 1),
   (4, 26, 'MZS', 'MOT', 1),
   (5, 26, 'MZS', 'CAR', 1),
   (6, 26, 'MZS', 'BIC', 1),
   (7, 26, 'MZS', 'MOT', 1),
   -- Parqueadero 27
   (1, 27, 'MZS', 'MOT', 1),
   (2, 27, 'MZS', 'CAR', 1),
   (3, 27, 'MZS', 'BIC', 1),
   (4, 27, 'MZS', 'MOT', 1),
   (5, 27, 'MZS', 'CAR', 1),
   (6, 27, 'MZS', 'BIC', 1),
   (7, 27, 'MZS', 'MOT', 1),
   -- Parqueadero 28
   (1, 28, 'MZS', 'MOT', 1),
   (2, 28, 'MZS', 'CAR', 1),
   (3, 28, 'MZS', 'BIC', 1),
   (4, 28, 'MZS', 'MOT', 1),
   (5, 28, 'MZS', 'CAR', 0),
   (6, 28, 'MZS', 'BIC', 0),
   (7, 28, 'MZS', 'MOT', 0),
   -- Parqueadero 29
   (1, 29, 'PER', 'CAR', 1),
   (2, 29, 'PER', 'CAR', 1),
   (3, 29, 'PER', 'CAR', 1),
   (4, 29, 'PER', 'CAR', 1),
   (5, 29, 'PER', 'CAR', 0),
   (6, 29, 'PER', 'CAR', 0),
   (7, 29, 'PER', 'CAR', 0),
   (8, 29, 'PER', 'CAR', 0),
   (9, 29, 'PER', 'CAR', 0),
   (10, 29, 'PER', 'CAR', 0),
   -- Parqueadero 30
   (1, 30, 'PER', 'MOT', 1),
   (2, 30, 'PER', 'MOT', 1),
   (3, 30, 'PER', 'MOT', 1),
   (4, 30, 'PER', 'MOT', 1),
   (5, 30, 'PER', 'MOT', 0),
   (6, 30, 'PER', 'MOT', 0),
   (7, 30, 'PER', 'MOT', 0),
   (8, 30, 'PER', 'MOT', 0),
   (9, 30, 'PER', 'MOT', 0),
   (10, 30, 'PER', 'MOT', 0),
   -- Parqueadero 31
   (1, 31, 'PER', 'BIC', 1),
   (2, 31, 'PER', 'BIC', 1),
   (3, 31, 'PER', 'BIC', 1),
   (4, 31, 'PER', 'BIC', 1),
   (5, 31, 'PER', 'BIC', 0),
   (6, 31, 'PER', 'BIC', 0),
   (7, 31, 'PER', 'BIC', 0),
   (8, 31, 'PER', 'BIC', 0),
   (9, 31, 'PER', 'BIC', 0),
   (10, 31, 'PER', 'BIC', 0),
   -- Parqueadero 32
   (1, 32, 'PER', 'MOT', 1),
   (2, 32, 'PER', 'CAR', 1),
   (3, 32, 'PER', 'BIC', 1),
   (4, 32, 'PER', 'MOT', 1),
   (5, 32, 'PER', 'CAR', 1),
   (6, 32, 'PER', 'BIC', 1),
   (7, 32, 'PER', 'MOT', 1),
   (8, 32, 'PER', 'CAR', 1),
   (9, 32, 'PER', 'BIC', 1),
   (10, 32, 'PER', 'MOT', 1),
   -- Parqueadero 33
   (1, 33, 'PER', 'MOT', 1),
   (2, 33, 'PER', 'CAR', 1),
   (3, 33, 'PER', 'BIC', 1),
   (4, 33, 'PER', 'MOT', 1),
   (5, 33, 'PER', 'CAR', 1),
   (6, 33, 'PER', 'BIC', 1),
   (7, 33, 'PER', 'MOT', 1),
   (8, 33, 'PER', 'CAR', 1),
   (9, 33, 'PER', 'BIC', 1),
   (10, 33, 'PER', 'MOT', 1),
   -- Parqueadero 34
   (1, 34, 'CAL', 'CAR', 1),
   (2, 34, 'CAL', 'CAR', 1),
   (3, 34, 'CAL', 'CAR', 1),
   (4, 34, 'CAL', 'CAR', 1),
   (5, 34, 'CAL', 'CAR', 0),
   (6, 34, 'CAL', 'CAR', 0),
   (7, 34, 'CAL', 'CAR', 0),
   (8, 34, 'CAL', 'CAR', 0),
   -- Parqueadero 35
   (1, 35, 'CAL', 'MOT', 1),
   (2, 35, 'CAL', 'MOT', 1),
   (3, 35, 'CAL', 'MOT', 1),
   (4, 35, 'CAL', 'MOT', 1),
   (5, 35, 'CAL', 'MOT', 1),
   (6, 35, 'CAL', 'MOT', 1),
   (7, 35, 'CAL', 'MOT', 1),
   (8, 35, 'CAL', 'MOT', 1),
   -- Parqueadero 36
   (1, 36, 'CAL', 'BIC', 0),
   (2, 36, 'CAL', 'BIC', 0),
   (3, 36, 'CAL', 'BIC', 0),
   (4, 36, 'CAL', 'BIC', 0),
   (5, 36, 'CAL', 'BIC', 0),
   (6, 36, 'CAL', 'BIC', 0),
   (7, 36, 'CAL', 'BIC', 0),
   (8, 36, 'CAL', 'BIC', 0),
   -- Parqueadero 37
   (1, 37, 'CAL', 'MOT', 0),
   (2, 37, 'CAL', 'CAR', 0),
   (3, 37, 'CAL', 'BIC', 0),
   (4, 37, 'CAL', 'MOT', 0),
   (5, 37, 'CAL', 'CAR', 0),
   (6, 37, 'CAL', 'BIC', 0),
   (7, 37, 'CAL', 'MOT', 0),
   (8, 37, 'CAL', 'CAR', 0),
   -- Parqueadero 38
   (1, 38, 'BAQ', 'CAR', 1),
   (2, 38, 'BAQ', 'CAR', 1),
   (3, 38, 'BAQ', 'CAR', 1),
   (4, 38, 'BAQ', 'CAR', 1),
   (5, 38, 'BAQ', 'CAR', 1),
   (6, 38, 'BAQ', 'CAR', 1),
   (7, 38, 'BAQ', 'CAR', 1),
   (8, 38, 'BAQ', 'CAR', 1),
   (9, 38, 'BAQ', 'CAR', 1),
   -- Parqueadero 39
   (1, 39, 'BAQ', 'MOT', 1),
   (2, 39, 'BAQ', 'MOT', 1),
   (3, 39, 'BAQ', 'MOT', 1),
   (4, 39, 'BAQ', 'MOT', 1),
   (5, 39, 'BAQ', 'MOT', 0),
   (6, 39, 'BAQ', 'MOT', 0),
   (7, 39, 'BAQ', 'MOT', 0),
   (8, 39, 'BAQ', 'MOT', 0),
   (9, 39, 'BAQ', 'MOT', 0),
   -- Parqueadero 40
   (1, 40, 'BAQ', 'BIC', 1),
   (2, 40, 'BAQ', 'BIC', 1),
   (3, 40, 'BAQ', 'BIC', 1),
   (4, 40, 'BAQ', 'BIC', 1),
   (5, 40, 'BAQ', 'BIC', 0),
   (6, 40, 'BAQ', 'BIC', 0),
   (7, 40, 'BAQ', 'BIC', 0),
   (8, 40, 'BAQ', 'BIC', 0),
   (9, 40, 'BAQ', 'BIC', 0),
   -- Parqueadero 41
   (1, 41, 'BAQ', 'MOT', 1),
   (2, 41, 'BAQ', 'CAR', 1),
   (3, 41, 'BAQ', 'BIC', 1),
   (4, 41, 'BAQ', 'MOT', 1),
   (5, 41, 'BAQ', 'CAR', 1),
   (6, 41, 'BAQ', 'BIC', 1),
   (7, 41, 'BAQ', 'MOT', 1),
   (8, 41, 'BAQ', 'CAR', 1),
   (9, 41, 'BAQ', 'BIC', 1),
   -- Parqueadero 42
   (1, 42, 'MED', 'CAR', 0),
   (2, 42, 'MED', 'CAR', 0),
   (3, 42, 'MED', 'CAR', 0),
   (4, 42, 'MED', 'CAR', 0),
   (5, 42, 'MED', 'CAR', 0),
   (6, 42, 'MED', 'CAR', 0),
   (7, 42, 'MED', 'CAR', 0),
   (8, 42, 'MED', 'CAR', 0),
   (9, 42, 'MED', 'CAR', 0),
   (10, 42, 'MED', 'CAR', 0),
   (11, 42, 'MED', 'CAR', 0),
   (12, 42, 'MED', 'CAR', 0),
   -- Parqueadero 43
   (1, 43, 'MED', 'MOT', 1),
   (2, 43, 'MED', 'MOT', 1),
   (3, 43, 'MED', 'MOT', 1),
   (4, 43, 'MED', 'MOT', 1),
   (5, 43, 'MED', 'MOT', 1),
   (6, 43, 'MED', 'MOT', 1),
   (7, 43, 'MED', 'MOT', 1),
   (8, 43, 'MED', 'MOT', 1),
   (9, 43, 'MED', 'MOT', 1),
   (10, 43, 'MED', 'MOT', 1),
   (11, 43, 'MED', 'MOT', 1),
   (12, 43, 'MED', 'MOT', 1),
   -- Parqueadero 44
   (1, 44, 'MED', 'BIC', 0),
   (2, 44, 'MED', 'BIC', 0),
   (3, 44, 'MED', 'BIC', 0),
   (4, 44, 'MED', 'BIC', 0),
   (5, 44, 'MED', 'BIC', 0),
   (6, 44, 'MED', 'BIC', 0),
   (7, 44, 'MED', 'BIC', 0),
   (8, 44, 'MED', 'BIC', 0),
   (9, 44, 'MED', 'BIC', 0),
   (10, 44, 'MED', 'BIC', 0),
   (11, 44, 'MED', 'BIC', 0),
   (12, 44, 'MED', 'BIC', 0),
   -- Parqueadero 45
   (1, 45, 'MED', 'MOT', 1),
   (2, 45, 'MED', 'CAR', 1),
   (3, 45, 'MED', 'BIC', 1),
   (4, 45, 'MED', 'MOT', 1),
   (5, 45, 'MED', 'CAR', 0),
   (6, 45, 'MED', 'BIC', 0),
   (7, 45, 'MED', 'MOT', 0),
   (8, 45, 'MED', 'CAR', 0),
   (9, 45, 'MED', 'BIC', 0),
   (10, 45, 'MED', 'MOT', 0),
   (11, 45, 'MED', 'CAR', 0),
   (12, 45, 'MED', 'BIC', 0),
   -- Parqueadero 46
   (1, 46, 'MTR', 'BIC', 1),
   (2, 46, 'MTR', 'CAR', 1),
   (3, 46, 'MTR', 'MOT', 1),
   (4, 46, 'MTR', 'BIC', 1),
   (5, 46, 'MTR', 'CAR', 0),
   (6, 46, 'MTR', 'MOT', 0),
   (7, 46, 'MTR', 'BIC', 0);

-- Insertar estados de reserva
INSERT INTO `FOURPARKSDATABASE`.`RESERVATIONSTATUS` (`IDRESSTATUS`, `DESCRESSTATUS`) 
VALUES
    ('PEN', 'Pendiente'),
    ('CON', 'Confirmada'),
    ('CAN', 'Cancelada'),
    ('CUR', 'En curso'),
    ('COM', 'Completada'),
    ('NPR', 'No presentado');
