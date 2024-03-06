-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema salesdb_data_modelling
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salesdb_data_modelling
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salesdb_data_modelling` ;
USE `salesdb_data_modelling` ;

-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`state` (
  `state_id` VARCHAR(50) NOT NULL,
  `area_code` VARCHAR(45) NULL,
  `state` VARCHAR(255) NULL,
  `country` VARCHAR(45) NULL,
  `state_code` VARCHAR(45) NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`city` (
  `city_id` VARCHAR(50) NOT NULL,
  `city_name` VARCHAR(255) NULL,
  `type` VARCHAR(255) NULL,
  `state_id` VARCHAR(255) NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_state_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_state`
    FOREIGN KEY (`state_id`)
    REFERENCES `salesdb_data_modelling`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`store` (
  `store_id` VARCHAR(50) NOT NULL,
  `store_name` VARCHAR(255) NULL,
  `longitude` DECIMAL NULL,
  `latitude` DECIMAL NULL,
  `location` VARCHAR(255) NULL,
  `city_id` VARCHAR(50) NULL,
  PRIMARY KEY (`store_id`),
  INDEX `fk_store_city_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `salesdb_data_modelling`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`employee` (
  `employee_id` VARCHAR(50) NOT NULL,
  `employee_first_name` VARCHAR(255) NULL,
  `employee_last_name` VARCHAR(255) NULL,
  `store_id` VARCHAR(50) NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_store_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `salesdb_data_modelling`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`product` (
  `product_id` VARCHAR(50) NOT NULL,
  `product_name` VARCHAR(255) NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`sales_channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`sales_channel` (
  `sales_channel_id` VARCHAR(50) NOT NULL,
  `sales_channel_name` VARCHAR(255) NULL,
  PRIMARY KEY (`sales_channel_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`customer` (
  `customer_id` VARCHAR(50) NOT NULL,
  `customer_first_name` VARCHAR(255) NULL,
  `customer_last_name` VARCHAR(255) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesdb_data_modelling`.`sales_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salesdb_data_modelling`.`sales_order` (
  `order_num` VARCHAR(50) NOT NULL,
  `order_date` DATETIME NULL,
  `currency_code` VARCHAR(45) NULL,
  `order_quantity` DECIMAL NULL,
  `discount_applied` DECIMAL NULL,
  `ship_date` DATETIME NULL,
  `delivery_date` DATETIME NULL,
  `procure_date` DATETIME NULL,
  `total_cost` DECIMAL NULL,
  `total_price` DECIMAL NULL,
  `employee_id` VARCHAR(50) NULL,
  `product_id` VARCHAR(50) NULL,
  `sales_channel_id` VARCHAR(50) NULL,
  `customer_id` VARCHAR(50) NULL,
  PRIMARY KEY (`order_num`),
  INDEX `fk_sales_order_employee_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_sales_order_product_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_sales_order_sales_channel_idx` (`sales_channel_id` ASC) VISIBLE,
  INDEX `fk_sales_order_customer_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_order_employee`
    FOREIGN KEY (`employee_id`)
    REFERENCES `salesdb_data_modelling`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_order_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `salesdb_data_modelling`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_order_sales_channel`
    FOREIGN KEY (`sales_channel_id`)
    REFERENCES `salesdb_data_modelling`.`sales_channel` (`sales_channel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_order_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `salesdb_data_modelling`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

commit;
use salesdb_data_modelling;
commit;