-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 30, 2013 at 07:14 AM
-- Server version: 5.5.24-0ubuntu0.12.04.1
-- PHP Version: 5.3.10-1ubuntu3.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ldshake_bio2`
--
CREATE DATABASE `ldshake` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ldshake`;

-- --------------------------------------------------------

--
-- Table structure for table `access_collection_membership`
--

CREATE TABLE IF NOT EXISTS `access_collection_membership` (
  `user_guid` int(11) NOT NULL,
  `access_collection_id` int(11) NOT NULL,
  PRIMARY KEY (`user_guid`,`access_collection_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `access_collections`
--

CREATE TABLE IF NOT EXISTS `access_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `owner_guid` bigint(20) unsigned NOT NULL,
  `site_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `owner_guid` (`owner_guid`),
  KEY `site_guid` (`site_guid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `annotations`
--

CREATE TABLE IF NOT EXISTS `annotations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_guid` bigint(20) unsigned NOT NULL,
  `name_id` int(11) NOT NULL,
  `value_id` int(11) NOT NULL,
  `value_type` enum('integer','text') NOT NULL,
  `owner_guid` bigint(20) unsigned NOT NULL,
  `access_id` int(11) NOT NULL,
  `time_created` int(11) NOT NULL,
  `enabled` enum('yes','no') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`),
  KEY `entity_guid` (`entity_guid`),
  KEY `name_id` (`name_id`),
  KEY `value_id` (`value_id`),
  KEY `owner_guid` (`owner_guid`),
  KEY `access_id` (`access_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `api_users`
--

CREATE TABLE IF NOT EXISTS `api_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_guid` bigint(20) unsigned DEFAULT NULL,
  `api_key` varchar(40) DEFAULT NULL,
  `secret` varchar(40) NOT NULL,
  `active` int(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_key` (`api_key`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `api_users`
--

INSERT INTO `api_users` (`id`, `site_guid`, `api_key`, `secret`, `active`) VALUES
(1, 1, 'f266c0068a5e5ef989f7a9f6bfba12a0afeb67d3', 'eece3f148eab1f8c5940526ba4d84c6a569ef18d', 1);

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `name` varchar(32) NOT NULL,
  `value` text NOT NULL,
  `site_guid` int(11) NOT NULL,
  PRIMARY KEY (`name`,`site_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `config`
--

INSERT INTO `config` (`name`, `value`, `site_guid`) VALUES
('view', 's:7:"default";', 1),
('language', 's:2:"en";', 1),
('ping_home', 's:8:"disabled";', 1);

-- --------------------------------------------------------

--
-- Table structure for table `datalists`
--

CREATE TABLE IF NOT EXISTS `datalists` (
  `name` varchar(32) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `datalists`
--

INSERT INTO `datalists` (`name`, `value`) VALUES
('__site_secret__', '36780713d363a0a0c771ea30571b4659'),
('filestore_run_once', '1265306714'),
('plugin_run_once', '1265306714'),
('widget_run_once', '1265306714'),
('installed', '1265306739'),
('path', 'C:/xampp/htdocs/ldshake/'),
('dataroot', 'E:/generic-data/'),
('default_site', '1'),
('admin_registered', '1');

-- --------------------------------------------------------

--
-- Table structure for table `entities`
--

CREATE TABLE IF NOT EXISTS `entities` (
  `guid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('object','user','group','site') NOT NULL,
  `subtype` int(11) DEFAULT NULL,
  `owner_guid` bigint(20) unsigned NOT NULL,
  `site_guid` bigint(20) unsigned NOT NULL,
  `container_guid` bigint(20) unsigned NOT NULL,
  `access_id` int(11) NOT NULL,
  `time_created` int(11) NOT NULL,
  `time_updated` int(11) NOT NULL,
  `enabled` enum('yes','no') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`guid`),
  KEY `type` (`type`),
  KEY `subtype` (`subtype`),
  KEY `owner_guid` (`owner_guid`),
  KEY `site_guid` (`site_guid`),
  KEY `container_guid` (`container_guid`),
  KEY `access_id` (`access_id`),
  KEY `time_created` (`time_created`),
  KEY `time_updated` (`time_updated`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=637 ;

--
-- Dumping data for table `entities`
--

INSERT INTO `entities` (`guid`, `type`, `subtype`, `owner_guid`, `site_guid`, `container_guid`, `access_id`, `time_created`, `time_updated`, `enabled`) VALUES
(1, 'site', 0, 0, 0, 0, 2, 1265306739, 1286979047, 'yes'),
(2, 'user', 0, 0, 1, 0, 2, 1265306770, 1359526211, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `entity_relationships`
--

CREATE TABLE IF NOT EXISTS `entity_relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid_one` bigint(20) unsigned NOT NULL,
  `relationship` varchar(50) NOT NULL,
  `guid_two` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid_one` (`guid_one`,`relationship`,`guid_two`),
  KEY `relationship` (`relationship`),
  KEY `guid_two` (`guid_two`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `entity_subtypes`
--

CREATE TABLE IF NOT EXISTS `entity_subtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('object','user','group','site') NOT NULL,
  `subtype` varchar(50) NOT NULL,
  `class` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`subtype`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `entity_subtypes`
--

INSERT INTO `entity_subtypes` (`id`, `type`, `subtype`, `class`) VALUES
(1, 'object', 'file', 'ElggFile'),
(2, 'object', 'plugin', 'ElggPlugin'),
(3, 'object', 'widget', 'ElggWidget'),
(4, 'object', 'page_top', ''),
(5, 'object', 'page', ''),
(6, 'object', 'stores', ''),
(7, 'object', 'cart', ''),
(8, 'object', 'cart_item', ''),
(9, 'object', 'address', ''),
(10, 'object', 'order', ''),
(11, 'object', 'order_item', ''),
(12, 'object', 'transaction', ''),
(13, 'object', 'modpiwik', ''),
(14, 'object', 'pages_welcome', ''),
(15, 'object', 'blog', ''),
(16, 'object', 'messages', ''),
(17, 'object', 'wizardUoL_template', ''),
(18, 'object', 'wizardUoL_lds', ''),
(19, 'object', 'api_key', ''),
(20, 'object', 'ad', ''),
(21, 'object', 'LdS', ''),
(22, 'object', 'LdS_document', ''),
(23, 'object', 'LdS_document_revision', ''),
(24, 'object', 'lds_uploaded_file', '');

-- --------------------------------------------------------

--
-- Table structure for table `geocode_cache`
--

CREATE TABLE IF NOT EXISTS `geocode_cache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(128) DEFAULT NULL,
  `lat` varchar(20) DEFAULT NULL,
  `long` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location` (`location`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups_entity`
--

CREATE TABLE IF NOT EXISTS `groups_entity` (
  `guid` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`guid`),
  FULLTEXT KEY `name` (`name`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hmac_cache`
--

CREATE TABLE IF NOT EXISTS `hmac_cache` (
  `hmac` varchar(255) NOT NULL,
  `ts` int(11) NOT NULL,
  PRIMARY KEY (`hmac`),
  KEY `ts` (`ts`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metadata`
--

CREATE TABLE IF NOT EXISTS `metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_guid` bigint(20) unsigned NOT NULL,
  `name_id` int(11) NOT NULL,
  `value_id` int(11) NOT NULL,
  `value_type` enum('integer','text') NOT NULL,
  `owner_guid` bigint(20) unsigned NOT NULL,
  `access_id` int(11) NOT NULL,
  `time_created` int(11) NOT NULL,
  `enabled` enum('yes','no') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`),
  KEY `entity_guid` (`entity_guid`),
  KEY `name_id` (`name_id`),
  KEY `value_id` (`value_id`),
  KEY `owner_guid` (`owner_guid`),
  KEY `access_id` (`access_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24907 ;

--
-- Dumping data for table `metadata`
--

INSERT INTO `metadata` (`id`, `entity_guid`, `name_id`, `value_id`, `value_type`, `owner_guid`, `access_id`, `time_created`, `enabled`) VALUES
(1, 1, 1, 478, 'text', 2, 2, 1265306739, 'yes'),
(23, 2, 10, 11, 'text', 2, 2, 1265306770, 'yes'),
(24, 2, 12, 11, 'text', 2, 2, 1265306770, 'yes'),
(25, 2, 13, 11, 'text', 0, 2, 1265306770, 'yes'),
(26, 2, 14, 14, 'text', 0, 2, 1265306770, 'yes'),
(27, 1, 15, 2008, 'text', 2, 2, 1265307023, 'yes'),
(3128, 1, 3, 525, 'text', 100, 2, 1289407209, 'yes'),
(3127, 1, 3, 517, 'text', 100, 2, 1289407209, 'yes'),
(3126, 1, 3, 20, 'text', 100, 2, 1289407209, 'yes'),
(3125, 1, 3, 466, 'text', 100, 2, 1289407209, 'yes'),
(3124, 1, 3, 35, 'text', 100, 2, 1289407209, 'yes'),
(3123, 1, 3, 474, 'text', 100, 2, 1289407209, 'yes'),
(3122, 1, 3, 33, 'text', 100, 2, 1289407209, 'yes'),
(3121, 1, 3, 31, 'text', 100, 2, 1289407209, 'yes'),
(3120, 1, 3, 29, 'text', 100, 2, 1289407209, 'yes'),
(3119, 1, 3, 27, 'text', 100, 2, 1289407209, 'yes'),
(3118, 1, 3, 25, 'text', 100, 2, 1289407209, 'yes'),
(3117, 1, 3, 23, 'text', 100, 2, 1289407209, 'yes'),
(3116, 1, 3, 17, 'text', 100, 2, 1289407209, 'yes'),
(3115, 1, 3, 8, 'text', 100, 2, 1289407209, 'yes'),
(3114, 1, 3, 6, 'text', 100, 2, 1289407209, 'yes'),
(3113, 1, 3, 4, 'text', 100, 2, 1289407209, 'yes'),
(3112, 1, 3, 5, 'text', 100, 2, 1289407209, 'yes'),
(3111, 1, 3, 7, 'text', 100, 2, 1289407209, 'yes'),
(3110, 1, 3, 9, 'text', 100, 2, 1289407209, 'yes'),
(3109, 1, 3, 18, 'text', 100, 2, 1289407209, 'yes'),
(3108, 1, 3, 22, 'text', 100, 2, 1289407209, 'yes'),
(554, 2, 67, 1, 'text', 0, 2, 1265361184, 'yes'),
(3107, 1, 3, 24, 'text', 100, 2, 1289407209, 'yes'),
(3106, 1, 3, 26, 'text', 100, 2, 1289407209, 'yes'),
(3105, 1, 3, 30, 'text', 100, 2, 1289407209, 'yes'),
(3104, 1, 3, 32, 'text', 100, 2, 1289407209, 'yes'),
(3103, 1, 3, 56, 'text', 100, 2, 1289407209, 'yes'),
(3102, 1, 3, 74, 'text', 100, 2, 1289407208, 'yes'),
(2489, 1, 466, 471, 'text', 2, 2, 1285147066, 'yes'),
(3101, 1, 3, 124, 'text', 100, 2, 1289407208, 'yes'),
(3100, 1, 3, 472, 'text', 100, 2, 1289407208, 'yes'),
(3099, 1, 3, 341, 'text', 100, 2, 1289407208, 'yes'),
(3098, 1, 3, 464, 'text', 100, 2, 1289407208, 'yes'),
(3097, 1, 3, 526, 'text', 100, 2, 1289407208, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `metastrings`
--

CREATE TABLE IF NOT EXISTS `metastrings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `string` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `string` (`string`(50))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2009 ;

--
-- Dumping data for table `metastrings`
--

INSERT INTO `metastrings` (`id`, `string`) VALUES
(1, 'email'),
(3, 'enabled_plugins'),
(4, 'profile'),
(5, 'river'),
(6, 'updateclient'),
(7, 'logbrowser'),
(8, 'diagnostics'),
(9, 'uservalidationbyemail'),
(10, 'admin'),
(11, '1'),
(12, 'notification:method:email'),
(13, 'validated'),
(14, '0'),
(15, 'pluginorder'),
(17, 'about'),
(18, 'apiadmin'),
(20, 'blog'),
(22, 'friends'),
(23, 'help'),
(24, 'messageboard'),
(25, 'metatag_manager'),
(26, 'photo_cumulus'),
(27, 'role'),
(29, 'pages'),
(30, 'messages'),
(31, 'tagcloud'),
(32, 'tag_cumulus'),
(33, 'walltowall'),
(35, 'wholeworldfriends'),
(56, 'status'),
(67, 'validated_method'),
(74, 'phpmailer'),
(124, 'contacts'),
(341, 'wizardUoL'),
(464, 'ad'),
(466, 'adcategories'),
(471, 'categryad'),
(472, 'socialcommerce'),
(474, 'market'),
(478, 'ldshake@gmail.com'),
(517, 'topbar_ldshake'),
(525, 'lds'),
(526, 'debug'),
(527, 'a:47:{i:10;s:5:"debug";i:20;s:5:"about";i:30;s:8:"apiadmin";i:40;s:12:"autocomplete";i:50;s:4:"blog";i:60;s:9:"bookmarks";i:70;s:8:"CKEditor";i:80;s:11:"diagnostics";i:90;s:9:"fckeditor";i:100;s:4:"file";i:110;s:7:"friends";i:120;s:16:"garbagecollector";i:130;s:6:"groups";i:140;s:8:"guidtool";i:150;s:4:"help";i:160;s:10:"logbrowser";i:170;s:9:"logrotate";i:180;s:12:"messageboard";i:190;s:8:"messages";i:200;s:15:"metatag_manager";i:210;s:5:"pages";i:220;s:13:"photo_cumulus";i:230;s:7:"profile";i:240;s:15:"reportedcontent";i:250;s:5:"river";i:260;s:4:"role";i:270;s:13:"scroll_on_top";i:280;s:6:"status";i:290;s:6:"stores";i:300;s:8:"tagcloud";i:310;s:11:"tag_cumulus";i:320;s:7:"tinymce";i:330;s:21:"uservalidationbyemail";i:340;s:10:"walltowall";i:350;s:25:"webgall_adsense_analytics";i:360;s:9:"zextender";i:370;s:5:"piwik";i:380;s:9:"analytics";i:390;s:10:"custom_reg";i:400;s:9:"uncaptcha";i:410;s:10:"embedvideo";i:420;s:9:"phpmailer";i:430;s:8:"contacts";i:440;s:17:"wholeworldfriends";i:450;s:9:"wizardUoL";i:460;s:14:"topbar_ldshake";i:470;s:3:"lds";}'),
(2008, 'a:23:{i:10;s:5:"debug";i:20;s:5:"about";i:30;s:12:"autocomplete";i:40;s:11:"diagnostics";i:50;s:7:"friends";i:60;s:16:"garbagecollector";i:70;s:6:"groups";i:80;s:10:"logbrowser";i:90;s:9:"logrotate";i:100;s:12:"messageboard";i:110;s:8:"messages";i:120;s:15:"metatag_manager";i:130;s:7:"profile";i:140;s:5:"river";i:150;s:4:"role";i:160;s:21:"uservalidationbyemail";i:170;s:9:"phpmailer";i:180;s:8:"contacts";i:190;s:17:"wholeworldfriends";i:200;s:14:"topbar_ldshake";i:210;s:3:"lds";i:220;s:9:"ldshakers";i:230;s:3:"t9n";}');

-- --------------------------------------------------------

--
-- Table structure for table `objects_entity`
--

CREATE TABLE IF NOT EXISTS `objects_entity` (
  `guid` bigint(20) unsigned NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`guid`),
  FULLTEXT KEY `title` (`title`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `private_settings`
--

CREATE TABLE IF NOT EXISTS `private_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_guid` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entity_guid` (`entity_guid`,`name`),
  KEY `name` (`name`),
  KEY `value` (`value`(50))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- Dumping data for table `private_settings`
--

INSERT INTO `private_settings` (`id`, `entity_guid`, `name`, `value`) VALUES
(1, 3, 'handler', 'tagcloud'),
(2, 3, 'context', 'dashboard'),
(3, 3, 'column', '2'),
(4, 3, 'order', '10'),
(5, 3, 'notags', '100'),
(6, 8, 'analytics', 'UA-12842204-1'),
(8, 10, 'analyticsEnabled', 'yes'),
(9, 10, 'analyticsSiteID', 'UA-12842204-1'),
(10, 10, 'analyticsSubDomainTraking', 'no'),
(11, 10, 'analyticsDomain', 'ldshake.upf.edu/ldshake'),
(12, 11, 'trick_field_name', 'email_address'),
(7, 8, 'spotlight', ''),
(13, 11, 'instant_validate', '0'),
(14, 11, 'instant_enable', '0'),
(15, 11, 'login_after', '0'),
(16, 11, 'register_success_forward', ''),
(17, 12, 'phpmailer_override', 'enabled'),
(18, 12, 'phpmailer_smtp', '1'),
(19, 12, 'phpmailer_host', 'webmail.doblevia.coop'),
(20, 12, 'phpmailer_smtp_auth', '1'),
(21, 12, 'phpmailer_username', 'miguelc@doblevia.coop'),
(22, 12, 'phpmailer_password', '000miguelon'),
(23, 12, 'nonstd_mta', '0'),
(24, 13, 'videowidth', '284'),
(25, 13, 'front_url', 'http://www.youtube.com/watch?v=jdutFKel6tc'),
(26, 13, 'front_width', '400'),
(27, 27, 'handler', 'messageboard'),
(28, 27, 'context', 'profile'),
(29, 27, 'column', '1'),
(30, 27, 'order', '10'),
(31, 28, 'handler', 'tagcloud'),
(32, 28, 'context', 'profile'),
(33, 28, 'column', '2'),
(34, 28, 'order', '10'),
(35, 29, 'handler', 'status'),
(36, 29, 'context', 'profile'),
(37, 29, 'column', '3'),
(38, 29, 'order', '10');

-- --------------------------------------------------------

--
-- Table structure for table `sites_entity`
--

CREATE TABLE IF NOT EXISTS `sites_entity` (
  `guid` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`guid`),
  UNIQUE KEY `url` (`url`),
  FULLTEXT KEY `name` (`name`,`description`,`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sites_entity`
--

INSERT INTO `sites_entity` (`guid`, `name`, `description`, `url`) VALUES
(1, 'LdShake, Learning Design Solutions', 'Learning Design Solutions to share and coedit', 'http://193.145.50.231/ldshake/');

-- --------------------------------------------------------

--
-- Table structure for table `system_log`
--

CREATE TABLE IF NOT EXISTS `system_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL,
  `object_class` varchar(50) NOT NULL,
  `object_type` varchar(50) NOT NULL,
  `object_subtype` varchar(50) NOT NULL,
  `event` varchar(50) NOT NULL,
  `performed_by_guid` int(11) NOT NULL,
  `owner_guid` int(11) NOT NULL,
  `access_id` int(11) NOT NULL,
  `enabled` enum('yes','no') NOT NULL DEFAULT 'yes',
  `time_created` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_id` (`object_id`),
  KEY `object_class` (`object_class`),
  KEY `object_type` (`object_type`),
  KEY `object_subtype` (`object_subtype`),
  KEY `event` (`event`),
  KEY `performed_by_guid` (`performed_by_guid`),
  KEY `access_id` (`access_id`),
  KEY `time_created` (`time_created`),
  KEY `river_key` (`object_type`,`object_subtype`,`event`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `system_log`
--

INSERT INTO `system_log` (`id`, `object_id`, `object_class`, `object_type`, `object_subtype`, `event`, `performed_by_guid`, `owner_guid`, `access_id`, `enabled`, `time_created`) VALUES
(1, 2, 'ElggUser', 'user', '', 'update', 2, 0, 2, 'yes', 1359525818),
(2, 2, 'ElggUser', 'user', '', 'update', 2, 0, 2, 'yes', 1359525818),
(3, 2, 'ElggUser', 'user', '', 'login', 2, 0, 2, 'yes', 1359525818),
(4, 27, 'ElggMetadata', 'metadata', 'pluginorder', 'update', 2, 0, 2, 'yes', 1359526087),
(5, 2, 'ElggUser', 'user', '', 'logout', 2, 0, 2, 'yes', 1359526211),
(6, 2, 'ElggUser', 'user', '', 'update', 2, 0, 2, 'yes', 1359526211),
(7, 2, 'ElggUser', 'user', '', 'update', 2, 0, 2, 'yes', 1359526211);

-- --------------------------------------------------------

--
-- Table structure for table `users_apisessions`
--

CREATE TABLE IF NOT EXISTS `users_apisessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_guid` bigint(20) unsigned NOT NULL,
  `site_guid` bigint(20) unsigned NOT NULL,
  `token` varchar(40) DEFAULT NULL,
  `expires` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_guid` (`user_guid`,`site_guid`),
  KEY `token` (`token`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users_entity`
--

CREATE TABLE IF NOT EXISTS `users_entity` (
  `guid` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `username` varchar(128) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `salt` varchar(8) NOT NULL DEFAULT '',
  `email` text NOT NULL,
  `language` varchar(6) NOT NULL DEFAULT '',
  `code` varchar(32) NOT NULL DEFAULT '',
  `last_action` int(11) NOT NULL DEFAULT '0',
  `prev_last_action` int(11) NOT NULL DEFAULT '0',
  `last_login` int(11) NOT NULL DEFAULT '0',
  `prev_last_login` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  UNIQUE KEY `username` (`username`),
  KEY `password` (`password`),
  KEY `email` (`email`(50)),
  KEY `code` (`code`),
  FULLTEXT KEY `name` (`name`),
  FULLTEXT KEY `name_2` (`name`,`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_entity`
--

INSERT INTO `users_entity` (`guid`, `name`, `username`, `password`, `salt`, `email`, `language`, `code`, `last_action`, `prev_last_action`, `last_login`, `prev_last_login`) VALUES
(2, 'Administrator', 'admin', 'c155b8103474ab10e13282f72ae2c61a', 'c5955f8e', 'admin@example.com', '', '', 1359526211, 1359526211, 1359525818, 1297418937);

-- --------------------------------------------------------

--
-- Table structure for table `users_sessions`
--

CREATE TABLE IF NOT EXISTS `users_sessions` (
  `session` varchar(255) NOT NULL,
  `ts` int(11) unsigned NOT NULL DEFAULT '0',
  `data` mediumblob,
  PRIMARY KEY (`session`),
  KEY `ts` (`ts`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_sessions`
--

INSERT INTO `users_sessions` (`session`, `ts`, `data`) VALUES
('3e0sd0qq4def0gae7vsmas4630', 1297354523, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a226561626636373139643262353635343466313764333337663630643138336464223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('jcbo2aaad9knasfpscgb11nqr2', 1297354753, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a223635373638303332356131353666376165646334336638626330373663636132223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('2c693v1o3908seehn12tnrg9t5', 1297354763, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a223162613838333936663766363739363066323162666164656561663038626430223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('h7a9cfhag7iputhki07b1or755', 1297354872, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a226639393963623036646564346339393237396233323131663665613035356132223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('s0e5rojhmmd7hc8sbcpb4mufj7', 1297354929, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a223132313865373039623039376364663238633735666364333737363237383534223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('gih9s3qsi51bf7gim5ggj59d04', 1297354994, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a223332353562666561626630313264643632663761313339313333653032313138223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('d193fgjj575ehhh71tnocjua46', 1297355007, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a226166636235393838386135646135613565633065663963313465383934393032223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('3q7lcpq9lr2p95ejcapcfap057', 1297355248, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a226166636235393838386135646135613565633065663963313465383934393032223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d757365727c4f3a383a22456c676755736572223a363a7b733a31333a22002a0061747472696275746573223b613a32333a7b733a343a2267756964223b733a313a2232223b733a343a2274797065223b733a343a2275736572223b733a373a2273756274797065223b733a313a2230223b733a31303a226f776e65725f67756964223b733a313a2230223b733a31343a22636f6e7461696e65725f67756964223b733a313a2230223b733a393a22736974655f67756964223b733a313a2231223b733a393a226163636573735f6964223b733a313a2232223b733a31323a2274696d655f63726561746564223b733a31303a2231323635333036373730223b733a31323a2274696d655f75706461746564223b733a31303a2231323937333535303535223b733a373a22656e61626c6564223b733a333a22796573223b733a31323a227461626c65735f73706c6974223b693a323b733a31333a227461626c65735f6c6f61646564223b693a323b733a343a226e616d65223b733a31333a2241646d696e6973747261746f72223b733a383a22757365726e616d65223b733a353a2261646d696e223b733a383a2270617373776f7264223b733a33323a226331353562383130333437346162313065313332383266373261653263363161223b733a343a2273616c74223b733a383a226335393535663865223b733a353a22656d61696c223b733a31373a2261646d696e406578616d706c652e636f6d223b733a383a226c616e6775616765223b733a303a22223b733a343a22636f6465223b733a33323a223532656232353863363832623363376330343266363437373134313662623634223b733a31313a226c6173745f616374696f6e223b733a31303a2231323937333535323437223b733a31363a22707265765f6c6173745f616374696f6e223b733a31303a2231323937333535323436223b733a31303a226c6173745f6c6f67696e223b733a31303a2231323937333535303535223b733a31353a22707265765f6c6173745f6c6f67696e223b733a31303a2231323937333534393939223b7d733a31353a22002a0075726c5f6f76657272696465223b4e3b733a31363a22002a0069636f6e5f6f76657272696465223b4e3b733a31363a22002a0074656d705f6d65746164617461223b613a303a7b7d733a31393a22002a0074656d705f616e6e6f746174696f6e73223b613a303a7b7d733a31373a2200456c6767456e746974790076616c6964223b623a303b7d677569647c733a313a2232223b69647c733a313a2232223b757365726e616d657c733a353a2261646d696e223b6e616d657c733a31333a2241646d696e6973747261746f72223b636f64657c733a33323a226539336161386664646436376234626138313464396132356539376131373931223b),
('8vgoc7e16cpb0nlu96p5qof1d3', 1297418045, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a223261373962636530643339393866636336613833343964363162313333643833223b6d73677c613a303a7b7d766965777c733a373a2264656661756c74223b),
('24o0jukacupla5v7l3d7fon361', 1297418057, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a223833643730363566346536623634313466393663306231363031616434323061223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('ui4ti97jh01irolsibj8dfpu26', 1297418352, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a226138623165656564643435333164363134373637326433376433623466653336223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('mqd33nteoc8g2tej94tvdt1vj2', 1297418998, 0x5f5f656c67675f66696e6765727072696e747c733a33323a226436333533623131643461363036316661653130623431373632623138653039223b5f5f656c67675f73657373696f6e7c733a33323a223963636461656138323431316664376537656332353530613065363336646563223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('g1ge3igf71o6egfttesrhfos05', 1359525811, 0x5f5f656c67675f66696e6765727072696e747c733a33323a223039326464373137376133316335333339336339373235323861383234363630223b5f5f656c67675f73657373696f6e7c733a33323a223965623737336135316433353736633133653463653433323736393037613931223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d),
('f42lifn1tjdr7c6g8ivifi0190', 1359526211, 0x5f5f656c67675f66696e6765727072696e747c733a33323a223039326464373137376133316335333339336339373235323861383234363630223b5f5f656c67675f73657373696f6e7c733a33323a223233373264616366663234393366346464333465333666393035363536376333223b766965777c733a373a2264656661756c74223b6d73677c613a303a7b7d);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
