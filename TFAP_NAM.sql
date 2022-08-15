-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TFAP_NAM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TFAP_NAM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TFAP_NAM` DEFAULT CHARACTER SET utf8 ;
USE `TFAP_NAM` ;

-- -----------------------------------------------------
-- Table `TFAP_NAM`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`persona` (
  `id_persona` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `email` VARCHAR(100) NOT NULL,
  `url_linkedin` VARCHAR(100) NOT NULL,
  `url_github` VARCHAR(100) NOT NULL,
  `url_banner` VARCHAR(100) NOT NULL,
  `about` VARCHAR(500) NOT NULL,
  `contrasenia` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_persona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`Tipo_skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`Tipo_skill` (
  `idTipo_skill` INT NOT NULL,
  `nombre_tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipo_skill`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`Nivel_skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`Nivel_skill` (
  `idnivel_skill` INT NOT NULL,
  `nivel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idnivel_skill`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`Skill` (
  `idSkill` INT NOT NULL,
  `tipo_skill` INT NOT NULL,
  `nivel_skill` INT NOT NULL,
  `persona` INT NOT NULL,
  `nombre_skill` VARCHAR(45) NOT NULL,
  `url_icono` VARCHAR(45) NULL,
  PRIMARY KEY (`idSkill`),
  INDEX `idnivel_idx` (`nivel_skill` ASC) VISIBLE,
  INDEX `idpersona_idx` (`persona` ASC) VISIBLE,
  INDEX `idtipo_idx` (`tipo_skill` ASC) VISIBLE,
  CONSTRAINT `idtipo`
    FOREIGN KEY (`tipo_skill`)
    REFERENCES `TFAP_NAM`.`Tipo_skill` (`idTipo_skill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idnivel`
    FOREIGN KEY (`nivel_skill`)
    REFERENCES `TFAP_NAM`.`Nivel_skill` (`idnivel_skill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idpersona`
    FOREIGN KEY (`persona`)
    REFERENCES `TFAP_NAM`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`proyecto` (
  `idproyecto` INT NOT NULL,
  `persona` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `url_captura` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `url_repositorio` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idproyecto`),
  INDEX `idpersona_idx` (`persona` ASC) VISIBLE,
  CONSTRAINT `idpersona`
    FOREIGN KEY (`persona`)
    REFERENCES `TFAP_NAM`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`estado` (
  `idestado` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL COMMENT 'en curso abandonado finalizado suspendido',
  PRIMARY KEY (`idestado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`tipo_educ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`tipo_educ` (
  `idtipo_educ` INT NOT NULL,
  `tipo_educacion` VARCHAR(45) NOT NULL COMMENT 'curso / terciario / universitario',
  PRIMARY KEY (`idtipo_educ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`educacion` (
  `ideducacion` INT NOT NULL,
  `persona` INT NOT NULL,
  `carrera` VARCHAR(45) NOT NULL,
  `tipo` INT NOT NULL COMMENT 'Universitaria / terciaria / curso',
  `institucion` VARCHAR(45) NOT NULL,
  `año_inicio` VARCHAR(45) NOT NULL COMMENT 'año de inicio de la carrera',
  `año_fin` VARCHAR(45) NULL COMMENT 'año finalizacion de la carrera\n',
  `estado` INT NOT NULL COMMENT 'En curso / abandonada / finalizada / suspendida',
  PRIMARY KEY (`ideducacion`),
  INDEX `idpersona_idx` (`persona` ASC) VISIBLE,
  INDEX `idestado_idx` (`estado` ASC) VISIBLE,
  INDEX `idtipo_idx` (`tipo` ASC) VISIBLE,
  CONSTRAINT `idpersona`
    FOREIGN KEY (`persona`)
    REFERENCES `TFAP_NAM`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idestado`
    FOREIGN KEY (`estado`)
    REFERENCES `TFAP_NAM`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idtipo`
    FOREIGN KEY (`tipo`)
    REFERENCES `TFAP_NAM`.`tipo_educ` (`idtipo_educ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TFAP_NAM`.`Laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TFAP_NAM`.`Laboral` (
  `idLaboral` INT NOT NULL,
  `persona` INT NOT NULL,
  `puesto` VARCHAR(45) NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  `fecha_inicio` VARCHAR(45) NOT NULL,
  `año` VARCHAR(45) NULL,
  `fecha_fin` VARCHAR(45) NULL,
  `descripcion` VARCHAR(450) NULL,
  PRIMARY KEY (`idLaboral`),
  INDEX `idpersona_idx` (`persona` ASC) VISIBLE,
  CONSTRAINT `idpersona`
    FOREIGN KEY (`persona`)
    REFERENCES `TFAP_NAM`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
