-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: localhost    Database: broker
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bill_of_users`
--

DROP TABLE IF EXISTS `bill_of_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_of_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'ID пользователя',
  `cash` decimal(11,2) DEFAULT NULL COMMENT 'Деньги или счёт',
  `currency_id` int unsigned DEFAULT NULL COMMENT 'Валюта счёта',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `bill_of_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `bill_of_users_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currencys` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица счетов пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_of_users`
--

LOCK TABLES `bill_of_users` WRITE;
/*!40000 ALTER TABLE `bill_of_users` DISABLE KEYS */;
INSERT INTO `bill_of_users` VALUES (1,1,34.00,2),(15,1,150245.00,2),(16,1,1000.00,1),(17,2,150.00,1),(18,3,1502453.00,2),(19,4,100500.00,2),(20,5,55000.00,1),(21,6,345893.00,2),(22,7,35.00,1),(23,8,5893854.00,2),(24,8,5024.25,1),(25,9,13245.78,1),(26,9,47950245.00,2),(27,10,14322145.00,2);
/*!40000 ALTER TABLE `bill_of_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_cash_after_update` AFTER UPDATE ON `bill_of_users` FOR EACH ROW BEGIN 
	IF NEW.cash <= '0' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough cash. You must top up your account!';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bounds`
--

DROP TABLE IF EXISTS `bounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bounds` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `simbol` varchar(15) NOT NULL COMMENT 'Обозначение эмитента',
  `name_of_the_issuer` varchar(30) NOT NULL COMMENT 'Название эмитента',
  `info_about_issuer` text NOT NULL COMMENT 'Сводка об эмитенте',
  `maturity_date` date NOT NULL COMMENT 'Дата погашения облигации',
  `profitability` varchar(5) DEFAULT NULL COMMENT 'Доходность',
  `market_id` int unsigned NOT NULL COMMENT 'ID типа рынка',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `market_id` (`market_id`),
  CONSTRAINT `bounds_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица облигаций';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bounds`
--

LOCK TABLES `bounds` WRITE;
/*!40000 ALTER TABLE `bounds` DISABLE KEYS */;
INSERT INTO `bounds` VALUES (1,'SU26215RMFS2','ОФЗ-26215','Наименование: МинФин РФ, облигации федерального займа с постоянным купонным доходом, документарные именные, выпуск 26215','2023-08-16','8,11%',1),(2,'RU000A0JXRV7','Альфа-Банк-20-боб','Наименование: \"Альфа-Банк\" АО, биржевые облигации процентные документарные на предъявителя, серии БО-20','2032-11-05','7,0%',1),(3,'Газпнф1P3R','RU000A0ZYDS7','Наименование: \"Газпром нефть\" ПАО, биржевые облигации документарные на предъявителя, серии 001P-03R','2022-10-17','7,62%',1),(4,'ГПБ БО-19','RU000A0ZYRY5','Наименование: \"Газпромбанк\" АО, облигации биржевые процентные документарные на предъявителя, серия БО-19','2023-12-02','6,08%',1),(5,'ГТЛК 1P-04','RU000A0JXPG2','Наименование: \"Государственная транспортная лизинговая компания\" ПАО, облигации биржевые процентные документарные на предъявителя, серии 001Р-04','2030-10-08','9,3%',1),(6,'ИКС5Фин1P3','RU000A0ZZ083','Наименование: \"ИКС 5 ФИНАНС\" ООО, облигации биржевые процентные документарные на предъявителя, серии 001P-03','2030-09-10','1,23%',1),(7,'ЛСР БО 1P2','RU000A0JXPM0','Наименование: \"Группа ЛСР\" ПАО, биржевые облигации документарные на предъявителя, серии БО-001P-02','2022-04-20','6,87%',1),(8,'МТС 001P-3','RU000A0ZYFC6','Наименование: \"Мобильные ТелеСистемы\", ПАО, биржевые облигации документарные на предъявителя, серии 001P-03','2022-11-03','8,37%',1),(9,'ОГК-2 1P3R','RU000A0ZZ1H2','Наименование: \"Вторая генерирующая компания оптового рынка электроэнергии\", ПАО, облигации биржевые процентные документарные на предъявителя серии 001P-03R','2023-03-21','6,72%',1),(10,'РЖД 1P-07R','RU000A0ZZ9R4','Наименование: \"РЖД\" ОАО, биржевые облигации документарные на предъявителя, серии 001P-07R','2033-05-26','8,97%',1);
/*!40000 ALTER TABLE `bounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencys`
--

DROP TABLE IF EXISTS `currencys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencys` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `symbol` char(1) NOT NULL COMMENT 'Обозначение валюты',
  `abbreviation` char(3) NOT NULL COMMENT 'Аббревиатура',
  `description` varchar(20) NOT NULL COMMENT 'Описание валюты',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица валют';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencys`
--

LOCK TABLES `currencys` WRITE;
/*!40000 ALTER TABLE `currencys` DISABLE KEYS */;
INSERT INTO `currencys` VALUES (1,'$','USD','Американский доллар'),(2,'₽','RUB','Российский рубль'),(3,'€','EUR','Евро'),(4,'$','CND','Канадский доллар'),(5,'£','GBP','Фунт стерлингов'),(6,'¥','JPY','Японская иена'),(7,'₣','CHF','Швейцарский франк'),(8,'¥','CNY','Китайский юань');
/*!40000 ALTER TABLE `currencys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deals`
--

DROP TABLE IF EXISTS `deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'ID пользователя',
  `type_of_bid_id` int unsigned NOT NULL COMMENT 'Тип заявки',
  `issuer_id` bigint unsigned NOT NULL COMMENT 'ID эмитента',
  `deal` enum('buy','sell') NOT NULL COMMENT 'Сделка на покупку или продажу',
  `quantity` int unsigned NOT NULL COMMENT 'Количество',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена сделки',
  `currency_id` int unsigned NOT NULL COMMENT 'ID валюты',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время совершения сделки',
  `closed` enum('yes','no') DEFAULT 'no' COMMENT 'Статус сделки (закрыта или нет)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `type_of_bid_id` (`type_of_bid_id`),
  KEY `issuer_id` (`issuer_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `deals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `deals_ibfk_2` FOREIGN KEY (`type_of_bid_id`) REFERENCES `type_of_bids` (`id`),
  CONSTRAINT `deals_ibfk_3` FOREIGN KEY (`issuer_id`) REFERENCES `issuer` (`id`),
  CONSTRAINT `deals_ibfk_4` FOREIGN KEY (`currency_id`) REFERENCES `currencys` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица сделок с ценными бумагами';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deals`
--

LOCK TABLES `deals` WRITE;
/*!40000 ALTER TABLE `deals` DISABLE KEYS */;
INSERT INTO `deals` VALUES (1,1,2,3,'buy',7,125.00,2,'2022-01-04 16:54:39','no'),(2,2,2,1,'buy',15,165.70,2,'2022-01-04 16:54:39','no'),(3,7,3,8,'buy',99,4567.80,1,'2022-01-04 16:54:39','no'),(4,5,2,10,'buy',1,400.00,2,'2022-01-04 16:54:39','no'),(5,3,1,5,'sell',3,53.60,1,'2022-01-04 16:54:39','no'),(6,4,1,6,'buy',128,342.10,2,'2022-01-04 16:54:39','no'),(7,4,2,6,'sell',128,347.60,2,'2022-01-04 16:54:39','yes'),(8,1,2,3,'sell',7,129.00,2,'2022-01-04 16:54:39','yes'),(9,2,1,1,'sell',15,170.40,2,'2022-01-04 16:54:39','yes'),(10,7,3,8,'sell',90,5438.00,1,'2022-01-04 16:54:39','no'),(11,5,2,7,'buy',14,342.00,2,'2022-01-04 16:54:39','no'),(12,8,2,2,'sell',77,111.00,2,'2022-01-04 16:54:39','no'),(13,1,4,9,'buy',70,20247.60,2,'2022-01-04 16:54:39','no'),(14,9,5,2,'buy',42,67.00,2,'2022-01-04 16:54:39','no'),(15,10,3,8,'sell',37,5400.00,2,'2022-01-04 16:54:39','no'),(16,2,2,1,'buy',19,132.80,2,'2022-01-04 16:54:39','no'),(22,1,2,8,'buy',3,94.00,1,'2022-01-19 16:31:17','no');
/*!40000 ALTER TABLE `deals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invest_profiles`
--

DROP TABLE IF EXISTS `invest_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invest_profiles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name_profile` varchar(50) NOT NULL COMMENT 'Название инвестиционного профиля',
  `description` text NOT NULL COMMENT 'Описание инвестиционного профиля',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_profile` (`name_profile`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица инвестиционных профилей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invest_profiles`
--

LOCK TABLES `invest_profiles` WRITE;
/*!40000 ALTER TABLE `invest_profiles` DISABLE KEYS */;
INSERT INTO `invest_profiles` VALUES (1,'Консервативный','Ваша цель - сохранение и защита капитала. Вы готовы размещать средства только в консервативные инструменты. Доходы предполагаются на уровне или чуть выше существующих процентных ставок по депозитам в соответствующей валюте. Однако доходность носит вероятностный характер, она скорее ожидаемая, чем гарантированная.'),(2,'Умеренно консервативный','Вы готовы принять разумный уровень инвестиционного риска в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +2-5% годовых в рублях и/или +2-5% в долларах США. В этом случае стоимость капитала может колебаться, а также упасть ниже суммы Ваших первоначальных инвестиций.'),(3,'Рациональный','Вы готовы принять умеренно высокий уровень инвестиционного риска и колебаний стоимости в кратко- и среднесрочной перспективе в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +5-8% годовых в рублях и/или +5-8% в доллорах США. Стоимость капитала может колебаться, а также упасть ниже сыммы Ваших первоначальных инвестиций'),(4,'Умеренно агрессивный','Вы готовы принять высокий уровень инвестиционного риска и колебаний стоимости в кратко- и среднесрочной перспективе в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +8-13% годовых в рублях и/или +8-12% в доллорах США. Стоимость капитала может колебаться, а также упасть ниже суммы Ваших первоначальных инвестиций в течение некоторго периода времени.'),(5,'Агрессивный','Вы готовы принять высокий уровень инвестиционного риска и колебаний стоимости на инвестиционном горизонте в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +13-18% годовых в рублях и/или +12-16% в доллорах США. Стоимость капитала может колебаться, а также упасть существенно ниже суммы Ваших первоначальных инвестиций на инвестиционном горизонте.'),(6,'Сверхагрессивный','Вы готовы принять крайне высокий уровень инвестиционного  риска и колебаний стоимости на инвестиционном горизонте в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +18% и выше годовых в рублях и/или +16% и выше в доллорах США. Вы можете самостоятельно определять и контролировать уровень инвестиционного риска и вероятной доходности, но, в случае ряда неудачных решений (сделок), возможно, с использованием \"плеча\" и производных финансовых инструментов, Ваши потери могут составлять на уровне 60% от первоначальных инвестиций.'),(7,'Профессиональный','Вы готовы самостоятельно оценивать и контролировать уровень инвестиционных рисков и брать на себя все риски без ограничений, в том числе маржинальные, и, таким образом, осознаёте, что в случае ряда неудачных сделок, возможно с использованием \"плеча\" и производных финансовых инструментов, Ваши потери могут составить 100% и даже более от суммы первоначальных инвестиций.');
/*!40000 ALTER TABLE `invest_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuer`
--

DROP TABLE IF EXISTS `issuer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issuer` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticker_symbol` char(5) NOT NULL COMMENT 'Обозначение эмитента',
  `name_of_the_issuer` varchar(30) NOT NULL COMMENT 'Название эмитента',
  `info_about_issuer` text NOT NULL COMMENT 'Сводка об эмитенте',
  `market_id` int unsigned NOT NULL,
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Текущая цена',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `simbol` (`ticker_symbol`),
  UNIQUE KEY `name_of_the_issuer` (`name_of_the_issuer`),
  KEY `market_id` (`market_id`),
  CONSTRAINT `issuer_ibfk_1` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица эмитентов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuer`
--

LOCK TABLES `issuer` WRITE;
/*!40000 ALTER TABLE `issuer` DISABLE KEYS */;
INSERT INTO `issuer` VALUES (1,'AAPL','Apple','Apple — американская корпорация из Купертино, инновационный лидер рынка гаджетов. Работает в премиум-сегменте. Создатель iPhone, iPod, iPad, Apple Watch, Apple TV, хранилища iCloud, технологии бесконтактной оплаты Apple Pay и собственного программного обеспечения: операционных систем iOS и MacOS.',2,170.00),(2,'AYX','Alteryx Class A','Alteryx Inc. («Элтерикс Инк.») является компанией, разрабатывающей программное обеспечение для самостоятельной аналитики данных. Компания предоставляет платформу на условиях подписки, позволяющую организациям подготавливать, объединять и анализировать данные из множества источников, что облегчает принятие решений на основе таких данных. Компания упрощает доступ к аналитической информации, основанной на данных, для всех специалистов по обработке данных, бизнес-аналитиков, программистов и специалистов по анализу данных за счет расширения функционала и аналитических инструментов. Платформа Компании позволяет бизнес-аналитикам просматривать базовые данные, метаданные и использовать прикладные аналитические инструменты на любом этапе процесса. Платформа Компании предназначена для взаимодействия с широким ассортиментом традиционных источников данных. Платформа также способна обрабатывать данные из облачных приложений, например, Google Analytics, Marketo, NetSuite, Salesforce и Workday, а также платформ социальных сетей Facebook и Twitter. Платформа Компании состоит из компонентов Alteryx Designer, Alteryx Server, Alteryx Connect и Alteryx Promote.',2,57.00),(3,'MU','Micron Technology','Micron Technology — американская транснациональная корпорация, производитель чипов памяти и флеш-накопителей. По данным 2019 года, занимает 4 место в списке крупнейших мировых производителей микроэлектронных компонентов.',2,96.00),(4,'MSFT','Microsoft','Microsoft — американская корпорация, создатель программного обеспечения для компьютеров, игровых приставок и офисных приложений. Разработчик Windows и Xbox. В апреле 2021 года Microsoft получила десятилетний контракт на поставку устройств дополненной реальности для армии США.',2,169.00),(5,'INTC','Intel','Intel — американская компания, самый крупный в мире разработчик микропроцессоров и чипсетов (наборов микросхем). Занимает 75% рынка в своём сегменте. Продукцию компании используют Dell, HP, Lenovo.',2,55.70),(6,'GAZP','Газпром','ПАО «Газпром» — глобальная энергетическая компания, располагает самыми богатыми в мире запасами природного газа. Доля компании в мировых запасах составляет 17%, в российских — 72%. Основные направления деятельности — геологоразведка, добыча, транспортировка, хранение, переработка и реализация газа, газового конденсата и нефти, реализация газа в качестве моторного топлива, а также производство и сбыт тепло- и электроэнергии. В структуру компании входят такие публичные эмитенты как Газпром нефть, Мосэнерго, ТГК-1, ОГК-2. Дивиденды: Компания стремится с 2021 г. выплачивать дивиденды в размере 50% чистой прибыли по МСФО с учетом «неденежных» корректировок. Если долговая нагрузка Группы превысит уровень 2,5 по коэффициенту «Чистый долг/EBITDA», совет директоров имеет возможность предложить размер дивидендов ниже целевых уровней.',1,304.03),(7,'SBER','Сбербанк','Сбербанк — один из системообразующих банков российской банковской системы, крупнейшая кредитная организация по размеру активов в РФ. Сбербанк занимает более 30% от банковской системы РФ и выступает главным аккумулятором средств клиентов. В секторе кредитования на долю банка приходится свыше 40% от общего выданных займов, а клиентская база насчитывает более миллиона предприятий. В региональную сеть СберБанка входят 11 территориальных банков с 14 080 подразделениями в 83 субъектах РФ Банк активно реализует инновационные программы в финансовой сфере и выступает одним из наиболее передовых представителей отрасли. В структуре группы Сбербанка присутствует множество лабораторий, специализирующихся на развитии технологической базы организации. Кроме того, компания присутствует в таких сегментах бизнеса как торговля недвижимостью, медицинские услуги, электронная коммерция. Амбиции Стратегии 2023: Рентабельность выше 17% Достаточность базового капитала (Common Equity Tier 1) >12,5% Уровень дивидендных выплат — 50% от чистой прибыли Дисциплина в управлении расходами и стоимостью риска Рост выручки от нефинансовых сервисов — более 100% ежегодно Топ-3 на рынке электронной коммерции',1,233.50),(8,'LKOH','ЛУКОЙЛ','ЛУКОЙЛ — одна из крупнейших вертикально интегрированных нефтегазовых компаний в мире, на долю которой приходится более 2% мировой добычи нефти и около 1% доказанных запасов углеводородов. Большая часть углеводородных запасов компании приходится на месторождения в Западной Сибири. ЛУКОЙЛ занимает одну из главных позиций на мировом рынке производства нефтепродуктов и нефтехимии, поставляя свою продукцию в 27 стран мира. Компания является полностью вертикально-интегрированной, контролируя всю производственную цепочку — от добычи нефти и газа до сбыта нефтепродуктов. 88% запасов и 83% добычи углеводородов приходится на Российскую Федерацию, при этом основная деятельность сосредоточена на территории 4-х федеральных округов — Северо-Западного, Приволжского, Уральского и Южного. В 2017 г. Совет директоров утвердил программу стратегического развития группы «ЛУКОЙЛ» на 2018–2027 г. Стратегия направлена на устойчивый рост ключевых показателей и выполнение прогрессивной дивидендной политики при консервативном сценарии цены на нефть, а также на дополнительное развитие бизнеса и распределение средств акционерам в случае более благоприятной конъюнктуры. Одним из приоритетов компании является устойчивый рост дивидендов не менее чем на уровень рублевой инфляции. Средний ежегодный темп прироста дивидендных выплат составляет 15%.',1,6179.50),(9,'GMKN','ГМК Норникель','Норильский никель — крупнейший в мире производитель никеля и палладия, один из крупнейших в мире производителей платины и меди. Компания также производит кобальт, родий, серебро, золото, иридий, рутений, селен, теллур и серу. Основные виды деятельности: - поиск, разведка, добыча, обогащение и переработка полезных ископаемых; - производство, маркетинг и реализация цветных и драгоценных металлов. Норильский никель развивает стратегическое партнерство более чем в 30 странах. Потребителями продукции являются порядка 400 компаний-партнеров. В России основными производственными подразделениями группы являются следующие вертикально интегрированные предприятия: - Заполярный филиал ПАО «ГМК «Норильский никель»; - АО «Кольская горно-металлургическая компания». Стратегия компании подразумевает развитие приоритетных первоклассных активов, модернизацию действующих активов для повышения эффективности и создание новых экологичных и безопасных производственных мощностей.',1,20328.00),(10,'ROSN','Роснефть','ПАО «НК «Роснефть» — лидер российской нефтяной отрасли и крупнейшая публичная нефтегазовая корпорация мира. Для обеспечения устойчивого роста добычи в долгосрочной перспективе Роснефть активно расширяет свою ресурсную базу за счет геологоразведочных работ и новых приобретений. Основными видами деятельности Роснефти являются: - поиск и разведка месторождений углеводородов; - добыча нефти, газа, газового конденсата; - реализация проектов по освоению морских месторождений; - переработка добытого сырья; - реализация нефти, газа и продуктов их переработки на территории России и за ее пределами. Компания удерживает лидирующие позиции по добыче и переработки нефти в российском нефтегазовом секторе. На ее долю приходится 40% от годовой добычи нефти и 35% переработки на территории РФ. На мировом рынке Роснефть входит в число крупнейших представителей отрасли с 6% от мировой добычи. К существенным преимуществам компании относится широкая розничная сбытовая сеть, а также наличие собственных экспортных терминалов как в России, так и за рубежом.',1,438.70),(11,'VTBR','ВТБ','ВТБ — российский коммерческий банк c государственным участием. Второй по величине активов банк страны и первый по размеру уставного капитала. Основным акционером Банка является Российская Федерация, которой в лице Росимущества принадлежит 60,9% голосующих акций, или 47,2% (с учетом ГК Агентство по страхованию вкладов — 92,23%) от уставного капитала Банка. Сеть банка формируют свыше 1000 офисов в 75 регионах страны. В числе предоставляемых услуг: выпуск банковских карт, ипотечное и потребительское кредитование, автокредитование, услуги дистанционного управления счетами, кредитные карты с льготным периодом, срочные вклады, аренда сейфовых ячеек, денежные переводы. Часть услуг доступна клиентам в круглосуточном режиме, для чего используются современные телекоммуникационные технологии. Группа является стратегическим холдингом, предусматривая единую стратегию развития компаний всей группы в рамках единого бренда, централизованного финансового менеджмента и управления рисками, а также унифицированных систем контроля.',1,0.43);
/*!40000 ALTER TABLE `issuer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `markets`
--

DROP TABLE IF EXISTS `markets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `markets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type_market` varchar(20) NOT NULL COMMENT 'Тип рынка (российский, зарубежный)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `type_market` (`type_market`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `markets`
--

LOCK TABLES `markets` WRITE;
/*!40000 ALTER TABLE `markets` DISABLE KEYS */;
INSERT INTO `markets` VALUES (2,'Зарубежные'),(1,'Российский');
/*!40000 ALTER TABLE `markets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_of_bids`
--

DROP TABLE IF EXISTS `type_of_bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_of_bids` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `types` varchar(15) NOT NULL COMMENT 'Тип заявки',
  `description` tinytext NOT NULL COMMENT 'Описание заявки',
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `types` (`types`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов заявок';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_of_bids`
--

LOCK TABLES `type_of_bids` WRITE;
/*!40000 ALTER TABLE `type_of_bids` DISABLE KEYS */;
INSERT INTO `type_of_bids` VALUES (1,'Лимитная','Купить не дороже указанной цены'),(2,'Рыночная','Купить по рыночной цене'),(3,'Стоп-димит','Если цена вырастет до указанной, выставить лимитную заявку на покупку'),(4,'Тейк-профит','Если цена цпадёт до указанной, выставить лимитную заявку на покупку'),(5,'Стоп-лосс','Если цена вырастет до указанной, купить по рыночной цене');
/*!40000 ALTER TABLE `type_of_bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'ID пользователя',
  `login` varchar(30) NOT NULL COMMENT 'Логин',
  `password_hash` char(55) NOT NULL COMMENT 'Хэш пароля',
  `phone` char(11) NOT NULL COMMENT 'Номер телефона',
  `email` varchar(120) NOT NULL COMMENT 'e-mail',
  `number_of_contract` char(10) NOT NULL COMMENT 'Номер договора',
  `date_of_contract` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата договора',
  `brokerage_account` char(15) NOT NULL COMMENT 'Брокерский счёт',
  `individual_investment_account` char(15) DEFAULT NULL COMMENT 'ИИС',
  `invest_profile_id` int unsigned NOT NULL COMMENT 'Инвистиционный профиль',
  `qualifying_investor_status` enum('FALSE','TRUE') NOT NULL DEFAULT 'FALSE' COMMENT 'Квалификационный статус инвестора',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `password_hash` (`password_hash`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `number_of_contract` (`number_of_contract`),
  UNIQUE KEY `brokerage_account` (`brokerage_account`),
  UNIQUE KEY `individual_investment_account` (`individual_investment_account`),
  KEY `user_id` (`user_id`),
  KEY `invest_profile_id` (`invest_profile_id`),
  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_profiles_ibfk_2` FOREIGN KEY (`invest_profile_id`) REFERENCES `invest_profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица профилей пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES (1,1,'asdf','78bf69kgrejj7h3','89039992799','psashok@mail.ru','451361/21','2022-01-17 11:53:35','451396',NULL,4,'FALSE'),(2,2,'qwer','hiujhrgrejj7h3','89039992794','psashok2@mail.ru','451391/21','2022-01-17 11:53:35','451986','345674',5,'FALSE'),(3,3,'zaqw','khd38vngty0te','89039992797','kolya@mail.ru','589732/19','2022-01-17 11:53:35','451929','345639',7,'FALSE'),(4,4,'wsdf','hjloe8nbh73f8','89039692794','petya@mail.ru','389571/13','2022-01-17 11:53:35','419985','396678',1,'FALSE'),(5,5,'frhe','mkdyhs9jeuof7','89039792794','pavel@mail.ru','123456/22','2022-01-17 11:53:35','459685',NULL,7,'FALSE'),(6,6,'fkeq','bspq8mdie8vr3','89037422771','nikolay@mail.ru','567392/26','2022-01-17 11:53:35','452894','345973',4,'TRUE'),(7,7,'krql','meomfkys18d9k','89039992794','aleksey@mail.ru','289460/18','2022-01-17 11:53:35','451893','345206',6,'FALSE'),(8,8,'gklo','noe9nf8rz0#sq','89996392644','boris@mail.ru','1852743/15','2022-01-17 11:53:35','192837',NULL,5,'TRUE'),(9,9,'aky3','do0h7m5j8f32s','89124685420','anton@mail.ru','495871/17','2022-01-17 11:53:35','428764',NULL,2,'FALSE'),(10,10,'wlo8','s9kr8nj4k0f2','89521753586','ivan@mail.ru','597438/29','2022-01-17 11:53:35','489520','679374',4,'FALSE'),(11,11,'kfej','kjkjtrh954mgkfjn7fng1','89029772796','petr02@mail.ru','123532/20','2020-12-04 00:00:00','451683','384692',3,'FALSE');
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL COMMENT 'Имя',
  `lastname` varchar(50) NOT NULL COMMENT 'Фамилия',
  `patronymic` varchar(50) NOT NULL COMMENT 'Отчество',
  `birthday` date NOT NULL COMMENT 'Дата рождения',
  `gender` enum('мужской','женский') NOT NULL COMMENT 'Пол',
  `citizenship` varchar(30) NOT NULL COMMENT 'Гражданство',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `firstname` (`firstname`),
  KEY `lastname` (`lastname`),
  KEY `otchestvo` (`patronymic`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Николай','Петрович','Хоменко','1975-12-23','мужской','Россия','2022-01-03 21:24:16','2022-01-03 21:24:16'),(2,'Рустем','Флюрович','Габдрашитов','1984-11-03','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(3,'Михаил','Николаевич','Горбунов','1989-09-12','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(4,'Павел','Михайлович','Артеменко','1965-08-26','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(5,'Павел','Николаевич','Колмогоров','1961-03-21','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(6,'Сергей','Сергеевич','Дегтярёв','1975-07-08','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(7,'Алина','Талгатовна','Зарипова','1993-04-14','женский','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(8,'Артём','Сергеевич','Волгин','1992-01-25','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(9,'Илья','Николаевич','Юдин','1990-07-19','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(10,'Константин','Васильевич','Кособрюхов','1980-02-18','мужской','Россия','2022-01-03 21:55:44','2022-01-03 21:55:44'),(11,'Пётр','Петрович','Петров','1959-03-21','мужской','Россия','2022-01-17 22:52:16','2022-01-17 22:52:16');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_birthday_before_insert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
	IF TIMESTAMPDIFF(YEAR, NEW.birthday, CURRENT_DATE()) < 18 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. You are do not adult!';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `view_bags`
--

DROP TABLE IF EXISTS `view_bags`;
/*!50001 DROP VIEW IF EXISTS `view_bags`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_bags` AS SELECT 
 1 AS `id`,
 1 AS `firstname`,
 1 AS `lastname`,
 1 AS `patronymic`,
 1 AS `ticker_symbol`,
 1 AS `name_of_the_issuer`,
 1 AS `quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_history_deals`
--

DROP TABLE IF EXISTS `view_history_deals`;
/*!50001 DROP VIEW IF EXISTS `view_history_deals`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_history_deals` AS SELECT 
 1 AS `name`,
 1 AS `name_of_the_issuer`,
 1 AS `deal`,
 1 AS `quantity`,
 1 AS `price`,
 1 AS `book_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_issuer_from_bags`
--

DROP TABLE IF EXISTS `view_issuer_from_bags`;
/*!50001 DROP VIEW IF EXISTS `view_issuer_from_bags`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_issuer_from_bags` AS SELECT 
 1 AS `id`,
 1 AS `firstname`,
 1 AS `lastname`,
 1 AS `patronymic`,
 1 AS `name_of_the_issuer`,
 1 AS `quantity`,
 1 AS `price`,
 1 AS `book_price`,
 1 AS `value`,
 1 AS `book_value`,
 1 AS `revaluation`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_bags`
--

/*!50001 DROP VIEW IF EXISTS `view_bags`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_bags` AS select `u`.`id` AS `id`,`u`.`firstname` AS `firstname`,`u`.`lastname` AS `lastname`,`u`.`patronymic` AS `patronymic`,`i`.`ticker_symbol` AS `ticker_symbol`,`i`.`name_of_the_issuer` AS `name_of_the_issuer`,`d`.`quantity` AS `quantity` from (((`user_profiles` `up` join `users` `u` on((`up`.`user_id` = `u`.`id`))) join `deals` `d` on((`d`.`user_id` = `u`.`id`))) join `issuer` `i` on((`i`.`id` = `d`.`issuer_id`))) where (`d`.`closed` = 'no') order by `u`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_history_deals`
--

/*!50001 DROP VIEW IF EXISTS `view_history_deals`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_history_deals` AS select concat(`u`.`firstname`,' ',`u`.`lastname`,' ',`u`.`patronymic`) AS `name`,`i`.`name_of_the_issuer` AS `name_of_the_issuer`,`d`.`deal` AS `deal`,`d`.`quantity` AS `quantity`,`d`.`price` AS `price`,(select (`d`.`quantity` * `d`.`price`)) AS `book_value` from ((`deals` `d` join `issuer` `i` on((`d`.`issuer_id` = `i`.`id`))) join `users` `u` on((`u`.`id` = `d`.`user_id`))) where (`u`.`id` = 4) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_issuer_from_bags`
--

/*!50001 DROP VIEW IF EXISTS `view_issuer_from_bags`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_issuer_from_bags` AS select `u`.`id` AS `id`,`u`.`firstname` AS `firstname`,`u`.`lastname` AS `lastname`,`u`.`patronymic` AS `patronymic`,`i`.`name_of_the_issuer` AS `name_of_the_issuer`,`d`.`quantity` AS `quantity`,`i`.`price` AS `price`,`d`.`price` AS `book_price`,(select (`d`.`quantity` * `i`.`price`)) AS `value`,(select (`d`.`quantity` * `d`.`price`)) AS `book_value`,(select (`book_value` - `value`)) AS `revaluation` from ((`issuer` `i` join `deals` `d` on((`i`.`id` = `d`.`issuer_id`))) join `users` `u` on((`u`.`id` = `d`.`user_id`))) where ((`d`.`closed` = 'no') and (`u`.`id` = 4)) order by `u`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-20 15:28:24
