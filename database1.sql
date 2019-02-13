-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.25-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table pda.mega_pokemon
DROP TABLE IF EXISTS `mega_pokemon`;
CREATE TABLE IF NOT EXISTS `mega_pokemon` (
  `mega_id` int(11) NOT NULL,
  `pokemon_id` int(11) NOT NULL,
  PRIMARY KEY (`mega_id`),
  KEY `FK_mega_pokemon_pokemon` (`pokemon_id`),
  CONSTRAINT `FK_mega_pokemon_pokemon` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pda.mega_pokemon: ~48 rows (approximately)
/*!40000 ALTER TABLE `mega_pokemon` DISABLE KEYS */;
INSERT INTO `mega_pokemon` (`mega_id`, `pokemon_id`) VALUES
	(10033, 3),
	(10034, 6),
	(10035, 6),
	(10036, 9),
	(10090, 15),
	(10073, 18),
	(10037, 65),
	(10071, 80),
	(10038, 94),
	(10039, 115),
	(10040, 127),
	(10041, 130),
	(10042, 142),
	(10043, 150),
	(10044, 150),
	(10045, 181),
	(10072, 208),
	(10046, 212),
	(10047, 214),
	(10048, 229),
	(10049, 248),
	(10065, 254),
	(10050, 257),
	(10064, 260),
	(10051, 282),
	(10066, 302),
	(10052, 303),
	(10053, 306),
	(10054, 308),
	(10055, 310),
	(10070, 319),
	(10087, 323),
	(10067, 334),
	(10056, 354),
	(10057, 359),
	(10074, 362),
	(10089, 373),
	(10076, 376),
	(10062, 380),
	(10063, 381),
	(10079, 384),
	(10088, 428),
	(10058, 445),
	(10059, 448),
	(10060, 460),
	(10068, 475),
	(10069, 531),
	(10075, 719);
/*!40000 ALTER TABLE `mega_pokemon` ENABLE KEYS */;

-- Dumping structure for table pda.mega_stat
DROP TABLE IF EXISTS `mega_stat`;
CREATE TABLE IF NOT EXISTS `mega_stat` (
  `mega_id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `base_stat` int(11) DEFAULT NULL,
  `effort` int(11) DEFAULT NULL,
  PRIMARY KEY (`mega_id`,`stat_id`),
  KEY `FK_mega_stat_stat` (`stat_id`),
  CONSTRAINT `FK_mega_stat_mega_pokemon` FOREIGN KEY (`mega_id`) REFERENCES `mega_pokemon` (`mega_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_mega_stat_stat` FOREIGN KEY (`stat_id`) REFERENCES `stat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pda.mega_stat: ~288 rows (approximately)
/*!40000 ALTER TABLE `mega_stat` DISABLE KEYS */;
INSERT INTO `mega_stat` (`mega_id`, `stat_id`, `base_stat`, `effort`) VALUES
	(10033, 1, 80, 0),
	(10033, 2, 100, 0),
	(10033, 3, 123, 0),
	(10033, 4, 122, 2),
	(10033, 5, 120, 1),
	(10033, 6, 80, 0),
	(10034, 1, 78, 0),
	(10034, 2, 130, 0),
	(10034, 3, 111, 0),
	(10034, 4, 130, 3),
	(10034, 5, 85, 0),
	(10034, 6, 100, 0),
	(10035, 1, 78, 0),
	(10035, 2, 104, 0),
	(10035, 3, 78, 0),
	(10035, 4, 159, 3),
	(10035, 5, 115, 0),
	(10035, 6, 100, 0),
	(10036, 1, 79, 0),
	(10036, 2, 103, 0),
	(10036, 3, 120, 0),
	(10036, 4, 135, 0),
	(10036, 5, 115, 3),
	(10036, 6, 78, 0),
	(10037, 1, 55, 0),
	(10037, 2, 50, 0),
	(10037, 3, 65, 0),
	(10037, 4, 175, 3),
	(10037, 5, 105, 0),
	(10037, 6, 150, 0),
	(10038, 1, 60, 0),
	(10038, 2, 65, 0),
	(10038, 3, 80, 0),
	(10038, 4, 170, 3),
	(10038, 5, 95, 0),
	(10038, 6, 130, 0),
	(10039, 1, 105, 2),
	(10039, 2, 125, 0),
	(10039, 3, 100, 0),
	(10039, 4, 60, 0),
	(10039, 5, 100, 0),
	(10039, 6, 100, 0),
	(10040, 1, 65, 0),
	(10040, 2, 155, 2),
	(10040, 3, 120, 0),
	(10040, 4, 65, 0),
	(10040, 5, 90, 0),
	(10040, 6, 105, 0),
	(10041, 1, 95, 0),
	(10041, 2, 155, 2),
	(10041, 3, 109, 0),
	(10041, 4, 70, 0),
	(10041, 5, 130, 0),
	(10041, 6, 81, 0),
	(10042, 1, 80, 0),
	(10042, 2, 135, 0),
	(10042, 3, 85, 0),
	(10042, 4, 70, 0),
	(10042, 5, 95, 0),
	(10042, 6, 150, 2),
	(10043, 1, 106, 0),
	(10043, 2, 190, 0),
	(10043, 3, 100, 0),
	(10043, 4, 154, 3),
	(10043, 5, 100, 0),
	(10043, 6, 130, 0),
	(10044, 1, 106, 0),
	(10044, 2, 150, 0),
	(10044, 3, 70, 0),
	(10044, 4, 194, 3),
	(10044, 5, 120, 0),
	(10044, 6, 140, 0),
	(10045, 1, 90, 0),
	(10045, 2, 95, 0),
	(10045, 3, 105, 0),
	(10045, 4, 165, 3),
	(10045, 5, 110, 0),
	(10045, 6, 45, 0),
	(10046, 1, 70, 0),
	(10046, 2, 150, 2),
	(10046, 3, 140, 0),
	(10046, 4, 65, 0),
	(10046, 5, 100, 0),
	(10046, 6, 75, 0),
	(10047, 1, 80, 0),
	(10047, 2, 185, 2),
	(10047, 3, 115, 0),
	(10047, 4, 40, 0),
	(10047, 5, 105, 0),
	(10047, 6, 75, 0),
	(10048, 1, 75, 0),
	(10048, 2, 90, 0),
	(10048, 3, 90, 0),
	(10048, 4, 140, 2),
	(10048, 5, 90, 0),
	(10048, 6, 115, 0),
	(10049, 1, 100, 0),
	(10049, 2, 164, 3),
	(10049, 3, 150, 0),
	(10049, 4, 95, 0),
	(10049, 5, 120, 0),
	(10049, 6, 71, 0),
	(10050, 1, 80, 0),
	(10050, 2, 160, 3),
	(10050, 3, 80, 0),
	(10050, 4, 130, 0),
	(10050, 5, 80, 0),
	(10050, 6, 100, 0),
	(10051, 1, 68, 0),
	(10051, 2, 85, 0),
	(10051, 3, 65, 0),
	(10051, 4, 165, 3),
	(10051, 5, 135, 0),
	(10051, 6, 100, 0),
	(10052, 1, 50, 0),
	(10052, 2, 105, 1),
	(10052, 3, 125, 1),
	(10052, 4, 55, 0),
	(10052, 5, 95, 0),
	(10052, 6, 50, 0),
	(10053, 1, 70, 0),
	(10053, 2, 140, 0),
	(10053, 3, 230, 3),
	(10053, 4, 60, 0),
	(10053, 5, 80, 0),
	(10053, 6, 50, 0),
	(10054, 1, 60, 0),
	(10054, 2, 100, 0),
	(10054, 3, 85, 0),
	(10054, 4, 80, 0),
	(10054, 5, 85, 0),
	(10054, 6, 100, 2),
	(10055, 1, 70, 0),
	(10055, 2, 75, 0),
	(10055, 3, 80, 0),
	(10055, 4, 135, 0),
	(10055, 5, 80, 0),
	(10055, 6, 135, 2),
	(10056, 1, 64, 0),
	(10056, 2, 165, 2),
	(10056, 3, 75, 0),
	(10056, 4, 93, 0),
	(10056, 5, 83, 0),
	(10056, 6, 75, 0),
	(10057, 1, 65, 0),
	(10057, 2, 150, 2),
	(10057, 3, 60, 0),
	(10057, 4, 115, 0),
	(10057, 5, 60, 0),
	(10057, 6, 115, 0),
	(10058, 1, 108, 0),
	(10058, 2, 170, 3),
	(10058, 3, 115, 0),
	(10058, 4, 120, 0),
	(10058, 5, 95, 0),
	(10058, 6, 92, 0),
	(10059, 1, 70, 0),
	(10059, 2, 145, 1),
	(10059, 3, 88, 0),
	(10059, 4, 140, 1),
	(10059, 5, 70, 0),
	(10059, 6, 112, 0),
	(10060, 1, 90, 0),
	(10060, 2, 132, 1),
	(10060, 3, 105, 0),
	(10060, 4, 132, 1),
	(10060, 5, 105, 0),
	(10060, 6, 30, 0),
	(10062, 1, 80, 0),
	(10062, 2, 100, 0),
	(10062, 3, 120, 0),
	(10062, 4, 140, 0),
	(10062, 5, 150, 3),
	(10062, 6, 110, 0),
	(10063, 1, 80, 0),
	(10063, 2, 130, 0),
	(10063, 3, 100, 0),
	(10063, 4, 160, 3),
	(10063, 5, 120, 0),
	(10063, 6, 110, 0),
	(10064, 1, 100, 0),
	(10064, 2, 150, 3),
	(10064, 3, 110, 0),
	(10064, 4, 95, 0),
	(10064, 5, 110, 0),
	(10064, 6, 70, 0),
	(10065, 1, 70, 0),
	(10065, 2, 110, 0),
	(10065, 3, 75, 0),
	(10065, 4, 145, 0),
	(10065, 5, 85, 0),
	(10065, 6, 145, 3),
	(10066, 1, 50, 0),
	(10066, 2, 85, 1),
	(10066, 3, 125, 1),
	(10066, 4, 85, 0),
	(10066, 5, 115, 0),
	(10066, 6, 20, 0),
	(10067, 1, 75, 0),
	(10067, 2, 110, 0),
	(10067, 3, 110, 0),
	(10067, 4, 110, 0),
	(10067, 5, 105, 2),
	(10067, 6, 80, 0),
	(10068, 1, 68, 0),
	(10068, 2, 165, 3),
	(10068, 3, 95, 0),
	(10068, 4, 65, 0),
	(10068, 5, 115, 0),
	(10068, 6, 110, 0),
	(10069, 1, 103, 2),
	(10069, 2, 60, 0),
	(10069, 3, 126, 0),
	(10069, 4, 80, 0),
	(10069, 5, 126, 0),
	(10069, 6, 50, 0),
	(10070, 1, 70, 0),
	(10070, 2, 140, 2),
	(10070, 3, 70, 0),
	(10070, 4, 110, 0),
	(10070, 5, 65, 0),
	(10070, 6, 105, 0),
	(10071, 1, 95, 0),
	(10071, 2, 75, 0),
	(10071, 3, 180, 2),
	(10071, 4, 130, 0),
	(10071, 5, 80, 0),
	(10071, 6, 30, 0),
	(10072, 1, 75, 0),
	(10072, 2, 125, 0),
	(10072, 3, 230, 2),
	(10072, 4, 55, 0),
	(10072, 5, 95, 0),
	(10072, 6, 30, 0),
	(10073, 1, 83, 0),
	(10073, 2, 80, 0),
	(10073, 3, 80, 0),
	(10073, 4, 135, 0),
	(10073, 5, 80, 0),
	(10073, 6, 121, 3),
	(10074, 1, 80, 2),
	(10074, 2, 120, 0),
	(10074, 3, 80, 0),
	(10074, 4, 120, 0),
	(10074, 5, 80, 0),
	(10074, 6, 100, 0),
	(10075, 1, 50, 0),
	(10075, 2, 160, 0),
	(10075, 3, 110, 1),
	(10075, 4, 160, 0),
	(10075, 5, 110, 2),
	(10075, 6, 110, 0),
	(10076, 1, 80, 0),
	(10076, 2, 145, 0),
	(10076, 3, 150, 3),
	(10076, 4, 105, 0),
	(10076, 5, 110, 0),
	(10076, 6, 110, 0),
	(10079, 1, 105, 0),
	(10079, 2, 180, 2),
	(10079, 3, 100, 0),
	(10079, 4, 180, 1),
	(10079, 5, 100, 0),
	(10079, 6, 115, 0),
	(10087, 1, 70, 0),
	(10087, 2, 120, 1),
	(10087, 3, 100, 0),
	(10087, 4, 145, 1),
	(10087, 5, 105, 0),
	(10087, 6, 20, 0),
	(10088, 1, 65, 0),
	(10088, 2, 136, 0),
	(10088, 3, 94, 0),
	(10088, 4, 54, 0),
	(10088, 5, 96, 0),
	(10088, 6, 135, 2),
	(10089, 1, 95, 0),
	(10089, 2, 145, 3),
	(10089, 3, 130, 0),
	(10089, 4, 120, 0),
	(10089, 5, 90, 0),
	(10089, 6, 120, 0),
	(10090, 1, 65, 0),
	(10090, 2, 150, 2),
	(10090, 3, 40, 0),
	(10090, 4, 15, 0),
	(10090, 5, 80, 1),
	(10090, 6, 145, 0);
/*!40000 ALTER TABLE `mega_stat` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;