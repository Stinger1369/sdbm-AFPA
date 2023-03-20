-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 20 mars 2023 à 11:38
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `sdbm`
--
CREATE DATABASE IF NOT EXISTS `sdbm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sdbm`;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `ID_ARTICLE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_ARTICLE` varchar(60) NOT NULL,
  `PRIX_ACHAT` float NOT NULL,
  `VOLUME` int(11) DEFAULT NULL,
  `TITRAGE` float DEFAULT NULL,
  `ID_MARQUE` int(11) NOT NULL,
  `ID_COULEUR` int(11) DEFAULT NULL,
  `ID_TYPE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ARTICLE`),
  KEY `FK_ARTICLE_COULEUR` (`ID_COULEUR`),
  KEY `FK_ARTICLE_MARQUE` (`ID_MARQUE`),
  KEY `FK_ARTICLE_TYPEBIERE` (`ID_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `continent`
--

DROP TABLE IF EXISTS `continent`;
CREATE TABLE IF NOT EXISTS `continent` (
  `ID_CONTINENT` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_CONTINENT` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`ID_CONTINENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `couleur`
--

DROP TABLE IF EXISTS `couleur`;
CREATE TABLE IF NOT EXISTS `couleur` (
  `ID_COULEUR` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_COULEUR` varchar(25) NOT NULL,
  PRIMARY KEY (`ID_COULEUR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `fabricant`
--

DROP TABLE IF EXISTS `fabricant`;
CREATE TABLE IF NOT EXISTS `fabricant` (
  `ID_FABRICANT` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_FABRICANT` varchar(40) NOT NULL,
  PRIMARY KEY (`ID_FABRICANT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `ID_MARQUE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_MARQUE` varchar(40) NOT NULL,
  `ID_PAYS` int(11) DEFAULT NULL,
  `ID_FABRICANT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_MARQUE`),
  KEY `FK_MARQUE_FABRICANT` (`ID_FABRICANT`),
  KEY `FK_MARQUE_PAYS` (`ID_PAYS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `ID_PAYS` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_PAYS` varchar(40) NOT NULL,
  `ID_CONTINENT` int(11) NOT NULL,
  PRIMARY KEY (`ID_PAYS`),
  KEY `FK_PAYS_CONTINENT` (`ID_CONTINENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
CREATE TABLE IF NOT EXISTS `ticket` (
  `ANNEE` int(11) NOT NULL,
  `NUMERO_TICKET` int(11) NOT NULL,
  `DATE_VENTE` datetime NOT NULL,
  PRIMARY KEY (`ANNEE`,`NUMERO_TICKET`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `typebiere`
--

DROP TABLE IF EXISTS `typebiere`;
CREATE TABLE IF NOT EXISTS `typebiere` (
  `ID_TYPE` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_TYPE` varchar(25) NOT NULL,
  PRIMARY KEY (`ID_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `vendre`
--

DROP TABLE IF EXISTS `vendre`;
CREATE TABLE IF NOT EXISTS `vendre` (
  `ANNEE` int(11) NOT NULL,
  `NUMERO_TICKET` int(11) NOT NULL,
  `ID_ARTICLE` int(11) NOT NULL,
  `QUANTITE` int(11) DEFAULT NULL,
  `PRIX_VENTE` float DEFAULT NULL,
  PRIMARY KEY (`ANNEE`,`NUMERO_TICKET`,`ID_ARTICLE`),
  KEY `FK_VENDRE_ARTICLE` (`ID_ARTICLE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
