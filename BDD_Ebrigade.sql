-- MySQL Script generated by MySQL Workbench
-- Sat Feb  1 19:02:47 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE TABLE `Geographique` (
  `idGeographique` INT NOT NULL,
  `Position_X` INT NULL,
  `Position_Y` INT NULL,
  PRIMARY KEY (`idGeographique`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDD_Ebrigade`.`Intervention`
-- -----------------------------------------------------
CREATE TABLE `Intervention` (
  `Numero_Intervention` INT NOT NULL,
  `Commune` VARCHAR(45) NULL,
  `Adresse` VARCHAR(45) NULL,
  `Type_interv` VARCHAR(45) NULL,
  `Opm` TINYINT NULL,
  `Important` TINYINT NULL,
  `Date_Heure_Debut` DATE NULL,
  `Date_Heure_Fin` DATE NULL,
  `Geographique_idGeographique` INT NOT NULL,
  PRIMARY KEY (`Numero_Intervention`, `Geographique_idGeographique`),
  CONSTRAINT `fk_Intervention_Geographique1`
    FOREIGN KEY (`Geographique_idGeographique`)
    REFERENCES `BDD_Ebrigade`.`Geographique` (`idGeographique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Intervention_Geographique1_idx` ON `Intervention` (`Geographique_idGeographique` ASC);


-- -----------------------------------------------------
-- Table `BDD_Ebrigade`.`Engins`
-- -----------------------------------------------------
CREATE TABLE `Engins` (
  `idEngins` INT NOT NULL,
  `Nom_Engin` VARCHAR(45) NULL,
  `Date_Heur_Depart` DATE NULL,
  `Date_Heure_Arriver` DATE NULL,
  `Date_Heure_Retour` DATE NULL,
  PRIMARY KEY (`idEngins`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDD_Ebrigade`.`Intervention_Engins`
-- -----------------------------------------------------
CREATE TABLE `Intervention_Engins` (
  `Intervention_Numero_Intervention` INT NOT NULL,
  `Engins_idEngins` INT NOT NULL,
  PRIMARY KEY (`Intervention_Numero_Intervention`, `Engins_idEngins`),
  CONSTRAINT `fk_Intervention_has_Engins_Intervention`
    FOREIGN KEY (`Intervention_Numero_Intervention`)
    REFERENCES `BDD_Ebrigade`.`Intervention` (`Numero_Intervention`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Intervention_has_Engins_Engins1`
    FOREIGN KEY (`Engins_idEngins`)
    REFERENCES `BDD_Ebrigade`.`Engins` (`idEngins`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Intervention_has_Engins_Engins1_idx` ON `Intervention_Engins` (`Engins_idEngins` ASC);

CREATE INDEX `fk_Intervention_has_Engins_Intervention_idx` ON `Intervention_Engins` (`Intervention_Numero_Intervention` ASC);


-- -----------------------------------------------------
-- Table `BDD_Ebrigade`.`Responsable`
-- -----------------------------------------------------
CREATE TABLE `Responsable` (
  `idResponsable` INT NOT NULL,
  `Nom` VARCHAR(45) NULL,
  PRIMARY KEY (`idResponsable`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BDD_Ebrigade`.`Personnel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Personnel` (
  `idPersonnel` INT NOT NULL,
  `Nom` VARCHAR(45) NULL,
  `Role` VARCHAR(45) NULL,
  `Responsable_idResponsable` INT NOT NULL,
  PRIMARY KEY (`idPersonnel`, `Responsable_idResponsable`),
  CONSTRAINT `fk_Personnel_Responsable1`
    FOREIGN KEY (`Responsable_idResponsable`)
    REFERENCES `BDD_Ebrigade`.`Responsable` (`idResponsable`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Personnel_Responsable1_idx` ON `Personnel` (`Responsable_idResponsable` ASC);


-- -----------------------------------------------------
-- Table `BDD_Ebrigade`.`Engins_Personnel`
-- -----------------------------------------------------
CREATE TABLE `Engins_Personnel` (
  `Engins_idEngins` INT NOT NULL,
  `Personnel_idPersonnel` INT NOT NULL,
  PRIMARY KEY (`Engins_idEngins`, `Personnel_idPersonnel`),
  CONSTRAINT `fk_Engins_has_Personnel_Engins1`
    FOREIGN KEY (`Engins_idEngins`)
    REFERENCES `BDD_Ebrigade`.`Engins` (`idEngins`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Engins_has_Personnel_Personnel1`
    FOREIGN KEY (`Personnel_idPersonnel`)
    REFERENCES `BDD_Ebrigade`.`Personnel` (`idPersonnel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Engins_has_Personnel_Personnel1_idx` ON `Engins_Personnel` (`Personnel_idPersonnel` ASC);

CREATE INDEX `fk_Engins_has_Personnel_Engins1_idx` ON `Engins_Personnel` (`Engins_idEngins` ASC);


-- -----------------------------------------------------
-- Table `BDD_Ebrigade`.`Parametre`
-- -----------------------------------------------------
CREATE TABLE `Parametre` (
  `idParametre` INT NOT NULL,
  `Jours_Feries` VARCHAR(45) NULL,
  `Heure_Debut` DATETIME NULL,
  `Heure_Fin` DATETIME NULL,
  PRIMARY KEY (`idParametre`))
ENGINE = InnoDB;

