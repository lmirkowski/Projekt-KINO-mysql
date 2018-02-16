-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema KINO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema KINO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `KINO` DEFAULT CHARACTER SET utf8 ;
USE `KINO` ;

-- -----------------------------------------------------
-- Table `KINO`.`film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`film` ;

CREATE TABLE IF NOT EXISTS `KINO`.`film` (
  `idfilm` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `rezyser` VARCHAR(45) NULL,
  `rok_prod` INT(4) NULL,
  `czas_trwania` VARCHAR(10) NULL,
  `kraj` VARCHAR(45) NULL,
  `obsada` LONGTEXT NULL,
  `ogr_wiek` VARCHAR(3) NULL,
  `gatunek` VARCHAR(45) NULL,
  `opis` LONGTEXT NULL,
  PRIMARY KEY (`idfilm`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KINO`.`sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`sala` ;

CREATE TABLE IF NOT EXISTS `KINO`.`sala` (
  `idsala` INT NOT NULL AUTO_INCREMENT,
  `nazwa_sali` VARCHAR(45) NOT NULL,
  `miejsca` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idsala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KINO`.`seans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`seans` ;

CREATE TABLE IF NOT EXISTS `KINO`.`seans` (
  `idseans` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `godzina` VARCHAR(5) NOT NULL,
  `film_idfilm` INT NULL,
  `sala_idsala` INT NULL,
  PRIMARY KEY (`idseans`),
  INDEX `fk_seans_film1_idx` (`film_idfilm` ASC),
  INDEX `fk_seans_sala1_idx` (`sala_idsala` ASC),
  CONSTRAINT `fk_seans_film1`
    FOREIGN KEY (`film_idfilm`)
    REFERENCES `KINO`.`film` (`idfilm`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_seans_sala1`
    FOREIGN KEY (`sala_idsala`)
    REFERENCES `KINO`.`sala` (`idsala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KINO`.`klient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`klient` ;

CREATE TABLE IF NOT EXISTS `KINO`.`klient` (
  `idklient` INT NOT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefon` INT NOT NULL,
  PRIMARY KEY (`idklient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KINO`.`logowanie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`logowanie` ;

CREATE TABLE IF NOT EXISTS `KINO`.`logowanie` (
  `idlogin` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idlogin`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KINO`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`admin` ;

CREATE TABLE IF NOT EXISTS `KINO`.`admin` (
  `idadmin` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `stanowisko` VARCHAR(45) NOT NULL,
  `logowanie_idlogin` INT NULL,
  PRIMARY KEY (`idadmin`),
  INDEX `fk_admin_logowanie1_idx` (`logowanie_idlogin` ASC),
  CONSTRAINT `fk_admin_logowanie1`
    FOREIGN KEY (`logowanie_idlogin`)
    REFERENCES `KINO`.`logowanie` (`idlogin`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KINO`.`rezerwacje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`rezerwacje` ;

CREATE TABLE IF NOT EXISTS `KINO`.`rezerwacje` (
  `idrezerwacje` INT NOT NULL AUTO_INCREMENT,
  `seans_idseans` INT NULL,
  `klient_idklient` INT NULL,
  PRIMARY KEY (`idrezerwacje`),
  INDEX `fk_rezerwacje_seans1_idx` (`seans_idseans` ASC),
  INDEX `fk_rezerwacje_klient1_idx` (`klient_idklient` ASC),
  CONSTRAINT `fk_rezerwacje_seans1`
    FOREIGN KEY (`seans_idseans`)
    REFERENCES `KINO`.`seans` (`idseans`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rezerwacje_klient1`
    FOREIGN KEY (`klient_idklient`)
    REFERENCES `KINO`.`klient` (`idklient`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KINO`.`bilety`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KINO`.`bilety` ;

CREATE TABLE IF NOT EXISTS `KINO`.`bilety` (
  `idbilety` INT NOT NULL AUTO_INCREMENT,
  `rodzaj` VARCHAR(45) NOT NULL,
  `cena` INT NOT NULL,
  `seans_idseans` INT NULL,
  PRIMARY KEY (`idbilety`),
  INDEX `fk_bilety_seans1_idx` (`seans_idseans` ASC),
  CONSTRAINT `fk_bilety_seans1`
    FOREIGN KEY (`seans_idseans`)
    REFERENCES `KINO`.`seans` (`idseans`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
