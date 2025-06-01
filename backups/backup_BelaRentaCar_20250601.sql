-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: BelaRentaCar
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.1

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
-- Table structure for table `Aluguer`
--

DROP TABLE IF EXISTS `Aluguer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Aluguer` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `DataInicio` datetime NOT NULL,
  `DataFim` datetime NOT NULL,
  `Preco` decimal(10,2) NOT NULL,
  `Multa` decimal(5,2) DEFAULT NULL,
  `ClienteId` int NOT NULL,
  `FuncionarioId` int NOT NULL,
  `AutomovelId` int NOT NULL,
  `RecolhidoFilialId` int NOT NULL,
  `DevolvidoFilialId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `ClienteId` (`ClienteId`),
  KEY `FuncionarioId` (`FuncionarioId`),
  KEY `AutomovelId` (`AutomovelId`),
  KEY `RecolhidoFilialId` (`RecolhidoFilialId`),
  KEY `DevolvidoFilialId` (`DevolvidoFilialId`),
  CONSTRAINT `Aluguer_ibfk_1` FOREIGN KEY (`ClienteId`) REFERENCES `Cliente` (`Id`),
  CONSTRAINT `Aluguer_ibfk_2` FOREIGN KEY (`FuncionarioId`) REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `Aluguer_ibfk_3` FOREIGN KEY (`AutomovelId`) REFERENCES `Automovel` (`Id`),
  CONSTRAINT `Aluguer_ibfk_4` FOREIGN KEY (`RecolhidoFilialId`) REFERENCES `Filial` (`Id`),
  CONSTRAINT `Aluguer_ibfk_5` FOREIGN KEY (`DevolvidoFilialId`) REFERENCES `Filial` (`Id`),
  CONSTRAINT `Aluguer_chk_1` CHECK ((`DataInicio` < `DataFim`))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aluguer`
--

LOCK TABLES `Aluguer` WRITE;
/*!40000 ALTER TABLE `Aluguer` DISABLE KEYS */;
INSERT INTO `Aluguer` VALUES (1,'2025-04-01 00:00:00','2025-04-05 00:00:00',190.00,0.00,1,2,1,2,1),(2,'2025-03-15 00:00:00','2025-03-17 00:00:00',110.00,10.00,2,1,2,2,2),(3,'2025-04-10 00:00:00','2025-04-13 00:00:00',125.00,0.00,3,3,3,2,3),(4,'2025-02-05 00:00:00','2025-02-07 00:00:00',80.00,5.00,4,5,4,2,2),(5,'2025-01-20 00:00:00','2025-01-24 00:00:00',170.00,0.00,5,4,5,2,2),(6,'2025-03-01 00:00:00','2025-03-04 00:00:00',200.00,15.00,1,2,6,2,3),(7,'2025-04-05 00:00:00','2025-04-07 00:00:00',110.00,0.00,2,1,7,2,1),(8,'2025-03-22 00:00:00','2025-03-26 00:00:00',250.00,0.00,6,5,8,2,1),(9,'2025-02-18 00:00:00','2025-02-22 00:00:00',290.00,20.00,4,3,9,2,3),(10,'2025-04-01 00:00:00','2025-04-03 00:00:00',115.00,0.00,5,4,10,2,1),(11,'2025-05-01 00:00:00','2025-05-05 00:00:00',140.00,0.00,11,7,11,1,1),(12,'2025-04-10 00:00:00','2025-04-12 00:00:00',80.00,0.00,12,8,12,1,2),(13,'2025-03-20 00:00:00','2025-03-22 00:00:00',76.00,5.00,13,9,13,1,3),(14,'2025-05-03 00:00:00','2025-05-04 00:00:00',60.00,0.00,14,10,14,1,3),(15,'2025-05-01 10:00:00','2025-05-05 10:00:00',3400.00,NULL,16,13,17,3,1),(16,'2025-06-10 09:00:00','2025-06-15 09:00:00',4750.00,100.00,17,15,18,3,2),(17,'2025-07-20 12:00:00','2025-07-25 12:00:00',3000.00,NULL,18,13,19,3,3);
/*!40000 ALTER TABLE `Aluguer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Automovel`
--

DROP TABLE IF EXISTS `Automovel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Automovel` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Marca` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Kilometragem` decimal(8,3) NOT NULL,
  `Ano` year NOT NULL,
  `Estado` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TipoConsumo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PrecoDia` decimal(8,2) NOT NULL,
  `FilialId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FilialId` (`FilialId`),
  CONSTRAINT `Automovel_ibfk_1` FOREIGN KEY (`FilialId`) REFERENCES `Filial` (`Id`),
  CONSTRAINT `Automovel_chk_1` CHECK ((`Estado` in (_utf8mb4'Disponível',_utf8mb4'Ocupado'))),
  CONSTRAINT `Automovel_chk_2` CHECK ((`TipoConsumo` in (_utf8mb4'Gasolina',_utf8mb4'Gasóleo',_utf8mb4'Elétrico',_utf8mb4'Híbrido')))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Automovel`
--

LOCK TABLES `Automovel` WRITE;
/*!40000 ALTER TABLE `Automovel` DISABLE KEYS */;
INSERT INTO `Automovel` VALUES (1,'Renault Clio',18000.000,2022,'Disponível','Gasolina',40.00,2),(2,'Peugeot 208',22000.000,2021,'Ocupado','Gasóleo',42.00,2),(3,'Volkswagen Golf',25000.000,2023,'Disponível','Gasolina',45.00,2),(4,'Audi A3',27000.000,2020,'Disponível','Gasolina',47.00,2),(5,'BMW Série 1',30000.000,2022,'Disponível','Gasóleo',50.00,2),(6,'Opel Corsa',15000.000,2021,'Ocupado','Elétrico',38.00,2),(7,'Ford Fiesta',17000.000,2023,'Disponível','Gasolina',39.00,2),(8,'Mercedes A-Class',28000.000,2020,'Disponível','Gasóleo',55.00,2),(9,'Tesla Model 3',35000.000,2022,'Disponível','Elétrico',60.00,2),(10,'Volvo XC40',32000.000,2021,'Ocupado','Gasolina',53.00,2),(11,'Renault Clio',35000.000,2019,'Disponível','Gasolina',35.00,1),(12,'Peugeot 308',20000.000,2020,'Disponível','Gasóleo',40.00,1),(13,'Fiat 500',15000.000,2021,'Ocupado','Elétrico',38.00,1),(14,'BMW Série 3',45000.000,2018,'Disponível','Gasolina',60.00,1),(15,'Audi A4',30000.000,2019,'Disponível','Gasóleo',55.00,1),(16,'Toyota Yaris',10000.000,2022,'Disponível','Híbrido',42.00,1),(17,'Ferrari Roma',12000.500,2022,'Disponível','Gasolina',850.00,3),(18,'Bentley Continental',9000.000,2021,'Disponível','Gasolina',950.00,3),(19,'Tesla Model S',3000.250,2023,'Disponível','Elétrico',600.00,3),(20,'Porsche Taycan',5000.000,2022,'Disponível','Elétrico',700.00,3);
/*!40000 ALTER TABLE `Automovel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NIF` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `LocalTrabalho` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Rua` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Localidade` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CodigoPostal` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `NIF` (`NIF`),
  CONSTRAINT `Cliente_chk_1` CHECK ((length(`NIF`) = 9))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (1,'Jan Peeters','010101010','Peeters Group','Rue de la Loi','Bélgica','1000'),(2,'Sofie Claes','020202020','Claes NV','Koningin Elisabethlaan','Bélgica','2000'),(3,'Luc Dupont','030303030','Dupont SA','Avenue Louise','Bélgica','1050'),(4,'Marie Van den Berg','040404040','Van den Berg BV','Groenplaats','Bélgica','2000'),(5,'Pieter Janssens','050505050','Janssens Ltd','Leuvenstraat','Bélgica','3000'),(6,'Els De Smet','060606060','De Smet Enterprises','Kerkstraat','Bélgica','2800'),(7,'Tom Willems','070707070','Willems Group','Vrijheidslaan','Bélgica','9000'),(8,'An Van Damme','080808080','Van Damme NV','Sint-Pietersplein','Bélgica','8000'),(9,'Karel Vermeulen','090909090','Vermeulen BV','Stationsstraat','Bélgica','8500'),(10,'Liesbeth Hermans','101010101','Hermans Ltd','Maastrichtersteenweg','Bélgica','3000'),(11,'João Silva','123456789','EDP','Rua das Flores','Lisboa','1000-123'),(12,'Maria Fernandes','987654321','GALP','Avenida da Liberdade','Lisboa','1050-456'),(13,'Pedro Santos','192837465','Sonae','Rua do Almada','Porto','4000-789'),(14,'Ana Oliveira','564738291','NOS','Praça da República','Porto','4050-321'),(15,'Carlos Ribeiro','918273645','Câmara de Faro','Rua da Misericórdia','Faro','8000-111'),(16,'Charlotte Grimaldi','111222333','Casino de Monte-Carlo','Avenue de Monte-Carlo','Monte Carlo','98000'),(17,'Louis Martinet','444555666','Banque de Monaco','Boulevard des Moulins','Monaco-Ville','98000'),(18,'Camille Duval','777888999','Hôtel Hermitage','Rue du Portier','Monte Carlo','98000');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente_Contacto`
--

DROP TABLE IF EXISTS `Cliente_Contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente_Contacto` (
  `ClienteId` int NOT NULL,
  `Telefone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ClienteId`,`Telefone`),
  CONSTRAINT `Cliente_Contacto_ibfk_1` FOREIGN KEY (`ClienteId`) REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente_Contacto`
--

LOCK TABLES `Cliente_Contacto` WRITE;
/*!40000 ALTER TABLE `Cliente_Contacto` DISABLE KEYS */;
INSERT INTO `Cliente_Contacto` VALUES (1,'012345678','jan.peeters@peeters.be'),(2,'023456789','sofie.claes@claes.be'),(3,'034567890','luc.dupont@dupont.be'),(4,'045678901','marie.vandenberg@vandenberg.be'),(5,'056789012','pieter.janssens@janssens.be'),(6,'067890123','els.desmet@desmet.be'),(7,'078901234','tom.willems@willems.be'),(8,'089012345','an.vandamme@vandamme.be'),(9,'090123456','karel.vermeulen@vermeulen.be'),(10,'101234567','liesbeth.hermans@hermans.be'),(11,'912345678','joao.silva@edp.pt'),(12,'913456789','maria.fernandes@galp.pt'),(13,'914567890','pedro.santos@sonae.pt'),(14,'915678901','ana.oliveira@nos.pt'),(15,'916789012','carlos.ribeiro@cm-faro.pt'),(16,'+37760000001','charlotte.g@email.mc'),(17,'+37760000002','louis.m@email.mc'),(18,'+37760000003','camille.d@email.mc');
/*!40000 ALTER TABLE `Cliente_Contacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Exerce`
--

DROP TABLE IF EXISTS `Exerce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Exerce` (
  `FuncionarioId` int NOT NULL,
  `FuncaoId` int NOT NULL,
  PRIMARY KEY (`FuncionarioId`,`FuncaoId`),
  KEY `FuncaoId` (`FuncaoId`),
  CONSTRAINT `Exerce_ibfk_1` FOREIGN KEY (`FuncionarioId`) REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `Exerce_ibfk_2` FOREIGN KEY (`FuncaoId`) REFERENCES `Funcao` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exerce`
--

LOCK TABLES `Exerce` WRITE;
/*!40000 ALTER TABLE `Exerce` DISABLE KEYS */;
INSERT INTO `Exerce` VALUES (1,1),(2,2),(4,2),(3,3),(5,4),(6,4),(8,6),(9,7),(7,8),(10,9),(12,12),(13,13),(14,14),(15,15);
/*!40000 ALTER TABLE `Exerce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Filial`
--

DROP TABLE IF EXISTS `Filial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Filial` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Localizacao` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Localizacao` (`Localizacao`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Filial`
--

LOCK TABLES `Filial` WRITE;
/*!40000 ALTER TABLE `Filial` DISABLE KEYS */;
INSERT INTO `Filial` VALUES (2,'Bélgica'),(3,'Mónaco'),(1,'Portugal');
/*!40000 ALTER TABLE `Filial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Funcao`
--

DROP TABLE IF EXISTS `Funcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Funcao` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Designacao` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SalarioBase` decimal(8,2) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Designacao` (`Designacao`),
  CONSTRAINT `Funcao_chk_1` CHECK ((`SalarioBase` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcao`
--

LOCK TABLES `Funcao` WRITE;
/*!40000 ALTER TABLE `Funcao` DISABLE KEYS */;
INSERT INTO `Funcao` VALUES (1,'Gestor de Filial Belga ',2100.00),(2,'Assistente de Atendimento Belga',1150.00),(3,'Técnico de Manutenção Belga',1350.00),(4,'Gestor Comercial Belga',1850.00),(5,'Gestor de Filial Portugues',1800.00),(6,'Assistente de Atendimento Portugues',1100.00),(7,'Técnico de Manutenção Portugues',1300.00),(8,'Gestor Comercial Portugues',1400.00),(9,'Segurança Portugues',1200.00),(10,'Gestor de Frota de Veículos de Luxo',5500.00),(11,'Especialista em Atendimento VIP',4800.00),(12,'Chauffeur Privado',5000.00),(13,'Técnico de Manutenção de Veículos de Luxo',4500.00),(14,'Consultor de Aluguer Premium',4700.00),(15,'Responsável de Logística',4300.00),(16,'Rececionista VIP',3500.00);
/*!40000 ALTER TABLE `Funcao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Funcionario`
--

DROP TABLE IF EXISTS `Funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Funcionario` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NIF` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Salario` decimal(8,2) NOT NULL,
  `Telefone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FilialId` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `NIF` (`NIF`),
  KEY `FilialId` (`FilialId`),
  CONSTRAINT `Funcionario_ibfk_1` FOREIGN KEY (`FilialId`) REFERENCES `Filial` (`Id`),
  CONSTRAINT `Funcionario_chk_1` CHECK ((length(`NIF`) = 9)),
  CONSTRAINT `Funcionario_chk_2` CHECK ((`Salario` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcionario`
--

LOCK TABLES `Funcionario` WRITE;
/*!40000 ALTER TABLE `Funcionario` DISABLE KEYS */;
INSERT INTO `Funcionario` VALUES (1,'Leonidas Lindt','222334444',4000.00,'961234567','lindt@belarentacar.com',2),(2,'Jan Claes','876436577',3200.00,'0476123456','jan.claes@belrentacar.be',2),(3,'Sofie Peeters','222333644',2800.00,'0487123456','sofie.peeters@belrentacar.be',2),(4,'Luc Dupont','333445555',2700.00,'0498123456','luc.dupont@belrentacar.be',2),(5,'Marie Janssens','444556666',2900.00,'0469123456','marie.janssens@belrentacar.be',2),(6,'Pieter Willems','555667777',2600.00,'0470123456','pieter.willems@belrentacar.be',2),(7,'Octavio Faísca','111223333',3000.00,'960123456','octfaisca@belarentacar.com',1),(8,'Miguel Costa','987283555',2800.00,'961234567','miguel.costa@belarentacar.pt',1),(9,'Sofia Martins','137495826',2500.00,'962345678','sofia.martins@belarentacar.pt',1),(10,'Rui Lopes','245918637',2300.00,'963456789','rui.lopes@belarentacar.pt',1),(11,'Inês Pereira','329847516',2100.00,'964567890','ines.pereira@belarentacar.pt',1),(12,'Jean Morel','123456789',4600.00,'+37761234567','jean.m@belarent.mc',3),(13,'Sophie Laurent','987654321',3200.00,'+37769876543','sophie.l@belarent.mc',3),(14,'Antoine Dubois','192837465',3000.00,'+37764572839','antoine.d@belarent.mc',3),(15,'Isabelle Blanc','564738291',2500.00,'+37761234987','isabelle.b@belarent.mc',3);
/*!40000 ALTER TABLE `Funcionario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-01 20:40:01
