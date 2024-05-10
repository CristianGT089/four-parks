-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- SCHEMA FOURPARKSDATABASE
-- -----------------------------------------------------
DROP DATABASE `FOURPARKSDATABASE`;
CREATE SCHEMA IF NOT EXISTS `FOURPARKSDATABASE` DEFAULT CHARACTER SET UTF8MB4 ;
USE `FOURPARKSDATABASE` ;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`DOCUMENTTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`DOCUMENTTYPE` (
  `IDDOCTYPE` VARCHAR(3) NOT NULL,
  `DESCDOCTYPE` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`IDDOCTYPE`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`USER` (
  `IDUSER` VARCHAR(13) NOT NULL,
  `FK_IDDOCTYPE` VARCHAR(3) NOT NULL,
  `FIRSTNAME` VARCHAR(45) NOT NULL,
  `LASTNAME` VARCHAR(45) NOT NULL,
  `EMAIL` VARCHAR(50) NOT NULL,
  `PHONE` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDUSER`, `FK_IDDOCTYPE`),
  INDEX `FK_USER_DOCUMENTTYPE_IDX` (`FK_IDDOCTYPE` ASC) VISIBLE,
  CONSTRAINT `FK_USER_DOCUMENTTYPE`
    FOREIGN KEY (`FK_IDDOCTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`DOCUMENTTYPE` (`IDDOCTYPE`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`USER_AUTHENTICATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`USER_AUTHENTICATION` (
  `IDUSER` VARCHAR(13) NOT NULL,
  `FK_IDDOCTYPE` VARCHAR(3) NOT NULL,
  `USERNAME` VARCHAR(30) NOT NULL,
  `PASSWORD` VARCHAR(200) NOT NULL,
  `ATTEMPTS` INT NOT NULL,
  `ISBLOCKED` TINYINT NOT NULL,
  `ROLE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDUSER`, `FK_IDDOCTYPE`),
  CONSTRAINT `FK_USER_AUTHENTICATION_USER`
    FOREIGN KEY (`IDUSER`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`ADDRESS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`ADDRESS` (
  `COORDINATESX` FLOAT(10,4) NOT NULL,
  `COORDINATESY` FLOAT(10,4) NOT NULL,
  `DESCADDRESS` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`COORDINATESX`, `COORDINATESY`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CITY` (
  `IDCITY` VARCHAR(3) NOT NULL,
  `NAME` VARCHAR(30) NOT NULL,
  `B_TOP` DECIMAL(10, 4) NOT NULL,
  `B_BOTTOM` DECIMAL(10, 4) NOT NULL,
  `B_LEFT` DECIMAL(10, 4) NOT NULL,
  `B_RIGHT` DECIMAL(10, 4) NOT NULL,
  `X_CENTER` DECIMAL(10, 4) NOT NULL,
  `Y_CENTER` DECIMAL(10, 4) NOT NULL,
  PRIMARY KEY (`IDCITY`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CARD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CARD` (
  `IDCARD` INT NOT NULL AUTO_INCREMENT,
  `SERIALCARD` VARCHAR(16) NOT NULL,
  `EXPIRYDATECARD` DATE NOT NULL,
  `CVVCARD` VARCHAR(3) NOT NULL,
  `FK_CLIENT_IDUSER` VARCHAR(13) NOT NULL,
  `FK_CLIENT_IDDOCTYPE` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDCARD`),
  INDEX `FK_CARD_CLIENTE_IDX` (`FK_CLIENT_IDUSER` ASC, `FK_CLIENT_IDDOCTYPE` ASC) VISIBLE,
  CONSTRAINT `FK_CARD_CLIENTE`
    FOREIGN KEY (`FK_CLIENT_IDUSER` , `FK_CLIENT_IDDOCTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `FK_IDDOCTYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`CUSTOMERACTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`CUSTOMERACTION` (
  `IDACTION` INT NOT NULL AUTO_INCREMENT,
  `DESCACTION` VARCHAR(45) NOT NULL,
  `FK_IDUSER` VARCHAR(13) NOT NULL,
  `FK_IDDOCTYPE` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDACTION`),
  INDEX `FK_ACTION_PERSON_IDX` (`FK_IDUSER` ASC, `FK_IDDOCTYPE` ASC) VISIBLE,
  CONSTRAINT `FK_ACTION_PERSON`
    FOREIGN KEY (`FK_IDUSER` , `FK_IDDOCTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `FK_IDDOCTYPE`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PAYMENTMETHOD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PAYMENTMETHOD` (
  `IDPAYMENTMETHOD` INT NOT NULL,
  `DESCPAYMENTMETHOD` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDPAYMENTMETHOD`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`SCHEDULE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`SCHEDULE` (
  `IDSCHEDULE` INT NOT NULL,
  `STARTTIME` TIME NULL DEFAULT NULL,
  `ENDTIME` TIME NULL DEFAULT NULL,
  `SCHEDULETYPE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDSCHEDULE`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PARKINGTYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PARKINGTYPE` (
  `IDPARKINGTYPE` VARCHAR(3) NOT NULL,
  `DESCPARKINGTYPE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IDPARKINGTYPE`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PARKING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PARKING` (
  `IDPARKING` INT NOT NULL AUTO_INCREMENT,
  `NAMEPARK` VARCHAR(45) NOT NULL,
  `CAPACITY` INT NOT NULL,
  `OCUPABILITY` FLOAT NOT NULL,
  `PHONE` VARCHAR(10) NOT NULL,
  `EMAIL` VARCHAR(45) NOT NULL,
  `FK_COORDINATESX` FLOAT(10,4) NOT NULL,
  `FK_COORDINATESY` FLOAT(10,4) NOT NULL,
  `FK_IDCITY` VARCHAR(3) NOT NULL,
  `FK_IDSCHEDULE` INT NOT NULL,
  `FK_ADMIN_IDUSER` VARCHAR(13) NOT NULL,
  `FK_ADMIN_IDDOCTYPE` VARCHAR(3) NOT NULL,
  `FK_IDPARKINGTYPE` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDPARKING`, `FK_IDCITY`),
  INDEX `FK_PARKING_CITY_IDX` (`FK_IDCITY` ASC) VISIBLE,
  INDEX `FK_PARKING_SCHEDULE_IDX` (`FK_IDSCHEDULE` ASC) VISIBLE,
  INDEX `FK_PARKING_ADDRESS` (`FK_COORDINATESX` ASC, `FK_COORDINATESY` ASC) VISIBLE,
  INDEX `FK_PARKING_ADMINISTRADOR_IDX` (`FK_ADMIN_IDUSER` ASC, `FK_ADMIN_IDDOCTYPE` ASC) VISIBLE,
  INDEX `FK_PARKING_PARKINGTYPE_IDX` (`FK_IDPARKINGTYPE` ASC) VISIBLE,
  INDEX `FK_PARKINGSPACE_PARKING_IDX` (`IDPARKING`, `FK_IDCITY`) VISIBLE,
  CONSTRAINT `FK_PARKING_ADDRESS`
    FOREIGN KEY (`FK_COORDINATESX` , `FK_COORDINATESY`)
    REFERENCES `FOURPARKSDATABASE`.`ADDRESS` (`COORDINATESX` , `COORDINATESY`),
  CONSTRAINT `FK_PARKING_CITY`
    FOREIGN KEY (`FK_IDCITY`)
    REFERENCES `FOURPARKSDATABASE`.`CITY` (`IDCITY`),
  CONSTRAINT `FK_PARKING_SCHEDULE`
    FOREIGN KEY (`FK_IDSCHEDULE`)
    REFERENCES `FOURPARKSDATABASE`.`SCHEDULE` (`IDSCHEDULE`),
  CONSTRAINT `FK_PARKING_ADMINISTRADOR`
    FOREIGN KEY (`FK_ADMIN_IDUSER` , `FK_ADMIN_IDDOCTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `FK_IDDOCTYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PARKINGSPACE_PARKINGTYPE`
    FOREIGN KEY (`FK_IDPARKINGTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`PARKINGTYPE` (`IDPARKINGTYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`VEHICLETYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`VEHICLETYPE` (
  `IDVEHICLETYPE` VARCHAR(3) NOT NULL,
  `DESCVEHICLETYPE` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IDVEHICLETYPE`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`PARKINGSPACE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`PARKINGSPACE` (
  `IDPARKINGSPACE` INT NOT NULL,
  `ISUNCOVERED` TINYINT NOT NULL,
  `FK_IDPARKING` INT NOT NULL,
  `FK_IDCITY` VARCHAR(3) NOT NULL,
  `FK_IDVEHICLETYPE` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDPARKINGSPACE`,`FK_IDPARKING`,`FK_IDCITY`),
  INDEX `FK_PARKINGSPACE_PARKING_IDX` (`FK_IDPARKING` ASC) VISIBLE,
  INDEX `FK_PARKINGSPACE_CITY_IDX` (`FK_IDCITY` ASC) VISIBLE,
  INDEX `FK_PARKINGSPACE_VEHICLETYPE_IDX` (`FK_IDVEHICLETYPE` ASC) VISIBLE,
  CONSTRAINT `FK_PARKINGSPACE_PARKING_UNIQUE`
    UNIQUE (`IDPARKINGSPACE`,`FK_IDPARKING`,`FK_IDCITY`,`FK_IDVEHICLETYPE`),
  CONSTRAINT `FK_PARKINGSPACE_PARKING`
    FOREIGN KEY (`FK_IDPARKING`, `FK_IDCITY`)
    REFERENCES `FOURPARKSDATABASE`.`PARKING` (`IDPARKING`, `FK_IDCITY`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PARKINGSPACE_VEHICLETYPE`
    FOREIGN KEY (`FK_IDVEHICLETYPE`)
    REFERENCES `FOURPARKSDATABASE`.`VEHICLETYPE` (`IDVEHICLETYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`RATE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`RATE` (
  `HOURCOST` INT NOT NULL,
  `CANCELLATIONCOST` INT NOT NULL,
  `ISUNCOVERED` TINYINT NOT NULL,
  `FK_IDPARKING` INT NOT NULL,
  `FK_IDCITY` VARCHAR(3) NOT NULL,
  `FK_IDVEHICLETYPE` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`FK_IDPARKING`,`FK_IDCITY`,`FK_IDVEHICLETYPE`,`ISUNCOVERED`),
  INDEX `FK_RATE_PARKING_IDX` (`FK_IDPARKING` ASC) VISIBLE,
  INDEX `FK_RATE_CITY_IDX` (`FK_IDCITY` ASC) VISIBLE,
  INDEX `FK_RATE_VEHICLETYPE_IDX` (`FK_IDVEHICLETYPE` ASC) VISIBLE,
  CONSTRAINT `FK_RATE_PARKING`
    FOREIGN KEY (`FK_IDPARKING`,`FK_IDCITY`)
    REFERENCES `FOURPARKSDATABASE`.`PARKING` (`IDPARKING`,`FK_IDCITY`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RATE_VEHICLETYPE`
    FOREIGN KEY (`FK_IDVEHICLETYPE`)
    REFERENCES `FOURPARKSDATABASE`.`VEHICLETYPE` (`IDVEHICLETYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`RESERVATIONSTATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`RESERVATIONSTATUS` (
  `IDRESSTATUS` VARCHAR(3) NOT NULL,
  `DESCRESSTATUS` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`IDRESSTATUS`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`RESERVATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`RESERVATION` (
  `IDRESERVATION` INT NOT NULL AUTO_INCREMENT,
  `DATERES` DATE NOT NULL,
  `STARTTIMERES` TIME NOT NULL,
  `ENDTIMERES` TIME NOT NULL,
  `CREATIONDATERES` DATE NOT NULL,
  `TOTALRES` FLOAT NULL DEFAULT NULL,
  `LICENSEPLATE` VARCHAR(6) NOT NULL,
  `FK_IDPARKINGSPACE` INT NOT NULL,
  `FK_IDPARKING` INT NOT NULL,
  `FK_IDCITY` VARCHAR(3) NOT NULL,
  `FK_IDVEHICLETYPE` VARCHAR(3) NOT NULL,
  `FK_CLIENT_IDUSER` VARCHAR(13) NOT NULL,
  `FK_CLIENT_IDDOCTYPE` VARCHAR(3) NOT NULL,
  `FK_IDRESSTATUS` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`IDRESERVATION`),
  INDEX `FK_RESERVATION_PARKINGSPACE_IDX` (`FK_IDPARKINGSPACE` ASC, `FK_IDPARKING` ASC, `FK_IDCITY` ASC, `FK_IDVEHICLETYPE` ASC) VISIBLE,
  INDEX `FK_RESERVATION_CLIENTE_IDX` (`FK_CLIENT_IDUSER` ASC, `FK_CLIENT_IDDOCTYPE` ASC) VISIBLE,
  INDEX `FK_RESERVATION_STATUS_IDX` (`FK_IDRESSTATUS`) VISIBLE,
  CONSTRAINT `FK_RESERVATION_PARKINGSPACE`
    FOREIGN KEY (`FK_IDPARKINGSPACE`, `FK_IDPARKING`, `FK_IDCITY`, `FK_IDVEHICLETYPE`)
    REFERENCES `FOURPARKSDATABASE`.`PARKINGSPACE` (`IDPARKINGSPACE`, `FK_IDPARKING`, `FK_IDCITY`, `FK_IDVEHICLETYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RESERVATION_CLIENTE`
    FOREIGN KEY (`FK_CLIENT_IDUSER` , `FK_CLIENT_IDDOCTYPE`)
    REFERENCES `FOURPARKSDATABASE`.`USER` (`IDUSER` , `FK_IDDOCTYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RESERVATION_STATUS`
    FOREIGN KEY (`FK_IDRESSTATUS`)
    REFERENCES `FOURPARKSDATABASE`.`RESERVATIONSTATUS` (`IDRESSTATUS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;


-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`SCORESYSTEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`SCORESYSTEM` (
  `IDSCORESYSTEM` INT NOT NULL,
  `RESERVATIONSCORE` VARCHAR(45) NULL DEFAULT NULL,
  `FK_IDPARKING` INT NOT NULL,
  PRIMARY KEY (`IDSCORESYSTEM`),
  INDEX `FK_SCORESYSTEM_PARKING_IDX` (`FK_IDPARKING` ASC) VISIBLE,
  CONSTRAINT `FK_SCORESYSTEM_PARKING`
    FOREIGN KEY (`FK_IDPARKING`)
    REFERENCES `FOURPARKSDATABASE`.`PARKING` (`IDPARKING`))
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- TABLE `FOURPARKSDATABASE`.`INVOICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FOURPARKSDATABASE`.`INVOICE` (
  `IDINVOICE` INT NOT NULL,
  `TOTALINVOICE` INT NOT NULL,
  `DATEINVOICE` DATE NOT NULL,
  `SUBTOTALINVOICE` INT NULL DEFAULT NULL,
  `FK_IDPAYMENTMETHOD` INT NOT NULL,
  `FK_IDRESERVATION` INT NOT NULL,
  PRIMARY KEY (`IDINVOICE`),
  INDEX `FK_INVOICE_PAYMENTMETHOD_IDX` (`FK_IDPAYMENTMETHOD` ASC) VISIBLE,
  INDEX `FK_INVOICE_RESERVATION_IDX` (`FK_IDRESERVATION` ASC) VISIBLE,
  CONSTRAINT `FK_INVOICE_PAYMENTMETHOD`
    FOREIGN KEY (`FK_IDPAYMENTMETHOD`)
    REFERENCES `FOURPARKSDATABASE`.`PAYMENTMETHOD` (`IDPAYMENTMETHOD`),
  CONSTRAINT `FK_INVOICE_RESERVATION`
    FOREIGN KEY (`FK_IDRESERVATION`)
    REFERENCES `FOURPARKSDATABASE`.`RESERVATION` (`IDRESERVATION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB
DEFAULT CHARACTER SET = UTF8MB4;


DELIMITER //

CREATE TRIGGER parking_operations
AFTER INSERT ON PARKINGSPACE
FOR EACH ROW
BEGIN
    DECLARE total_spaces INT;
    DECLARE parking_type VARCHAR(3);

    -- Obtener el tipo de estacionamiento
    SELECT FK_IDPARKINGTYPE INTO parking_type
    FROM PARKING
    WHERE IDPARKING = NEW.FK_IDPARKING AND FK_IDCITY = NEW.FK_IDCITY;

    -- Validar el valor de ISUNCOVERED
    IF parking_type = 'UNC' AND NEW.ISUNCOVERED = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El valor en ISUNCOVERED no es válido para este tipo de estacionamiento (Sin cubrir)';
    END IF;

    IF parking_type = 'COV' AND NEW.ISUNCOVERED = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El valor en ISUNCOVERED no es válido para este tipo de estacionamiento (Cubierto)';
    END IF;

    -- Calcula el total de espacios de estacionamiento en el parqueadero
    SELECT COUNT(*)
    INTO total_spaces
    FROM PARKINGSPACE
    WHERE FK_IDPARKING = NEW.FK_IDPARKING;

    -- Actualiza la capacidad en la tabla PARKING
    UPDATE PARKING
    SET CAPACITY = total_spaces
    WHERE IDPARKING = NEW.FK_IDPARKING;
END;
//
DELIMITER ;
	

DELIMITER //

CREATE TRIGGER insert_rate_on_parkingspace_insert
AFTER INSERT ON PARKINGSPACE
FOR EACH ROW
BEGIN
    -- Verificar si la fila ya existe en la tabla RATE
    DECLARE rate_exists INT;
    SELECT COUNT(*) INTO rate_exists FROM RATE 
    WHERE FK_IDPARKING = NEW.FK_IDPARKING 
    AND ISUNCOVERED = NEW.ISUNCOVERED 
    AND FK_IDVEHICLETYPE = NEW.FK_IDVEHICLETYPE;
    
    -- Si no existe, insertar una nueva fila en RATE
    IF rate_exists = 0 THEN
        INSERT INTO RATE (HOURCOST, CANCELLATIONCOST, ISUNCOVERED, FK_IDPARKING, FK_IDCITY, FK_IDVEHICLETYPE)
        VALUES (3000, 500, NEW.ISUNCOVERED, NEW.FK_IDPARKING, NEW.FK_IDCITY, NEW.FK_IDVEHICLETYPE);
    END IF;
END//

DELIMITER ;

DELIMITER //
CREATE TRIGGER before_insert_reservation
BEFORE INSERT ON `FOURPARKSDATABASE`.`RESERVATION`
FOR EACH ROW
BEGIN
    IF NEW.CREATIONDATERES > NEW.DATERES THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CREATIONDATERES must be before or equal to DATERES';
    END IF;
    
    IF NEW.STARTTIMERES >= NEW.ENDTIMERES THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'STARTTIMERES must be before ENDTIMERES';
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_update_attempts
AFTER UPDATE ON `FOURPARKSDATABASE`.`USER_AUTHENTICATION`
FOR EACH ROW
BEGIN
    IF NEW.ATTEMPTS = 3 THEN
        UPDATE `FOURPARKSDATABASE`.`USER_AUTHENTICATION`
        SET ISBLOCKED = TRUE
        WHERE IDUSER = NEW.IDUSER AND FK_IDDOCTYPE = NEW.FK_IDDOCTYPE;
    END IF;
END;
//
DELIMITER ;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
