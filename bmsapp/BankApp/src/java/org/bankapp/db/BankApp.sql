-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.1.73-community - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for bankapp
DROP DATABASE IF EXISTS `bankapp`;
CREATE DATABASE IF NOT EXISTS `bankapp` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bankapp`;


-- Dumping structure for table bankapp.address
DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `AddressId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `DoorNo` varchar(255) DEFAULT NULL,
  `StreetName` varchar(255) DEFAULT NULL,
  `City` varchar(25) DEFAULT NULL,
  `Country` varchar(25) DEFAULT NULL,
  `District` varchar(255) DEFAULT NULL,
  `State` varchar(255) DEFAULT NULL,
  `pincode` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`AddressId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bankapp.address: ~3 rows (approximately)
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`AddressId`, `DoorNo`, `StreetName`, `City`, `Country`, `District`, `State`, `pincode`) VALUES
	(2685127777, 'zxcxczcz', 'zxcxzc', 'zczxcz', 'zczxczxc', 'zcxzczxc', 'czxczxc', 32442432432342),
	(2685132777, 'zxcxczcz', 'zxcxzc', 'zczxcz', 'zczxczxc', 'zcxzczxc', 'czxczxc', 32442432432342),
	(2685201426, 'zxcxczcz', 'zxcxzc', 'zczxcz', 'zczxczxc', 'zcxzczxc', 'czxczxc', 32442432432342);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;


-- Dumping structure for table bankapp.balance
DROP TABLE IF EXISTS `balance`;
CREATE TABLE IF NOT EXISTS `balance` (
  `AccountId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Balance` double DEFAULT NULL,
  `TransactionId` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`AccountId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bankapp.balance: ~3 rows (approximately)
/*!40000 ALTER TABLE `balance` DISABLE KEYS */;
INSERT INTO `balance` (`AccountId`, `Balance`, `TransactionId`) VALUES
	(76951506526, 300, NULL),
	(76951703826, 500, NULL),
	(76952335825, 1000, NULL);
/*!40000 ALTER TABLE `balance` ENABLE KEYS */;


-- Dumping structure for table bankapp.bankuser
DROP TABLE IF EXISTS `bankuser`;
CREATE TABLE IF NOT EXISTS `bankuser` (
  `UserId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `password` varchar(25555) DEFAULT NULL,
  `SecretKey` longblob,
  `role` varchar(255) DEFAULT NULL,
  `oldPassword` varchar(30000) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bankapp.bankuser: ~4 rows (approximately)
/*!40000 ALTER TABLE `bankuser` DISABLE KEYS */;
INSERT INTO `bankuser` (`UserId`, `password`, `SecretKey`, `role`, `oldPassword`) VALUES
	(12345, NULL, NULL, 'admin', 'abcdef'),
	(7427150654, NULL, NULL, 'User', 'zxcz150652014'),
	(7427170384, NULL, NULL, 'User', 'asd170382014'),
	(7427256464, NULL, NULL, 'User', 'dfs256462014');
/*!40000 ALTER TABLE `bankuser` ENABLE KEYS */;


-- Dumping structure for table bankapp.customer
DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `AccountId` bigint(20) DEFAULT NULL,
  `DetaildId` bigint(20) unsigned DEFAULT NULL,
  `UserId` bigint(20) unsigned DEFAULT NULL,
  `CustomerId` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bankapp.customer: ~3 rows (approximately)
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` (`AccountId`, `DetaildId`, `UserId`, `CustomerId`) VALUES
	(76951506526, 726212777152, 7427150654, 7728150656),
	(76951703826, 726213277655, 7427170384, 7728170386),
	(76952335825, 7262279340, 7427256464, 77282564622);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;


-- Dumping structure for table bankapp.details
DROP TABLE IF EXISTS `details`;
CREATE TABLE IF NOT EXISTS `details` (
  `DetailsId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `First_Name` varchar(255) DEFAULT NULL,
  `Last_Name` varchar(255) DEFAULT NULL,
  `Mobile` varchar(25) DEFAULT NULL,
  `EmailId` varchar(255) DEFAULT NULL,
  `Picture` mediumblob,
  `Signature` mediumblob,
  `AccountType` varchar(25) DEFAULT NULL,
  `MinimumBalance` double DEFAULT NULL,
  `AddressID` bigint(20) unsigned DEFAULT NULL,
  `ParentName` varchar(255) DEFAULT NULL,
  `Designation` varchar(255) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `securityQuestion` varchar(255) DEFAULT NULL,
  `securityAnswer` varchar(255) DEFAULT NULL,
  `Documents` mediumblob,
  PRIMARY KEY (`DetailsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bankapp.details: ~2 rows (approximately)
/*!40000 ALTER TABLE `details` DISABLE KEYS */;
INSERT INTO `details` (`DetailsId`, `First_Name`, `Last_Name`, `Mobile`, `EmailId`, `Picture`, `Signature`, `AccountType`, `MinimumBalance`, `AddressID`, `ParentName`, `Designation`, `DOB`, `securityQuestion`, `securityAnswer`, `Documents`) VALUES
INSERT INTO `details` (`DetailsId`, `First_Name`, `Last_Name`, `Mobile`, `EmailId`, `Picture`, `Signature`, `AccountType`, `MinimumBalance`, `AddressID`, `ParentName`, `Designation`, `DOB`, `securityQuestion`, `securityAnswer`, `Documents`) VALUES
INSERT INTO `details` (`DetailsId`, `First_Name`, `Last_Name`, `Mobile`, `EmailId`, `Picture`, `Signature`, `AccountType`, `MinimumBalance`, `AddressID`, `ParentName`, `Designation`, `DOB`, `securityQuestion`, `securityAnswer`, `Documents`) VALUES
/*!40000 ALTER TABLE `details` ENABLE KEYS */;


-- Dumping structure for table bankapp.dummy
DROP TABLE IF EXISTS `dummy`;
CREATE TABLE IF NOT EXISTS `dummy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Pic` mediumblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bankapp.dummy: ~0 rows (approximately)
/*!40000 ALTER TABLE `dummy` DISABLE KEYS */;
/*!40000 ALTER TABLE `dummy` ENABLE KEYS */;


-- Dumping structure for table bankapp.transactions
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `TransactionId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `TransactionType` varchar(25) DEFAULT NULL,
  `TransactionAmount` double DEFAULT NULL,
  PRIMARY KEY (`TransactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table bankapp.transactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;