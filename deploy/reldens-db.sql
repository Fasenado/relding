-- MySQL dump 10.13  Distrib 8.4.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: reldens
-- ------------------------------------------------------
-- Server version	8.4.9

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
-- Table structure for table `ads`
--

DROP TABLE IF EXISTS `ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` int unsigned NOT NULL,
  `type_id` int unsigned NOT NULL,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `top` int unsigned DEFAULT NULL,
  `bottom` int unsigned DEFAULT NULL,
  `left` int unsigned DEFAULT NULL,
  `right` int unsigned DEFAULT NULL,
  `replay` int unsigned DEFAULT NULL,
  `enabled` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `provider_id` (`provider_id`),
  KEY `type_id` (`type_id`) USING BTREE,
  CONSTRAINT `FK_ads_ads_providers` FOREIGN KEY (`provider_id`) REFERENCES `ads_providers` (`id`),
  CONSTRAINT `FK_ads_ads_types` FOREIGN KEY (`type_id`) REFERENCES `ads_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads`
--

LOCK TABLES `ads` WRITE;
/*!40000 ALTER TABLE `ads` DISABLE KEYS */;
INSERT INTO `ads` VALUES (3,'fullTimeBanner',1,1,320,50,NULL,NULL,0,NULL,80,NULL,0,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,'ui-banner',1,1,320,50,NULL,NULL,80,NULL,80,NULL,0,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,'crazy-games-sample-video',1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(6,'game-monetize-sample-video',2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads_banner`
--

DROP TABLE IF EXISTS `ads_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads_banner` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ads_id` int unsigned NOT NULL,
  `banner_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ads_id` (`ads_id`),
  CONSTRAINT `FK_ads_banner_ads` FOREIGN KEY (`ads_id`) REFERENCES `ads` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads_banner`
--

LOCK TABLES `ads_banner` WRITE;
/*!40000 ALTER TABLE `ads_banner` DISABLE KEYS */;
INSERT INTO `ads_banner` VALUES (1,3,'{\"fullTime\": true}'),(2,4,'{\"uiReferenceIds\":[\"box-open-clan\",\"equipment-open\",\"inventory-open\",\"player-stats-open\"]}');
/*!40000 ALTER TABLE `ads_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads_event_video`
--

DROP TABLE IF EXISTS `ads_event_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads_event_video` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ads_id` int unsigned NOT NULL,
  `event_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ads_id` (`ads_id`),
  KEY `ad_id` (`ads_id`) USING BTREE,
  KEY `room_id` (`event_key`) USING BTREE,
  CONSTRAINT `FK_ads_scene_change_video_ads` FOREIGN KEY (`ads_id`) REFERENCES `ads` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads_event_video`
--

LOCK TABLES `ads_event_video` WRITE;
/*!40000 ALTER TABLE `ads_event_video` DISABLE KEYS */;
INSERT INTO `ads_event_video` VALUES (1,5,'activatedRoom_ReldensTown','{\"rewardItemKey\":\"coins\",\"rewardItemQty\":1}'),(2,6,'activatedRoom_ReldensForest','{\"rewardItemKey\":\"coins\",\"rewardItemQty\":1}');
/*!40000 ALTER TABLE `ads_event_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads_played`
--

DROP TABLE IF EXISTS `ads_played`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads_played` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ads_id` int unsigned NOT NULL,
  `player_id` int unsigned NOT NULL,
  `started_at` datetime NOT NULL DEFAULT (now()),
  `ended_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ads_id` (`ads_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `FK_ads_played_ads` FOREIGN KEY (`ads_id`) REFERENCES `ads` (`id`),
  CONSTRAINT `FK_ads_played_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads_played`
--

LOCK TABLES `ads_played` WRITE;
/*!40000 ALTER TABLE `ads_played` DISABLE KEYS */;
/*!40000 ALTER TABLE `ads_played` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads_providers`
--

DROP TABLE IF EXISTS `ads_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads_providers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint unsigned NOT NULL DEFAULT (1),
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads_providers`
--

LOCK TABLES `ads_providers` WRITE;
/*!40000 ALTER TABLE `ads_providers` DISABLE KEYS */;
INSERT INTO `ads_providers` VALUES (1,'crazyGames',0),(2,'gameMonetize',0);
/*!40000 ALTER TABLE `ads_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ads_types`
--

DROP TABLE IF EXISTS `ads_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ads_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ads_types`
--

LOCK TABLES `ads_types` WRITE;
/*!40000 ALTER TABLE `ads_types` DISABLE KEYS */;
INSERT INTO `ads_types` VALUES (1,'banner'),(2,'eventVideo');
/*!40000 ALTER TABLE `ads_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio`
--

DROP TABLE IF EXISTS `audio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `audio_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `files_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_id` int unsigned DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `enabled` tinyint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `audio_key` (`audio_key`),
  KEY `FK_audio_rooms` (`room_id`),
  KEY `FK_audio_audio_categories` (`category_id`),
  CONSTRAINT `FK_audio_audio_categories` FOREIGN KEY (`category_id`) REFERENCES `audio_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_audio_rooms` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio`
--

LOCK TABLES `audio` WRITE;
/*!40000 ALTER TABLE `audio` DISABLE KEYS */;
INSERT INTO `audio` VALUES (3,'footstep','footstep.mp3','{\"onlyCurrentPlayer\":true}',NULL,3,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,'reldens-town','reldens-town.mp3','',4,1,1,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `audio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio_categories`
--

DROP TABLE IF EXISTS `audio_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint DEFAULT NULL,
  `single_audio` tinyint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_key` (`category_key`),
  UNIQUE KEY `category_label` (`category_label`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio_categories`
--

LOCK TABLES `audio_categories` WRITE;
/*!40000 ALTER TABLE `audio_categories` DISABLE KEYS */;
INSERT INTO `audio_categories` VALUES (1,'music','Music',1,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,'sound','Sound',1,0,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `audio_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio_markers`
--

DROP TABLE IF EXISTS `audio_markers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio_markers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `audio_id` int unsigned NOT NULL,
  `marker_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start` int unsigned NOT NULL,
  `duration` int unsigned NOT NULL,
  `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `audio_id_marker_key` (`audio_id`,`marker_key`),
  KEY `audio_id` (`audio_id`),
  CONSTRAINT `FK_audio_markers_audio` FOREIGN KEY (`audio_id`) REFERENCES `audio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio_markers`
--

LOCK TABLES `audio_markers` WRITE;
/*!40000 ALTER TABLE `audio_markers` DISABLE KEYS */;
INSERT INTO `audio_markers` VALUES (1,4,'ReldensTown',0,41,NULL),(2,3,'journeyman_right',0,1,NULL),(3,3,'journeyman_left',0,1,NULL),(4,3,'journeyman_up',0,1,NULL),(5,3,'journeyman_down',0,1,NULL),(6,3,'r_journeyman_right',0,1,NULL),(7,3,'r_journeyman_left',0,1,NULL),(8,3,'r_journeyman_up',0,1,NULL),(9,3,'r_journeyman_down',0,1,NULL),(10,3,'sorcerer_right',0,1,NULL),(11,3,'sorcerer_left',0,1,NULL),(12,3,'sorcerer_up',0,1,NULL),(13,3,'sorcerer_down',0,1,NULL),(14,3,'r_sorcerer_right',0,1,NULL),(15,3,'r_sorcerer_left',0,1,NULL),(16,3,'r_sorcerer_up',0,1,NULL),(17,3,'r_sorcerer_down',0,1,NULL),(18,3,'warlock_right',0,1,NULL),(19,3,'warlock_left',0,1,NULL),(20,3,'warlock_up',0,1,NULL),(21,3,'warlock_down',0,1,NULL),(22,3,'r_warlock_right',0,1,NULL),(23,3,'r_warlock_left',0,1,NULL),(24,3,'r_warlock_up',0,1,NULL),(25,3,'r_warlock_down',0,1,NULL),(26,3,'swordsman_right',0,1,NULL),(27,3,'swordsman_left',0,1,NULL),(28,3,'swordsman_up',0,1,NULL),(29,3,'swordsman_down',0,1,NULL),(30,3,'r_swordsman_right',0,1,NULL),(31,3,'r_swordsman_left',0,1,NULL),(32,3,'r_swordsman_up',0,1,NULL),(33,3,'r_swordsman_down',0,1,NULL),(34,3,'warrior_right',0,1,NULL),(35,3,'warrior_left',0,1,NULL),(36,3,'warrior_up',0,1,NULL),(37,3,'warrior_down',0,1,NULL),(38,3,'r_warrior_right',0,1,NULL),(39,3,'r_warrior_left',0,1,NULL),(40,3,'r_warrior_up',0,1,NULL),(41,3,'r_warrior_down',0,1,NULL);
/*!40000 ALTER TABLE `audio_markers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio_player_config`
--

DROP TABLE IF EXISTS `audio_player_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio_player_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `enabled` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `player_id_category_id` (`player_id`,`category_id`),
  KEY `FK_audio_player_config_audio_categories` (`category_id`),
  CONSTRAINT `FK_audio_player_config_audio_categories` FOREIGN KEY (`category_id`) REFERENCES `audio_categories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_audio_player_config_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio_player_config`
--

LOCK TABLES `audio_player_config` WRITE;
/*!40000 ALTER TABLE `audio_player_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `audio_player_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `room_id` int unsigned DEFAULT NULL,
  `message` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `private_player_id` int unsigned DEFAULT NULL,
  `message_type` int unsigned DEFAULT NULL,
  `message_time` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`player_id`),
  KEY `scene_id` (`room_id`),
  KEY `private_user_id` (`private_player_id`),
  KEY `FK_chat_chat_message_types` (`message_type`),
  CONSTRAINT `FK__players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`),
  CONSTRAINT `FK__players_2` FOREIGN KEY (`private_player_id`) REFERENCES `players` (`id`),
  CONSTRAINT `FK__scenes` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  CONSTRAINT `FK_chat_chat_message_types` FOREIGN KEY (`message_type`) REFERENCES `chat_message_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
INSERT INTO `chat` VALUES (1,2,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"asd\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 08:34:30'),(2,2,4,'{\"m\":\"chat.joinedRoom\",\"pn\":\"asd\",\"rn\":\"reldens-town\"}',NULL,2,'2026-06-09 08:34:37'),(3,2,5,'{\"m\":\"chat.joinedRoom\",\"pn\":\"asd\",\"rn\":\"reldens-forest\"}',NULL,2,'2026-06-09 08:34:43'),(4,3,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"фыв\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 08:53:12'),(5,3,2,'{\"m\":\"chat.guestInvalidChangePoint\"}',NULL,10,'2026-06-09 08:54:07'),(6,3,2,'{\"m\":\"chat.guestInvalidChangePoint\"}',NULL,10,'2026-06-09 08:54:07'),(7,3,2,'{\"m\":\"chat.guestInvalidChangePoint\"}',NULL,10,'2026-06-09 08:54:08'),(8,3,4,'{\"m\":\"chat.joinedRoom\",\"pn\":\"фыв\",\"rn\":\"reldens-town\"}',NULL,2,'2026-06-09 08:54:11'),(9,3,5,'{\"m\":\"chat.joinedRoom\",\"pn\":\"фыв\",\"rn\":\"reldens-forest\"}',NULL,2,'2026-06-09 08:54:18'),(10,3,4,'{\"m\":\"chat.joinedRoom\",\"pn\":\"фыв\",\"rn\":\"reldens-town\"}',NULL,2,'2026-06-09 08:54:34'),(11,4,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"312\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:02:43'),(12,5,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"выф\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:03:03'),(13,5,4,'{\"m\":\"chat.joinedRoom\",\"pn\":\"выф\",\"rn\":\"reldens-town\"}',NULL,2,'2026-06-09 09:03:07'),(14,6,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"Tester8877\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:27:19'),(15,7,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"das\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:29:58'),(16,7,4,'{\"m\":\"chat.joinedRoom\",\"pn\":\"das\",\"rn\":\"reldens-town\"}',NULL,2,'2026-06-09 09:30:02'),(17,7,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"das\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:30:05'),(18,8,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"Tester6078\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:30:06'),(19,7,4,'{\"m\":\"chat.joinedRoom\",\"pn\":\"das\",\"rn\":\"reldens-town\"}',NULL,2,'2026-06-09 09:30:14'),(20,7,5,'{\"m\":\"chat.joinedRoom\",\"pn\":\"das\",\"rn\":\"reldens-forest\"}',NULL,2,'2026-06-09 09:30:41'),(21,9,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"Tester6834\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:32:57'),(22,10,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"Tester1641\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:35:52'),(23,11,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"Tester1555\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:37:32'),(24,13,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"Bravo2474\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:39:23'),(25,12,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"Alpha0428\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:39:30'),(26,14,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"wad\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:40:56'),(27,14,4,'{\"m\":\"chat.joinedRoom\",\"pn\":\"wad\",\"rn\":\"reldens-town\"}',NULL,2,'2026-06-09 09:40:57'),(28,14,2,'{\"m\":\"chat.joinedRoom\",\"pn\":\"wad\",\"rn\":\"reldens-house-1\"}',NULL,2,'2026-06-09 09:41:01');
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_message_types`
--

DROP TABLE IF EXISTS `chat_message_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_message_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `show_tab` tinyint unsigned DEFAULT NULL,
  `also_show_in_type` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_chat_message_types_chat_message_types` (`also_show_in_type`),
  CONSTRAINT `FK_chat_message_types_chat_message_types` FOREIGN KEY (`also_show_in_type`) REFERENCES `chat_message_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_message_types`
--

LOCK TABLES `chat_message_types` WRITE;
/*!40000 ALTER TABLE `chat_message_types` DISABLE KEYS */;
INSERT INTO `chat_message_types` VALUES (1,'message',1,NULL),(2,'joined',0,1),(3,'system',0,1),(4,'private',1,1),(5,'damage',0,1),(6,'reward',0,1),(7,'skill',0,1),(8,'teams',1,1),(9,'global',1,1),(10,'error',0,1);
/*!40000 ALTER TABLE `chat_message_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clan`
--

DROP TABLE IF EXISTS `clan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int unsigned NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` int unsigned NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_id` (`owner_id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK_clan_clan_levels` (`level`),
  CONSTRAINT `FK_clan_clan_levels` FOREIGN KEY (`level`) REFERENCES `clan_levels` (`key`),
  CONSTRAINT `FK_clan_players` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clan`
--

LOCK TABLES `clan` WRITE;
/*!40000 ALTER TABLE `clan` DISABLE KEYS */;
/*!40000 ALTER TABLE `clan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clan_levels`
--

DROP TABLE IF EXISTS `clan_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clan_levels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` int unsigned NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required_experience` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clan_levels`
--

LOCK TABLES `clan_levels` WRITE;
/*!40000 ALTER TABLE `clan_levels` DISABLE KEYS */;
INSERT INTO `clan_levels` VALUES (1,1,'1',0);
/*!40000 ALTER TABLE `clan_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clan_levels_modifiers`
--

DROP TABLE IF EXISTS `clan_levels_modifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clan_levels_modifiers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `level_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` int unsigned NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `modifier_id` (`key`) USING BTREE,
  KEY `level_key` (`level_id`) USING BTREE,
  KEY `FK_clan_levels_modifiers_operation_types` (`operation`) USING BTREE,
  CONSTRAINT `FK_clan_levels_modifiers_clan_levels` FOREIGN KEY (`level_id`) REFERENCES `clan_levels` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_clan_levels_modifiers_operation_types` FOREIGN KEY (`operation`) REFERENCES `operation_types` (`key`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clan_levels_modifiers`
--

LOCK TABLES `clan_levels_modifiers` WRITE;
/*!40000 ALTER TABLE `clan_levels_modifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `clan_levels_modifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clan_members`
--

DROP TABLE IF EXISTS `clan_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clan_members` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `clan_id` int unsigned NOT NULL,
  `player_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `clan_id_player_id` (`clan_id`,`player_id`) USING BTREE,
  UNIQUE KEY `player_id` (`player_id`) USING BTREE,
  CONSTRAINT `FK_clan_members_clan` FOREIGN KEY (`clan_id`) REFERENCES `clan` (`id`),
  CONSTRAINT `FK_clan_members_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clan_members`
--

LOCK TABLES `clan_members` WRITE;
/*!40000 ALTER TABLE `clan_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `clan_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `scope_path` (`scope`,`path`) USING BTREE,
  KEY `FK_config_config_types` (`type`) USING BTREE,
  CONSTRAINT `FK_config_config_types` FOREIGN KEY (`type`) REFERENCES `config_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'client','actions/damage/color','#ff0000',1),(2,'client','actions/damage/duration','600',2),(3,'client','actions/damage/enabled','1',3),(4,'client','actions/damage/font','Verdana, Geneva, sans-serif',1),(5,'client','actions/damage/fontSize','14',2),(6,'client','actions/damage/shadowColor','rgba(0,0,0,0.7)',1),(7,'client','actions/damage/showAll','0',3),(8,'client','actions/damage/stroke','#000000',1),(9,'client','actions/damage/strokeThickness','4',2),(10,'client','actions/damage/top','50',2),(11,'client','actions/skills/affectedProperty','hp',1),(12,'client','ads/general/providers/crazyGames/enabled','0',3),(13,'client','ads/general/providers/crazyGames/sdkUrl','https://sdk.crazygames.com/crazygames-sdk-v2.js',1),(14,'client','ads/general/providers/crazyGames/videoMinimumDuration','3000',2),(15,'client','ads/general/providers/gameMonetize/enabled','0',3),(16,'client','ads/general/providers/gameMonetize/gameId','your-game-id-should-be-here',1),(17,'client','ads/general/providers/gameMonetize/sdkUrl','https://api.gamemonetize.com/sdk.js',1),(18,'client','chat/messages/characterLimit','100',2),(19,'client','chat/messages/characterLimitOverhead','30',2),(20,'client','clan/general/openInvites','0',3),(21,'client','clan/labels/clanTitle','Clan: %clanName - Leader: %leaderName',1),(22,'client','clan/labels/propertyMaxValue','/ %propertyMaxValue',1),(23,'client','clan/labels/requestFromTitle','Clan request from:',1),(24,'client','gameEngine/banner','0',3),(25,'client','gameEngine/dom/createContainer','1',3),(26,'client','gameEngine/height','1280',2),(27,'client','gameEngine/parent','reldens',1),(28,'client','gameEngine/physics/arcade/debug','false',3),(29,'client','gameEngine/physics/arcade/gravity/x','0',2),(30,'client','gameEngine/physics/arcade/gravity/y','0',2),(31,'client','gameEngine/physics/default','arcade',1),(32,'client','gameEngine/scale/autoCenter','1',2),(33,'client','gameEngine/scale/autoRound','0',3),(34,'client','gameEngine/scale/max/height','1280',2),(35,'client','gameEngine/scale/max/width','1280',2),(36,'client','gameEngine/scale/min/height','360',2),(37,'client','gameEngine/scale/min/width','360',2),(38,'client','gameEngine/scale/mode','5',2),(39,'client','gameEngine/scale/parent','reldens',1),(40,'client','gameEngine/scale/zoom','1',2),(41,'client','gameEngine/type','0',2),(42,'client','gameEngine/width','1280',2),(43,'client','general/animations/frameRate','10',2),(44,'client','general/assets/arrowDownPath','/assets/sprites/arrow-down.png',1),(45,'client','general/assets/statsIconPath','/assets/icons/book.png',1),(46,'client','general/controls/action_button_hold','0',3),(47,'client','general/controls/allowSimultaneousKeys','1',3),(48,'client','general/engine/clientInterpolation','1',3),(49,'client','general/engine/experimentalClientPrediction','0',3),(50,'client','general/engine/interpolationSpeed','0.4',2),(51,'client','general/gameEngine/updateGameSizeTimeOut','500',2),(52,'client','general/users/allowGuest','1',3),(53,'client','general/users/allowRegistration','1',3),(54,'client','login/termsAndConditions/body','This is our test terms and conditions content.',1),(55,'client','login/termsAndConditions/checkboxLabel','Accept terms and conditions',1),(56,'client','login/termsAndConditions/es/body','Este es el contenido de nuestros términos y condiciones de prueba.',1),(57,'client','login/termsAndConditions/es/checkboxLabel','Aceptar terminos y condiciones',1),(58,'client','login/termsAndConditions/es/heading','Términos y condiciones',1),(59,'client','login/termsAndConditions/es/link','Acepta nuestros Términos y Condiciones (haz clic aquí).',1),(60,'client','login/termsAndConditions/heading','Terms and conditions',1),(61,'client','login/termsAndConditions/link','Accept our Terms and Conditions (click here).',1),(62,'client','map/layersDepth/belowPlayer','0',2),(63,'client','map/layersDepth/changePoints','0',2),(64,'client','map/tileData/height','32',2),(65,'client','map/tileData/margin','1',2),(66,'client','map/tileData/spacing','2',2),(67,'client','map/tileData/width','32',2),(68,'client','objects/npc/invalidOptionMessage','I do not understand.',1),(69,'client','players/animations/basedOnPress','1',3),(70,'client','players/animations/collideWorldBounds','1',3),(71,'client','players/animations/defaultFrames/down/end','2',2),(72,'client','players/animations/defaultFrames/down/start','0',2),(73,'client','players/animations/defaultFrames/left/end','5',2),(74,'client','players/animations/defaultFrames/left/start','3',2),(75,'client','players/animations/defaultFrames/right/end','8',2),(76,'client','players/animations/defaultFrames/right/start','6',2),(77,'client','players/animations/defaultFrames/up/end','11',2),(78,'client','players/animations/defaultFrames/up/start','9',2),(79,'client','players/animations/diagonalHorizontal','1',3),(80,'client','players/animations/fadeDuration','1000',2),(81,'client','players/animations/fallbackImage','player-base.png',1),(82,'client','players/barsProperties','{\"hp\":{\"enabled\":true,\"label\":\"HP\",\"activeColor\":\"#d53434\",\"inactiveColor\":\"#330000\"},\"mp\":{\"enabled\":true,\"label\":\"MP\",\"activeColor\":\"#5959fb\",\"inactiveColor\":\"#000033\"}}',4),(83,'client','players/multiplePlayers/enabled','1',3),(84,'client','players/physicalBody/height','25',2),(85,'client','players/physicalBody/width','25',2),(86,'client','players/playedTime/label','Played time %playedTimeInHs hs',1),(87,'client','players/playedTime/show','2',2),(88,'client','players/size/height','71',2),(89,'client','players/size/leftOffset','0',2),(90,'client','players/size/topOffset','20',2),(91,'client','players/size/width','52',2),(92,'client','players/tapMovement/enabled','1',3),(93,'client','rewards/titles/rewardMessage','You obtained %dropQuantity %itemLabel',1),(94,'client','rooms/selection/allowOnLogin','1',3),(95,'client','rooms/selection/allowOnRegistration','1',3),(96,'client','rooms/selection/loginAvailableRooms','*',1),(97,'client','rooms/selection/loginLastLocation','1',3),(98,'client','rooms/selection/loginLastLocationLabel','Last Location',1),(99,'client','rooms/selection/registrationAvailableRooms','*',1),(100,'client','skills/animations/default_atk','{\"key\":\"default_atk\",\"animationData\":{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"default_atk\",\"frameWidth\":64,\"frameHeight\":64,\"start\":0,\"end\":4,\"repeat\":0}}',4),(101,'client','skills/animations/default_bullet','{\"key\":\"default_bullet\",\"animationData\":{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"default_bullet\",\"frameWidth\":64,\"frameHeight\":64,\"start\":0,\"end\":2,\"repeat\":-1,\"frameRate\":1}}',4),(102,'client','skills/animations/default_cast','{\"key\": \"default_cast\",\"animationData\":{\"enabled\":false,\"type\":\"spritesheet\",\"img\":\"default_cast\",\"frameWidth\":64,\"frameHeight\":64,\"start\":0,\"end\":3,\"repeat\":0}}',4),(103,'client','skills/animations/default_death','{\"key\":\"default_death\",\"animationData\":{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"default_death\",\"frameWidth\":64,\"frameHeight\":64,\"start\":0,\"end\":1,\"repeat\":0,\"frameRate\":1}}',4),(104,'client','skills/animations/default_hit','{\"key\":\"default_hit\",\"animationData\":{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"default_hit\",\"frameWidth\":64,\"frameHeight\":64,\"start\":0,\"end\":3,\"repeat\":0,\"depthByPlayer\":\"above\"}}',4),(105,'client','team/labels/leaderNameTitle','Team leader: %leaderName',1),(106,'client','team/labels/propertyMaxValue','/ %propertyMaxValue',1),(107,'client','team/labels/requestFromTitle','Team request from:',1),(108,'client','trade/players/awaitTimeOut','1',3),(109,'client','trade/players/timeOut','8000',2),(110,'client','ui/chat/damageMessages','1',3),(111,'client','ui/chat/defaultOpen','0',3),(112,'client','ui/chat/dodgeMessages','1',3),(113,'client','ui/chat/effectMessages','1',3),(114,'client','ui/chat/enabled','1',3),(115,'client','ui/chat/notificationBalloon','1',3),(116,'client','ui/chat/overheadChat/closeChatBoxAfterSend','1',3),(117,'client','ui/chat/overheadChat/enabled','1',3),(118,'client','ui/chat/overheadChat/isTyping','1',3),(119,'client','ui/chat/overheadText/align','center',1),(120,'client','ui/chat/overheadText/depth','200000',2),(121,'client','ui/chat/overheadText/fill','#ffffff',1),(122,'client','ui/chat/overheadText/fontFamily','Verdana, Geneva, sans-serif',1),(123,'client','ui/chat/overheadText/fontSize','12px',1),(124,'client','ui/chat/overheadText/height','15',2),(125,'client','ui/chat/overheadText/shadowBlur','5',2),(126,'client','ui/chat/overheadText/shadowColor','rgba(0,0,0,0.7)',1),(127,'client','ui/chat/overheadText/shadowX','5',2),(128,'client','ui/chat/overheadText/shadowY','5',2),(129,'client','ui/chat/overheadText/stroke','rgba(0,0,0,0.7)',1),(130,'client','ui/chat/overheadText/strokeThickness','20',2),(131,'client','ui/chat/overheadText/textLength','4',2),(132,'client','ui/chat/overheadText/timeOut','5000',2),(133,'client','ui/chat/overheadText/topOffset','20',2),(134,'client','ui/chat/responsiveX','100',2),(135,'client','ui/chat/responsiveY','100',2),(136,'client','ui/chat/showTabs','1',3),(137,'client','ui/chat/totalValidTypes','2',2),(138,'client','ui/chat/x','440',2),(139,'client','ui/chat/y','940',2),(140,'client','ui/clan/enabled','1',3),(141,'client','ui/clan/responsiveX','100',2),(142,'client','ui/clan/responsiveY','0',2),(143,'client','ui/clan/sharedProperties','{\"hp\":{\"path\":\"stats/hp\",\"pathMax\":\"statsBase/hp\",\"label\":\"HP\"},\"mp\":{\"path\":\"stats/mp\",\"pathMax\":\"statsBase/mp\",\"label\":\"MP\"}}',4),(144,'client','ui/clan/x','430',2),(145,'client','ui/clan/y','100',2),(146,'client','ui/controls/allowPrimaryTouch','1',3),(147,'client','ui/controls/defaultActionKey','',1),(148,'client','ui/controls/disableContextMenu','1',3),(149,'client','ui/controls/enabled','1',3),(150,'client','ui/controls/opacityEffect','1',3),(151,'client','ui/controls/primaryMove','0',3),(152,'client','ui/controls/responsiveX','0',2),(153,'client','ui/controls/responsiveY','100',2),(154,'client','ui/controls/tabTarget','1',3),(155,'client','ui/controls/x','120',2),(156,'client','ui/controls/y','390',2),(157,'client','ui/default/responsiveX','10',2),(158,'client','ui/default/responsiveY','10',2),(159,'client','ui/default/x','120',2),(160,'client','ui/default/y','100',2),(161,'client','ui/equipment/enabled','1',3),(162,'client','ui/equipment/responsiveX','100',2),(163,'client','ui/equipment/responsiveY','0',2),(164,'client','ui/equipment/x','430',2),(165,'client','ui/equipment/y','90',2),(166,'client','ui/fullScreenButton/enabled','1',3),(167,'client','ui/fullScreenButton/responsiveX','100',2),(168,'client','ui/fullScreenButton/responsiveY','0',2),(169,'client','ui/fullScreenButton/x','380',2),(170,'client','ui/fullScreenButton/y','20',2),(171,'client','ui/instructions/enabled','1',3),(172,'client','ui/instructions/responsiveX','100',2),(173,'client','ui/instructions/responsiveY','100',2),(174,'client','ui/instructions/x','380',2),(175,'client','ui/instructions/y','940',2),(176,'client','ui/inventory/enabled','1',3),(177,'client','ui/inventory/responsiveX','100',2),(178,'client','ui/inventory/responsiveY','0',2),(179,'client','ui/inventory/x','380',2),(180,'client','ui/inventory/y','450',2),(181,'client','ui/lifeBar/enabled','1',3),(182,'client','ui/lifeBar/fillStyle','0xff0000',1),(183,'client','ui/lifeBar/fixedPosition','0',3),(184,'client','ui/lifeBar/height','5',2),(185,'client','ui/lifeBar/lineStyle','0xffffff',1),(186,'client','ui/lifeBar/responsiveX','1',2),(187,'client','ui/lifeBar/responsiveY','24',2),(188,'client','ui/lifeBar/showAllPlayers','0',3),(189,'client','ui/lifeBar/showEnemies','1',3),(190,'client','ui/lifeBar/showOnClick','1',3),(191,'client','ui/lifeBar/top','5',2),(192,'client','ui/lifeBar/width','50',2),(193,'client','ui/lifeBar/x','5',2),(194,'client','ui/lifeBar/y','12',2),(195,'client','ui/loading/assetsColor','#ffffff',1),(196,'client','ui/loading/assetsSize','18px',1),(197,'client','ui/loading/font','Verdana, Geneva, sans-serif',1),(198,'client','ui/loading/fontSize','20px',1),(199,'client','ui/loading/loadingColor','#ffffff',1),(200,'client','ui/loading/percentColor','#666666',1),(201,'client','ui/loading/showAssets','1',3),(202,'client','ui/maximum/x','1280',2),(203,'client','ui/maximum/y','1280',2),(204,'client','ui/minimap/addCircle','1',3),(205,'client','ui/minimap/camBackgroundColor','rgba(0,0,0,0.6)',1),(206,'client','ui/minimap/camX','240',2),(207,'client','ui/minimap/camY','10',2),(208,'client','ui/minimap/camZoom','0.08',2),(209,'client','ui/minimap/circleAlpha','1',2),(210,'client','ui/minimap/circleColor','rgb(0,0,0)',1),(211,'client','ui/minimap/circleFillAlpha','0',2),(212,'client','ui/minimap/circleFillColor','1',2),(213,'client','ui/minimap/circleRadio','80.35',2),(214,'client','ui/minimap/circleStrokeAlpha','0.6',2),(215,'client','ui/minimap/circleStrokeColor','0',2),(216,'client','ui/minimap/circleStrokeLineWidth','6',2),(217,'client','ui/minimap/circleX','320',2),(218,'client','ui/minimap/circleY','88',2),(219,'client','ui/minimap/enabled','1',3),(220,'client','ui/minimap/fixedHeight','450',2),(221,'client','ui/minimap/fixedWidth','450',2),(222,'client','ui/minimap/mapHeightDivisor','1',2),(223,'client','ui/minimap/mapWidthDivisor','1',2),(224,'client','ui/minimap/responsiveX','40',2),(225,'client','ui/minimap/responsiveY','2.4',2),(226,'client','ui/minimap/roundMap','1',3),(227,'client','ui/minimap/x','330',2),(228,'client','ui/minimap/y','10',2),(229,'client','ui/npcDialog/responsiveX','10',2),(230,'client','ui/npcDialog/responsiveY','10',2),(231,'client','ui/npcDialog/x','120',2),(232,'client','ui/npcDialog/y','100',2),(233,'client','ui/options/acceptOrDecline','{\"1\":{\"label\":\"Accept\",\"value\":1},\"2\":{\"label\":\"Decline\",\"value\":2}}',4),(234,'client','ui/playerBox/enabled','1',3),(235,'client','ui/playerBox/responsiveX','0',2),(236,'client','ui/playerBox/responsiveY','0',2),(237,'client','ui/playerBox/x','50',2),(238,'client','ui/playerBox/y','30',2),(239,'client','ui/players/nameText/align','center',1),(240,'client','ui/players/nameText/depth','200000',2),(241,'client','ui/players/nameText/fill','#ffffff',1),(242,'client','ui/players/nameText/fontFamily','Verdana, Geneva, sans-serif',1),(243,'client','ui/players/nameText/fontSize','12px',1),(244,'client','ui/players/nameText/height','-90',2),(245,'client','ui/players/nameText/shadowBlur','5',2),(246,'client','ui/players/nameText/shadowColor','rgba(0,0,0,0.7)',1),(247,'client','ui/players/nameText/shadowX','5',2),(248,'client','ui/players/nameText/shadowY','5',2),(249,'client','ui/players/nameText/stroke','#000000',1),(250,'client','ui/players/nameText/strokeThickness','4',2),(251,'client','ui/players/nameText/textLength','4',2),(252,'client','ui/players/showNames','1',3),(253,'client','ui/playerStats/enabled','1',3),(254,'client','ui/playerStats/responsiveX','100',2),(255,'client','ui/playerStats/responsiveY','0',2),(256,'client','ui/playerStats/x','430',2),(257,'client','ui/playerStats/y','20',2),(258,'client','ui/pointer/show','1',3),(259,'client','ui/pointer/topOffSet','16',2),(260,'client','ui/rewards/enabled','1',3),(261,'client','ui/rewards/responsiveX','100',2),(262,'client','ui/rewards/responsiveY','0',2),(263,'client','ui/rewards/x','430',2),(264,'client','ui/rewards/y','200',2),(265,'client','ui/sceneLabel/enabled','1',3),(266,'client','ui/sceneLabel/responsiveX','50',2),(267,'client','ui/sceneLabel/responsiveY','0',2),(268,'client','ui/sceneLabel/x','250',2),(269,'client','ui/sceneLabel/y','20',2),(270,'client','ui/scores/enabled','1',3),(271,'client','ui/scores/responsiveX','100',2),(272,'client','ui/scores/responsiveY','0',2),(273,'client','ui/scores/x','430',2),(274,'client','ui/scores/y','150',2),(275,'client','ui/screen/responsive','1',3),(276,'client','ui/settings/enabled','1',3),(277,'client','ui/settings/responsiveX','100',2),(278,'client','ui/settings/responsiveY','100',2),(279,'client','ui/settings/x','940',2),(280,'client','ui/settings/y','280',2),(281,'client','ui/skills/enabled','1',3),(282,'client','ui/skills/responsiveX','0',2),(283,'client','ui/skills/responsiveY','100',2),(284,'client','ui/skills/x','230',2),(285,'client','ui/skills/y','390',2),(286,'client','ui/teams/enabled','1',3),(287,'client','ui/teams/responsiveX','100',2),(288,'client','ui/teams/responsiveY','0',2),(289,'client','ui/teams/sharedProperties','{\"hp\":{\"path\":\"stats/hp\",\"pathMax\":\"statsBase/hp\",\"label\":\"HP\"},\"mp\":{\"path\":\"stats/mp\",\"pathMax\":\"statsBase/mp\",\"label\":\"MP\"}}',4),(290,'client','ui/teams/x','430',2),(291,'client','ui/teams/y','100',2),(292,'client','ui/trade/responsiveX','5',2),(293,'client','ui/trade/responsiveY','5',2),(294,'client','ui/trade/x','5',2),(295,'client','ui/trade/y','5',2),(296,'client','ui/uiTarget/enabled','1',3),(297,'client','ui/uiTarget/hideOnDialog','0',3),(298,'client','ui/uiTarget/responsiveX','0',2),(299,'client','ui/uiTarget/responsiveY','0',2),(300,'client','ui/uiTarget/x','10',2),(301,'client','ui/uiTarget/y','85',2),(302,'client','world/debug/enabled','0',3),(303,'server','actions/pvp/battleTimeOff','20000',2),(304,'server','actions/pvp/timerType','bt',1),(305,'server','admin/companyName','Reldens - Administration Panel',1),(306,'server','admin/faviconPath','/assets/web/favicon.ico',1),(307,'server','admin/logoPath','/assets/web/reldens-your-logo-mage.png',1),(308,'server','admin/roleId','99',2),(309,'server','admin/stylesPath','/css/reldens-admin-client.css',1),(310,'server','chat/messages/broadcast_join','1',3),(311,'server','chat/messages/broadcast_leave','1',3),(312,'server','chat/messages/global_allowed_roles','1,9000',1),(313,'server','chat/messages/global_enabled','1',3),(314,'server','enemies/default/affectedProperty','stats/hp',1),(315,'server','enemies/default/skillKey','attackShort',1),(316,'server','enemies/initialStats/aim','50',2),(317,'server','enemies/initialStats/atk','50',2),(318,'server','enemies/initialStats/def','50',2),(319,'server','enemies/initialStats/dodge','50',2),(320,'server','enemies/initialStats/hp','50',2),(321,'server','enemies/initialStats/mp','50',2),(322,'server','enemies/initialStats/speed','50',2),(323,'server','enemies/initialStats/stamina','50',2),(324,'server','objects/actions/closeInteractionOnOutOfReach','1',3),(325,'server','objects/actions/interactionsDistance','140',2),(326,'server','objects/drops/disappearTime','1800000',2),(327,'server','players/actions/initialClassPathId','1',2),(328,'server','players/actions/interactionDistance','40',2),(329,'server','players/drop/percent','20',2),(330,'server','players/drop/quantity','2',2),(331,'server','players/gameOver/timeOut','10000',2),(332,'server','players/guestUser/allowOnRooms','1',3),(333,'server','players/guestUser/roleId','2',2),(334,'server','players/initialState/dir','down',1),(335,'server','players/initialState/room_id','4',2),(336,'server','players/initialState/x','400',2),(337,'server','players/initialState/y','345',2),(338,'server','players/initialUser/roleId','1',2),(339,'server','players/initialUser/status','1',2),(340,'server','players/physicsBody/speed','180',2),(341,'server','players/physicsBody/usePlayerSpeedConfig','0',3),(342,'server','players/physicsBody/usePlayerSpeedProperty','0',3),(343,'server','rewards/actions/disappearTime','1800000',2),(344,'server','rewards/actions/interactionsDistance','40',2),(345,'server','rewards/loginReward/enabled','1',3),(346,'server','rewards/playedTimeReward/enabled','1',3),(347,'server','rewards/playedTimeReward/time','30000',3),(348,'server','rooms/validation/enabled','1',3),(349,'server','rooms/validation/valid','room_game,chat_global',1),(350,'server','rooms/world/bulletsStopOnPlayer','1',3),(351,'server','rooms/world/disableObjectsCollisionsOnChase','0',3),(352,'server','rooms/world/disableObjectsCollisionsOnReturn','1',3),(353,'server','rooms/world/groupWallsHorizontally','1',3),(354,'server','rooms/world/groupWallsVertically','0',3),(355,'server','rooms/world/movementSpeed','180',2),(356,'server','rooms/world/onlyWalkable','1',3),(357,'server','rooms/world/timeStep','0.04',2),(358,'server','rooms/world/tryClosestPath','0',3),(359,'server','scores/fullTableView/enabled','1',3),(360,'server','scores/obtainedScorePerNpc','5',2),(361,'server','scores/obtainedScorePerPlayer','10',2),(362,'server','scores/useNpcCustomScore','1',3);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_types`
--

DROP TABLE IF EXISTS `config_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_types`
--

LOCK TABLES `config_types` WRITE;
/*!40000 ALTER TABLE `config_types` DISABLE KEYS */;
INSERT INTO `config_types` VALUES (1,'string'),(2,'float'),(3,'boolean'),(4,'json'),(5,'comma_separated');
/*!40000 ALTER TABLE `config_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drops_animations`
--

DROP TABLE IF EXISTS `drops_animations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drops_animations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned NOT NULL,
  `asset_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `item_id_unique` (`item_id`) USING BTREE,
  KEY `item_id` (`item_id`) USING BTREE,
  CONSTRAINT `FK_drops_animations_items_item` FOREIGN KEY (`item_id`) REFERENCES `items_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drops_animations`
--

LOCK TABLES `drops_animations` WRITE;
/*!40000 ALTER TABLE `drops_animations` DISABLE KEYS */;
INSERT INTO `drops_animations` VALUES (1,1,NULL,'coins','coins.png','{\"start\":0,\"end\":0,\"repeat\":-1,\"frameWidth\":32, \"frameHeight\":32,\"depthByPlayer\":\"above\"}'),(2,2,NULL,'branch','branch.png','{\"start\":0,\"end\":2,\"repeat\":-1,\"frameWidth\":32, \"frameHeight\":32,\"depthByPlayer\":\"above\"}'),(3,3,NULL,'heal-potion-20','heal-potion-20.png','{\"start\":0,\"end\":0,\"repeat\":-1,\"frameWidth\":32, \"frameHeight\":32,\"depthByPlayer\":\"above\"}'),(4,4,NULL,'axe','axe.png','{\"start\":0,\"end\":0,\"repeat\":-1,\"frameWidth\":32, \"frameHeight\":32,\"depthByPlayer\":\"above\"}'),(5,5,NULL,'spear','spear.png','{\"start\":0,\"end\":0,\"repeat\":-1,\"frameWidth\":32, \"frameHeight\":32,\"depthByPlayer\":\"above\"}'),(6,6,NULL,'magic-potion-20','magic-potion-20.png','{\"start\":0,\"end\":0,\"repeat\":-1,\"frameWidth\":32, \"frameHeight\":32,\"depthByPlayer\":\"above\"}');
/*!40000 ALTER TABLE `drops_animations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_enabled` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'chat','Chat',1),(2,'objects','Objects',1),(3,'respawn','Respawn',1),(4,'inventory','Inventory',1),(5,'firebase','Firebase',1),(6,'actions','Actions',1),(7,'users','Users',1),(8,'audio','Audio',1),(9,'rooms','Rooms',1),(10,'admin','Admin',1),(11,'prediction','Prediction',0),(12,'teams','Teams',1),(13,'rewards','Rewards',1),(14,'snippets','Snippets',1),(16,'ads','Ads',1),(17,'world','World',0),(18,'scores','Scores',1);
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_group`
--

DROP TABLE IF EXISTS `items_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `files_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sort` int DEFAULT NULL,
  `items_limit` int NOT NULL DEFAULT '0',
  `limit_per_item` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_group`
--

LOCK TABLES `items_group` WRITE;
/*!40000 ALTER TABLE `items_group` DISABLE KEYS */;
INSERT INTO `items_group` VALUES (1,'weapon','Weapon','All kinds of weapons.','weapon.png',2,1,0),(2,'shield','Shield','Protect with these items.','shield.png',3,1,0),(3,'armor','Armor','','armor.png',4,1,0),(4,'boots','Boots','','boots.png',6,1,0),(5,'gauntlets','Gauntlets','','gauntlets.png',5,1,0),(6,'helmet','Helmet','','helmet.png',1,1,0);
/*!40000 ALTER TABLE `items_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_inventory`
--

DROP TABLE IF EXISTS `items_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_inventory` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `qty` int NOT NULL DEFAULT '0',
  `remaining_uses` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_items_inventory_items_item` (`item_id`) USING BTREE,
  KEY `FK_items_inventory_players` (`owner_id`) USING BTREE,
  CONSTRAINT `FK_items_inventory_items_item` FOREIGN KEY (`item_id`) REFERENCES `items_item` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_items_inventory_players` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_inventory`
--

LOCK TABLES `items_inventory` WRITE;
/*!40000 ALTER TABLE `items_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_item`
--

DROP TABLE IF EXISTS `items_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_item` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int NOT NULL DEFAULT '0',
  `group_id` int unsigned DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty_limit` int NOT NULL DEFAULT '0',
  `uses_limit` int NOT NULL DEFAULT '1',
  `useTimeOut` int DEFAULT NULL,
  `execTimeOut` int DEFAULT NULL,
  `customData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `group_id` (`group_id`),
  KEY `type` (`type`),
  CONSTRAINT `FK_items_item_items_group` FOREIGN KEY (`group_id`) REFERENCES `items_group` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_items_item_items_types` FOREIGN KEY (`type`) REFERENCES `items_types` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_item`
--

LOCK TABLES `items_item` WRITE;
/*!40000 ALTER TABLE `items_item` DISABLE KEYS */;
INSERT INTO `items_item` VALUES (1,'coins',3,NULL,'Coins',NULL,0,1,NULL,NULL,'{\"canBeDropped\": true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(2,'branch',10,NULL,'Tree branch','An useless tree branch (for now)',0,1,NULL,NULL,'{\"canBeDropped\": true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,'heal_potion_20',5,NULL,'Heal Potion','A heal potion that will restore 20 HP.',0,1,NULL,NULL,'{\"canBeDropped\":true,\"animationData\":{\"frameWidth\":64,\"frameHeight\":64,\"start\":6,\"end\":11,\"repeat\":0,\"usePlayerPosition\":true,\"followPlayer\":true,\"startsOnTarget\":true},\"removeAfterUse\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,'axe',1,1,'Axe','A short distance but powerful weapon.',0,0,NULL,NULL,'{\"canBeDropped\":true,\"animationData\":{\"frameWidth\":64,\"frameHeight\":64,\"start\":6,\"end\":11,\"repeat\":0,\"destroyOnComplete\":true,\"usePlayerPosition\":true,\"followPlayer\":true,\"startsOnTarget\":true}}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,'spear',1,1,'Spear','A short distance but powerful weapon.',0,0,NULL,NULL,'{\"canBeDropped\":true,\"animationData\":{\"frameWidth\":64,\"frameHeight\":64,\"start\":6,\"end\":11,\"repeat\":0,\"destroyOnComplete\":true,\"usePlayerPosition\":true,\"followPlayer\":true,\"startsOnTarget\":true}}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(6,'magic_potion_20',5,NULL,'Magic Potion','A magic potion that will restore 20 MP.',0,1,NULL,NULL,'{\"canBeDropped\":true,\"animationData\":{\"frameWidth\":64,\"frameHeight\":64,\"start\":6,\"end\":11,\"repeat\":0,\"usePlayerPosition\":true,\"followPlayer\":true,\"startsOnTarget\":true},\"removeAfterUse\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `items_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_item_modifiers`
--

DROP TABLE IF EXISTS `items_item_modifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_item_modifiers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` int unsigned NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maxProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `item_id` (`item_id`) USING BTREE,
  KEY `operation` (`operation`) USING BTREE,
  CONSTRAINT `FK_items_item_modifiers_items_item` FOREIGN KEY (`item_id`) REFERENCES `items_item` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_items_item_modifiers_operation_types` FOREIGN KEY (`operation`) REFERENCES `operation_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_item_modifiers`
--

LOCK TABLES `items_item_modifiers` WRITE;
/*!40000 ALTER TABLE `items_item_modifiers` DISABLE KEYS */;
INSERT INTO `items_item_modifiers` VALUES (1,4,'atk','stats/atk',5,'5',NULL),(2,3,'heal_potion_20','stats/hp',1,'20','statsBase/hp'),(3,5,'atk','stats/atk',5,'3',NULL),(4,6,'magic_potion_20','stats/mp',1,'20','statsBase/mp');
/*!40000 ALTER TABLE `items_item_modifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_types`
--

DROP TABLE IF EXISTS `items_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_types`
--

LOCK TABLES `items_types` WRITE;
/*!40000 ALTER TABLE `items_types` DISABLE KEYS */;
INSERT INTO `items_types` VALUES (10,'base'),(1,'equipment'),(3,'single'),(4,'single_equipment'),(5,'single_usable'),(2,'usable');
/*!40000 ALTER TABLE `items_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locale`
--

DROP TABLE IF EXISTS `locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locale` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `language_code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locale`
--

LOCK TABLES `locale` WRITE;
/*!40000 ALTER TABLE `locale` DISABLE KEYS */;
INSERT INTO `locale` VALUES (1,'en_US','en','US',1);
/*!40000 ALTER TABLE `locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int unsigned NOT NULL,
  `layer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tile_index` int unsigned DEFAULT NULL,
  `class_type` int unsigned DEFAULT NULL,
  `object_class_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `private_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `client_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `enabled` tinyint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `object_class_key` (`object_class_key`) USING BTREE,
  UNIQUE KEY `room_id_layer_name_tile_index` (`room_id`,`layer_name`,`tile_index`) USING BTREE,
  KEY `room_id` (`room_id`) USING BTREE,
  KEY `class_type` (`class_type`) USING BTREE,
  CONSTRAINT `FK_objects_objects_types` FOREIGN KEY (`class_type`) REFERENCES `objects_types` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_objects_rooms` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,4,'ground-collisions',444,2,'door_1','door_house_1','','{\"runOnHit\":true,\"roomVisible\":true,\"yFix\":6}','{\"positionFix\":{\"y\":-18},\"frameStart\":0,\"frameEnd\":3,\"repeat\":0,\"hideOnComplete\":false,\"autoStart\":false,\"restartTime\":2000}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(2,8,'respawn-area-monsters-lvl-1-2',NULL,7,'enemy_bot_1','enemy_forest_1','Tree','{\"shouldRespawn\":true,\"childObjectType\":4,\"isAggressive\":true}','{\"autoStart\":true}',0,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,8,'respawn-area-monsters-lvl-1-2',NULL,7,'enemy_bot_2','enemy_forest_2','Tree Punch','{\"shouldRespawn\":true,\"childObjectType\":4}','{\"autoStart\":true}',0,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,4,'ground-collisions',951,2,'door_2','door_house_2','','{\"runOnHit\":true,\"roomVisible\":true,\"yFix\":6}','{\"positionFix\":{\"y\":-18},\"frameStart\":0,\"frameEnd\":3,\"repeat\":0,\"hideOnComplete\":false,\"autoStart\":false,\"restartTime\":2000}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,4,'house-collisions-over-player',535,3,'npc_1','people_town_1','Alfred','{\"runOnAction\":true,\"playerVisible\":true}','{\"content\":\"Hello! My name is Alfred. Go to the forest and kill some monsters! Now... leave me alone!\"}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(6,5,'respawn-area-monsters-lvl-1-2',NULL,7,'enemy_1','enemy_forest_1','Tree','{\"shouldRespawn\":true,\"childObjectType\":4,\"isAggressive\":true}','{\"autoStart\":true}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(7,5,'respawn-area-monsters-lvl-1-2',NULL,7,'enemy_2','enemy_forest_2','Tree Punch','{\"shouldRespawn\":true,\"childObjectType\":4,\"isAggressive\":true,\"interactionRadio\":70}','{\"autoStart\":true}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(8,4,'house-collisions-over-player',538,3,'npc_2','healer_1','Mamon','{\"runOnAction\":true,\"playerVisible\":true,\"sendInvalidOptionMessage\":true}','{\"content\":\"Hello traveler! I can restore your health, would you like me to do it?\",\"options\":{\"1\":{\"label\":\"Heal HP\",\"value\":1},\"2\":{\"label\":\"Nothing...\",\"value\":2},\"3\":{\"label\":\"Need some MP\",\"value\":3}},\"ui\":true}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(10,4,'house-collisions-over-player',560,5,'npc_3','merchant_1','Gimly','{\"runOnAction\":true,\"playerVisible\":true,\"sendInvalidOptionMessage\":true}','{\"content\":\"Hi there! What would you like to do?\",\"options\":{\"buy\":{\"label\":\"Buy\",\"value\":\"buy\"},\"sell\":{\"label\":\"Sell\",\"value\":\"sell\"}}}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(12,4,'house-collisions-over-player',562,3,'npc_4','weapons_master_1','Barrik','{\"runOnAction\":true,\"playerVisible\":true,\"sendInvalidOptionMessage\":true}','{\"content\":\"Hi, I am the weapons master, choose your weapon and go kill some monsters!\",\"options\":{\"1\":{\"key\":\"axe\",\"label\":\"Axe\",\"value\":1,\"icon\":\"axe\"},\"2\":{\"key\":\"spear\",\"label\":\"Spear\",\"value\":2,\"icon\":\"spear\"}},\"ui\":true}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(13,5,'forest-collisions',258,3,'npc_5','quest_npc_1','Miles','{\"runOnAction\":true,\"playerVisible\":true,\"sendInvalidOptionMessage\":true}','{\"content\":\"Hi there! Do you want a coin? I can give you one if you give me a tree branch.\",\"options\":{\"1\":{\"label\":\"Sure!\",\"value\":1},\"2\":{\"label\":\"No, thank you.\",\"value\":2}},\"ui\":true}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(14,9,'ground-respawn-area',NULL,7,'enemy_bot_b1','enemy_forest_1','Tree','{\"shouldRespawn\":true,\"childObjectType\":4,\"isAggressive\":true,\"interactionRadio\":120}','{\"autoStart\":true}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(15,9,'ground-respawn-area',NULL,7,'enemy_bot_b2','enemy_forest_2','Tree Punch','{\"shouldRespawn\":true,\"childObjectType\":4,\"isAggressive\":true,\"interactionRadio\":70}','{\"autoStart\":true}',1,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_animations`
--

DROP TABLE IF EXISTS `objects_animations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_animations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `animationKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `animationData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `object_id_animationKey` (`object_id`,`animationKey`),
  KEY `id` (`id`) USING BTREE,
  KEY `object_id` (`object_id`) USING BTREE,
  CONSTRAINT `FK_objects_animations_objects` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_animations`
--

LOCK TABLES `objects_animations` WRITE;
/*!40000 ALTER TABLE `objects_animations` DISABLE KEYS */;
INSERT INTO `objects_animations` VALUES (5,6,'respawn-area-monsters-lvl-1-2_6_right','{\"start\":6,\"end\":8}'),(6,6,'respawn-area-monsters-lvl-1-2_6_down','{\"start\":0,\"end\":2}'),(7,6,'respawn-area-monsters-lvl-1-2_6_left','{\"start\":3,\"end\":5}'),(8,6,'respawn-area-monsters-lvl-1-2_6_up','{\"start\":9,\"end\":11}');
/*!40000 ALTER TABLE `objects_animations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_assets`
--

DROP TABLE IF EXISTS `objects_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_assets` (
  `object_asset_id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `asset_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `asset_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `asset_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`object_asset_id`) USING BTREE,
  KEY `object_id` (`object_id`) USING BTREE,
  CONSTRAINT `FK_objects_assets_objects` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_assets`
--

LOCK TABLES `objects_assets` WRITE;
/*!40000 ALTER TABLE `objects_assets` DISABLE KEYS */;
INSERT INTO `objects_assets` VALUES (1,1,'spritesheet','door_house_1','door-a-x2.png','{\"frameWidth\":32,\"frameHeight\":58}'),(2,4,'spritesheet','door_house_2','door-a-x2.png','{\"frameWidth\":32,\"frameHeight\":58}'),(3,5,'spritesheet','people_town_1','people-b-x2.png','{\"frameWidth\":52,\"frameHeight\":71}'),(4,2,'spritesheet','enemy_forest_1','monster-treant.png','{\"frameWidth\":47,\"frameHeight\":50}'),(5,6,'spritesheet','enemy_forest_1','monster-treant.png','{\"frameWidth\":47,\"frameHeight\":50}'),(6,7,'spritesheet','enemy_forest_2','monster-golem2.png','{\"frameWidth\":47,\"frameHeight\":50}'),(7,5,'spritesheet','healer_1','healer-1.png','{\"frameWidth\":52,\"frameHeight\":71}'),(8,3,'spritesheet','enemy_forest_2','monster-golem2.png','{\"frameWidth\":47,\"frameHeight\":50}'),(9,10,'spritesheet','merchant_1','people-d-x2.png','{\"frameWidth\":52,\"frameHeight\":71}'),(10,12,'spritesheet','weapons_master_1','people-c-x2.png','{\"frameWidth\":52,\"frameHeight\":71}'),(11,13,'spritesheet','quest_npc_1','people-quest-npc.png','{\"frameWidth\":52,\"frameHeight\":71}'),(12,14,'spritesheet','enemy_forest_1','monster-treant.png','{\"frameWidth\":47,\"frameHeight\":50}'),(13,15,'spritesheet','enemy_forest_2','monster-golem2.png','{\"frameWidth\":47,\"frameHeight\":50}');
/*!40000 ALTER TABLE `objects_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_items_inventory`
--

DROP TABLE IF EXISTS `objects_items_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_items_inventory` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int unsigned NOT NULL,
  `item_id` int unsigned NOT NULL,
  `qty` int NOT NULL DEFAULT '0',
  `remaining_uses` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_items_inventory_items_item` (`item_id`) USING BTREE,
  KEY `FK_objects_items_inventory_objects` (`owner_id`),
  CONSTRAINT `FK_objects_items_inventory_item` FOREIGN KEY (`item_id`) REFERENCES `items_item` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_objects_items_inventory_objects` FOREIGN KEY (`owner_id`) REFERENCES `objects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_items_inventory`
--

LOCK TABLES `objects_items_inventory` WRITE;
/*!40000 ALTER TABLE `objects_items_inventory` DISABLE KEYS */;
INSERT INTO `objects_items_inventory` VALUES (2,10,4,-1,-1,0),(3,10,5,-1,-1,0),(5,10,3,-1,1,0),(6,10,6,-1,1,0);
/*!40000 ALTER TABLE `objects_items_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_items_requirements`
--

DROP TABLE IF EXISTS `objects_items_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_items_requirements` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `item_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `required_item_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `required_quantity` int unsigned NOT NULL DEFAULT '0',
  `auto_remove_requirement` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_objects_items_requirements_objects` (`object_id`),
  KEY `FK_objects_items_requirements_items_item` (`item_key`),
  KEY `FK_objects_items_requirements_items_item_2` (`required_item_key`),
  CONSTRAINT `FK_objects_items_requirements_items_item` FOREIGN KEY (`item_key`) REFERENCES `items_item` (`key`),
  CONSTRAINT `FK_objects_items_requirements_items_item_2` FOREIGN KEY (`required_item_key`) REFERENCES `items_item` (`key`),
  CONSTRAINT `FK_objects_items_requirements_objects` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_items_requirements`
--

LOCK TABLES `objects_items_requirements` WRITE;
/*!40000 ALTER TABLE `objects_items_requirements` DISABLE KEYS */;
INSERT INTO `objects_items_requirements` VALUES (1,10,'axe','coins',5,1),(2,10,'spear','coins',2,1),(3,10,'heal_potion_20','coins',2,1),(5,10,'magic_potion_20','coins',2,1);
/*!40000 ALTER TABLE `objects_items_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_items_rewards`
--

DROP TABLE IF EXISTS `objects_items_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_items_rewards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `item_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_item_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `reward_quantity` int unsigned NOT NULL DEFAULT '0',
  `reward_item_is_required` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_objects_items_requirements_objects` (`object_id`) USING BTREE,
  KEY `FK_objects_items_rewards_items_item` (`item_key`),
  KEY `FK_objects_items_rewards_items_item_2` (`reward_item_key`),
  CONSTRAINT `FK_objects_items_rewards_items_item` FOREIGN KEY (`item_key`) REFERENCES `items_item` (`key`),
  CONSTRAINT `FK_objects_items_rewards_items_item_2` FOREIGN KEY (`reward_item_key`) REFERENCES `items_item` (`key`),
  CONSTRAINT `FK_objects_items_rewards_object` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_items_rewards`
--

LOCK TABLES `objects_items_rewards` WRITE;
/*!40000 ALTER TABLE `objects_items_rewards` DISABLE KEYS */;
INSERT INTO `objects_items_rewards` VALUES (1,10,'axe','coins',2,0),(2,10,'spear','coins',1,0),(3,10,'heal_potion_20','coins',1,0),(5,10,'magic_potion_20','coins',1,0);
/*!40000 ALTER TABLE `objects_items_rewards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_skills`
--

DROP TABLE IF EXISTS `objects_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_skills` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `target_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_objects_skills_objects` (`object_id`) USING BTREE,
  KEY `FK_objects_skills_skills_skill` (`skill_id`) USING BTREE,
  KEY `FK_objects_skills_target_options` (`target_id`) USING BTREE,
  CONSTRAINT `FK_objects_skills_objects` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  CONSTRAINT `FK_objects_skills_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`),
  CONSTRAINT `FK_objects_skills_target_options` FOREIGN KEY (`target_id`) REFERENCES `target_options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_skills`
--

LOCK TABLES `objects_skills` WRITE;
/*!40000 ALTER TABLE `objects_skills` DISABLE KEYS */;
INSERT INTO `objects_skills` VALUES (1,6,1,2);
/*!40000 ALTER TABLE `objects_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_stats`
--

DROP TABLE IF EXISTS `objects_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_stats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `stat_id` int unsigned NOT NULL,
  `base_value` int unsigned NOT NULL,
  `value` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `object_id_stat_id` (`object_id`,`stat_id`) USING BTREE,
  KEY `stat_id` (`stat_id`) USING BTREE,
  KEY `object_id` (`object_id`) USING BTREE,
  CONSTRAINT `FK_object_current_stats_objects` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_objects_current_stats_objects_stats` FOREIGN KEY (`stat_id`) REFERENCES `stats` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_stats`
--

LOCK TABLES `objects_stats` WRITE;
/*!40000 ALTER TABLE `objects_stats` DISABLE KEYS */;
INSERT INTO `objects_stats` VALUES (1,2,1,50,50),(2,2,2,50,50),(3,2,3,50,50),(4,2,4,50,50),(5,2,5,50,50),(6,2,6,50,50),(7,2,7,50,50),(8,2,8,50,50),(9,2,9,50,50),(10,2,10,50,50),(11,3,1,50,50),(12,3,2,50,50),(13,3,3,50,50),(14,3,4,50,50),(15,3,5,50,50),(16,3,6,50,50),(17,3,7,50,50),(18,3,8,50,50),(19,3,9,50,50),(20,3,10,50,50),(21,6,1,50,50),(22,6,2,50,50),(23,6,3,50,50),(24,6,4,50,50),(25,6,5,50,50),(26,6,6,50,50),(27,6,7,50,50),(28,6,8,50,50),(29,6,9,50,50),(30,6,10,50,50),(31,7,1,50,50),(32,7,2,50,50),(33,7,3,50,50),(34,7,4,50,50),(35,7,5,50,50),(36,7,6,50,50),(37,7,7,50,50),(38,7,8,50,50),(39,7,9,50,50),(40,7,10,50,50),(41,14,1,50,50),(42,14,2,50,50),(43,14,3,50,50),(44,14,4,50,50),(45,14,5,50,50),(46,14,6,50,50),(47,14,7,50,50),(48,14,8,50,50),(49,14,9,50,50),(50,14,10,50,50),(51,15,1,50,50),(52,15,2,50,50),(53,15,3,50,50),(54,15,4,50,50),(55,15,5,50,50),(56,15,6,50,50),(57,15,7,50,50),(58,15,8,50,50),(59,15,9,50,50),(60,15,10,50,50);
/*!40000 ALTER TABLE `objects_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects_types`
--

DROP TABLE IF EXISTS `objects_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objects_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects_types`
--

LOCK TABLES `objects_types` WRITE;
/*!40000 ALTER TABLE `objects_types` DISABLE KEYS */;
INSERT INTO `objects_types` VALUES (2,'animation'),(1,'base'),(6,'drop'),(4,'enemy'),(7,'multiple'),(3,'npc'),(5,'trader');
/*!40000 ALTER TABLE `objects_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_types`
--

DROP TABLE IF EXISTS `operation_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operation_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_types`
--

LOCK TABLES `operation_types` WRITE;
/*!40000 ALTER TABLE `operation_types` DISABLE KEYS */;
INSERT INTO `operation_types` VALUES (1,'Increment',1),(2,'Decrease',2),(3,'Divide',3),(4,'Multiply',4),(5,'Increment Percentage',5),(6,'Decrease Percentage',6),(7,'Set',7),(8,'Method',8),(9,'Set Number',9);
/*!40000 ALTER TABLE `operation_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_name` (`user_id`,`name`),
  KEY `FK_players_users` (`user_id`),
  CONSTRAINT `FK_players_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,1,'ImRoot','2022-03-17 14:57:50','2026-06-09 13:32:18'),(2,3,'asd','2026-06-09 13:34:29','2026-06-09 13:34:29'),(3,4,'фыв','2026-06-09 13:53:12','2026-06-09 13:53:12'),(4,5,'312','2026-06-09 14:02:43','2026-06-09 14:02:43'),(5,6,'выф','2026-06-09 14:03:02','2026-06-09 14:03:02'),(6,7,'Tester8877','2026-06-09 14:27:18','2026-06-09 14:27:18'),(7,8,'das','2026-06-09 14:29:58','2026-06-09 14:29:58'),(8,9,'Tester6078','2026-06-09 14:30:06','2026-06-09 14:30:06'),(9,10,'Tester6834','2026-06-09 14:32:56','2026-06-09 14:32:56'),(10,11,'Tester1641','2026-06-09 14:35:51','2026-06-09 14:35:51'),(11,12,'Tester1555','2026-06-09 14:37:31','2026-06-09 14:37:31'),(12,13,'Alpha0428','2026-06-09 14:39:22','2026-06-09 14:39:22'),(13,14,'Bravo2474','2026-06-09 14:39:23','2026-06-09 14:39:23'),(14,15,'wad','2026-06-09 14:40:56','2026-06-09 14:40:56');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players_state`
--

DROP TABLE IF EXISTS `players_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players_state` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `room_id` int unsigned NOT NULL,
  `x` int unsigned NOT NULL,
  `y` int unsigned NOT NULL,
  `dir` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `player_id` (`player_id`) USING BTREE,
  KEY `FK_player_state_rooms` (`room_id`) USING BTREE,
  KEY `FK_player_state_player_stats` (`player_id`) USING BTREE,
  CONSTRAINT `FK_player_state_player_stats` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_player_state_rooms` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players_state`
--

LOCK TABLES `players_state` WRITE;
/*!40000 ALTER TABLE `players_state` DISABLE KEYS */;
INSERT INTO `players_state` VALUES (1,1,5,332,288,'down'),(2,2,5,1245,578,'right'),(3,3,4,917,453,'right'),(4,4,2,622,555,'right'),(5,5,4,721,323,'up'),(6,6,2,548,615,'up'),(7,7,5,640,768,'up'),(8,8,2,548,633,'up'),(9,9,2,548,615,'up'),(10,10,2,548,615,'up'),(11,11,2,548,615,'up'),(12,12,2,548,600,'up'),(13,13,2,548,630,'up'),(14,14,2,548,615,'up');
/*!40000 ALTER TABLE `players_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players_stats`
--

DROP TABLE IF EXISTS `players_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players_stats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `stat_id` int unsigned NOT NULL,
  `base_value` int unsigned NOT NULL,
  `value` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `player_id_stat_id` (`player_id`,`stat_id`) USING BTREE,
  KEY `stat_id` (`stat_id`) USING BTREE,
  KEY `user_id` (`player_id`) USING BTREE,
  CONSTRAINT `FK_player_current_stats_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_players_current_stats_players_stats` FOREIGN KEY (`stat_id`) REFERENCES `stats` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players_stats`
--

LOCK TABLES `players_stats` WRITE;
/*!40000 ALTER TABLE `players_stats` DISABLE KEYS */;
INSERT INTO `players_stats` VALUES (1,1,1,280,81),(2,1,2,280,85),(3,1,3,280,400),(4,1,4,280,280),(5,1,5,100,100),(6,1,6,100,100),(7,1,7,100,100),(8,1,8,100,100),(9,1,9,100,100),(10,1,10,100,100),(11,2,1,100,100),(12,2,2,100,100),(13,2,3,100,100),(14,2,4,100,100),(15,2,5,100,100),(16,2,6,100,100),(17,2,7,100,100),(18,2,8,100,100),(19,2,9,100,100),(20,2,10,100,100),(21,3,1,100,100),(22,3,2,100,100),(23,3,3,100,100),(24,3,4,100,100),(25,3,5,100,100),(26,3,6,100,100),(27,3,7,100,100),(28,3,8,100,100),(29,3,9,100,100),(30,3,10,100,100),(31,4,1,100,100),(32,4,2,100,100),(33,4,3,100,100),(34,4,4,100,100),(35,4,5,100,100),(36,4,6,100,100),(37,4,7,100,100),(38,4,8,100,100),(39,4,9,100,100),(40,4,10,100,100),(41,5,1,100,100),(42,5,2,100,100),(43,5,3,100,100),(44,5,4,100,100),(45,5,5,100,100),(46,5,6,100,100),(47,5,7,100,100),(48,5,8,100,100),(49,5,9,100,100),(50,5,10,100,100),(51,6,1,100,100),(52,6,2,100,100),(53,6,3,100,100),(54,6,4,100,100),(55,6,5,100,100),(56,6,6,100,100),(57,6,7,100,100),(58,6,8,100,100),(59,6,9,100,100),(60,6,10,100,100),(61,7,1,100,100),(62,7,2,100,100),(63,7,3,100,100),(64,7,4,100,100),(65,7,5,100,100),(66,7,6,100,100),(67,7,7,100,100),(68,7,8,100,100),(69,7,9,100,100),(70,7,10,100,100),(71,8,1,100,100),(72,8,2,100,100),(73,8,3,100,100),(74,8,4,100,100),(75,8,5,100,100),(76,8,6,100,100),(77,8,7,100,100),(78,8,8,100,100),(79,8,9,100,100),(80,8,10,100,100),(81,9,1,100,100),(82,9,2,100,100),(83,9,3,100,100),(84,9,4,100,100),(85,9,5,100,100),(86,9,6,100,100),(87,9,7,100,100),(88,9,8,100,100),(89,9,9,100,100),(90,9,10,100,100),(91,10,1,100,100),(92,10,2,100,100),(93,10,3,100,100),(94,10,4,100,100),(95,10,5,100,100),(96,10,6,100,100),(97,10,7,100,100),(98,10,8,100,100),(99,10,9,100,100),(100,10,10,100,100),(101,11,1,100,100),(102,11,2,100,100),(103,11,3,100,100),(104,11,4,100,100),(105,11,5,100,100),(106,11,6,100,100),(107,11,7,100,100),(108,11,8,100,100),(109,11,9,100,100),(110,11,10,100,100),(111,12,1,100,100),(112,12,2,100,100),(113,12,3,100,100),(114,12,4,100,100),(115,12,5,100,100),(116,12,6,100,100),(117,12,7,100,100),(118,12,8,100,100),(119,12,9,100,100),(120,12,10,100,100),(121,13,1,100,100),(122,13,2,100,100),(123,13,3,100,100),(124,13,4,100,100),(125,13,5,100,100),(126,13,6,100,100),(127,13,7,100,100),(128,13,8,100,100),(129,13,9,100,100),(130,13,10,100,100),(131,14,1,100,100),(132,14,2,100,100),(133,14,3,100,100),(134,14,4,100,100),(135,14,5,100,100),(136,14,6,100,100),(137,14,7,100,100),(138,14,8,100,100),(139,14,9,100,100),(140,14,10,100,100);
/*!40000 ALTER TABLE `players_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `respawn`
--

DROP TABLE IF EXISTS `respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `respawn` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `respawn_time` int unsigned NOT NULL DEFAULT '0',
  `instances_limit` int unsigned NOT NULL DEFAULT '0',
  `layer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `respawn_object_id` (`object_id`),
  CONSTRAINT `FK_respawn_objects` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respawn`
--

LOCK TABLES `respawn` WRITE;
/*!40000 ALTER TABLE `respawn` DISABLE KEYS */;
INSERT INTO `respawn` VALUES (1,2,20000,10,'respawn-area-monsters-lvl-1-2','2026-06-09 13:32:18','2026-06-09 13:32:18'),(2,3,10000,20,'respawn-area-monsters-lvl-1-2','2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,6,20000,2,'respawn-area-monsters-lvl-1-2','2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,7,10000,3,'respawn-area-monsters-lvl-1-2','2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,14,20000,100,'ground-respawn-area','2026-06-09 13:32:18','2026-06-09 13:32:18'),(6,15,10000,200,'ground-respawn-area','2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `respawn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rewards`
--

DROP TABLE IF EXISTS `rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int unsigned NOT NULL,
  `item_id` int unsigned DEFAULT NULL,
  `modifier_id` int unsigned DEFAULT NULL,
  `experience` int unsigned NOT NULL DEFAULT '0',
  `drop_rate` int unsigned NOT NULL,
  `drop_quantity` int unsigned NOT NULL,
  `is_unique` tinyint unsigned DEFAULT NULL,
  `was_given` tinyint unsigned DEFAULT NULL,
  `has_drop_body` tinyint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_rewards_items_item` (`item_id`) USING BTREE,
  KEY `FK_rewards_objects` (`object_id`) USING BTREE,
  KEY `FK_rewards_rewards_modifiers` (`modifier_id`) USING BTREE,
  CONSTRAINT `FK_rewards_items_item` FOREIGN KEY (`item_id`) REFERENCES `items_item` (`id`),
  CONSTRAINT `FK_rewards_objects` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`),
  CONSTRAINT `FK_rewards_rewards_modifiers` FOREIGN KEY (`modifier_id`) REFERENCES `rewards_modifiers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rewards`
--

LOCK TABLES `rewards` WRITE;
/*!40000 ALTER TABLE `rewards` DISABLE KEYS */;
INSERT INTO `rewards` VALUES (1,2,2,NULL,10,100,3,0,0,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(2,3,2,NULL,10,100,1,0,0,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,6,2,NULL,10,100,3,0,0,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,7,2,NULL,10,100,1,0,0,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,14,2,NULL,10,100,3,0,0,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(6,15,2,NULL,10,100,1,0,0,1,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `rewards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rewards_events`
--

DROP TABLE IF EXISTS `rewards_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards_events` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handler_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_data` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint DEFAULT NULL,
  `active_from` datetime DEFAULT NULL,
  `active_to` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `event_key` (`event_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rewards_events`
--

LOCK TABLES `rewards_events` WRITE;
/*!40000 ALTER TABLE `rewards_events` DISABLE KEYS */;
INSERT INTO `rewards_events` VALUES (1,'rewards.dailyLogin','rewards.dailyDescription','login','reldens.joinRoomEnd','{\"action\":\"dailyLogin\",\"items\":{\"coins\":1}}',0,1,NULL,NULL),(2,'rewards.straightDaysLogin','rewards.straightDaysDescription','login','reldens.joinRoomEnd','{\"action\":\"straightDaysLogin\",\"days\":2,\"items\":{\"coins\":10}}',0,1,NULL,NULL);
/*!40000 ALTER TABLE `rewards_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rewards_events_state`
--

DROP TABLE IF EXISTS `rewards_events_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards_events_state` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `rewards_events_id` int unsigned NOT NULL,
  `player_id` int unsigned NOT NULL,
  `state` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rewards_events_id` (`rewards_events_id`) USING BTREE,
  KEY `user_id` (`player_id`) USING BTREE,
  CONSTRAINT `FK__rewards_events` FOREIGN KEY (`rewards_events_id`) REFERENCES `rewards_events` (`id`),
  CONSTRAINT `FK_rewards_events_state_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rewards_events_state`
--

LOCK TABLES `rewards_events_state` WRITE;
/*!40000 ALTER TABLE `rewards_events_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `rewards_events_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rewards_modifiers`
--

DROP TABLE IF EXISTS `rewards_modifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards_modifiers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` int unsigned NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `modifier_id` (`key`) USING BTREE,
  KEY `operation` (`operation`) USING BTREE,
  CONSTRAINT `FK_rewards_modifiers_operation_types` FOREIGN KEY (`operation`) REFERENCES `operation_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rewards_modifiers`
--

LOCK TABLES `rewards_modifiers` WRITE;
/*!40000 ALTER TABLE `rewards_modifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `rewards_modifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `map_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `scene_images` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_class_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `server_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (2,'reldens-house-1','House - 1','reldens-house-1.json','reldens-house-1.png',NULL,NULL,'{\"allowGuest\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,'reldens-house-2','House - 2','reldens-house-2.json','reldens-house-2.png',NULL,NULL,'{\"allowGuest\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,'reldens-town','Town','reldens-town.json','reldens-town.png',NULL,NULL,'{\"allowGuest\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,'reldens-forest','Forest','reldens-forest.json','reldens-forest.png',NULL,NULL,'{\"allowGuest\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(6,'reldens-house-1-2d-floor','House - 1 - Floor 2','reldens-house-1-2d-floor.json','reldens-house-1-2d-floor.png',NULL,NULL,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(7,'reldens-gravity','Gravity World!','reldens-gravity.json','reldens-gravity.png',NULL,NULL,'{\"allowGuest\":true,\"gravity\":[0,625],\"applyGravity\":true,\"allowPassWallsFromBelow\":true,\"timeStep\":0.012,\"type\":\"TOP_DOWN_WITH_GRAVITY\",\"useFixedWorldStep\":false,\"maxSubSteps\":2,\"movementSpeed\":160,\"usePathFinder\":false}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(8,'reldens-bots','Bots Test','reldens-bots.json','reldens-forest.png',NULL,NULL,'{\"allowGuest\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(9,'reldens-bots-forest','Bots Forest','reldens-bots-forest.json','reldens-bots-forest.png',NULL,NULL,'{\"allowGuest\":true,\"joinInRandomPlace\":true,\"joinInRandomPlaceGuestAlways\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18'),(10,'reldens-bots-forest-house-01-n0','Bots Forest - House 1-0','reldens-bots-forest-house-01-n0.json','reldens-bots-forest-house-01-n0.png',NULL,NULL,'{\"allowGuest\":true}','2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms_change_points`
--

DROP TABLE IF EXISTS `rooms_change_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms_change_points` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int unsigned NOT NULL,
  `tile_index` int unsigned NOT NULL,
  `next_room_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `scene_id` (`room_id`),
  KEY `FK_rooms_change_points_rooms_2` (`next_room_id`),
  CONSTRAINT `FK_rooms_change_points_rooms` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_rooms_change_points_rooms_2` FOREIGN KEY (`next_room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms_change_points`
--

LOCK TABLES `rooms_change_points` WRITE;
/*!40000 ALTER TABLE `rooms_change_points` DISABLE KEYS */;
INSERT INTO `rooms_change_points` VALUES (1,2,816,4),(2,2,817,4),(3,3,778,4),(4,3,779,4),(5,4,444,2),(6,4,951,3),(7,4,18,5),(8,4,19,5),(9,5,1315,4),(10,5,1316,4),(11,2,623,6),(12,2,663,6),(13,6,624,2),(14,6,664,2),(15,7,540,3),(16,3,500,7),(17,3,780,4),(18,9,20349,10),(19,10,381,9),(20,10,382,9);
/*!40000 ALTER TABLE `rooms_change_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms_return_points`
--

DROP TABLE IF EXISTS `rooms_return_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms_return_points` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int unsigned NOT NULL,
  `direction` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `x` int unsigned NOT NULL,
  `y` int unsigned NOT NULL,
  `is_default` tinyint unsigned DEFAULT NULL,
  `from_room_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_scenes_return_points_rooms` (`room_id`),
  KEY `FK_scenes_return_points_rooms_2` (`from_room_id`) USING BTREE,
  CONSTRAINT `FK_rooms_return_points_rooms_from_room_id` FOREIGN KEY (`from_room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_rooms_return_points_rooms_room_id` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms_return_points`
--

LOCK TABLES `rooms_return_points` WRITE;
/*!40000 ALTER TABLE `rooms_return_points` DISABLE KEYS */;
INSERT INTO `rooms_return_points` VALUES (1,2,'up',548,615,1,4),(2,3,'up',640,600,1,4),(3,4,'down',400,345,1,2),(4,4,'down',1266,670,0,3),(5,5,'up',640,768,0,4),(6,8,'up',640,768,0,4),(7,4,'down',615,64,0,5),(9,6,'right',820,500,0,2),(11,2,'left',720,540,0,6),(12,7,'left',340,600,0,NULL),(13,3,'down',660,520,0,7),(14,9,'down',4500,985,1,NULL),(15,9,'down',1600,4544,0,10),(16,10,'up',64,544,1,9);
/*!40000 ALTER TABLE `rooms_return_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scores` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `total_score` int unsigned NOT NULL,
  `players_kills_count` int unsigned NOT NULL,
  `npcs_kills_count` int unsigned NOT NULL,
  `last_player_kill_time` datetime DEFAULT NULL,
  `last_npc_kill_time` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `player_id` (`player_id`) USING BTREE,
  CONSTRAINT `FK_scores_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scores_detail`
--

DROP TABLE IF EXISTS `scores_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scores_detail` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `obtained_score` int unsigned NOT NULL,
  `kill_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `kill_player_id` int unsigned DEFAULT NULL,
  `kill_npc_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `player_id` (`player_id`) USING BTREE,
  CONSTRAINT `FK_scores_detail_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores_detail`
--

LOCK TABLES `scores_detail` WRITE;
/*!40000 ALTER TABLE `scores_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `scores_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_class_level_up_animations`
--

DROP TABLE IF EXISTS `skills_class_level_up_animations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_class_level_up_animations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `class_path_id` int unsigned DEFAULT NULL,
  `level_id` int unsigned DEFAULT NULL,
  `animationData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `class_path_id_level_id` (`class_path_id`,`level_id`) USING BTREE,
  KEY `FK_skills_class_level_up_skills_levels` (`level_id`) USING BTREE,
  CONSTRAINT `FK_skills_class_level_up_skills_class_path` FOREIGN KEY (`class_path_id`) REFERENCES `skills_class_path` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_skills_class_level_up_skills_levels` FOREIGN KEY (`level_id`) REFERENCES `skills_levels` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_class_level_up_animations`
--

LOCK TABLES `skills_class_level_up_animations` WRITE;
/*!40000 ALTER TABLE `skills_class_level_up_animations` DISABLE KEYS */;
INSERT INTO `skills_class_level_up_animations` VALUES (1,NULL,NULL,'{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"heal_cast\",\"frameWidth\":64,\"frameHeight\":70,\"start\":0,\"end\":3,\"repeat\":-1,\"destroyTime\":2000,\"depthByPlayer\":\"above\"}');
/*!40000 ALTER TABLE `skills_class_level_up_animations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_class_path`
--

DROP TABLE IF EXISTS `skills_class_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_class_path` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `levels_set_id` int unsigned NOT NULL,
  `enabled` tinyint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `levels_set_id` (`levels_set_id`),
  CONSTRAINT `FK_skills_class_path_skills_levels_set` FOREIGN KEY (`levels_set_id`) REFERENCES `skills_levels_set` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_class_path`
--

LOCK TABLES `skills_class_path` WRITE;
/*!40000 ALTER TABLE `skills_class_path` DISABLE KEYS */;
INSERT INTO `skills_class_path` VALUES (1,'journeyman','Journeyman',1,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(2,'sorcerer','Sorcerer',2,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,'warlock','Warlock',3,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,'swordsman','Swordsman',4,1,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,'warrior','Warrior',5,1,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `skills_class_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_class_path_level_labels`
--

DROP TABLE IF EXISTS `skills_class_path_level_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_class_path_level_labels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `class_path_id` int unsigned NOT NULL,
  `level_id` int unsigned NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_path_id_level_key` (`class_path_id`,`level_id`) USING BTREE,
  KEY `class_path_id` (`class_path_id`),
  KEY `level_key` (`level_id`) USING BTREE,
  CONSTRAINT `FK__skills_class_path` FOREIGN KEY (`class_path_id`) REFERENCES `skills_class_path` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_skills_class_path_level_labels_skills_levels` FOREIGN KEY (`level_id`) REFERENCES `skills_levels` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_class_path_level_labels`
--

LOCK TABLES `skills_class_path_level_labels` WRITE;
/*!40000 ALTER TABLE `skills_class_path_level_labels` DISABLE KEYS */;
INSERT INTO `skills_class_path_level_labels` VALUES (1,1,3,'Old Traveler'),(2,2,7,'Fire Master'),(3,3,11,'Magus'),(4,4,15,'Blade Master'),(5,5,19,'Palading');
/*!40000 ALTER TABLE `skills_class_path_level_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_class_path_level_skills`
--

DROP TABLE IF EXISTS `skills_class_path_level_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_class_path_level_skills` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `class_path_id` int unsigned NOT NULL,
  `level_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `class_path_id_level_id_skill_id` (`class_path_id`,`level_id`,`skill_id`) USING BTREE,
  KEY `class_path_id` (`class_path_id`) USING BTREE,
  KEY `skill_id` (`skill_id`) USING BTREE,
  KEY `level_key` (`level_id`) USING BTREE,
  CONSTRAINT `FK_skills_class_path_level_skills_skills_class_path` FOREIGN KEY (`class_path_id`) REFERENCES `skills_class_path` (`id`),
  CONSTRAINT `FK_skills_class_path_level_skills_skills_levels_id` FOREIGN KEY (`level_id`) REFERENCES `skills_levels` (`id`),
  CONSTRAINT `FK_skills_class_path_level_skills_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_class_path_level_skills`
--

LOCK TABLES `skills_class_path_level_skills` WRITE;
/*!40000 ALTER TABLE `skills_class_path_level_skills` DISABLE KEYS */;
INSERT INTO `skills_class_path_level_skills` VALUES (1,1,1,2),(2,1,3,1),(3,1,4,3),(4,1,4,4),(5,2,5,1),(6,2,7,3),(7,2,8,4),(8,3,9,1),(9,3,11,3),(10,3,12,2),(11,4,13,2),(12,4,15,4),(13,5,17,2),(14,5,19,1),(15,5,20,4);
/*!40000 ALTER TABLE `skills_class_path_level_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_groups`
--

DROP TABLE IF EXISTS `skills_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_groups`
--

LOCK TABLES `skills_groups` WRITE;
/*!40000 ALTER TABLE `skills_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_levels`
--

DROP TABLE IF EXISTS `skills_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_levels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` int unsigned NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required_experience` bigint unsigned DEFAULT NULL,
  `level_set_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_level_set_id` (`key`,`level_set_id`),
  KEY `level_set_id` (`level_set_id`),
  CONSTRAINT `FK_skills_levels_skills_levels_set` FOREIGN KEY (`level_set_id`) REFERENCES `skills_levels_set` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_levels`
--

LOCK TABLES `skills_levels` WRITE;
/*!40000 ALTER TABLE `skills_levels` DISABLE KEYS */;
INSERT INTO `skills_levels` VALUES (1,1,'1',0,1),(2,2,'2',100,1),(3,5,'5',338,1),(4,10,'10',2570,1),(5,1,'1',0,2),(6,2,'2',100,2),(7,5,'5',338,2),(8,10,'10',2570,2),(9,1,'1',0,3),(10,2,'2',100,3),(11,5,'5',338,3),(12,10,'10',2570,3),(13,1,'1',0,4),(14,2,'2',100,4),(15,5,'5',338,4),(16,10,'10',2570,4),(17,1,'1',0,5),(18,2,'2',100,5),(19,5,'5',338,5),(20,10,'10',2570,5);
/*!40000 ALTER TABLE `skills_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_levels_modifiers`
--

DROP TABLE IF EXISTS `skills_levels_modifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_levels_modifiers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `level_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` int unsigned NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modifier_id` (`key`) USING BTREE,
  KEY `level_key` (`level_id`) USING BTREE,
  KEY `FK_skills_levels_modifiers_operation_types` (`operation`) USING BTREE,
  CONSTRAINT `FK_skills_levels_modifiers_operation_types` FOREIGN KEY (`operation`) REFERENCES `operation_types` (`key`) ON UPDATE CASCADE,
  CONSTRAINT `FK_skills_levels_modifiers_skills_levels` FOREIGN KEY (`level_id`) REFERENCES `skills_levels` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_levels_modifiers`
--

LOCK TABLES `skills_levels_modifiers` WRITE;
/*!40000 ALTER TABLE `skills_levels_modifiers` DISABLE KEYS */;
INSERT INTO `skills_levels_modifiers` VALUES (1,2,'inc_atk','stats/atk',1,'10',NULL,NULL,NULL,NULL),(2,2,'inc_def','stats/def',1,'10',NULL,NULL,NULL,NULL),(3,2,'inc_hp','stats/hp',1,'10',NULL,NULL,NULL,NULL),(4,2,'inc_mp','stats/mp',1,'10',NULL,NULL,NULL,NULL),(5,2,'inc_atk','statsBase/atk',1,'10',NULL,NULL,NULL,NULL),(6,2,'inc_def','statsBase/def',1,'10',NULL,NULL,NULL,NULL),(7,2,'inc_hp','statsBase/hp',1,'10',NULL,NULL,NULL,NULL),(8,2,'inc_mp','statsBase/mp',1,'10',NULL,NULL,NULL,NULL),(9,3,'inc_atk','stats/atk',1,'20',NULL,NULL,NULL,NULL),(10,3,'inc_def','stats/def',1,'20',NULL,NULL,NULL,NULL),(11,3,'inc_hp','stats/hp',1,'20',NULL,NULL,NULL,NULL),(12,3,'inc_mp','stats/mp',1,'20',NULL,NULL,NULL,NULL),(13,3,'inc_atk','statsBase/atk',1,'20',NULL,NULL,NULL,NULL),(14,3,'inc_def','statsBase/def',1,'20',NULL,NULL,NULL,NULL),(15,3,'inc_hp','statsBase/hp',1,'20',NULL,NULL,NULL,NULL),(16,3,'inc_mp','statsBase/mp',1,'20',NULL,NULL,NULL,NULL),(17,4,'inc_atk','stats/atk',1,'50',NULL,NULL,NULL,NULL),(18,4,'inc_def','stats/def',1,'50',NULL,NULL,NULL,NULL),(19,4,'inc_hp','stats/hp',1,'50',NULL,NULL,NULL,NULL),(20,4,'inc_mp','stats/mp',1,'50',NULL,NULL,NULL,NULL),(21,4,'inc_atk','statsBase/atk',1,'50',NULL,NULL,NULL,NULL),(22,4,'inc_def','statsBase/def',1,'50',NULL,NULL,NULL,NULL),(23,4,'inc_hp','statsBase/hp',1,'50',NULL,NULL,NULL,NULL),(24,4,'inc_mp','statsBase/mp',1,'50',NULL,NULL,NULL,NULL),(25,6,'inc_atk','stats/atk',1,'10',NULL,NULL,NULL,NULL),(26,6,'inc_def','stats/def',1,'10',NULL,NULL,NULL,NULL),(27,6,'inc_hp','stats/hp',1,'10',NULL,NULL,NULL,NULL),(28,6,'inc_mp','stats/mp',1,'10',NULL,NULL,NULL,NULL),(29,6,'inc_atk','statsBase/atk',1,'10',NULL,NULL,NULL,NULL),(30,6,'inc_def','statsBase/def',1,'10',NULL,NULL,NULL,NULL),(31,6,'inc_hp','statsBase/hp',1,'10',NULL,NULL,NULL,NULL),(32,6,'inc_mp','statsBase/mp',1,'10',NULL,NULL,NULL,NULL),(33,7,'inc_atk','stats/atk',1,'20',NULL,NULL,NULL,NULL),(34,7,'inc_def','stats/def',1,'20',NULL,NULL,NULL,NULL),(35,7,'inc_hp','stats/hp',1,'20',NULL,NULL,NULL,NULL),(36,7,'inc_mp','stats/mp',1,'20',NULL,NULL,NULL,NULL),(37,7,'inc_atk','statsBase/atk',1,'20',NULL,NULL,NULL,NULL),(38,7,'inc_def','statsBase/def',1,'20',NULL,NULL,NULL,NULL),(39,7,'inc_hp','statsBase/hp',1,'20',NULL,NULL,NULL,NULL),(40,7,'inc_mp','statsBase/mp',1,'20',NULL,NULL,NULL,NULL),(41,8,'inc_atk','stats/atk',1,'50',NULL,NULL,NULL,NULL),(42,8,'inc_def','stats/def',1,'50',NULL,NULL,NULL,NULL),(43,8,'inc_hp','stats/hp',1,'50',NULL,NULL,NULL,NULL),(44,8,'inc_mp','stats/mp',1,'50',NULL,NULL,NULL,NULL),(45,8,'inc_atk','statsBase/atk',1,'50',NULL,NULL,NULL,NULL),(46,8,'inc_def','statsBase/def',1,'50',NULL,NULL,NULL,NULL),(47,8,'inc_hp','statsBase/hp',1,'50',NULL,NULL,NULL,NULL),(48,8,'inc_mp','statsBase/mp',1,'50',NULL,NULL,NULL,NULL),(49,10,'inc_atk','stats/atk',1,'10',NULL,NULL,NULL,NULL),(50,10,'inc_def','stats/def',1,'10',NULL,NULL,NULL,NULL),(51,10,'inc_hp','stats/hp',1,'10',NULL,NULL,NULL,NULL),(52,10,'inc_mp','stats/mp',1,'10',NULL,NULL,NULL,NULL),(53,10,'inc_atk','statsBase/atk',1,'10',NULL,NULL,NULL,NULL),(54,10,'inc_def','statsBase/def',1,'10',NULL,NULL,NULL,NULL),(55,10,'inc_hp','statsBase/hp',1,'10',NULL,NULL,NULL,NULL),(56,10,'inc_mp','statsBase/mp',1,'10',NULL,NULL,NULL,NULL),(57,11,'inc_atk','stats/atk',1,'20',NULL,NULL,NULL,NULL),(58,11,'inc_def','stats/def',1,'20',NULL,NULL,NULL,NULL),(59,11,'inc_hp','stats/hp',1,'20',NULL,NULL,NULL,NULL),(60,11,'inc_mp','stats/mp',1,'20',NULL,NULL,NULL,NULL),(61,11,'inc_atk','statsBase/atk',1,'20',NULL,NULL,NULL,NULL),(62,11,'inc_def','statsBase/def',1,'20',NULL,NULL,NULL,NULL),(63,11,'inc_hp','statsBase/hp',1,'20',NULL,NULL,NULL,NULL),(64,11,'inc_mp','statsBase/mp',1,'20',NULL,NULL,NULL,NULL),(65,12,'inc_atk','stats/atk',1,'50',NULL,NULL,NULL,NULL),(66,12,'inc_def','stats/def',1,'50',NULL,NULL,NULL,NULL),(67,12,'inc_hp','stats/hp',1,'50',NULL,NULL,NULL,NULL),(68,12,'inc_mp','stats/mp',1,'50',NULL,NULL,NULL,NULL),(69,12,'inc_atk','statsBase/atk',1,'50',NULL,NULL,NULL,NULL),(70,12,'inc_def','statsBase/def',1,'50',NULL,NULL,NULL,NULL),(71,12,'inc_hp','statsBase/hp',1,'50',NULL,NULL,NULL,NULL),(72,12,'inc_mp','statsBase/mp',1,'50',NULL,NULL,NULL,NULL),(73,14,'inc_atk','stats/atk',1,'10',NULL,NULL,NULL,NULL),(74,14,'inc_def','stats/def',1,'10',NULL,NULL,NULL,NULL),(75,14,'inc_hp','stats/hp',1,'10',NULL,NULL,NULL,NULL),(76,14,'inc_mp','stats/mp',1,'10',NULL,NULL,NULL,NULL),(77,14,'inc_atk','statsBase/atk',1,'10',NULL,NULL,NULL,NULL),(78,14,'inc_def','statsBase/def',1,'10',NULL,NULL,NULL,NULL),(79,14,'inc_hp','statsBase/hp',1,'10',NULL,NULL,NULL,NULL),(80,14,'inc_mp','statsBase/mp',1,'10',NULL,NULL,NULL,NULL),(81,15,'inc_atk','stats/atk',1,'20',NULL,NULL,NULL,NULL),(82,15,'inc_def','stats/def',1,'20',NULL,NULL,NULL,NULL),(83,15,'inc_hp','stats/hp',1,'20',NULL,NULL,NULL,NULL),(84,15,'inc_mp','stats/mp',1,'20',NULL,NULL,NULL,NULL),(85,15,'inc_atk','statsBase/atk',1,'20',NULL,NULL,NULL,NULL),(86,15,'inc_def','statsBase/def',1,'20',NULL,NULL,NULL,NULL),(87,15,'inc_hp','statsBase/hp',1,'20',NULL,NULL,NULL,NULL),(88,15,'inc_mp','statsBase/mp',1,'20',NULL,NULL,NULL,NULL),(89,16,'inc_atk','stats/atk',1,'50',NULL,NULL,NULL,NULL),(90,16,'inc_def','stats/def',1,'50',NULL,NULL,NULL,NULL),(91,16,'inc_hp','stats/hp',1,'50',NULL,NULL,NULL,NULL),(92,16,'inc_mp','stats/mp',1,'50',NULL,NULL,NULL,NULL),(93,16,'inc_atk','statsBase/atk',1,'50',NULL,NULL,NULL,NULL),(94,16,'inc_def','statsBase/def',1,'50',NULL,NULL,NULL,NULL),(95,16,'inc_hp','statsBase/hp',1,'50',NULL,NULL,NULL,NULL),(96,16,'inc_mp','statsBase/mp',1,'50',NULL,NULL,NULL,NULL),(97,18,'inc_atk','stats/atk',1,'10',NULL,NULL,NULL,NULL),(98,18,'inc_def','stats/def',1,'10',NULL,NULL,NULL,NULL),(99,18,'inc_hp','stats/hp',1,'10',NULL,NULL,NULL,NULL),(100,18,'inc_mp','stats/mp',1,'10',NULL,NULL,NULL,NULL),(101,18,'inc_atk','statsBase/atk',1,'10',NULL,NULL,NULL,NULL),(102,18,'inc_def','statsBase/def',1,'10',NULL,NULL,NULL,NULL),(103,18,'inc_hp','statsBase/hp',1,'10',NULL,NULL,NULL,NULL),(104,18,'inc_mp','statsBase/mp',1,'10',NULL,NULL,NULL,NULL),(105,19,'inc_atk','stats/atk',1,'20',NULL,NULL,NULL,NULL),(106,19,'inc_def','stats/def',1,'20',NULL,NULL,NULL,NULL),(107,19,'inc_hp','stats/hp',1,'20',NULL,NULL,NULL,NULL),(108,19,'inc_mp','stats/mp',1,'20',NULL,NULL,NULL,NULL),(109,19,'inc_atk','statsBase/atk',1,'20',NULL,NULL,NULL,NULL),(110,19,'inc_def','statsBase/def',1,'20',NULL,NULL,NULL,NULL),(111,19,'inc_hp','statsBase/hp',1,'20',NULL,NULL,NULL,NULL),(112,19,'inc_mp','statsBase/mp',1,'20',NULL,NULL,NULL,NULL),(113,20,'inc_atk','stats/atk',1,'50',NULL,NULL,NULL,NULL),(114,20,'inc_def','stats/def',1,'50',NULL,NULL,NULL,NULL),(115,20,'inc_hp','stats/hp',1,'50',NULL,NULL,NULL,NULL),(116,20,'inc_mp','stats/mp',1,'50',NULL,NULL,NULL,NULL),(117,20,'inc_atk','statsBase/atk',1,'50',NULL,NULL,NULL,NULL),(118,20,'inc_def','statsBase/def',1,'50',NULL,NULL,NULL,NULL),(119,20,'inc_hp','statsBase/hp',1,'50',NULL,NULL,NULL,NULL),(120,20,'inc_mp','statsBase/mp',1,'50',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `skills_levels_modifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_levels_modifiers_conditions`
--

DROP TABLE IF EXISTS `skills_levels_modifiers_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_levels_modifiers_conditions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `levels_modifier_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conditional` enum('eq','ne','lt','gt','le','ge') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `levels_modifier_id` (`levels_modifier_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_levels_modifiers_conditions`
--

LOCK TABLES `skills_levels_modifiers_conditions` WRITE;
/*!40000 ALTER TABLE `skills_levels_modifiers_conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills_levels_modifiers_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_levels_set`
--

DROP TABLE IF EXISTS `skills_levels_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_levels_set` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autoFillRanges` tinyint unsigned DEFAULT NULL,
  `autoFillExperienceMultiplier` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_levels_set`
--

LOCK TABLES `skills_levels_set` WRITE;
/*!40000 ALTER TABLE `skills_levels_set` DISABLE KEYS */;
INSERT INTO `skills_levels_set` VALUES (1,NULL,NULL,1,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(2,NULL,NULL,1,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,NULL,NULL,1,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,NULL,NULL,1,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(5,NULL,NULL,1,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `skills_levels_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_owners_class_path`
--

DROP TABLE IF EXISTS `skills_owners_class_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_owners_class_path` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `class_path_id` int unsigned NOT NULL,
  `owner_id` int unsigned NOT NULL,
  `currentLevel` bigint unsigned NOT NULL DEFAULT '0',
  `currentExp` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `level_set_id` (`class_path_id`) USING BTREE,
  KEY `FK_skills_owners_class_path_players` (`owner_id`) USING BTREE,
  CONSTRAINT `FK_skills_owners_class_path_players` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`),
  CONSTRAINT `FK_skills_owners_class_path_skills_class_path` FOREIGN KEY (`class_path_id`) REFERENCES `skills_class_path` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_owners_class_path`
--

LOCK TABLES `skills_owners_class_path` WRITE;
/*!40000 ALTER TABLE `skills_owners_class_path` DISABLE KEYS */;
INSERT INTO `skills_owners_class_path` VALUES (1,1,1,10,9080),(2,1,2,1,0),(3,3,3,1,0),(4,1,4,1,0),(5,1,5,1,0),(6,1,6,1,0),(7,1,7,1,0),(8,1,8,1,0),(9,1,9,1,0),(10,1,10,1,0),(11,1,11,1,0),(12,1,12,1,0),(13,1,13,1,0),(14,1,14,1,0);
/*!40000 ALTER TABLE `skills_owners_class_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill`
--

DROP TABLE IF EXISTS `skills_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int unsigned NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autoValidation` tinyint DEFAULT NULL,
  `skillDelay` int NOT NULL,
  `castTime` int NOT NULL,
  `usesLimit` int NOT NULL DEFAULT '0',
  `range` int NOT NULL,
  `rangeAutomaticValidation` tinyint DEFAULT NULL,
  `rangePropertyX` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rangePropertyY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rangeTargetPropertyX` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rangeTargetPropertyY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allowSelfTarget` tinyint DEFAULT NULL,
  `criticalChance` int DEFAULT NULL,
  `criticalMultiplier` int DEFAULT NULL,
  `criticalFixedValue` int DEFAULT NULL,
  `customData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`) USING BTREE,
  KEY `FK_skills_skill_skills_skill_type` (`type`) USING BTREE,
  CONSTRAINT `FK_skills_skill_skills_skill_type` FOREIGN KEY (`type`) REFERENCES `skills_skill_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill`
--

LOCK TABLES `skills_skill` WRITE;
/*!40000 ALTER TABLE `skills_skill` DISABLE KEYS */;
INSERT INTO `skills_skill` VALUES (1,'attackBullet',4,NULL,0,1000,0,0,250,1,'state/x','state/y',NULL,NULL,0,10,2,0,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(2,'attackShort',2,NULL,0,600,0,0,50,1,'state/x','state/y',NULL,NULL,0,10,2,0,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(3,'fireball',4,NULL,0,5000,2000,0,280,1,'state/x','state/y',NULL,NULL,0,10,2,0,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18'),(4,'heal',3,NULL,0,5000,2000,0,100,1,'state/x','state/y',NULL,NULL,1,0,1,0,NULL,'2026-06-09 13:32:18','2026-06-09 13:32:18');
/*!40000 ALTER TABLE `skills_skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_animations`
--

DROP TABLE IF EXISTS `skills_skill_animations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_animations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `classKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `animationData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `skill_id_key` (`skill_id`,`key`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `key` (`key`) USING BTREE,
  KEY `skill_id` (`skill_id`) USING BTREE,
  CONSTRAINT `FK_skills_skill_animations_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_animations`
--

LOCK TABLES `skills_skill_animations` WRITE;
/*!40000 ALTER TABLE `skills_skill_animations` DISABLE KEYS */;
INSERT INTO `skills_skill_animations` VALUES (1,3,'bullet',NULL,'{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"fireball_bullet\",\"frameWidth\":64,\"frameHeight\":64,\"start\":0,\"end\":3,\"repeat\":-1,\"frameRate\":1,\"dir\":3}'),(2,3,'cast',NULL,'{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"fireball_cast\",\"frameWidth\":64,\"frameHeight\":70,\"start\":0,\"end\":3,\"repeat\":-1,\"destroyTime\":2000,\"depthByPlayer\":\"above\"}'),(3,4,'cast',NULL,'{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"heal_cast\",\"frameWidth\":64,\"frameHeight\":70,\"start\":0,\"end\":3,\"repeat\":-1,\"destroyTime\":2000}'),(4,4,'hit',NULL,'{\"enabled\":true,\"type\":\"spritesheet\",\"img\":\"heal_hit\",\"frameWidth\":64,\"frameHeight\":70,\"start\":0,\"end\":4,\"repeat\":0,\"depthByPlayer\":\"above\"}');
/*!40000 ALTER TABLE `skills_skill_animations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_attack`
--

DROP TABLE IF EXISTS `skills_skill_attack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_attack` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `affectedProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `allowEffectBelowZero` tinyint unsigned DEFAULT NULL,
  `hitDamage` int unsigned NOT NULL,
  `applyDirectDamage` tinyint unsigned DEFAULT NULL,
  `attackProperties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `defenseProperties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `aimProperties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dodgeProperties` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dodgeFullEnabled` tinyint DEFAULT '1',
  `dodgeOverAimSuccess` tinyint DEFAULT '1',
  `damageAffected` tinyint DEFAULT NULL,
  `criticalAffected` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `skill_id_unique` (`skill_id`) USING BTREE,
  KEY `skill_id` (`skill_id`) USING BTREE,
  CONSTRAINT `FK__skills_skill_attack` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_attack`
--

LOCK TABLES `skills_skill_attack` WRITE;
/*!40000 ALTER TABLE `skills_skill_attack` DISABLE KEYS */;
INSERT INTO `skills_skill_attack` VALUES (1,1,'stats/hp',0,3,0,'stats/atk,stats/speed','stats/def,stats/speed','stats/aim','stats/dodge',0,1,0,0),(2,2,'stats/hp',0,5,0,'stats/atk,stats/speed','stats/def,stats/speed','stats/aim','stats/dodge',0,1,0,0),(3,3,'stats/hp',0,7,0,'stats/mgk-atk,stats/speed','stats/mgk-def,stats/speed','stats/aim','stats/dodge',0,1,0,0);
/*!40000 ALTER TABLE `skills_skill_attack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_group_relation`
--

DROP TABLE IF EXISTS `skills_skill_group_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_group_relation` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `group_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `skill_id_unique` (`skill_id`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE,
  KEY `skill_id` (`skill_id`) USING BTREE,
  CONSTRAINT `FK__skills_groups` FOREIGN KEY (`group_id`) REFERENCES `skills_groups` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK__skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_group_relation`
--

LOCK TABLES `skills_skill_group_relation` WRITE;
/*!40000 ALTER TABLE `skills_skill_group_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills_skill_group_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_owner_conditions`
--

DROP TABLE IF EXISTS `skills_skill_owner_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_owner_conditions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conditional` enum('eq','ne','lt','gt','le','ge') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `skill_id_property_key` (`skill_id`,`property_key`) USING BTREE,
  KEY `skill_id` (`skill_id`) USING BTREE,
  CONSTRAINT `FK_skills_skill_owner_conditions_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_owner_conditions`
--

LOCK TABLES `skills_skill_owner_conditions` WRITE;
/*!40000 ALTER TABLE `skills_skill_owner_conditions` DISABLE KEYS */;
INSERT INTO `skills_skill_owner_conditions` VALUES (1,3,'available_mp','stats/mp','ge','5');
/*!40000 ALTER TABLE `skills_skill_owner_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_owner_effects`
--

DROP TABLE IF EXISTS `skills_skill_owner_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_owner_effects` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` int unsigned NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maxValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `skill_id` (`skill_id`) USING BTREE,
  KEY `FK_skills_skill_owner_effects_operation_types` (`operation`),
  CONSTRAINT `FK_skills_skill_owner_effects_operation_types` FOREIGN KEY (`operation`) REFERENCES `operation_types` (`key`) ON UPDATE CASCADE,
  CONSTRAINT `FK_skills_skill_owner_effects_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_owner_effects`
--

LOCK TABLES `skills_skill_owner_effects` WRITE;
/*!40000 ALTER TABLE `skills_skill_owner_effects` DISABLE KEYS */;
INSERT INTO `skills_skill_owner_effects` VALUES (2,3,'dec_mp','stats/mp',2,'5','0',' ',NULL,NULL),(3,4,'dec_mp','stats/mp',2,'2','0','',NULL,NULL);
/*!40000 ALTER TABLE `skills_skill_owner_effects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_owner_effects_conditions`
--

DROP TABLE IF EXISTS `skills_skill_owner_effects_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_owner_effects_conditions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_owner_effect_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conditional` enum('eq','ne','lt','gt','le','ge') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `skill_owner_effect_id` (`skill_owner_effect_id`) USING BTREE,
  CONSTRAINT `FK_skills_skill_owner_effects_conditions_skill_owner_effects` FOREIGN KEY (`skill_owner_effect_id`) REFERENCES `skills_skill_owner_effects` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_owner_effects_conditions`
--

LOCK TABLES `skills_skill_owner_effects_conditions` WRITE;
/*!40000 ALTER TABLE `skills_skill_owner_effects_conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills_skill_owner_effects_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_physical_data`
--

DROP TABLE IF EXISTS `skills_skill_physical_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_physical_data` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `magnitude` int unsigned NOT NULL,
  `objectWidth` int unsigned NOT NULL,
  `objectHeight` int unsigned NOT NULL,
  `validateTargetOnHit` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `skill_id` (`skill_id`) USING BTREE,
  KEY `attack_skill_id` (`skill_id`) USING BTREE,
  CONSTRAINT `FK_skills_skill_physical_data_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_physical_data`
--

LOCK TABLES `skills_skill_physical_data` WRITE;
/*!40000 ALTER TABLE `skills_skill_physical_data` DISABLE KEYS */;
INSERT INTO `skills_skill_physical_data` VALUES (1,1,350,5,5,0),(2,3,550,5,5,0);
/*!40000 ALTER TABLE `skills_skill_physical_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_target_effects`
--

DROP TABLE IF EXISTS `skills_skill_target_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_target_effects` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` int unsigned NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maxValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `minProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxProperty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `skill_id` (`skill_id`) USING BTREE,
  KEY `FK_skills_skill_target_effects_operation_types` (`operation`),
  CONSTRAINT `FK_skills_skill_effect_modifiers` FOREIGN KEY (`skill_id`) REFERENCES `skills_skill` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_skills_skill_target_effects_operation_types` FOREIGN KEY (`operation`) REFERENCES `operation_types` (`key`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_target_effects`
--

LOCK TABLES `skills_skill_target_effects` WRITE;
/*!40000 ALTER TABLE `skills_skill_target_effects` DISABLE KEYS */;
INSERT INTO `skills_skill_target_effects` VALUES (1,4,'heal','stats/hp',1,'10','0','0',NULL,'statsBase/hp');
/*!40000 ALTER TABLE `skills_skill_target_effects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_target_effects_conditions`
--

DROP TABLE IF EXISTS `skills_skill_target_effects_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_target_effects_conditions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_target_effect_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `property_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conditional` enum('eq','ne','lt','gt','le','ge') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `skill_target_effect_id` (`skill_target_effect_id`) USING BTREE,
  CONSTRAINT `FK_skills_skill_target_effects_conditions_skill_target_effects` FOREIGN KEY (`skill_target_effect_id`) REFERENCES `skills_skill_target_effects` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_target_effects_conditions`
--

LOCK TABLES `skills_skill_target_effects_conditions` WRITE;
/*!40000 ALTER TABLE `skills_skill_target_effects_conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills_skill_target_effects_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills_skill_type`
--

DROP TABLE IF EXISTS `skills_skill_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills_skill_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills_skill_type`
--

LOCK TABLES `skills_skill_type` WRITE;
/*!40000 ALTER TABLE `skills_skill_type` DISABLE KEYS */;
INSERT INTO `skills_skill_type` VALUES (2,'attack'),(1,'base'),(3,'effect'),(4,'physical_attack'),(5,'physical_effect');
/*!40000 ALTER TABLE `skills_skill_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snippets`
--

DROP TABLE IF EXISTS `snippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snippets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `locale_id` int unsigned NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `locale_id` (`locale_id`),
  CONSTRAINT `FK_snippets_locale` FOREIGN KEY (`locale_id`) REFERENCES `locale` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snippets`
--

LOCK TABLES `snippets` WRITE;
/*!40000 ALTER TABLE `snippets` DISABLE KEYS */;
/*!40000 ALTER TABLE `snippets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_value` int unsigned NOT NULL,
  `customData` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (1,'hp','HP','Player life points',100,'{\"showBase\":true}','2026-06-09 13:32:19','2026-06-09 13:32:19'),(2,'mp','MP','Player magic points',100,'{\"showBase\":true}','2026-06-09 13:32:19','2026-06-09 13:32:19'),(3,'atk','Atk','Player attack points',100,NULL,'2026-06-09 13:32:19','2026-06-09 13:32:19'),(4,'def','Def','Player defense points',100,NULL,'2026-06-09 13:32:19','2026-06-09 13:32:19'),(5,'dodge','Dodge','Player dodge points',100,NULL,'2026-06-09 13:32:19','2026-06-09 13:32:19'),(6,'speed','Speed','Player speed point',100,NULL,'2026-06-09 13:32:19','2026-06-09 13:32:19'),(7,'aim','Aim','Player aim points',100,NULL,'2026-06-09 13:32:19','2026-06-09 13:32:19'),(8,'stamina','Stamina','Player stamina points',100,'{\"showBase\":true}','2026-06-09 13:32:19','2026-06-09 13:32:19'),(9,'mAtk','Magic Atk','Player magic attack',100,NULL,'2026-06-09 13:32:19','2026-06-09 13:32:19'),(10,'mDef','Magic Def','Player magic defense',100,NULL,'2026-06-09 13:32:19','2026-06-09 13:32:19');
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_options`
--

DROP TABLE IF EXISTS `target_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_options` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `target_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `target_key` (`target_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_options`
--

LOCK TABLES `target_options` WRITE;
/*!40000 ALTER TABLE `target_options` DISABLE KEYS */;
INSERT INTO `target_options` VALUES (1,'object','Object'),(2,'player','Player');
/*!40000 ALTER TABLE `target_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int unsigned NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (now()),
  `updated_at` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
  `played_time` int NOT NULL DEFAULT '0',
  `login_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'root@yourgame.com','root','879abc0494b36a09f184fd8308ea18f2643d71263f145b1e40e2ec3546d42202:6a186aff4d69daadcd7940a839856b394b12f0aec64a5df745c83cf9d881dc9dcb121b03d946872571f214228684216df097305b68417a56403299b8b2388db3',99,'1','2022-03-17 13:57:44','2023-10-21 11:51:55',0,0),(2,'admin@pixel.life','admin','679151025fc46882fb6215d82b57e40f65679ec62417720597d9f155fe445751:10462de530c145439e630ae08eca29ba4c0dd1e6eb3fa8c8d17ef5bf86616fc5f40d641bd7d308cbafb7ff6549508a3b9dcc2012861f2f64b89dfd129364c567',99,'1','2026-06-09 13:32:51','2026-06-09 13:32:51',0,0),(3,'guest-Ts9pPChrSZHW@guest-reldens.com','guest-Ts9pPChrSZHW','35d6edee7fc1d4f817aeeea1316ef841ff8b4a4a46b4a4ddcd9b583d0894693d:4ce9e54f159eb9c032434483cae1523911f39ba95d4baafdd3bebe4ed5a9b8a244a4a0c119a217260da843918e0fac3b0ef820b296690c17e9c9eb1dc37e8a54',2,'1','2026-06-09 13:34:27','2026-06-09 13:34:56',21,2),(4,'guest-7FD6fqKsrg5l@guest-reldens.com','guest-7FD6fqKsrg5l','9788d52d7cfaa9087747d807c7617f73ead27a600eab0dad9c54e44a415bb49a:ed5ad5ac5826f899cab592b86cb4fef9457980051460fae6988f296c648276554bd101201f414bf8cf782cca2f1340771becfc6a6dd2e5fbc945919c7af59577',2,'1','2026-06-09 13:52:30','2026-06-09 13:54:40',14,2),(5,'guest-SyjW0SJirgJM@guest-reldens.com','guest-SyjW0SJirgJM','bb57462f563dd0aab83199f3ac299427c83dd6eada4d70b9954cae773abf78fe:f1df906d41e8eec6dad684d142c6bcc6de407fcaa7b98e1340f71f722f9a34ec3ff2fdb90d7648abff1c1adef6be78a54ad0c17767e51c5774e7769442dbd1a9',2,'1','2026-06-09 14:02:40','2026-06-09 14:02:59',15,2),(6,'guest-m7UEKv5gN1bp@guest-reldens.com','guest-m7UEKv5gN1bp','758620e9d75fa21978db7f13039974a9e2e1a1a3163377cfcced77ffa92a9844:b86303bb82cc476ccb9ea29ab521e4037dcc8cd5ed6aecb207bb55a214bcf268feb22c1833d302cdf085b928c9b29282baf92c22721176f02cfea4e06a946d27',2,'1','2026-06-09 14:03:00','2026-06-09 14:03:26',19,2),(7,'guest-VxC5scaQ6Oak@guest-reldens.com','guest-VxC5scaQ6Oak','8d936b12ea508f62bd955d13c98492bbbd5a82e4d966e7c3311a78d02d591a4b:f7a5e5659c0afa35aa61c48a15812a240c3e2f3c7422b5df0a8eb367de05833b1239bcf6e2cf6d545753737614bc37a39bdcb819da194ebdf3d2ac6d083cc2ea',2,'1','2026-06-09 14:27:18','2026-06-09 14:27:26',7,2),(8,'guest-0Fl7zcULAtKV@guest-reldens.com','guest-0Fl7zcULAtKV','7c42a9bb76214def7776ef417a6d55fc518a2389ca28e86e6b598a1986e486ec:64e2d3a9eeff75aba731ca4abccdbda88251e49351940776b6d61b682aef50bdbb777b7d0d01275e6b123a677c837a4560f0f03f525403ace6333834c9f29e29',2,'1','2026-06-09 14:29:55','2026-06-09 14:30:41',30,2),(9,'guest-A6Cgq38ygYjH@guest-reldens.com','guest-A6Cgq38ygYjH','adb7e8a535b01527f2d5ff528e98faf37b513a7bc6d38ee2875d6161cb6f5e1a:cd3d9a8478a2ef0a22f25fbb0aa21be770f037657c13d9067aec759e5ca85176c066dd3545fcc127ac618a6c3886cbee779633bd5e6dae0a5e76c49ebd109f41',2,'1','2026-06-09 14:30:06','2026-06-09 14:30:13',7,2),(10,'guest-fqVud2QOBWro@guest-reldens.com','guest-fqVud2QOBWro','81690ab67f248ed3b775a680e9aae85ab13e72557e97c63f4308e54d475a22de:5a245090074a31ab363cdac4d77ad44de531901f5fbc183f32471bf86b35f60da00784129064988e156ece98e6110ebe8fc4e04318a57c8c656e1e8110ab455c',2,'1','2026-06-09 14:32:56','2026-06-09 14:33:04',7,2),(11,'guest-HGc5Qmg5Edpf@guest-reldens.com','guest-HGc5Qmg5Edpf','3b70ec2ba0c88353df0c790b875c264c9abf45ed303bbfd7ba50393b9f06eb4a:675d06ca54ca2db2c00b094faeecb4b8a8d35391190f2e43688216c3eb9db7bd3bb43f7207dcda1bba240421b3e9c5a597f137aedfef94eaae67a7aa4ce6acd0',2,'1','2026-06-09 14:35:51','2026-06-09 14:35:59',7,2),(12,'guest-teyQJQMkpPmc@guest-reldens.com','guest-teyQJQMkpPmc','edc93bafc9f220e980ce12d204476f8dafaec1ff8d7300a7b12b7d3053867099:1c6689c5ee2db6bd773faf82552a70437957b88a7040e3adb062535f9ee32863c9a26632c65909bd409e0d16096ce2d5bbe40695a3d3d97007b28597b9064673',2,'1','2026-06-09 14:37:31','2026-06-09 14:37:39',7,2),(13,'guest-nrdnBTbhYzdT@guest-reldens.com','guest-nrdnBTbhYzdT','94bc0012028e747c8ec94bb8cd084c4b6555ab09b193b5c95f5f2a480d38cfd8:ba89af739f4310b59dddd29fe6bb2e364f178d5a4338ba2277647e3ad72b2c2ce560d6e706af49f6b855c02ef363a04ac0dd91f43ee38092e795455dcade2468',2,'1','2026-06-09 14:39:21','2026-06-09 14:39:31',9,2),(14,'guest-NXUicWr7hOLT@guest-reldens.com','guest-NXUicWr7hOLT','eff7d7471d0d9874f33f3102c0a6e5641abc7d305b5dc90555281bd9eefba2b1:05f0760a268b2f6d327d88d853c754698fff43a177d7f7620e992fd330a62ed7365aa3aa76d2f6f0e206706a2fb22c8ae4b9e72afd98f2cb81071d9a8aba15a9',2,'1','2026-06-09 14:39:23','2026-06-09 14:39:31',7,2),(15,'guest-SagwMSSphj52@guest-reldens.com','guest-SagwMSSphj52','76ee30c1691fb361ff6fbe07c16cf24bb1ae35d474b6f74e3cface1c97425f8c:69926925205906dabcd1757f339b64c887093e73e8bb6b0f64f9362337ad0794a28c2d57aebc9ad6ebafbb8d47dfb6303981dcc5171f50bc50646a55a5bbd51a',2,'1','2026-06-09 14:40:49','2026-06-09 14:41:01',3,2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_locale`
--

DROP TABLE IF EXISTS `users_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_locale` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `locale_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `locale_id_player_id` (`locale_id`,`user_id`) USING BTREE,
  KEY `locale_id` (`locale_id`) USING BTREE,
  KEY `player_id` (`user_id`) USING BTREE,
  CONSTRAINT `FK_players_locale_locale` FOREIGN KEY (`locale_id`) REFERENCES `locale` (`id`),
  CONSTRAINT `FK_users_locale_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_locale`
--

LOCK TABLES `users_locale` WRITE;
/*!40000 ALTER TABLE `users_locale` DISABLE KEYS */;
INSERT INTO `users_locale` VALUES (1,1,1);
/*!40000 ALTER TABLE `users_locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_login`
--

DROP TABLE IF EXISTS `users_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_login` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `logout_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `FK_users_login_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_login`
--

LOCK TABLES `users_login` WRITE;
/*!40000 ALTER TABLE `users_login` DISABLE KEYS */;
INSERT INTO `users_login` VALUES (1,3,'2026-06-09 08:34:27',NULL),(2,3,'2026-06-09 08:34:29','2026-06-09 08:34:56'),(3,4,'2026-06-09 08:52:30',NULL),(4,4,'2026-06-09 08:53:12','2026-06-09 08:54:40'),(5,5,'2026-06-09 09:02:40',NULL),(6,5,'2026-06-09 09:02:43','2026-06-09 09:02:59'),(7,6,'2026-06-09 09:03:00',NULL),(8,6,'2026-06-09 09:03:03','2026-06-09 09:03:26'),(9,7,'2026-06-09 09:27:18',NULL),(10,7,'2026-06-09 09:27:19','2026-06-09 09:27:26'),(11,8,'2026-06-09 09:29:55',NULL),(12,8,'2026-06-09 09:29:58','2026-06-09 09:30:41'),(13,9,'2026-06-09 09:30:06','2026-06-09 09:30:13'),(14,9,'2026-06-09 09:30:06',NULL),(15,10,'2026-06-09 09:32:56',NULL),(16,10,'2026-06-09 09:32:57','2026-06-09 09:33:04'),(17,11,'2026-06-09 09:35:51',NULL),(18,11,'2026-06-09 09:35:52','2026-06-09 09:35:59'),(19,12,'2026-06-09 09:37:31','2026-06-09 09:37:39'),(20,12,'2026-06-09 09:37:31',NULL),(21,13,'2026-06-09 09:39:21',NULL),(22,13,'2026-06-09 09:39:22','2026-06-09 09:39:31'),(23,14,'2026-06-09 09:39:23','2026-06-09 09:39:31'),(24,14,'2026-06-09 09:39:23',NULL),(25,15,'2026-06-09 09:40:49',NULL),(26,15,'2026-06-09 09:40:56','2026-06-09 09:41:01');
/*!40000 ALTER TABLE `users_login` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09 19:42:49
