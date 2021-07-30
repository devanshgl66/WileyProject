-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema wileyProject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wileyProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wileyProject` ;
-- -----------------------------------------------------
-- Schema dba
-- -----------------------------------------------------
USE `wileyProject` ;

-- -----------------------------------------------------
-- Table `wileyProject`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(256) NULL,
  `account_no` VARCHAR(45) NULL,
  `pan_number` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `account_no_UNIQUE` (`account_no` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `pan_number_UNIQUE` (`pan_number` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This table is for storing user account details';


-- -----------------------------------------------------
-- Table `wileyProject`.`wallets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`wallets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `currency_type` ENUM("INR", "USD") NOT NULL,
  `amount` FLOAT NOT NULL DEFAULT 0.0,
  `status` ENUM("blocked", "active", "pending") NULL DEFAULT 'pending',
  PRIMARY KEY (`id`),
  INDEX `wallet_account_id_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `wallet_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `wileyProject`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This contains data for user wallet';


-- -----------------------------------------------------
-- Table `wileyProject`.`wallet_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`wallet_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM("debit", "credit") NOT NULL,
  `wallet_id` INT NOT NULL,
  `amount` FLOAT NOT NULL,
  `status` ENUM("pending", "complete", "failed") NOT NULL,
  `mode` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `wallet_transaction_wallet_id_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `wallet_transaction_wallet_id`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wileyProject`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(10) NULL,
  `is_active` TINYINT NOT NULL,
  `added_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wileyProject`.`trade_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`trade_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wallet_id` INT NOT NULL,
  `type` ENUM("buy", "sell") NULL,
  `status` ENUM("pending", "complete", "failed") NULL,
  `item_id` INT NULL,
  `unit_price` FLOAT NULL,
  `quantity` FLOAT NOT NULL DEFAULT 0.0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `trade_trans_wallet_idx` (`wallet_id` ASC) VISIBLE,
  INDEX `fk_trade_transaction_item_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `trade_trans_wallet`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_transaction_item`
    FOREIGN KEY (`item_id`)
    REFERENCES `wileyProject`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Contains data for transaction\n';


-- -----------------------------------------------------
-- Table `wileyProject`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wallet_id` INT NULL,
  `status` ENUM("pending", "complete", "failed") NOT NULL,
  `transaction_id` INT NULL,
  `order_price` FLOAT NULL,
  `order_quantity` FLOAT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `orders_transaction_id_idx` (`transaction_id` ASC) VISIBLE,
  CONSTRAINT `orders_wallet_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orders_transaction_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `wileyProject`.`trade_transactions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wileyProject`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wileyProject`.`inventory` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `quantity` FLOAT NOT NULL DEFAULT 0.0,
  `wallet_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `inventory_wallet_id_idx` (`wallet_id` ASC) VISIBLE,
  INDEX `inventory_item_id_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `inventory_wallet_id`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `wileyProject`.`wallets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inventory_item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `wileyProject`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
