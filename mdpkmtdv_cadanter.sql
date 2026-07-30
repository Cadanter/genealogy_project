-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 26, 2026 at 02:25 PM
-- Server version: 8.0.39
-- PHP Version: 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mdpkmtdv_cadanter`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 3, 'add_permission'),
(6, 'Can change permission', 3, 'change_permission'),
(7, 'Can delete permission', 3, 'delete_permission'),
(8, 'Can view permission', 3, 'view_permission'),
(9, 'Can add group', 2, 'add_group'),
(10, 'Can change group', 2, 'change_group'),
(11, 'Can delete group', 2, 'delete_group'),
(12, 'Can view group', 2, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add category', 7, 'add_category'),
(26, 'Can change category', 7, 'change_category'),
(27, 'Can delete category', 7, 'delete_category'),
(28, 'Can view category', 7, 'view_category'),
(29, 'Can add tag', 10, 'add_tag'),
(30, 'Can change tag', 10, 'change_tag'),
(31, 'Can delete tag', 10, 'delete_tag'),
(32, 'Can view tag', 10, 'view_tag'),
(33, 'Can add post', 9, 'add_post'),
(34, 'Can change post', 9, 'change_post'),
(35, 'Can delete post', 9, 'delete_post'),
(36, 'Can view post', 9, 'view_post'),
(37, 'Can add comment', 8, 'add_comment'),
(38, 'Can change comment', 8, 'change_comment'),
(39, 'Can delete comment', 8, 'delete_comment'),
(40, 'Can view comment', 8, 'view_comment'),
(41, 'Can add person', 16, 'add_person'),
(42, 'Can change person', 16, 'change_person'),
(43, 'Can delete person', 16, 'delete_person'),
(44, 'Can view person', 16, 'view_person'),
(45, 'Can add user profile', 18, 'add_userprofile'),
(46, 'Can change user profile', 18, 'change_userprofile'),
(47, 'Can delete user profile', 18, 'delete_userprofile'),
(48, 'Can view user profile', 18, 'view_userprofile'),
(49, 'Can add marriage', 14, 'add_marriage'),
(50, 'Can change marriage', 14, 'change_marriage'),
(51, 'Can delete marriage', 14, 'delete_marriage'),
(52, 'Can view marriage', 14, 'view_marriage'),
(53, 'Can add relationship', 17, 'add_relationship'),
(54, 'Can change relationship', 17, 'change_relationship'),
(55, 'Can delete relationship', 17, 'delete_relationship'),
(56, 'Can view relationship', 17, 'view_relationship'),
(57, 'Can add event', 13, 'add_event'),
(58, 'Can change event', 13, 'change_event'),
(59, 'Can delete event', 13, 'delete_event'),
(60, 'Can view event', 13, 'view_event'),
(61, 'Can add document', 12, 'add_document'),
(62, 'Can change document', 12, 'change_document'),
(63, 'Can delete document', 12, 'delete_document'),
(64, 'Can view document', 12, 'view_document'),
(65, 'Can add audit log', 11, 'add_auditlog'),
(66, 'Can change audit log', 11, 'change_auditlog'),
(67, 'Can delete audit log', 11, 'delete_auditlog'),
(68, 'Can view audit log', 11, 'view_auditlog'),
(69, 'Can add pending edit', 15, 'add_pendingedit'),
(70, 'Can change pending edit', 15, 'change_pendingedit'),
(71, 'Can delete pending edit', 15, 'delete_pendingedit'),
(72, 'Can view pending edit', 15, 'view_pendingedit');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1200000$Ycf9q1acV1bKHwgFBrxqzo$Yio1a8AZUeREdY2ApcvT6DihT1RUslBHTZz3Nd95Kos=', '2026-07-21 15:25:23.131921', 1, 'Cadanter', 'Danie', 'van Eeden', 'cadanter@gmail.com', 1, 1, '2026-07-08 09:52:40.000000'),
(3, 'pbkdf2_sha256$1200000$T7jxjoZuNrSWitWsl5Ar2y$WwrNI+0Omyb3ffezaQFmM00AV7ueivgONsuO5u1YC0Y=', '2026-07-20 16:20:18.003017', 0, 'JeanetteLindeque', 'Jeanette', 'Lindeque', 'jeanettelindeque@gmail.com', 0, 1, '2026-07-20 16:20:16.740749');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user_user_permissions`
--

INSERT INTO `auth_user_user_permissions` (`id`, `user_id`, `permission_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 15),
(16, 1, 16),
(17, 1, 17),
(18, 1, 18),
(19, 1, 19),
(20, 1, 20),
(21, 1, 21),
(22, 1, 22),
(23, 1, 23),
(24, 1, 24),
(25, 1, 25),
(26, 1, 26),
(27, 1, 27),
(28, 1, 28),
(29, 1, 29),
(30, 1, 30),
(31, 1, 31),
(32, 1, 32),
(33, 1, 33),
(34, 1, 34),
(35, 1, 35),
(36, 1, 36),
(37, 1, 37),
(38, 1, 38),
(39, 1, 39),
(40, 1, 40),
(41, 1, 41),
(42, 1, 42),
(43, 1, 43),
(44, 1, 44),
(45, 1, 45),
(46, 1, 46),
(47, 1, 47),
(48, 1, 48),
(49, 1, 49),
(50, 1, 50),
(51, 1, 51),
(52, 1, 52),
(53, 1, 53),
(54, 1, 54),
(55, 1, 55),
(56, 1, 56),
(57, 1, 57),
(58, 1, 58),
(59, 1, 59),
(60, 1, 60),
(61, 1, 61),
(62, 1, 62),
(63, 1, 63),
(64, 1, 64),
(65, 1, 65),
(66, 1, 66),
(67, 1, 67),
(68, 1, 68),
(69, 1, 69),
(70, 1, 70),
(71, 1, 71),
(72, 1, 72);

-- --------------------------------------------------------

--
-- Table structure for table `blog_category`
--

CREATE TABLE `blog_category` (
  `id` bigint NOT NULL,
  `name` varchar(80) NOT NULL,
  `name_af` varchar(80) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `blog_category`
--

INSERT INTO `blog_category` (`id`, `name`, `name_af`, `slug`, `description`) VALUES
(1, 'Family', 'Familie', 'family', 'Stories, ontdekkings en gedagtes t.o.v. familie geskiedenis.\r\nStories, discoveries and reflections on family history.'),
(2, 'History', 'Geskiedenis', 'history', 'Afrikaans en Duitse/Hollandse historiese konteks.\r\nAfrican and Dutch/German historical context'),
(3, 'Archive', 'Argief', 'archive', 'Die opstelling van ons familie register.\r\nThe creating of oour family archive.'),
(4, 'Technology', 'Tegnologie', 'technology', 'Skryf oor sagteware, hulpmiddels en die digitale wêreld\r\nWriting about software, tools and the digital world'),
(5, 'Reflections', 'Gedagtes', 'reflections', 'Persoonlike opstelle en waarnemings.\r\nPersonal essays and observations.');

-- --------------------------------------------------------

--
-- Table structure for table `blog_comment`
--

CREATE TABLE `blog_comment` (
  `id` bigint NOT NULL,
  `author_name` varchar(100) NOT NULL,
  `author_email` varchar(254) NOT NULL,
  `body` longtext NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `post_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_post`
--

CREATE TABLE `blog_post` (
  `id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `title_af` varchar(200) NOT NULL,
  `slug` varchar(220) NOT NULL,
  `body` longtext NOT NULL,
  `body_af` longtext NOT NULL,
  `excerpt` longtext NOT NULL,
  `excerpt_af` longtext NOT NULL,
  `cover_image` varchar(100) DEFAULT NULL,
  `language` varchar(4) NOT NULL,
  `status` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `category_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `blog_post`
--

INSERT INTO `blog_post` (`id`, `title`, `title_af`, `slug`, `body`, `body_af`, `excerpt`, `excerpt_af`, `cover_image`, `language`, `status`, `created_at`, `updated_at`, `published_at`, `author_id`, `category_id`) VALUES
(7, 'Plasing van GEDCOM Datums', 'Plasing van GEDCOM Datums', 'gedcom-date-entry', 'Tydens die skepping van ons familie se webtuiste moes ek besluit het om of \'n unieke stelsel te bou of \'n stelsel volgens die internasionale standaarde.\r\n\r\nDie tweede opsie is toe gekies sodat data gedeel kan word op ander stelsels beskikbaar op die internet.  Dit het dan die gevolg gehad dat die invoer van datums moet verander en nie net \'n datum in te lees op die algemene datum formate nie.\r\n\r\nGEDCOM maak dit moontlik om datums te stoor volgens die inligting beskikbaar met behulp van die PRESIES, VOOR(BEF), NA(AFT), ONGEVEER(EST), TUSSEN(BET) en ONBEKEND(UNK) keuses.  Dit beteken dat onvolledige datums soos net die jaar of maand en jaar ingelees kan word sonder dat dit die stelsel sal breek, en sodoende nog die regte berekenings kan doen.', 'Tydens die skepping van ons familie se webtuiste moes ek besluit het om of \'n unieke stelsel te bou of \'n stelsel volgens die internasionale standaarde.\r\n\r\nDie tweede opsie is toe gekies sodat data gedeel kan word op ander stelsels beskikbaar op die internet.  Dit het dan die gevolg gehad dat die invoer van datums moet verander en nie net \'n datum in te lees op die algemene datum formate nie.\r\n\r\nGEDCOM maak dit moontlik om datums te stoor volgens die inligting beskikbaar met behulp van die PRESIES, VOOR(BEF), NA(AFT), ONGEVEER(EST), TUSSEN(BET) en ONBEKEND(UNK) keuses.  Dit beteken dat onvolledige datums soos net die jaar of maand en jaar ingelees kan word sonder dat dit die stelsel sal breek, en sodoende nog die regte berekenings kan doen.', '', '', '', 'af', 'published', '2026-07-11 10:42:33.433264', '2026-07-11 10:42:33.433302', '2026-07-11 10:23:00.000000', 1, 3),
(8, 'Van Eeden Archive Introduction', 'Bekendstelling van die Van Eeden Argief', 'van-eeden-archive-introduction', 'This website was created by me as a promise to my father, Daniel (Daan) Hendrik van Eeden, to release his book on which he worked for so many years, electronically with the aim that every van Eeden family member can add to it. It is absolutely free to all who are interested in using it.\r\n\r\nI hope everyone enjoys it.\r\n\r\nI do ask that only those who share the Eeden surname will sign up. If I then have any questions I will get in touch with the email provided.\r\n\r\nAny questions or suggestions can be directed to Danie van Eeden at info@cadanter.co.za', 'Hierdie webtuiste is deur my geskep as \'n belofte aan my vader, Daniel (Daan) Hendrik van Eeden om sy boek waaraan hy soveel jare aan gewerk het, elektronies vry te stel met die doel dat elke van Eeden familielid daarby kan aanvoeg.  Dit is absoluut gratis aan almal wat belangstel om daarvan gebruik te maak.\r\n\r\nEk hoop almal geniet dit.\r\n\r\nEk vra wel dat slegs die wat deel het aan die van Eeden van sal aanteken.  Indien ek dan enige vrae het sal ek in kontak tree met die epos wat verskaf is.\r\n\r\nEnige vrae of voorstelle kan gerig word aan Danie van Eeden by info@cadanter.co.za.', '', '', '', 'both', 'published', '2026-07-11 11:43:20.985420', '2026-07-11 11:43:20.985463', '2026-07-11 10:49:00.000000', 1, 3),
(9, 'Erfenis', 'Erfenis', 'erfenis', 'My pa het vir 48 jaar lank aan die familie register gewerk tot misnoë vir my ma en ons as kinders, want hy het elke vakansie meer tyd gespandeer om familie op te soek as om tyd met ons mee te bring.  En tog trek ons vandag die voordeel daarvan om \'n boek van ons familie te besit waarin ons ons voorsate kan eien en waarop ons kan voortbou.\r\n\r\nHy het in samewerking met Prof. Gideon de V. de Kock van die Genealogiese Navorsingsgroep te Port Elizabeth Universiteit opgestel en 300 eksemplare ( ISBN: 0-86988-791-2) gedruk waarvan 5 na ons toe gekom het.  Ek besit die sewende boek.  Die mense wat wel \'n boek kon bekom is baie gelukkig want daar gaan volgens die professor nie meer gedruk word nie.\r\n\r\nMy pa het nooit die boek gesien nie want ons het vyf van die boeke per pos ontvang op die dag van sy begrafnis.  Dit is inderdaad baie tragies.\r\n\r\nDit is ongelukkig so dat heelwat van die boeke misdrukke in het, soos ladsye wat deurmekaar en onderstebo gebind is.  Dit is vir my baie onaanvaarbaar maar ek kan niks daaromtrent doen nie.  Ek het ook my bes probeer om \'n elektroniese weergawe van die Universiteit te bekom, maar dit is geweier omrede dit hulle uitsluitlike kopiereg het.\r\n\r\nAl my pa se aantekeninge is in kratte verpak, maar met my trek vanaf Welkom na die Kaap kon ek dit nie op die trek sit nie en lê dit nog steeds in bewaring by my vorige werkgewer.  Ek hoop om dit eendag by my te kry wanneer hulle my laaste gelde uitbetaal wat hulle my nog skuld (hoop is natuurlik nie iets waarop ek kan staatmaak nie).\r\n\r\nDie enigste ander manier is om donasies te ontvang om die kostes van vervoer te dek of iemand wat dalk in die toekoms die reis gaan meemaak en die kratte kan saam vervoer.  As iemand kan help met welke metode ook al, sal ek dit opreg waardeer.\r\n\r\nSeëngroete aan al die familie.\r\n\r\nDanie', 'My pa het vir 48 jaar lank aan die familie register gewerk tot misnoë vir my ma en ons as kinders, want hy het elke vakansie meer tyd gespandeer om familie op te soek as om tyd met ons mee te bring.  En tog trek ons vandag die voordeel daarvan om \'n boek van ons familie te besit waarin ons ons voorsate kan eien en waarop ons kan voortbou.\r\n\r\nHy het in samewerking met Prof. Gideon de V. de Kock van die Genealogiese Navorsingsgroep te Port Elizabeth Universiteit opgestel en 300 eksemplare ( ISBN: 0-86988-791-2) gedruk waarvan 5 na ons toe gekom het.  Ek besit die sewende boek.  Die mense wat wel \'n boek kon bekom is baie gelukkig want daar gaan volgens die professor nie meer gedruk word nie.\r\n\r\nMy pa het nooit die boek gesien nie want ons het vyf van die boeke per pos ontvang op die dag van sy begrafnis.  Dit is inderdaad baie tragies.\r\n\r\nDit is ongelukkig so dat heelwat van die boeke misdrukke in het, soos ladsye wat deurmekaar en onderstebo gebind is.  Dit is vir my baie onaanvaarbaar maar ek kan niks daaromtrent doen nie.  Ek het ook my bes probeer om \'n elektroniese weergawe van die Universiteit te bekom, maar dit is geweier omrede dit hulle uitsluitlike kopiereg het.\r\n\r\nAl my pa se aantekeninge is in kratte verpak, maar met my trek vanaf Welkom na die Kaap kon ek dit nie op die trek sit nie en lê dit nog steeds in bewaring by my vorige werkgewer.  Ek hoop om dit eendag by my te kry wanneer hulle my laaste gelde uitbetaal wat hulle my nog skuld (hoop is natuurlik nie iets waarop ek kan staatmaak nie).\r\n\r\nDie enigste ander manier is om donasies te ontvang om die kostes van vervoer te dek of iemand wat dalk in die toekoms die reis gaan meemaak en die kratte kan saam vervoer.  As iemand kan help met welke metode ook al, sal ek dit opreg waardeer.\r\n\r\nSeëngroete aan al die familie.\r\n\r\nDanie', '', '', '', 'af', 'published', '2026-07-21 07:53:36.440468', '2026-07-21 07:57:57.522715', '2026-07-21 07:01:00.000000', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `blog_post_tags`
--

CREATE TABLE `blog_post_tags` (
  `id` bigint NOT NULL,
  `post_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_tag`
--

CREATE TABLE `blog_tag` (
  `id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2026-07-08 12:07:02.071143', '1', 'Cadanter', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(2, '2026-07-08 12:10:11.571212', '1', 'Cadanter', 2, '[{\"changed\": {\"fields\": [\"Email address\"]}}]', 4, 1),
(3, '2026-07-08 12:12:47.608951', '1', 'Cadanter (Administrateur)', 2, '[{\"changed\": {\"fields\": [\"Role\"]}}]', 18, 1),
(4, '2026-07-11 05:59:18.126116', '1', 'Family', 1, '[{\"added\": {}}]', 7, 1),
(5, '2026-07-11 06:01:37.266023', '2', 'History', 1, '[{\"added\": {}}]', 7, 1),
(6, '2026-07-11 06:03:22.437694', '3', 'Archive', 1, '[{\"added\": {}}]', 7, 1),
(7, '2026-07-11 06:05:22.221522', '4', 'Technology', 1, '[{\"added\": {}}]', 7, 1),
(8, '2026-07-11 06:06:28.057528', '5', 'Reflections', 1, '[{\"added\": {}}]', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'group'),
(3, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'blog', 'category'),
(8, 'blog', 'comment'),
(9, 'blog', 'post'),
(10, 'blog', 'tag'),
(5, 'contenttypes', 'contenttype'),
(11, 'genealogy', 'auditlog'),
(12, 'genealogy', 'document'),
(13, 'genealogy', 'event'),
(14, 'genealogy', 'marriage'),
(15, 'genealogy', 'pendingedit'),
(16, 'genealogy', 'person'),
(17, 'genealogy', 'relationship'),
(18, 'genealogy', 'userprofile'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-07-08 09:36:23.192175'),
(2, 'auth', '0001_initial', '2026-07-08 09:36:23.824630'),
(3, 'admin', '0001_initial', '2026-07-08 09:36:23.952633'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-07-08 09:36:23.967917'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-07-08 09:36:23.976482'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-07-08 09:36:24.052235'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-07-08 09:36:24.093447'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-07-08 09:36:24.123411'),
(9, 'auth', '0004_alter_user_username_opts', '2026-07-08 09:36:24.134470'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-07-08 09:36:24.168649'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-07-08 09:36:24.170056'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-07-08 09:36:24.187279'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-07-08 09:36:24.222532'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-07-08 09:36:24.263127'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-07-08 09:36:24.289477'),
(16, 'auth', '0011_update_proxy_permissions', '2026-07-08 09:36:24.307716'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-07-08 09:36:24.358244'),
(18, 'blog', '0001_initial', '2026-07-08 09:36:24.890358'),
(19, 'blog', '0002_alter_category_id_alter_category_name_af_and_more', '2026-07-08 09:36:25.015676'),
(20, 'genealogy', '0001_initial', '2026-07-08 09:36:25.844825'),
(21, 'genealogy', '0002_alter_auditlog_id_alter_document_date_and_more', '2026-07-08 09:36:26.070316'),
(22, 'genealogy', '0003_alter_person_options_alter_auditlog_action_and_more', '2026-07-08 09:36:26.264343'),
(23, 'genealogy', '0004_alter_person_photo', '2026-07-08 09:36:26.285603'),
(24, 'genealogy', '0005_document_event', '2026-07-08 09:36:26.336154'),
(25, 'genealogy', '0006_alter_person_options_document_marriage_and_more', '2026-07-08 09:36:26.588701'),
(26, 'sessions', '0001_initial', '2026-07-08 09:36:26.610816'),
(27, 'genealogy', '0007_event_main_person', '2026-07-09 23:13:03.331673'),
(28, 'blog', '0003_alter_post_body_alter_post_title', '2026-07-11 09:59:02.090136');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('04kk2f691aoqc45alyc0y5wwrabo60wt', '.eJxVjEEOwiAQRe_C2pCBUgZcuvcMZGBQqgaS0q6Md7dNutDtf-_9twi0LiWsPc9hYnEWSpx-t0jpmesO-EH13mRqdZmnKHdFHrTLa-P8uhzu30GhXrZ6QEDlsnfaGuMtJs0GkdJoIMItg8FkB2LNTnsFSoHVSKijM6DGDYjPF6YlNkU:1wkmin:Jrh8Ubk-puWGqUJZGmucg-2V1aeQyyNWUpRs9fO2EdQ', '2026-07-31 17:51:37.601372'),
('qt3ed1p06nxr08743b5mlw72ma1sqhh6', '.eJxVjEEOwiAQRe_C2pCBUgZcuvcMZGBQqgaS0q6Md7dNutDtf-_9twi0LiWsPc9hYnEWSpx-t0jpmesO-EH13mRqdZmnKHdFHrTLa-P8uhzu30GhXrZ6QEDlsnfaGuMtJs0GkdJoIMItg8FkB2LNTnsFSoHVSKijM6DGDYjPF6YlNkU:1wmCLT:nhU29KEX_fKjK9OIYXExUUppC4yhSqtLliLyAyk4Y64', '2026-08-04 15:25:23.134942'),
('wtmwg607o8n33uj2czux9td26fjb7syz', '.eJxVjEEOwiAQRe_C2hBsoQMu3fcMZIYZpGpoUtqV8e7apAvd_vfef6mI21ri1mSJE6uL6tXpdyNMD6k74DvW26zTXNdlIr0r-qBNjzPL83q4fwcFW_nWDrI5kw8ggwRCAzl5CD6xwcEyBOCMRIa99NnnzpLtkCwbJ94Ei069P_mmOHo:1wlqj4:6MeZnjmTuqPamFSAf0k2pEoqHyeuYsKhBca5A8WZrK0', '2026-08-03 16:20:18.005450'),
('ypc130bmpr94rrhpp7zwl46w6164ufl0', '.eJxVjEEOwiAQRe_C2pCBUgZcuvcMZGBQqgaS0q6Md7dNutDtf-_9twi0LiWsPc9hYnEWSpx-t0jpmesO-EH13mRqdZmnKHdFHrTLa-P8uhzu30GhXrZ6QEDlsnfaGuMtJs0GkdJoIMItg8FkB2LNTnsFSoHVSKijM6DGDYjPF6YlNkU:1wlrJ5:e_QW-p_MrzMRdIoCmV1y6lmUBE6fL-KMiBOaji9C12k', '2026-08-03 16:57:31.002993');

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_auditlog`
--

CREATE TABLE `genealogy_auditlog` (
  `id` bigint NOT NULL,
  `action` varchar(10) NOT NULL,
  `model_name` varchar(50) NOT NULL,
  `object_id` int DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `changes` json NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `note` longtext NOT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_auditlog`
--

INSERT INTO `genealogy_auditlog` (`id`, `action`, `model_name`, `object_id`, `object_repr`, `changes`, `timestamp`, `note`, `user_id`) VALUES
(729, 'update', 'Person', 12, 'Jan Dirk van Eeden', '{\"last_name\": [\"vanEeden\", \"van Eeden\"]}', '2026-07-21 06:43:10.837161', '', 1),
(730, 'update', 'Person', 13, 'Petronella van Eeden', '{\"last_name\": [\"vanEeden\", \"van Eeden\"]}', '2026-07-21 06:43:46.444318', '', 1),
(731, 'update', 'Person', 14, 'Frederik van Eeden', '{\"last_name\": [\"vanEeden\", \"van Eeden\"]}', '2026-07-21 06:44:27.340794', '', 1),
(732, 'update', 'Person', 15, 'Maria van Eeden', '{\"last_name\": [\"vanEeden\", \"van Eeden\"]}', '2026-07-21 06:45:00.296936', '', 1),
(733, 'update', 'Person', 15, 'Maria van Eeden', '{\"is_deceased\": [false, true]}', '2026-07-21 11:40:52.649834', '', 1),
(734, 'update', 'Person', 209, 'Jacomina Potgieter', '{\"is_deceased\": [false, true]}', '2026-07-21 11:43:36.015216', '', 1),
(735, 'update', 'Person', 204, 'Hester Magdalena Botha', '{\"is_deceased\": [false, true]}', '2026-07-21 11:44:04.600644', '', 1),
(736, 'create', 'Document', 1, 'Ria van Eeden se instte', '{}', '2026-07-21 14:03:29.794105', '', 1),
(737, 'create', 'Document', 2, 'Ria se Insette', '{}', '2026-07-21 14:21:48.353836', '', 1),
(738, 'delete', 'Document', 1, 'Ria van Eeden se instte', '{}', '2026-07-21 14:22:15.232033', '', 1),
(739, 'update', 'Document', 2, 'Ria se Insette', '{}', '2026-07-21 14:23:25.554763', '', 1),
(740, 'update', 'Person', 1, 'Jan Janse van Eeden', '{}', '2026-07-21 16:51:23.447925', '', 1),
(741, 'update', 'Document', 2, 'Ria van Eeden se Insette', '{}', '2026-07-21 16:53:06.618749', '', 1),
(742, 'create', 'Relationship', 338, 'Hendrina Stevens is Ouer of Jan Dirk van Eeden', '{}', '2026-07-21 17:40:50.654302', '', 1),
(743, 'create', 'Relationship', 339, 'Hendrina Stevens is Ouer of Petronella van Eeden', '{}', '2026-07-21 17:41:25.855067', '', 1),
(744, 'create', 'Relationship', 340, 'Hendrina Stevens is Ouer of Frederik van Eeden', '{}', '2026-07-21 17:42:13.163459', '', 1),
(745, 'create', 'Relationship', 341, 'Hendrina Stevens is Ouer of Maria van Eeden', '{}', '2026-07-21 17:43:05.234928', '', 1),
(746, 'create', 'Relationship', 342, 'Hendrina Stevens is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-21 17:43:30.888731', '', 1),
(747, 'create', 'Relationship', 343, 'Hendrina Stevens is Ouer of Judith van Eeden', '{}', '2026-07-21 18:20:15.059006', '', 1),
(748, 'delete', 'Relationship', 21, 'Frederik Jansz van Eeden is Ouer of Johannes van Eeden', '{}', '2026-07-21 18:28:06.871997', '', 1),
(749, 'create', 'Relationship', 344, 'Frederik Jansz van Eeden is Ouer of Johannes van Eeden', '{}', '2026-07-21 18:32:23.388301', '', 1),
(750, 'delete', 'Relationship', 343, 'Hendrina Stevens is Ouer of Judith van Eeden', '{}', '2026-07-21 21:47:31.120295', '', 1),
(751, 'delete', 'Relationship', 340, 'Hendrina Stevens is Ouer of Frederik van Eeden', '{}', '2026-07-21 21:47:47.159450', '', 1),
(752, 'delete', 'Relationship', 341, 'Hendrina Stevens is Ouer of Maria van Eeden', '{}', '2026-07-21 21:47:57.442512', '', 1),
(753, 'delete', 'Relationship', 342, 'Hendrina Stevens is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-21 21:48:10.359109', '', 1),
(754, 'delete', 'Relationship', 339, 'Hendrina Stevens is Ouer of Petronella van Eeden', '{}', '2026-07-21 21:48:17.949434', '', 1),
(755, 'delete', 'Relationship', 338, 'Hendrina Stevens is Ouer of Jan Dirk van Eeden', '{}', '2026-07-21 21:48:27.926330', '', 1),
(756, 'update', 'Person', 19, 'Johannes van Eeden', '{\"birth_date\": [\"BET 6 OCT 1737 AND 16 OCT 1740\", \"EST 1739\"], \"death_date\": [\"EST 1739\", \"\"]}', '2026-07-21 21:56:11.685385', '', 1),
(757, 'create', 'Marriage', 57, 'Johannes van Eeden & Hendrina Stevens', '{}', '2026-07-21 22:01:41.214142', 'Uit die van Eeden boek.', 1),
(758, 'delete', 'Marriage', 57, 'Johannes van Eeden & Hendrina Stevens', '{}', '2026-07-21 22:05:44.732458', '', 1),
(759, 'create', 'Person', 245, 'Pieter Grobler', '{}', '2026-07-22 06:00:01.035047', 'Uit die van Eeden boek.', 1),
(760, 'create', 'Marriage', 58, 'Aletta Peternella van Eeden & Pieter Grobler', '{}', '2026-07-22 06:01:28.038401', 'Uit die van Eeden boek.', 1),
(761, 'create', 'Person', 246, 'Maria Booysen', '{}', '2026-07-22 06:06:15.852347', 'Uit die van Eeden boek.', 1),
(762, 'create', 'Marriage', 59, 'Jan Dirk van Eeden & Maria Booysen', '{}', '2026-07-22 06:07:48.354016', 'Uit die van Eeden boek.', 1),
(763, 'update', 'Person', 245, 'Pieter Grobler', '{\"is_deceased\": [false, true]}', '2026-07-22 06:08:20.378700', '', 1),
(764, 'create', 'Relationship', 345, 'Hendrina Stevens is Ouer of Jan Dirk van Eeden', '{}', '2026-07-22 06:09:59.645727', '', 1),
(765, 'create', 'Relationship', 346, 'Hendrina Stevens is Ouer of Petronella van Eeden', '{}', '2026-07-22 06:10:39.084704', '', 1),
(766, 'create', 'Relationship', 347, 'Hendrina Stevens is Ouer of Frederik van Eeden', '{}', '2026-07-22 06:11:25.716769', '', 1),
(767, 'create', 'Relationship', 348, 'Hendrina Stevens is Ouer of Maria van Eeden', '{}', '2026-07-22 06:12:08.925361', '', 1),
(768, 'create', 'Relationship', 349, 'Hendrina Stevens is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-22 06:13:07.185251', '', 1),
(769, 'create', 'Relationship', 350, 'Hendrina Stevens is Ouer of Judith van Eeden', '{}', '2026-07-22 06:14:24.958555', '', 1),
(770, 'create', 'Relationship', 351, 'Hendrina Stevens is Ouer of Joseph van Eeden', '{}', '2026-07-22 06:14:55.525204', '', 1),
(771, 'create', 'Relationship', 352, 'Hendrina Stevens is Ouer of Johannes van Eeden', '{}', '2026-07-22 06:15:41.620221', '', 1),
(772, 'create', 'Relationship', 353, 'Hendrina Stevens is Ouer of Hermina van Eeden', '{}', '2026-07-22 06:16:13.689853', '', 1),
(773, 'create', 'Relationship', 354, 'Hendrina Stevens is Ouer of Elsje van Eeden', '{}', '2026-07-22 06:16:39.228244', '', 1),
(774, 'create', 'Relationship', 355, 'Hendrina Stevens is Ouer of Cornelius Frans van Eeden', '{}', '2026-07-22 06:17:36.094698', '', 1),
(775, 'update', 'Person', 22, 'Cornelis Frans van Eeden', '{\"first_name\": [\"Cornelius\", \"Cornelis\"]}', '2026-07-22 06:17:58.234134', '', 1),
(776, 'create', 'Relationship', 356, 'Maria Booysen is Ouer of Aletta Peternella van Eeden', '{}', '2026-07-22 06:20:51.695842', '', 1),
(777, 'create', 'Person', 247, 'Matthys Calitz', '{}', '2026-07-22 06:27:58.266509', 'Uit die van Eeden boek.', 1),
(778, 'create', 'Marriage', 60, 'Petronella van Eeden & Matthys Calitz', '{}', '2026-07-22 06:29:20.435234', 'Uit die van Eeden boek.', 1),
(779, 'update', 'Marriage', 60, 'Petronella van Eeden & Matthys Calitz', '{\"status\": [\"married\", \"divorced\"], \"end_date\": [\"\", \"BEF 27 MAY 1751\"]}', '2026-07-22 06:31:49.442671', '', 1),
(780, 'create', 'Person', 248, 'Johan Hendrik Christoffel Kock', '{}', '2026-07-22 06:37:21.131763', 'Uit die van Eeden boek.', 1),
(781, 'create', 'Marriage', 61, 'Petronella van Eeden & Johan Hendrik Christoffel Kock', '{}', '2026-07-22 06:38:54.463385', 'Uit die van Eeden boek.', 1),
(782, 'update', 'Person', 248, 'Johan Hendrik Christoffel Kock', '{\"biography\": [\"Ook bekend as Johann Heinrich Christoph Kok, aankoms 1745,soldaat, boukneg 1745-1747, burger van Swellendam 1747.\", \"Van Waldeck. Ook bekend as Johann Heinrich Christoph Kok, aankoms 1745,soldaat, boukneg 1745-1747, burger van Swellendam 1747.\"]}', '2026-07-22 06:39:45.903176', '', 1),
(783, 'create', 'Person', 249, 'Matthys de Beer', '{}', '2026-07-22 06:49:43.294160', 'Uit die van Eeden boek.', 1),
(784, 'create', 'Marriage', 62, 'Maria van Eeden & Matthys de Beer', '{}', '2026-07-22 06:50:36.893742', 'Uit die van Eeden boek.', 1),
(785, 'create', 'Person', 250, 'Cornelia Margaretha van Eeden', '{}', '2026-07-22 06:57:09.066326', 'Uit die van Eeden boek.', 1),
(786, 'create', 'Marriage', 63, 'Frederik Jacobus van Eeden & Cornelia Margaretha van Eeden', '{}', '2026-07-22 06:58:28.779159', 'Uit die van Eeden boek.', 1),
(787, 'create', 'Relationship', 357, 'Cornelia Margaretha van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-22 06:59:30.983864', '', 1),
(788, 'create', 'Relationship', 358, 'Cornelia Margaretha van Eeden is Ouer of Dorothea Regina van Eeden', '{}', '2026-07-22 07:00:22.520645', '', 1),
(789, 'create', 'Relationship', 359, 'Cornelia Margaretha van Eeden is Ouer of Gerrit van Eeden', '{}', '2026-07-22 07:00:59.296543', '', 1),
(790, 'create', 'Relationship', 360, 'Cornelia Margaretha van Eeden is Ouer of Jacob van Eeden', '{}', '2026-07-22 07:01:40.658860', '', 1),
(791, 'create', 'Relationship', 361, 'Cornelia Margaretha van Eeden is Ouer of Hendrina Hermina van Eeden', '{}', '2026-07-22 07:02:14.430398', '', 1),
(792, 'create', 'Relationship', 362, 'Cornelia Margaretha van Eeden is Ouer of Gideon Willem van Eeden', '{}', '2026-07-22 20:41:53.322199', '', 1),
(793, 'create', 'Relationship', 363, 'Cornelia Margaretha van Eeden is Ouer of Jan Bastiaan van Eeden', '{}', '2026-07-22 20:42:35.179023', '', 1),
(794, 'create', 'Relationship', 364, 'Cornelia Margaretha van Eeden is Ouer of Maria Elizabeth van Eeden', '{}', '2026-07-22 20:43:58.161037', '', 1),
(795, 'create', 'Relationship', 365, 'Cornelia Margaretha van Eeden is Ouer of Dorothea Regina van Eeden', '{}', '2026-07-22 20:44:37.620809', '', 1),
(796, 'create', 'Relationship', 366, 'Cornelia Margaretha van Eeden is Ouer of Catharina Johanna van Eeden', '{}', '2026-07-22 20:45:49.502387', '', 1),
(797, 'delete', 'Relationship', 362, 'Cornelia Margaretha van Eeden is Ouer of Gideon Willem van Eeden', '{}', '2026-07-22 20:49:19.136664', '', 1),
(798, 'delete', 'Relationship', 366, 'Cornelia Margaretha van Eeden is Ouer of Catharina Johanna van Eeden', '{}', '2026-07-22 20:49:28.737030', '', 1),
(799, 'delete', 'Relationship', 365, 'Cornelia Margaretha van Eeden is Ouer of Dorothea Regina van Eeden', '{}', '2026-07-22 20:49:38.891112', '', 1),
(800, 'delete', 'Relationship', 364, 'Cornelia Margaretha van Eeden is Ouer of Maria Elizabeth van Eeden', '{}', '2026-07-22 20:49:49.509354', '', 1),
(801, 'delete', 'Relationship', 363, 'Cornelia Margaretha van Eeden is Ouer of Jan Bastiaan van Eeden', '{}', '2026-07-22 20:50:00.968347', '', 1),
(802, 'create', 'Person', 251, 'Coenelia Margaretha van Eeden', '{}', '2026-07-22 21:01:38.609546', 'Uit die van Eeden boek.', 1),
(803, 'update', 'Person', 251, 'Cornelia Margaretha van Eeden', '{\"first_name\": [\"Coenelia\", \"Cornelia\"]}', '2026-07-22 21:04:16.415766', '', 1),
(804, 'update', 'Person', 34, 'Cornelia Margaretha van Eeden', '{\"first_name\": [\"Coenelia\", \"Cornelia\"]}', '2026-07-22 21:04:56.361453', '', 1),
(805, 'create', 'Marriage', 64, 'Frederik Jacobus van Eeden & Cornelia Margaretha van Eeden', '{}', '2026-07-22 21:07:30.015686', 'Uit die van Eeden boek.', 1),
(806, 'create', 'Relationship', 367, 'Cornelia Margaretha van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-22 21:08:57.561001', '', 1),
(807, 'create', 'Relationship', 368, 'Cornelia Margaretha van Eeden is Ouer of Jacobus Albertus van Eeden', '{}', '2026-07-22 21:09:32.051143', '', 1),
(808, 'create', 'Relationship', 369, 'Cornelia Margaretha van Eeden is Ouer of Zacharia Geertruy van Eeden', '{}', '2026-07-22 21:10:12.369837', '', 1),
(809, 'create', 'Relationship', 370, 'Cornelia Margaretha van Eeden is Ouer of Jacob Johannes van Eeden', '{}', '2026-07-22 21:11:13.755007', '', 1),
(810, 'create', 'Relationship', 371, 'Cornelia Margaretha van Eeden is Ouer of Gerrit Christiaan van Eeden', '{}', '2026-07-22 21:12:42.929604', '', 1),
(811, 'create', 'Relationship', 372, 'Cornelia Margaretha van Eeden is Ouer of Cornelia Margaretha van Eeden', '{}', '2026-07-22 21:13:51.229938', '', 1),
(812, 'create', 'Relationship', 373, 'Cornelia Margaretha van Eeden is Ouer of Hendrina Hermina van Eeden', '{}', '2026-07-22 21:14:44.963141', '', 1),
(813, 'create', 'Relationship', 374, 'Cornelia Margaretha van Eeden is Ouer of Gideon Willem van Eeden', '{}', '2026-07-22 21:15:19.330498', '', 1),
(814, 'create', 'Relationship', 375, 'Cornelia Margaretha van Eeden is Ouer of Jan Bastiaan van Eeden', '{}', '2026-07-22 21:15:45.630716', '', 1),
(815, 'create', 'Relationship', 376, 'Cornelia Margaretha van Eeden is Ouer of Maria Elizabeth van Eeden', '{}', '2026-07-22 21:16:33.811730', '', 1),
(816, 'create', 'Relationship', 377, 'Cornelia Margaretha van Eeden is Ouer of Dorothea Regina van Eeden', '{}', '2026-07-22 21:17:03.982415', '', 1),
(817, 'create', 'Relationship', 378, 'Cornelia Margaretha van Eeden is Ouer of Catharina Johanna van Eeden', '{}', '2026-07-22 21:17:39.164960', '', 1),
(818, 'create', 'Person', 252, 'Maria Elizabeth van Eeden', '{}', '2026-07-22 21:28:26.976536', 'Uit die van Eeden boek.', 1),
(819, 'create', 'Marriage', 65, 'Frederik Jacobus van Eeden & Maria Elizabeth van Eeden', '{}', '2026-07-22 21:30:01.765443', 'Uit die van Eeden boek.', 1),
(820, 'create', 'Relationship', 379, 'Maria Elizabeth van Eeden is Ouer of Hermina Elizabeth van Eeden', '{}', '2026-07-22 21:31:27.464027', '', 1),
(821, 'create', 'Relationship', 380, 'Maria Elizabeth van Eeden is Ouer of Cornelia Margaretha van Eeden', '{}', '2026-07-22 21:32:01.527961', '', 1),
(822, 'create', 'Relationship', 381, 'Maria Elizabeth van Eeden is Ouer of Maria Elizabeth van Eeden', '{}', '2026-07-22 21:32:40.674450', '', 1),
(823, 'create', 'Relationship', 382, 'Maria Elizabeth van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-22 21:33:27.769474', '', 1),
(824, 'create', 'Relationship', 383, 'Maria Elizabeth van Eeden is Ouer of Gabriel Jacobus van Eeden', '{}', '2026-07-22 21:33:58.405756', '', 1),
(825, 'create', 'Relationship', 384, 'Maria Elizabeth van Eeden is Ouer of Jacobus Petrus van Eeden', '{}', '2026-07-22 21:34:32.629581', '', 1),
(826, 'create', 'Relationship', 385, 'Maria Elizabeth van Eeden is Ouer of Hermina Elizabeth van Eeden', '{}', '2026-07-22 21:35:04.792228', '', 1),
(827, 'create', 'Relationship', 386, 'Maria Elizabeth van Eeden is Ouer of Zacharia Geertruida van Eeden', '{}', '2026-07-22 21:35:36.288231', '', 1),
(828, 'create', 'Relationship', 387, 'Maria Elizabeth van Eeden is Ouer of Margaretha Johanna van Eeden', '{}', '2026-07-22 21:36:13.360675', '', 1),
(829, 'create', 'Relationship', 388, 'Maria Elizabeth van Eeden is Ouer of Gerrit Christiaan van Eeden', '{}', '2026-07-22 21:36:46.970206', '', 1),
(830, 'create', 'Relationship', 389, 'Maria Elizabeth van Eeden is Ouer of Pieter Christiaan van Eeden', '{}', '2026-07-22 21:37:16.817332', '', 1),
(831, 'create', 'Relationship', 390, 'Maria Elizabeth van Eeden is Ouer of Gideon Albertus van Eeden', '{}', '2026-07-22 21:37:46.772487', '', 1),
(832, 'create', 'Person', 253, 'Michiel Casparus Eksteen', '{}', '2026-07-22 21:43:10.346666', 'Uit die van Eeden boek.', 1),
(833, 'create', 'Marriage', 66, 'Cornelia Margaretha van Eeden & Michiel Casparus Eksteen', '{}', '2026-07-22 21:45:29.439558', 'Uit die van Eeden boek.', 1),
(834, 'update', 'Person', 253, 'Michiel Casparus Eksteen', '{\"notes\": [\"\", \"(s.v. Hendrik Oostwald Eksteen & Elizabeth Francina Adendorff)\"]}', '2026-07-22 21:48:22.683782', '', 1),
(835, 'create', 'Person', 254, 'Hermanus Steyn', '{}', '2026-07-22 21:54:19.460198', 'Uit die van Eeden boek.', 1),
(836, 'create', 'Marriage', 67, 'Maria Elizabeth van Eeden & Hermanus Steyn', '{}', '2026-07-22 21:55:24.070923', 'Uit die van Eeden boek.', 1),
(837, 'create', 'Person', 255, 'Hester Magdalena Joubert', '{}', '2026-07-23 06:17:19.451427', 'Uit die van Eeden boek.', 1),
(838, 'create', 'Marriage', 68, 'Frederik Jacobus van Eeden & Hester Magdalena Joubert', '{}', '2026-07-23 06:18:57.418503', 'Uit die van Eeden boek.', 1),
(839, 'update', 'Person', 255, 'Hester Magdalena van Eeden', '{\"last_name\": [\"Joubert\", \"van Eeden\"], \"maiden_name\": [\"\", \"Joubert\"]}', '2026-07-23 06:19:31.161629', '', 1),
(840, 'create', 'Person', 256, 'Anna Margaretha van Eeden', '{}', '2026-07-23 10:05:13.367394', 'Uit die van Eeden boek.', 1),
(841, 'create', 'Relationship', 391, 'Frederik Jacobus van Eeden is Ouer of Anna Margaretha van Eeden', '{}', '2026-07-23 10:05:57.031457', '', 1),
(842, 'create', 'Person', 257, 'Frederik Jacobus van Eeden', '{}', '2026-07-23 10:13:32.245049', 'Uit die van Eeden boek.', 1),
(843, 'create', 'Marriage', 69, 'Frederik Jacobus van Eeden & Frederik Jacobus van Eeden', '{}', '2026-07-23 10:16:31.026549', 'Uit die van Eeden boek.', 1),
(844, 'delete', 'Marriage', 69, 'Frederik Jacobus van Eeden & Frederik Jacobus van Eeden', '{}', '2026-07-23 10:19:44.169856', '', 1),
(845, 'create', 'Marriage', 70, 'Hermina Elizabeth van Eeden & Frederik Jacobus van Eeden', '{}', '2026-07-23 10:21:23.241663', 'Uit die van Eeden boek.', 1),
(846, 'delete', 'Marriage', 70, 'Hermina Elizabeth van Eeden & Frederik Jacobus van Eeden', '{}', '2026-07-23 10:24:47.682260', '', 1),
(847, 'create', 'Marriage', 71, 'Anna Margaretha van Eeden & Frederik Jacobus van Eeden', '{}', '2026-07-23 10:26:14.546356', 'Uit die van Eeden boek.', 1),
(848, 'create', 'Person', 258, 'Hansie De Waal', '{}', '2026-07-25 09:41:41.165835', '', 3),
(849, 'create', 'Person', 259, 'Frederik Jacobus van Eeden', '{}', '2026-07-26 08:47:30.097789', 'Uit die van Eeden boek.', 1),
(850, 'create', 'Relationship', 392, 'Frederik Jacobus van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-26 08:48:05.219344', '', 1),
(851, 'create', 'Person', 260, 'Maria Elizabeth van Eeden', '{}', '2026-07-26 08:51:52.314993', 'Uit die van Eeden boek.', 1),
(852, 'create', 'Marriage', 72, 'Frederik Jacobus van Eeden & Maria Elizabeth van Eeden', '{}', '2026-07-26 08:54:15.020233', 'Uit die van Eeden boek.', 1),
(853, 'create', 'Person', 261, 'Johannes Stephanus van Eeden', '{}', '2026-07-26 08:59:29.509438', 'Uit die van Eeden boek.', 1),
(854, 'create', 'Relationship', 393, 'Frederik Jacobus van Eeden is Ouer of Johannes Stephanus van Eeden', '{}', '2026-07-26 09:00:00.360846', '', 1),
(855, 'create', 'Person', 262, 'Anna Margaretha van Eeden', '{}', '2026-07-26 09:03:27.170429', 'Uit die van Eeden boek.', 1),
(856, 'create', 'Marriage', 73, 'Johannes Stephanus van Eeden & Anna Margaretha van Eeden', '{}', '2026-07-26 09:04:34.752047', 'Uit die van Eeden boek.', 1),
(857, 'create', 'Person', 263, 'Susarah Magdalena van Eeden', '{}', '2026-07-26 09:09:37.349459', 'Uit die van Eeden boek.', 1),
(858, 'create', 'Marriage', 74, 'Johannes Stephanus van Eeden & Susarah Magdalena van Eeden', '{}', '2026-07-26 09:11:12.677212', 'Uit die van Eeden boek.', 1),
(859, 'create', 'Person', 264, 'Frederik Jacobus van Eeden', '{}', '2026-07-26 09:25:30.376404', 'Uit die van Eeden boek.', 1),
(860, 'create', 'Relationship', 394, 'Johannes Stephanus van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-26 09:26:10.357965', '', 1),
(861, 'create', 'Person', 265, 'Johannes Stephanus van Eeden', '{}', '2026-07-26 13:07:35.592526', 'Uit die van Eeden boek.', 1),
(862, 'create', 'Relationship', 395, 'Johannes Stephanus van Eeden is Ouer of Johannes Stephanus van Eeden', '{}', '2026-07-26 13:08:06.562591', '', 1),
(863, 'create', 'Person', 266, 'Anna Magdalena van Eeden', '{}', '2026-07-26 13:11:51.912820', 'Uit die van Eeden boek.', 1),
(864, 'create', 'Marriage', 75, 'Johannes Stephanus van Eeden & Anna Magdalena van Eeden', '{}', '2026-07-26 13:12:51.020643', '', 1),
(865, 'create', 'Person', 267, 'Gabriel Jacobus van Eeden', '{}', '2026-07-26 13:17:46.386714', 'Uit die van Eeden boek.', 1),
(866, 'create', 'Relationship', 396, 'Johannes Stephanus van Eeden is Ouer of Gabriel Jacobus van Eeden', '{}', '2026-07-26 13:18:08.182629', '', 1),
(867, 'create', 'Person', 268, 'Geertruyda Alida Magdalena van Eeden', '{}', '2026-07-26 13:23:28.546082', 'Uit die van Eeden boek.', 1),
(868, 'create', 'Marriage', 76, 'Gabriel Jacobus van Eeden & Geertruyda Alida Magdalena van Eeden', '{}', '2026-07-26 13:24:36.135249', 'Uit die van Eeden boek.', 1),
(869, 'create', 'Person', 269, 'Gideon Jacobus van Eeden', '{}', '2026-07-26 13:31:38.658147', 'Uit die van Eeden boek.', 1),
(870, 'create', 'Relationship', 397, 'Johannes Stephanus van Eeden is Ouer of Gideon Jacobus van Eeden', '{}', '2026-07-26 13:32:22.944492', '', 1),
(871, 'create', 'Person', 270, 'Wilhelmina Christina van Eeden', '{}', '2026-07-26 13:38:15.083626', 'Uit die van Eeden boek.', 1),
(872, 'create', 'Marriage', 77, 'Gideon Jacobus van Eeden & Wilhelmina Christina van Eeden', '{}', '2026-07-26 13:40:20.008558', 'Uit die van Eeden boek.', 1),
(873, 'create', 'Person', 271, 'Susara Magdalena van Eeden', '{}', '2026-07-26 13:42:10.987896', 'Uit die van Eeden boek.', 1),
(874, 'create', 'Relationship', 398, 'Johannes Stephanus van Eeden is Ouer of Susara Magdalena van Eeden', '{}', '2026-07-26 13:42:49.720672', '', 1),
(875, 'create', 'Person', 272, 'Jacobus Marthinus van Eeden', '{}', '2026-07-26 13:45:08.769224', 'Uit die van Eeden boek.', 1),
(876, 'create', 'Relationship', 399, 'Johannes Stephanus van Eeden is Ouer of Jacobus Marthinus van Eeden', '{}', '2026-07-26 13:45:37.258101', '', 1),
(877, 'create', 'Person', 273, 'Gert Christiaan van Eeden', '{}', '2026-07-26 13:49:14.189798', 'Uit die van Eeden boek.', 1),
(878, 'create', 'Relationship', 400, 'Johannes Stephanus van Eeden is Ouer of Gert Christiaan van Eeden', '{}', '2026-07-26 13:49:32.825055', '', 1),
(879, 'create', 'Person', 274, 'Renske Jacoba van Eeden', '{}', '2026-07-26 13:53:07.380410', 'Uit die van Eeden boek.', 1),
(880, 'create', 'Marriage', 78, 'Gert Christiaan van Eeden & Renske Jacoba van Eeden', '{}', '2026-07-26 13:54:53.680129', 'Uit die van Eeden boek.', 1),
(881, 'create', 'Person', 275, 'Hester Magdalena van Eeden', '{}', '2026-07-26 13:57:11.799955', 'Uit die van Eeden boek.', 1),
(882, 'create', 'Relationship', 401, 'Johannes Stephanus van Eeden is Ouer of Hester Magdalena van Eeden', '{}', '2026-07-26 13:57:49.188218', '', 1),
(883, 'create', 'Person', 276, 'Sophia Maria van Eeden', '{}', '2026-07-26 13:58:43.352031', 'Uit die van Eeden boek.', 1),
(884, 'create', 'Relationship', 402, 'Johannes Stephanus van Eeden is Ouer of Sophia Maria van Eeden', '{}', '2026-07-26 13:59:01.513364', '', 1),
(885, 'create', 'Relationship', 403, 'Susarah Magdalena van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-26 14:00:34.939965', '', 1),
(886, 'create', 'Relationship', 404, 'Susarah Magdalena van Eeden is Ouer of Johannes Stephanus van Eeden', '{}', '2026-07-26 14:02:00.328980', '', 1),
(887, 'create', 'Relationship', 405, 'Susarah Magdalena van Eeden is Ouer of Gabriel Jacobus van Eeden', '{}', '2026-07-26 14:02:30.656016', '', 1),
(888, 'create', 'Relationship', 406, 'Susarah Magdalena van Eeden is Ouer of Gideon Jacobus van Eeden', '{}', '2026-07-26 14:02:57.857684', '', 1),
(889, 'create', 'Relationship', 407, 'Susarah Magdalena van Eeden is Ouer of Susara Magdalena van Eeden', '{}', '2026-07-26 14:03:34.469035', '', 1),
(890, 'create', 'Relationship', 408, 'Susarah Magdalena van Eeden is Ouer of Jacobus Marthinus van Eeden', '{}', '2026-07-26 14:04:23.028774', '', 1),
(891, 'create', 'Relationship', 409, 'Susarah Magdalena van Eeden is Ouer of Gert Christiaan van Eeden', '{}', '2026-07-26 14:04:58.436014', '', 1),
(892, 'create', 'Relationship', 410, 'Susarah Magdalena van Eeden is Ouer of Hester Magdalena van Eeden', '{}', '2026-07-26 14:05:32.084388', '', 1),
(893, 'create', 'Relationship', 411, 'Susarah Magdalena van Eeden is Ouer of Sophia Maria van Eeden', '{}', '2026-07-26 14:05:56.798003', '', 1),
(894, 'create', 'Person', 277, 'Johanna Christina Helena van Eeden', '{}', '2026-07-26 14:13:22.683017', 'Uit die van Eeden boek.', 1),
(895, 'create', 'Marriage', 79, 'Frederik Jacobus van Eeden & Johanna Christina Helena van Eeden', '{}', '2026-07-26 14:15:10.236196', 'Uit die van Eeden boek.', 1),
(896, 'create', 'Person', 278, 'Anna Petronella van Eeden', '{}', '2026-07-26 14:18:23.645567', 'Uit die van Eeden boek.', 1),
(897, 'update', 'Person', 278, 'Anna Petronella van Eeden', '{\"birth_date\": [\"EST 1920\", \"6 JUN 1897\"]}', '2026-07-26 14:21:17.664241', '', 1),
(898, 'create', 'Marriage', 80, 'Frederik Jacobus van Eeden & Anna Petronella van Eeden', '{}', '2026-07-26 14:22:36.198054', 'Uit die van Eeden boek.', 1),
(899, 'create', 'Person', 279, 'Cornelia Frederika van Eeden', '{}', '2026-07-26 14:43:41.243841', 'Uit die van Eeden boek.', 1),
(900, 'create', 'Relationship', 412, 'Frederik Jacobus van Eeden is Ouer of Cornelia Frederika van Eeden', '{}', '2026-07-26 14:44:16.829191', '', 1),
(901, 'create', 'Person', 280, 'Joh van Wyk', '{}', '2026-07-26 14:49:26.254673', 'Uit die van Eeden boek.', 1),
(902, 'update', 'Person', 280, 'Johannes van Wyk', '{\"first_name\": [\"Joh\", \"Johannes\"]}', '2026-07-26 14:53:12.950330', '', 1),
(903, 'create', 'Marriage', 81, 'Cornelia Frederika van Eeden & Johannes van Wyk', '{}', '2026-07-26 14:54:45.069369', '', 1),
(904, 'create', 'Person', 281, 'Jacobus van Wyk', '{}', '2026-07-26 14:58:37.707308', 'Uit die van Eeden boek.', 1),
(905, 'create', 'Relationship', 413, 'Cornelia Frederika van Eeden is Ouer of Jacobus van Wyk', '{}', '2026-07-26 14:59:02.088299', '', 1),
(906, 'create', 'Person', 282, 'Johannes van Wyk', '{}', '2026-07-26 15:00:06.620223', 'Uit die van Eeden boek.', 1),
(907, 'create', 'Relationship', 414, 'Cornelia Frederika van Eeden is Ouer of Johannes van Wyk', '{}', '2026-07-26 15:00:28.741361', '', 1),
(908, 'create', 'Relationship', 415, 'Johannes van Wyk is Ouer of Jacobus van Wyk', '{}', '2026-07-26 15:01:17.845958', '', 1),
(909, 'create', 'Relationship', 416, 'Johannes van Wyk is Ouer of Johannes van Wyk', '{}', '2026-07-26 15:02:04.567907', '', 1),
(910, 'create', 'Person', 283, 'Susara Magdalena van Eeden', '{}', '2026-07-26 15:06:34.772761', 'Uit die van Eeden boek.', 1),
(911, 'create', 'Relationship', 417, 'Frederik Jacobus van Eeden is Ouer of Susara Magdalena van Eeden', '{}', '2026-07-26 15:07:11.569339', '', 1),
(912, 'create', 'Person', 284, 'Johanna Christina van Eeden', '{}', '2026-07-26 15:11:03.696602', 'Uit die van Eeden boek.', 1),
(913, 'create', 'Relationship', 418, 'Frederik Jacobus van Eeden is Ouer of Johanna Christina van Eeden', '{}', '2026-07-26 15:11:33.313707', '', 1),
(914, 'create', 'Person', 285, 'Daniel Craigen', '{}', '2026-07-26 15:16:29.345853', 'Uit die van Eeden boek.', 1),
(915, 'create', 'Marriage', 82, 'Johanna Christina van Eeden & Daniel Craigen', '{}', '2026-07-26 15:18:01.172778', 'Uit die van Eeden boek.', 1),
(916, 'create', 'Person', 286, 'Helene Coral Craigen', '{}', '2026-07-26 15:20:10.486068', 'Uit die van Eeden boek.', 1),
(917, 'create', 'Relationship', 419, 'Johanna Christina van Eeden is Ouer of Helene Coral Craigen', '{}', '2026-07-26 15:20:32.120705', '', 1),
(918, 'create', 'Person', 287, 'Brian Dennis Butler', '{}', '2026-07-26 15:21:32.721352', 'Uit die van Eeden boek.', 1),
(919, 'create', 'Marriage', 83, 'Helene Coral Craigen & Brian Dennis Butler', '{}', '2026-07-26 15:22:05.190435', 'Uit die van Eeden boek.', 1),
(920, 'create', 'Person', 288, 'Anne Elizabeth Craigen', '{}', '2026-07-26 15:24:07.356281', 'Uit die van Eeden boek.', 1),
(921, 'create', 'Relationship', 420, 'Johanna Christina van Eeden is Ouer of Anne Elizabeth Craigen', '{}', '2026-07-26 15:24:26.518012', '', 1),
(922, 'create', 'Person', 289, 'Ronald Montague Matthews', '{}', '2026-07-26 15:25:57.135999', 'Uit die van Eeden boek.', 1),
(923, 'create', 'Marriage', 84, 'Anne Elizabeth Craigen & Ronald Montague Matthews', '{}', '2026-07-26 15:26:26.050066', 'Uit die van Eeden boek.', 1),
(924, 'create', 'Person', 290, 'Daniel Frederik Craigen', '{}', '2026-07-26 15:28:53.897136', 'Uit die van Eeden boek.', 1),
(925, 'create', 'Relationship', 421, 'Johanna Christina van Eeden is Ouer of Daniel Frederik Craigen', '{}', '2026-07-26 15:29:14.103505', '', 1),
(926, 'create', 'Person', 291, 'Hester Maria van Eeden', '{}', '2026-07-26 15:30:42.653203', 'Uit die van Eeden boek.', 1),
(927, 'create', 'Relationship', 422, 'Frederik Jacobus van Eeden is Ouer of Hester Maria van Eeden', '{}', '2026-07-26 15:31:22.903762', '', 1),
(928, 'update', 'Person', 291, 'Hester Maria van Eeden', '{\"is_deceased\": [false, true]}', '2026-07-26 15:31:47.946503', '', 1),
(929, 'create', 'Person', 292, 'Anna Petronella van Eeden', '{}', '2026-07-26 15:35:23.519298', 'Uit die van Eeden boek.', 1),
(930, 'create', 'Relationship', 423, 'Frederik Jacobus van Eeden is Ouer of Anna Petronella van Eeden', '{}', '2026-07-26 15:36:02.295542', '', 1),
(931, 'create', 'Person', 293, 'Abraham Albertus Petrus Odendaal', '{}', '2026-07-26 15:41:12.287762', 'Uit die van Eeden boek.', 1),
(932, 'create', 'Marriage', 85, 'Anna Petronella van Eeden & Abraham Albertus Petrus Odendaal', '{}', '2026-07-26 15:42:18.241484', 'Uit die van Eeden boek.', 1),
(933, 'create', 'Person', 294, 'Willem Johannes Odendaal', '{}', '2026-07-26 15:45:54.127085', 'Uit die van Eeden boek.', 1),
(934, 'create', 'Relationship', 424, 'Anna Petronella van Eeden is Ouer of Willem Johannes Odendaal', '{}', '2026-07-26 15:46:16.367733', '', 1),
(935, 'create', 'Person', 295, 'Mariana Haasbroek', '{}', '2026-07-26 15:50:38.409304', 'Uit die van Eeden boek.', 1),
(936, 'create', 'Marriage', 86, 'Willem Johannes Odendaal & Mariana Haasbroek', '{}', '2026-07-26 15:52:42.775522', 'Uit die van Eeden boek.', 1),
(937, 'create', 'Person', 296, 'Hermine Odendaal', '{}', '2026-07-26 15:54:47.069498', 'Uit die van Eeden boek.', 1),
(938, 'create', 'Relationship', 425, 'Willem Johannes Odendaal is Ouer of Hermine Odendaal', '{}', '2026-07-26 15:55:08.520190', '', 1),
(939, 'create', 'Person', 297, 'Nanette Odendaal', '{}', '2026-07-26 15:56:03.852062', 'Uit die van Eeden boek.', 1),
(940, 'create', 'Relationship', 426, 'Willem Johannes Odendaal is Ouer of Nanette Odendaal', '{}', '2026-07-26 15:56:18.037452', '', 1),
(941, 'create', 'Relationship', 427, 'Mariana Haasbroek is Ouer of Hermine Odendaal', '{}', '2026-07-26 15:56:46.756996', '', 1),
(942, 'create', 'Relationship', 428, 'Mariana Haasbroek is Ouer of Nanette Odendaal', '{}', '2026-07-26 15:57:03.078655', '', 1),
(943, 'create', 'Person', 298, 'Frederik Jacobus Odendaal', '{}', '2026-07-26 15:58:45.974363', 'Uit die van Eeden boek.', 1),
(944, 'create', 'Relationship', 429, 'Anna Petronella van Eeden is Ouer of Frederik Jacobus Odendaal', '{}', '2026-07-26 15:59:14.092779', '', 1),
(945, 'create', 'Person', 299, 'Mariaan Wolhuter', '{}', '2026-07-26 16:00:13.778170', 'Uit die van Eeden boek.', 1),
(946, 'create', 'Marriage', 87, 'Frederik Jacobus Odendaal & Mariaan Wolhuter', '{}', '2026-07-26 16:01:19.269409', 'Uit die van Eeden boek.', 1),
(947, 'create', 'Person', 300, 'Anna Petronella Odendaal', '{}', '2026-07-26 16:02:41.913676', 'Uit die van Eeden boek.', 1),
(948, 'create', 'Relationship', 430, 'Anna Petronella van Eeden is Ouer of Anna Petronella Odendaal', '{}', '2026-07-26 16:03:23.143167', '', 1),
(949, 'create', 'Person', 301, 'Hermanus Hendrik Giliomee', '{}', '2026-07-26 16:04:46.729651', 'Uit die van Eeden boek.', 1),
(950, 'create', 'Marriage', 88, 'Anna Petronella Odendaal & Hermanus Hendrik Giliomee', '{}', '2026-07-26 16:05:58.677395', 'Uit die van Eeden boek.', 1),
(951, 'create', 'Person', 302, 'Johannes Stephanus van Eeden', '{}', '2026-07-26 16:29:15.516643', 'Uit die van Eeden boek.', 1),
(952, 'create', 'Relationship', 431, 'Frederik Jacobus van Eeden is Ouer of Johannes Stephanus van Eeden', '{}', '2026-07-26 16:29:40.917421', '', 1),
(953, 'create', 'Person', 303, 'Hester Magdalena van Eeden', '{}', '2026-07-26 16:33:59.977383', 'Uit die van Eeden boek.', 1),
(954, 'create', 'Marriage', 89, 'Johannes Stephanus van Eeden & Hester Magdalena van Eeden', '{}', '2026-07-26 16:35:20.733429', 'Uit die van Eeden boek.', 1),
(955, 'create', 'Relationship', 432, 'Daniel Craigen is Ouer of Helene Coral Craigen', '{}', '2026-07-26 16:43:12.235692', '', 1),
(956, 'create', 'Relationship', 433, 'Daniel Craigen is Ouer of Anne Elizabeth Craigen', '{}', '2026-07-26 16:43:39.725872', '', 1),
(957, 'create', 'Relationship', 434, 'Daniel Craigen is Ouer of Daniel Frederik Craigen', '{}', '2026-07-26 16:44:09.394369', '', 1),
(958, 'create', 'Relationship', 435, 'Abraham Albertus Petrus Odendaal is Ouer of Willem Johannes Odendaal', '{}', '2026-07-26 16:45:13.761493', '', 1),
(959, 'create', 'Relationship', 436, 'Abraham Albertus Petrus Odendaal is Ouer of Frederik Jacobus Odendaal', '{}', '2026-07-26 16:46:05.492193', '', 1),
(960, 'create', 'Relationship', 437, 'Abraham Albertus Petrus Odendaal is Ouer of Anna Petronella Odendaal', '{}', '2026-07-26 16:46:48.000435', '', 1),
(961, 'create', 'Person', 304, 'Frederik Jacobus van Eeden', '{}', '2026-07-26 16:50:06.741067', 'Uit die van Eeden boek.', 1),
(962, 'create', 'Relationship', 438, 'Johannes Stephanus van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-26 16:50:32.376631', '', 1),
(963, 'create', 'Person', 305, 'Amanda van Eeden', '{}', '2026-07-26 16:52:27.236815', 'Uit die van Eeden boek.', 1),
(964, 'create', 'Relationship', 439, 'Johannes Stephanus van Eeden is Ouer of Amanda van Eeden', '{}', '2026-07-26 16:52:49.407401', '', 1),
(965, 'create', 'Relationship', 440, 'Hester Magdalena van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-26 16:54:24.290290', '', 1),
(966, 'create', 'Relationship', 441, 'Hester Magdalena van Eeden is Ouer of Amanda van Eeden', '{}', '2026-07-26 16:54:48.330299', '', 1),
(967, 'create', 'Person', 306, 'Pierre le Grange', '{}', '2026-07-26 16:57:49.937697', 'Uit die van Eeden boek.', 1),
(968, 'create', 'Marriage', 90, 'Amanda van Eeden & Pierre le Grange', '{}', '2026-07-26 16:59:08.969707', 'Uit die van Eeden boek.', 1),
(969, 'create', 'Person', 307, 'Nadia le Grange', '{}', '2026-07-26 17:00:55.161137', 'Uit die van Eeden boek.', 1),
(970, 'create', 'Relationship', 442, 'Amanda van Eeden is Ouer of Nadia le Grange', '{}', '2026-07-26 17:01:16.951324', '', 1),
(971, 'create', 'Person', 308, 'Eeden le Grange', '{}', '2026-07-26 17:02:23.904150', 'Uit die van Eeden boek.', 1),
(972, 'create', 'Relationship', 443, 'Amanda van Eeden is Ouer of Eeden le Grange', '{}', '2026-07-26 17:02:48.331449', '', 1),
(973, 'create', 'Relationship', 444, 'Pierre le Grange is Ouer of Nadia le Grange', '{}', '2026-07-26 17:03:27.390594', '', 1),
(974, 'create', 'Relationship', 445, 'Pierre le Grange is Ouer of Eeden le Grange', '{}', '2026-07-26 17:03:58.249379', '', 1),
(975, 'create', 'Person', 309, 'Sophia Maria van Eeden', '{}', '2026-07-26 17:13:35.523152', 'Uit die van Eeden boek.', 1),
(976, 'create', 'Relationship', 446, 'Frederik Jacobus van Eeden is Ouer of Sophia Maria van Eeden', '{}', '2026-07-26 17:14:02.127707', '', 1),
(977, 'create', 'Person', 310, 'Daniel Johannes Gerrits', '{}', '2026-07-26 17:17:34.029235', 'Uit die van Eeden boek.', 1),
(978, 'create', 'Marriage', 91, 'Sophia Maria van Eeden & Daniel Johannes Gerrits', '{}', '2026-07-26 17:18:29.173976', 'Uit die van Eeden boek.', 1),
(979, 'create', 'Person', 311, 'Dirk Cornelius Human', '{}', '2026-07-26 17:20:07.783841', 'Uit die van Eeden boek.', 1),
(980, 'create', 'Marriage', 92, 'Sophia Maria van Eeden & Dirk Cornelius Human', '{}', '2026-07-26 17:20:59.934116', 'Uit die van Eeden boek.', 1),
(981, 'create', 'Person', 312, 'Daniel Johannes Gerrits', '{}', '2026-07-26 17:23:04.009636', 'Uit die van Eeden boek.', 1),
(982, 'create', 'Relationship', 447, 'Sophia Maria van Eeden is Ouer of Daniel Johannes Gerrits', '{}', '2026-07-26 17:23:31.526503', '', 1),
(983, 'create', 'Person', 313, 'Anna-Marie Gerrits', '{}', '2026-07-26 17:25:54.796049', 'Uit die van Eeden boek.', 1),
(984, 'create', 'Relationship', 448, 'Sophia Maria van Eeden is Ouer of Anna-Marie Gerrits', '{}', '2026-07-26 17:26:20.090587', '', 1),
(985, 'create', 'Relationship', 449, 'Daniel Johannes Gerrits is Ouer of Daniel Johannes Gerrits', '{}', '2026-07-26 17:27:05.111497', '', 1),
(986, 'create', 'Relationship', 450, 'Daniel Johannes Gerrits is Ouer of Anna-Marie Gerrits', '{}', '2026-07-26 17:27:20.952406', '', 1),
(987, 'create', 'Person', 314, 'Maria Catharina van Eeden', '{}', '2026-07-26 17:29:10.286194', 'Uit die van Eeden boek.', 1),
(988, 'create', 'Relationship', 451, 'Frederik Jacobus van Eeden is Ouer of Maria Catharina van Eeden', '{}', '2026-07-26 17:29:39.766358', '', 1),
(989, 'create', 'Relationship', 452, 'Johanna Christina Helena van Eeden is Ouer of Cornelia Frederika van Eeden', '{}', '2026-07-26 17:32:15.008277', '', 1),
(990, 'create', 'Relationship', 453, 'Johanna Christina Helena van Eeden is Ouer of Susara Magdalena van Eeden', '{}', '2026-07-26 17:32:51.723176', '', 1),
(991, 'create', 'Relationship', 454, 'Johanna Christina Helena van Eeden is Ouer of Johanna Christina van Eeden', '{}', '2026-07-26 17:33:25.521110', '', 1),
(992, 'create', 'Relationship', 455, 'Johanna Christina Helena van Eeden is Ouer of Hester Maria van Eeden', '{}', '2026-07-26 17:33:52.283100', '', 1),
(993, 'create', 'Relationship', 456, 'Anna Petronella van Eeden is Ouer of Anna Petronella van Eeden', '{}', '2026-07-26 17:34:34.339396', '', 1),
(994, 'create', 'Relationship', 457, 'Anna Petronella van Eeden is Ouer of Johannes Stephanus van Eeden', '{}', '2026-07-26 17:35:01.328056', '', 1),
(995, 'create', 'Relationship', 458, 'Anna Petronella van Eeden is Ouer of Sophia Maria van Eeden', '{}', '2026-07-26 17:35:33.962066', '', 1),
(996, 'create', 'Relationship', 459, 'Anna Petronella van Eeden is Ouer of Maria Catharina van Eeden', '{}', '2026-07-26 17:36:09.638320', '', 1),
(997, 'create', 'Person', 315, 'Johannes Christiaan Rust', '{}', '2026-07-26 17:39:01.500149', 'Uit die van Eeden boek.', 1),
(998, 'create', 'Marriage', 93, 'Maria Catharina van Eeden & Johannes Christiaan Rust', '{}', '2026-07-26 17:39:44.539274', 'Uit die van Eeden boek.', 1),
(999, 'create', 'Person', 316, 'Petrus Johannes Blom', '{}', '2026-07-26 17:43:47.342100', 'Uit die van Eeden boek.', 1),
(1000, 'create', 'Marriage', 94, 'Maria Catharina van Eeden & Petrus Johannes Blom', '{}', '2026-07-26 17:44:44.468076', 'Uit die van Eeden boek.', 1),
(1001, 'create', 'Person', 317, 'Johannes Christiaan Rust', '{}', '2026-07-26 17:48:33.658104', 'Uit die van Eeden boek.', 1),
(1002, 'create', 'Relationship', 460, 'Maria Catharina van Eeden is Ouer of Johannes Christiaan Rust', '{}', '2026-07-26 17:49:18.373218', '', 1),
(1003, 'create', 'Person', 318, 'Lorraine du Plessis', '{}', '2026-07-26 17:50:50.565018', 'Uit die van Eeden boek.', 1),
(1004, 'create', 'Marriage', 95, 'Johannes Christiaan Rust & Lorraine du Plessis', '{}', '2026-07-26 17:51:10.491179', 'Uit die van Eeden boek.', 1),
(1005, 'create', 'Person', 319, 'Frederik Jacobus Rust', '{}', '2026-07-26 17:52:50.661186', 'Uit die van Eeden boek.', 1),
(1006, 'create', 'Relationship', 461, 'Maria Catharina van Eeden is Ouer of Frederik Jacobus Rust', '{}', '2026-07-26 17:53:13.212468', '', 1),
(1007, 'create', 'Relationship', 462, 'Johannes Christiaan Rust is Ouer of Johannes Christiaan Rust', '{}', '2026-07-26 17:54:14.017589', '', 1),
(1008, 'create', 'Relationship', 463, 'Johannes Christiaan Rust is Ouer of Frederik Jacobus Rust', '{}', '2026-07-26 17:54:55.062641', '', 1),
(1009, 'create', 'Person', 320, 'Heidie van Staden', '{}', '2026-07-26 17:56:41.912368', 'Uit die van Eeden boek.', 1),
(1010, 'create', 'Marriage', 96, 'Frederik Jacobus Rust & Heidie van Staden', '{}', '2026-07-26 17:57:32.793842', 'Uit die van Eeden boek.', 1),
(1011, 'create', 'Person', 321, 'Annelize Rust', '{}', '2026-07-26 17:59:28.121016', 'Uit die van Eeden boek.', 1),
(1012, 'create', 'Relationship', 464, 'Frederik Jacobus Rust is Ouer of Annelize Rust', '{}', '2026-07-26 17:59:48.885899', '', 1),
(1013, 'create', 'Person', 322, 'Petrus Johannes Rust', '{}', '2026-07-26 18:00:43.360202', 'Uit die van Eeden boek.', 1),
(1014, 'create', 'Relationship', 465, 'Frederik Jacobus Rust is Ouer of Petrus Johannes Rust', '{}', '2026-07-26 18:01:07.663517', '', 1),
(1015, 'create', 'Relationship', 466, 'Heidie van Staden is Ouer of Annelize Rust', '{}', '2026-07-26 18:01:42.076537', '', 1),
(1016, 'create', 'Relationship', 467, 'Heidie van Staden is Ouer of Petrus Johannes Rust', '{}', '2026-07-26 18:02:10.877843', '', 1),
(1017, 'create', 'Relationship', 468, 'Gert Christiaan van Eeden is Ouer of Frederik Jacobus van Eeden', '{}', '2026-07-26 18:15:49.686750', '', 1),
(1018, 'create', 'Relationship', 469, 'Gert Christiaan van Eeden is Ouer of Leonard Johannes Haasbroek van Eeden', '{}', '2026-07-26 18:16:42.448351', '', 1),
(1019, 'create', 'Relationship', 470, 'Gert Christiaan van Eeden is Ouer of Jacobus Stefanus van Eeden', '{}', '2026-07-26 18:17:37.236085', '', 1),
(1020, 'create', 'Relationship', 471, 'Gert Christiaan van Eeden is Ouer of Dina Maria Christina van Eeden', '{}', '2026-07-26 18:18:05.844363', '', 1),
(1021, 'create', 'Relationship', 472, 'Gert Christiaan van Eeden is Ouer of Daniel Hendrik van Eeden', '{}', '2026-07-26 18:18:35.963197', '', 1),
(1022, 'create', 'Relationship', 473, 'Gert Christiaan van Eeden is Ouer of Daniel Gerbrand van Eeden', '{}', '2026-07-26 18:19:00.089112', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_document`
--

CREATE TABLE `genealogy_document` (
  `id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `document_type` varchar(30) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `date` varchar(100) NOT NULL,
  `source` varchar(300) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `uploaded_by_id` int DEFAULT NULL,
  `event_id` bigint DEFAULT NULL,
  `marriage_id` bigint DEFAULT NULL,
  `relationship_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_document`
--

INSERT INTO `genealogy_document` (`id`, `title`, `document_type`, `file`, `image`, `description`, `date`, `source`, `created_at`, `uploaded_by_id`, `event_id`, `marriage_id`, `relationship_id`) VALUES
(2, 'Ria van Eeden se Insette', 'other', 'documents/ria_se_brokkie.pdf', '', 'Jan Janse se Gekiedenis.', '21/06/2026', 'Ria van Eeden', '2026-07-21 14:21:48.345795', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_document_people`
--

CREATE TABLE `genealogy_document_people` (
  `id` bigint NOT NULL,
  `document_id` bigint NOT NULL,
  `person_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_document_people`
--

INSERT INTO `genealogy_document_people` (`id`, `document_id`, `person_id`) VALUES
(2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_event`
--

CREATE TABLE `genealogy_event` (
  `id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `event_type` varchar(20) NOT NULL,
  `date` varchar(100) NOT NULL,
  `place` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `main_person_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_event`
--

INSERT INTO `genealogy_event` (`id`, `title`, `event_type`, `date`, `place`, `description`, `main_person_id`) VALUES
(1, 'Doop van Johannes van Eeden', 'baptism', '19 JAN 1676', 'Stellenbosch, South Africa', '', 4),
(2, 'Doop van Arij van Eeden', 'baptism', '16 APR 1690', 'Stellenbosch, South Africa', '', 5),
(3, 'Doop van Maria Magdalena van Eeden', 'baptism', '25 SEP 1712', 'Stellenbosch, South Africa', '', 7),
(4, 'Doop - Jacobus van Eeden', 'baptism', '13 FEB 1692', '', '', 8);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_event_people`
--

CREATE TABLE `genealogy_event_people` (
  `id` bigint NOT NULL,
  `event_id` bigint NOT NULL,
  `person_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_event_people`
--

INSERT INTO `genealogy_event_people` (`id`, `event_id`, `person_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(15, 1, 4),
(4, 2, 1),
(5, 2, 3),
(14, 2, 5),
(10, 3, 5),
(11, 3, 6),
(16, 3, 7),
(17, 4, 1),
(18, 4, 3),
(19, 4, 8);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_marriage`
--

CREATE TABLE `genealogy_marriage` (
  `id` bigint NOT NULL,
  `marriage_date` varchar(100) NOT NULL,
  `marriage_place` varchar(200) NOT NULL,
  `end_date` varchar(100) NOT NULL,
  `end_place` varchar(200) NOT NULL,
  `status` varchar(20) NOT NULL,
  `notes` longtext NOT NULL,
  `person1_id` bigint NOT NULL,
  `person2_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_marriage`
--

INSERT INTO `genealogy_marriage` (`id`, `marriage_date`, `marriage_place`, `end_date`, `end_place`, `status`, `notes`, `person1_id`, `person2_id`) VALUES
(1, '4 OCT 1671', '', 'EST MAY 1684', '', 'divorced', '', 1, 2),
(2, '13 JUL 1688', 'Cape Town, South Africa', '', '', 'married', '', 1, 3),
(3, '29 MAR 1711', '', '', '', 'married', '', 5, 6),
(4, '31 MAR 1851', 'Swellendam', '', '', 'married', '', 50, 53),
(5, '21 JUN 1878', 'Montagu', '28 JAN 1931', 'Vergelegen', 'widowed', '', 56, 63),
(7, '8 JUN 1931', 'Bethulie', '', '', 'married', '', 56, 64),
(8, '27 JUN 1911', 'NG Kerk, Bethulie', '12 APR 1943', 'Bethulie', 'widowed', '', 71, 76),
(9, '26 DEC 1943', 'NG Kerk, Bethulie', '', '', 'married', 'Getrou deur ds JS Wolhuter', 71, 77),
(10, '16 DEC 1941', 'Bethulie', '', '', 'married', 'Getrou uit NG Kerk deur ds HW Dreyer.', 78, 84),
(11, '10 NOV 1945', 'Bethulie', '', '', 'married', '', 79, 85),
(13, '5 AUG 1950', 'Springs, South Africa', '', '', 'married', '', 82, 87),
(14, '3 NOV 1956', 'Bloemfontein', '', '', 'married', '', 83, 88),
(15, '4 OCT 1975', '', '', '', 'married', '', 91, 95),
(16, '21 DEC 1976', '', 'BEF 1986', '', 'divorced', '', 92, 96),
(17, '29 MAR 1986', 'Swellendam', '', '', 'married', '', 92, 97),
(18, '28 FEB 1976', '', '', '', 'married', '', 93, 98),
(19, '10 FEB 1979', '', '', '', 'married', '', 94, 99),
(20, '3 JUN 1967', '', 'BEF 1973', '', 'divorced', '', 89, 104),
(21, '10 NOV 1973', '', '', '', 'married', '', 89, 105),
(22, '25 OCT 1941', '', '', '', 'married', '', 80, 86),
(23, '3 SEP 1960', '', '21 AUG 1961', '', 'widowed', '', 100, 107),
(24, '6 FEB 1965', '', '', '', 'married', '', 100, 108),
(25, '9 DEC 1967', '', '', '', 'married', '', 101, 111),
(26, '2 JUL 1966', '', '', '', 'married', '', 102, 116),
(27, '26 JUN 1971', '', '', '', 'married', '', 103, 119),
(28, '31 MAR 1979', '', '', '', 'married', '', 90, 133),
(29, '20 FEB 1993', 'Jacobsdal', '', '', 'married', '', 112, 143),
(30, '30 OCT 1993', '', '', '', 'married', '', 146, 147),
(31, '30 OCT 1993', 'Jacobsdal', '', '', 'married', '', 150, 151),
(32, '15 SEP 2001', 'Kapel van die Eagle\'s Eye Country Estate, Pretoria.', '', '', 'married', '', 117, 152),
(33, '12 OCT 1996', 'Afrikaanse Protestante Kerk, Klerksdorp', '16 JAN 2002', '', 'widowed', '', 121, 153),
(34, '9 MAY 1998', 'NG Kerk, Verwoerdburgstad', '', '', 'married', '', 122, 155),
(35, '4 DEC 1971', 'Pitersburg', '', '', 'married', '', 124, 156),
(36, '6 DEC 1997', 'Gereformeerde Kerk te Mooinooi.', '', '', 'married', '', 157, 160),
(37, '2 AUG 1980', '', 'EST 1987', '', 'divorced', '', 125, 164),
(38, '22 OCT 1995', 'Protestantse Kerk, Worcester', 'EST NOV 2001', '', 'divorced', '', 125, 165),
(39, '13 JUN 1992', 'Kibler Park in Ou Apostoliese Kerk', '31 MAR 2022', '', 'widowed', '', 126, 168),
(40, '15 DEC 1984', 'Johannesburg', '2 APR 1986', 'Johannesburg', 'divorced', '', 168, 169),
(41, '', '', '', '', 'divorced', '', 127, 173),
(42, 'BEF 4 JUL 1991', '', '', '', 'married', '', 127, 174),
(43, '5 DEC 1987', 'Regents Park', '', '', 'married', '', 128, 176),
(44, 'EST 1710', 'Kape Town, South Africa', '', '', 'married', '', 8, 177),
(45, '20 NOV 1729', 'Paarl', '', '', 'married', '', 178, 180),
(46, '19 APR 1732', 'Stellenbosch', 'BEF 4 MAR 1742', '', 'divorced', '', 179, 181),
(47, '4 MAR 1742', 'Paarl', '', '', 'married', '', 179, 182),
(48, '9 AUG 1722', '', '', '', 'married', 'Datum ook moontlik 14/02/1723.', 9, 183),
(49, '18 FEB 1714', '', 'BEF 1734', '', 'divorced', '', 10, 184),
(50, 'EST 1734', '', '', '', 'married', '', 10, 185),
(51, '13 DEC 1733', '', '', '', 'married', '', 186, 187),
(52, '5 JAN 1738', '', '', '', 'married', '', 190, 191),
(53, '14 MAR 1751', '', '', '', 'married', '', 206, 207),
(54, '2 JUN 1748', '', 'BEF 7 APR 1765', '', 'divorced', '', 215, 216),
(55, '7 APR 1765', '', '', '', 'married', '', 215, 217),
(56, '2 MAR 1749', 'Drakenstein', '', '', 'married', '', 236, 237),
(58, '29 OCT 1786', 'Paarl', '', '', 'married', '', 23, 245),
(59, '6 MAY 1759', 'VglP68, get.te Paarl', '', '', 'married', '', 12, 246),
(60, '25 FEB 1742', 'Paarl', 'BEF 27 MAY 1751', '', 'divorced', '', 13, 247),
(61, '27 MAY 1751', '', '', '', 'married', '', 13, 248),
(62, '3 SEP 1747', '', '', '', 'married', '', 15, 249),
(63, '4 MAR 1755', '', '', '', 'married', '', 16, 250),
(64, '28 OCT 1781', '', '', '', 'married', '', 24, 251),
(65, 'EST JUL 1808', '', '', '', 'married', '', 29, 252),
(66, '6 MAY 1838', '', '', '', 'married', '', 42, 253),
(67, 'EST 1842', '', '', '', 'married', '', 43, 254),
(68, '11 MAR 1838', 'Swellendam', '', '', 'married', '', 44, 255),
(71, '5 MAR 1860', '', '', '', 'married', '', 256, 257),
(72, '', '', '', '', 'married', '', 259, 260),
(73, 'EST 1868', '', '', '', 'married', '', 261, 262),
(74, 'EST 1882', '', '', '', 'married', '', 261, 263),
(75, 'EST 1926', '', '', '', 'married', '', 265, 266),
(76, '21 JUN 1921', 'Caledon', '', '', 'married', '', 267, 268),
(77, 'EST 1926', 'Bonnievale', '4 MAR 1972', '', 'widowed', '', 269, 270),
(78, '20 APR 1926', 'Villiersdorp', '9 JUL 1980', '', 'widowed', '', 273, 274),
(79, 'EST 1913', '', '10 JAN 1919', '', 'widowed', '', 264, 277),
(80, 'EST 1920', '', '', '', 'married', '', 264, 278),
(81, '3 MAR 1951', 'Benoni', '', '', 'married', '', 279, 280),
(82, '30 JAN 1943', 'NG Kerk, Woodstock', '', '', 'married', '', 284, 285),
(83, '', '', '', '', 'married', '', 286, 287),
(84, '', '', '', '', 'married', '', 288, 289),
(85, '1 JUN 1948', 'Buffeljachtsrivier', '', '', 'married', '', 292, 293),
(86, '20 JUL 1974', 'Louis Trichardt', '', '', 'married', '', 294, 295),
(87, '24 JUN 1977', 'Swellendam', '', '', 'married', '', 298, 299),
(88, '27 FEB 1976', 'Buffeljachtsrivier', '', '', 'married', '', 300, 301),
(89, '18 DEC 1954', '', '', '', 'married', '', 302, 303),
(90, '19 OCT 1988', 'Bloubergstrand, Kaapstad.', '', '', 'married', '', 305, 306),
(91, '', '', 'BEF 1987', '', 'divorced', '', 309, 310),
(92, '23 JAN 1987', '', '', '', 'married', '', 309, 311),
(93, 'EST 1952', '', '', '', 'married', '', 314, 315),
(94, 'EST 1960', '', '', '', 'married', '', 314, 316),
(95, '', '', '', '', 'married', '', 317, 318),
(96, 'EST 1977', '', '', '', 'married', '', 319, 320);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_pendingedit`
--

CREATE TABLE `genealogy_pendingedit` (
  `id` bigint NOT NULL,
  `action` varchar(10) NOT NULL,
  `model_name` varchar(50) NOT NULL,
  `object_id` int DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `proposed_data` json NOT NULL,
  `field_changes` json NOT NULL,
  `note` longtext NOT NULL,
  `status` varchar(10) NOT NULL,
  `review_note` longtext NOT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `proposed_by_id` int NOT NULL,
  `reviewed_by_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_person`
--

CREATE TABLE `genealogy_person` (
  `id` bigint NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `maiden_name` varchar(100) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `birth_date` varchar(100) NOT NULL,
  `birth_place` varchar(200) NOT NULL,
  `death_date` varchar(100) NOT NULL,
  `death_place` varchar(200) NOT NULL,
  `is_deceased` tinyint(1) NOT NULL,
  `biography` longtext NOT NULL,
  `notes` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `birth_lat` double DEFAULT NULL,
  `birth_lng` double DEFAULT NULL,
  `death_lat` double DEFAULT NULL,
  `death_lng` double DEFAULT NULL,
  `created_by_id` int DEFAULT NULL,
  `is_root` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_person`
--

INSERT INTO `genealogy_person` (`id`, `first_name`, `middle_name`, `last_name`, `maiden_name`, `gender`, `photo`, `birth_date`, `birth_place`, `death_date`, `death_place`, `is_deceased`, `biography`, `notes`, `created_at`, `updated_at`, `birth_lat`, `birth_lng`, `death_lat`, `death_lng`, `created_by_id`, `is_root`) VALUES
(1, 'Jan', 'Janse', 'van Eeden', '', 'M', '', 'EST 1637', 'Oldenburg, Germany', 'EST 1704', 'Stellenbosch, South Africa', 1, 'Bekend as Jan van Oldenburg, aankoms 1662 as \"onderscheepskorporaal\". In 1682 vestig hy hom op \"Krommerivier\" by Stellenbosch as smid en boer; Vryburger van Stellenbosch 1688; hy word amptelik eerste eienaar van Krommerivier in 1692 na die aankoms van die eerste landmeter, ene Mostert. Maak \'n gesamentlike testament as Jan Jantz; sy boedel gedateer 26 Mei 1702 dui aan dat hy \'n suksesvolle boer was.', '', '2026-07-09 07:44:19.475659', '2026-07-21 16:51:23.446165', NULL, NULL, NULL, NULL, 1, 1),
(2, 'Elizabeth', 'Janz', 'van Eeden', '', 'F', '', 'BEF 1662', '', '', '', 1, 'Bekend as Lijsbeth; 1677 met ma na Holland gestuur vir behandeling teen drankmisbruik, terug in 1682; 1684 deur man geskei weens owerspel en na Betaafse vrouetughuis gestuur, waar sy sterf.', '', '2026-07-09 07:50:40.485760', '2026-07-12 21:49:44.515035', NULL, NULL, NULL, NULL, 1, 0),
(3, 'Maria', 'Russaar', 'van Eeden', '', 'F', '', 'EST 1659', '', 'AFT 1711', '', 1, 'Van ook gespel \"Rousseau\" of \"Rossar\" op testament; van Blois, Frankryk, waarskynlik verwant aan stamvader Pierre Rousseau; Maria en 14 ander Hugenote (Totaal 6 mans, 6 vrouens en 3 kinders) gaan aan boord van Die Kamer van Amsterdam se seilskip die Brossenburg (lengte 36 meter). In beheer van Kaptein Jan Claasje Valcquit. Hulle verlaat Textell op 6 Januarie 1688 en arriveer op 12 Mei 1688 in Tafelbaai.', '', '2026-07-09 08:07:04.179056', '2026-07-12 21:50:17.104024', NULL, NULL, NULL, NULL, 1, 0),
(4, 'Johannes', '', 'van Eeden', '', 'M', '', 'EST 1675', '', '', '', 1, 'Ongetroud; in 1702 was hy 27j oud en erf o.a. 250 gulde van sy pa.', '', '2026-07-09 08:17:23.750006', '2026-07-10 05:51:02.233412', NULL, NULL, NULL, NULL, 1, 0),
(5, 'Arij', '', 'van Eeden', '', 'M', '', 'BEF 16 APR 1690', '', '', '', 1, '', '', '2026-07-09 10:11:41.719937', '2026-07-09 10:11:41.719980', NULL, NULL, NULL, NULL, 1, 0),
(6, 'Judith', 'du Plessis', 'van Eeden', '', 'F', '', 'EST 1694', 'Ireland', '', '', 1, '', 'd.v. Jean Prieur du Plessis & Marie (Madeleine) Menantenau', '2026-07-09 11:39:53.008164', '2026-07-12 21:49:03.132558', NULL, NULL, NULL, NULL, 1, 0),
(7, 'Maria', 'Magdalena', 'van Eeden', '', 'F', '', 'BEF 25 SEP 1712', '', '', '', 1, '', '', '2026-07-09 11:46:22.948506', '2026-07-09 11:46:22.948534', NULL, NULL, NULL, NULL, 1, 0),
(8, 'Jacobus', '', 'van Eeden', '', 'M', '', 'BEF 13 FEB 1692', '', '', '', 1, '', '', '2026-07-10 05:49:58.026245', '2026-07-10 07:21:40.293068', NULL, NULL, NULL, NULL, 1, 0),
(9, 'Frederik', 'Jansz', 'van Eeden', '', 'M', '', 'EST 1694', '', '21 JUL 1752', '', 1, 'Skaapboer Swellendam distrik op huurpaggrond.', '', '2026-07-10 05:59:06.394301', '2026-07-10 05:59:06.394340', NULL, NULL, NULL, NULL, 1, 0),
(10, 'Maria', 'Catharina', 'van Eeden', '', 'F', '', 'BEF 31 JAN 1696', '', '', '', 1, '', '', '2026-07-10 06:08:22.547827', '2026-07-10 07:26:02.169674', NULL, NULL, NULL, NULL, 1, 0),
(11, 'Dirk', '', 'van Eeden', '', 'M', '', 'BEF 3 NOV 1697', '', '', '', 1, '', '', '2026-07-10 07:12:42.469300', '2026-07-10 07:19:38.886788', NULL, NULL, NULL, NULL, 1, 0),
(12, 'Jan', 'Dirk', 'van Eeden', '', 'M', '', 'BEF 10 OCT 1723', '', '', '', 1, 'Burge van Swellendam', '', '2026-07-10 07:31:03.151488', '2026-07-21 06:43:10.833486', NULL, NULL, NULL, NULL, 1, 0),
(13, 'Petronella', '', 'van Eeden', '', 'F', '', 'BEF 22 JUL 1725', '', '', '', 1, 'Ander spelling - Peternella.', 'Haaqr handtekening verskyn op vader se testament.', '2026-07-10 07:39:09.787420', '2026-07-21 06:43:46.441403', NULL, NULL, NULL, NULL, 1, 0),
(14, 'Frederik', '', 'van Eeden', '', 'M', '', 'BEF 22 JUL 1727', '', '', '', 1, '', '', '2026-07-10 07:53:19.393953', '2026-07-21 06:44:27.337380', NULL, NULL, NULL, NULL, 1, 0),
(15, 'Maria', '', 'van Eeden', '', 'F', '', 'BEF 20 NOV 1729', '', '', '', 1, '', '', '2026-07-10 07:54:52.200334', '2026-07-21 11:40:52.647761', NULL, NULL, NULL, NULL, 1, 0),
(16, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', 'BEF 14 SEP 1732', '', '', '', 1, 'Burger van Swellendam.', '', '2026-07-10 13:30:52.211154', '2026-07-10 13:30:52.211188', NULL, NULL, NULL, NULL, 1, 0),
(17, 'Judith', '', 'van Eeden', '', 'F', '', 'BEF 16 JAN 1735', '', '', '', 1, '', '', '2026-07-10 13:34:18.049054', '2026-07-10 13:34:18.049098', NULL, NULL, NULL, NULL, 1, 0),
(18, 'Joseph', '', 'van Eeden', '', 'M', '', 'BEF 6 OCT 1737', '', '20 NOV 1823', '', 1, '', 'Testament opgestel op 03/10/1801 te Swellendam.', '2026-07-10 13:37:03.764674', '2026-07-10 13:37:03.764715', NULL, NULL, NULL, NULL, 1, 0),
(19, 'Johannes', '', 'van Eeden', '', 'M', '', 'EST 1739', '', '', '', 1, '', '', '2026-07-10 13:40:51.116396', '2026-07-21 21:56:11.683541', NULL, NULL, NULL, NULL, 1, 0),
(20, 'Hermina', '', 'van Eeden', '', 'F', '', 'BEF 16 OCT 1740', '', '', '', 1, '', '', '2026-07-10 13:42:42.680366', '2026-07-10 13:42:42.680412', NULL, NULL, NULL, NULL, 1, 0),
(21, 'Elsje', '', 'van Eeden', '', 'F', '', 'BEF 20 JAN 1743', '', '', '', 1, '', '', '2026-07-10 13:46:21.180775', '2026-07-10 13:46:21.180816', NULL, NULL, NULL, NULL, 1, 0),
(22, 'Cornelis', 'Frans', 'van Eeden', '', 'M', '', 'BEF 20 JUL 1745', '', '', '', 1, '', '', '2026-07-10 13:47:41.291101', '2026-07-22 06:17:58.232311', NULL, NULL, NULL, NULL, 1, 0),
(23, 'Aletta', 'Peternella', 'van Eeden', '', 'F', '', 'BEF 3 APR 1763', '', '', '', 1, '', '', '2026-07-10 14:13:32.749593', '2026-07-10 14:13:32.749624', NULL, NULL, NULL, NULL, 1, 0),
(24, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', 'EST 1756', 'Swellendam, South Africa', '17 JUL 1836', 'Swellendam, South Africa', 1, 'Boer', '', '2026-07-10 14:18:04.436893', '2026-07-10 14:18:04.436925', NULL, NULL, NULL, NULL, 1, 0),
(25, 'Dorothea', 'Regina', 'van Eeden', '', 'F', '', 'BEF 2 JUL 1758', '', '30 MAR 1818', '', 1, '', '', '2026-07-10 14:20:25.533890', '2026-07-10 14:20:25.533927', NULL, NULL, NULL, NULL, 1, 0),
(26, 'Jacob', '', 'van Eeden', '', 'M', '', 'BEF 30 NOV 1760', '', '', '', 1, '', '', '2026-07-10 14:21:37.292917', '2026-07-10 14:21:37.292951', NULL, NULL, NULL, NULL, 1, 0),
(27, 'Gerrit', '', 'van Eeden', '', 'M', '', 'BEF 25 DEC 1762', '', '', '', 1, '', '', '2026-07-10 14:22:46.143835', '2026-07-10 14:22:46.143860', NULL, NULL, NULL, NULL, 1, 0),
(28, 'Hendrina', 'Hermina', 'van Eeden', '', 'F', '', 'BEF 21 APR 1765', '', '28 MAY 1830', '', 1, '', '', '2026-07-10 14:24:43.144772', '2026-07-10 14:24:43.144814', NULL, NULL, NULL, NULL, 1, 0),
(29, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', 'BEF 27 OCT 1782', '', '18 JUN 1878', '', 1, 'Hy het blykbaar op Het Goed Geloof geboer toe dit nog \'n leenplass was en sy seun, Gerrit Christiaan is daar gebore. Het Goed Geloof - groot 2 177 morg- is eers op 01/09/1832 deur die regering aan Jacobus Stephanus Bruwer toegeken. Frederik moes egter voor 1828 na die plaas Vaandrigtsdrift getrek het want sy tweede jongste seun, Pieter Christiaan is daar gebore. Frederik het op Vaandrigtsdrift tot sy vrou op 16/04/1880 op die plaas oorlede is, waarna sy seun Gabriël Jacobus die boerdery oorgeneem het en op Vaandrigtsdrift geboer het totdat hy daar oorlede is. Die naam Vaandrigtsdrift was daardie tyd op verskillende maniere geskryf, naamlik Drift of Drichts Drift of selfs Faandelsdrift.', '', '2026-07-11 14:46:11.075681', '2026-07-11 14:46:11.075718', NULL, NULL, NULL, NULL, 1, 0),
(30, 'Jacobus', 'Albertus', 'van Eeden', '', 'M', '', '24 MAY 1784', 'Swellendam, South Africa', '8 JUL 1855', '', 1, 'Boer', '', '2026-07-11 14:56:03.740795', '2026-07-11 14:56:03.740828', NULL, NULL, NULL, NULL, 1, 0),
(31, 'Zacharia', 'Geertruy', 'van Eeden', '', 'F', '', '14 OCT 1787', '', '', '', 1, '', '', '2026-07-11 15:00:39.117482', '2026-07-11 15:00:39.117529', NULL, NULL, NULL, NULL, 1, 0),
(32, 'Jacob', 'Johannes', 'van Eeden', '', 'M', '', 'BEF 21 FEB 1790', '', '', '', 1, '', '', '2026-07-11 15:02:05.259528', '2026-07-11 15:02:05.259609', NULL, NULL, NULL, NULL, 1, 0),
(33, 'Gerrit', 'Christiaan', 'van Eeden', '', 'M', '', '21 JUN 1791', '', '23 SEP 1860', 'Swellendam, South Africa', 1, 'Gebore op Boesjesmans Pad en sterf in sy huis; landboer op Het Goed Geloof, groot 2 177 morg is op 01/09/1832 deur die Regering aan Jacobus Stephanus Bruwer toegeken; 1869 koop hy 1 163 morg van die plaas van Bruwer, en op 04/02/1869 word dit in sy naam en sy drie seuns Dirk Cornelius, Jacobus Albertus en Hermanus Johannes geregistreer; 24/12/1896 verkoop Bruwer 1 014 morg van Het Goed Geloof aan Paul Jacobus Jordaan; 31/12/1907 na Paul se dood word die grond oorgeplaas in die naam van sy vrou, Susanna Catharina Jordaan.', '', '2026-07-11 15:45:33.506844', '2026-07-11 15:45:33.506917', NULL, NULL, NULL, NULL, 1, 0),
(34, 'Cornelia', 'Margaretha', 'van Eeden', '', 'F', '', 'BEF 21 APR 1793', '', '27 DEC 1869', 'Swellendam, South Africa', 1, '', '', '2026-07-11 15:49:05.252453', '2026-07-22 21:04:56.359500', NULL, NULL, NULL, NULL, 1, 0),
(35, 'Hendrina', 'Hermina', 'van Eeden', '', 'F', '', '13 JAN 1795', '', '17 NOV 1825', 'Swellendam, South Africa', 1, '', '', '2026-07-11 15:51:33.330225', '2026-07-11 15:51:33.330255', NULL, NULL, NULL, NULL, 1, 0),
(36, 'Gideon', 'Willem', 'van Eeden', '', 'M', '', 'BEF 16 APR 1797', 'Swellendam, South Africa', '12 APR 1856', 'Swellendam, South Africa', 1, 'Gebore op Naauwkloof, dist. Swellendam; sterf op Bosjesmanspad, Swellendam. Ontvang Bosjesmanspad groot 4 356 morg as Quitrent toewysing op 12/05/1848; erfgename verloor dit as gevolg van kontant skuld in 1868.', '', '2026-07-11 16:00:05.743375', '2026-07-11 16:00:05.743419', NULL, NULL, NULL, NULL, 1, 0),
(37, 'Jan', 'Bastiaan', 'van Eeden', '', 'M', '', 'BEF 15 DEC 1798', '', '', '', 1, '', '', '2026-07-11 16:02:37.314118', '2026-07-11 16:02:37.314145', NULL, NULL, NULL, NULL, 1, 0),
(38, 'Maria', 'Elizabeth', 'van Eeden', '', 'F', '', 'BEF 10 AUG 1800', '', '', '', 1, '', '', '2026-07-11 16:03:52.080500', '2026-07-11 16:03:52.080538', NULL, NULL, NULL, NULL, 1, 0),
(39, 'Dorothea', 'Regina', 'van Eeden', '', 'F', '', '19 JUN 1803', '', '21 NOV 1828', 'Swellendam, South Africa', 1, '', '', '2026-07-11 16:06:06.982125', '2026-07-11 16:06:06.982164', NULL, NULL, NULL, NULL, 1, 0),
(40, 'Catharina', 'Johanna', 'van Eeden', '', 'F', '', '27 MAY 1804', '', '28 SEP 1876', 'Swellendam, South Africa', 1, '', '', '2026-07-11 16:08:37.327752', '2026-07-11 16:08:37.327794', NULL, NULL, NULL, NULL, 1, 0),
(41, 'Hermina', 'Elizabeth', 'van Eeden', '', 'F', '', 'BEF 1 OCT 1809', '', '', '', 1, 'Sterf op \'n jong ouderdom.', '', '2026-07-11 16:40:23.475794', '2026-07-11 16:40:23.475838', NULL, NULL, NULL, NULL, 1, 0),
(42, 'Cornelia', 'Margaretha', 'van Eeden', '', 'F', '', 'BEF 5 JAN 1811', '', '', '', 1, '', '', '2026-07-11 16:41:56.312222', '2026-07-11 20:11:58.985917', NULL, NULL, NULL, NULL, 1, 0),
(43, 'Maria', 'Elizabeth', 'van Eeden', '', 'F', '', 'EST DEC 1811', 'Swellendam, South Africa', '', '', 1, '', '', '2026-07-11 16:44:16.099922', '2026-07-11 16:44:16.099992', NULL, NULL, NULL, NULL, 1, 0),
(44, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', '1 AUG 1813', 'Swellendam, South Africa', '', '', 1, 'Hy en sy seuns was transportryers vanaf die Kaap na die Noorde en veral Kimberley met toerusting vir die myners.', '', '2026-07-11 16:48:10.720809', '2026-07-11 16:48:10.720839', NULL, NULL, NULL, NULL, 1, 0),
(45, 'Gabriel', 'Jacobus', 'van Eeden', '', 'M', '', 'BEF 7 MAY 1815', '', '18 JUN 1878', 'Breederivier, South Africa', 1, 'Sterf in sy woning te Vaandrigtsdrift; boer; van Drift, Breederivier toe hy trou.', '', '2026-07-11 16:56:19.844131', '2026-07-11 16:56:19.844161', NULL, NULL, NULL, NULL, 1, 0),
(46, 'Jacobus', 'Petrus', 'van Eeden', '', 'M', '', 'EST DEC 1816', '', '', '', 1, '', '', '2026-07-11 16:59:16.558669', '2026-07-11 16:59:16.558697', NULL, NULL, NULL, NULL, 1, 0),
(47, 'Hermina', 'Elizabeth', 'van Eeden', '', 'F', '', '24 OCT 1818', '', '', '', 1, '', '', '2026-07-11 17:00:58.498910', '2026-07-11 17:00:58.498968', NULL, NULL, NULL, NULL, 1, 0),
(48, 'Zacharia', 'Geertruida', 'van Eeden', '', 'F', '', '24 MAY 1822', '', '', '', 1, '', '', '2026-07-11 17:02:37.488071', '2026-07-11 17:02:37.488099', NULL, NULL, NULL, NULL, 1, 0),
(49, 'Margaretha', 'Johanna', 'van Eeden', '', 'F', '', '28 MAY 1824', '', '', '', 1, '', '', '2026-07-11 17:04:05.913177', '2026-07-11 17:04:05.913206', NULL, NULL, NULL, NULL, 1, 0),
(50, 'Gerrit', 'Christiaan', 'van Eeden', '', 'M', '', '18 OCT 1826', '', '22 FEB 1926', 'Barrydale, South Africa', 1, 'Gebore op Goedgeloof; \'n moontlike geskiedenis van hom en De Vlakte volgens beskikbare inligting; Gert was bietjie meer as \'n jaar oud toe sy ouers vanaf Het Goed Geloof na die plaas Vaandrigtsdrift getrek het en het Gert dus daar grootgeword. Toe hy egter groot en oud genoeg was (moontlik 21 jaar) besluit hy om terug te keer na sy geboorteplaas (moontlik 1847) en huur die deel van Het Goed Geloof wat genoem was De Vlakte by die dan eienaar Jacobus Stephanus Bruwer, om daarop te boer want volgens oorlewering het Gert op De Vlakte geboer (navorser se tant Abrama het aan hom vertel dat sy kan onthou dat oupagrootjie op De Vlakte geboer het). Vier jaar na sy intrek trou hy met die eienaar Bruwer se dogter. \'n Tweede moontlikheid bestaan ook dat Gert boerderyregte by sy skoonpa gekry het nadat hy met die dogter getrou het want Gert was toe al 25 jaar oud. Twee jaar later word hulle seun, Gerrit Christiaan, op Goedgeloof gebore. Hierdie seun moes toe op \'n stadium die boerdery by sy pa oorgeneem het want heelwat later in 1891 word sy tweede jongste dogter, Susanna Johanna, op Goedgeloof gebore. Hy moes egter voor 1913 besluit het om op Barrydale te gaan woon want hierdie dogter, toe nog \'n ongetroude onderwyseres, is op 09/09/1913 in sy huis op Barrydale oorlede en hy self in sy huis op Barydale oorlede. Toe hy besluit het om op te hou boer, moes sy suster, Susanna Johanna, getroud met Casper Francois Lotz, blykbaar die boerdery by haar broer oorgeneem het want sy is op 05/03/1897 op 27 jarige ouderdom op Goedgeloof oorlede.', '', '2026-07-11 17:36:12.993074', '2026-07-11 17:36:12.993105', NULL, NULL, NULL, NULL, 1, 0),
(51, 'Pieter', 'Christiaan', 'van Eeden', '', 'M', '', '8 OCT 1828', 'Swellendam, South Africa', '21 APR 1911', 'Robertson, South Africa', 1, 'Gebore op Drights Drift dist. Swellendam; sterf in sy huis op Robertson; winkelier.', '', '2026-07-11 17:41:57.267494', '2026-07-11 17:41:57.267551', NULL, NULL, NULL, NULL, 1, 0),
(52, 'Gideon', 'Albertus', 'van Eeden', '', 'M', '', '5 SEP 1830', '', '', '', 1, 'Hy word nie genoem in sy moeder se sterfkennis nie.', '', '2026-07-11 17:44:38.117834', '2026-07-11 17:44:38.117858', NULL, NULL, NULL, NULL, 1, 0),
(53, 'Aletta', 'Susanna', 'van Eeden', 'Bruwer', 'F', '', '24 DEC 1826', '', '', '', 1, 'Van die plaas Weltevrede; A. Francina geb. 10/10/1834 volgens Bruwer-boek. (d.v. Jacobus Stephanus Bruwer & Aletta Francina Bruwer)', '', '2026-07-11 18:14:54.445027', '2026-07-12 21:47:41.176163', NULL, NULL, NULL, NULL, 1, 0),
(54, 'Gerrit', 'Christiaan', 'van Eeden', '', 'M', '', '20 MAY 1853', 'Swellendam, South Africa', '22 DEC 1926', 'Barrydale, South Africa', 1, '', 'Gebore op Goedgeloof, dist. Swellendam; Sterf in sy huis op Barrydale.', '2026-07-11 18:20:48.825546', '2026-07-11 18:20:48.825590', NULL, NULL, NULL, NULL, 1, 0),
(55, 'Jacobus', 'Stefanus', 'van Eeden', '', 'M', '', '23 SEP 1855', 'Montagu, South Africa', '', 'Barrydale, South Africa', 1, '', 'Sterf in sy huis op Barrydale.', '2026-07-11 18:26:02.526132', '2026-07-11 18:26:02.526176', NULL, NULL, NULL, NULL, 1, 0),
(56, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', 'people/photos/Frederik_Jacobus_-_a1b4c5d1f10g3.jpeg', '8 OCT 1857', '', '30 JUL 1934', 'Bethulie, South Africa', 1, 'Boer; hy het eers geboer Rietvlei nr. 1, dist. Momtagu; trek na Suid Vrystaat en koop die plaas Vergelegen - eers genoem Greenlands - tussen die Oranje- en Caledonrivier 17 myl vanaf Bethulie op die ou Aliwal-Noord pad. Dit is nou \'n wildplaas genoem Tussen-die-Riviere. Vir sy nageslag was hy bekend as oupa Frikkie. Op sy plaas by Montagu was \'n plaasskool waarvan mej. Perold die prinsipale was. Agter die stalle was \'n klein geboutjie wat die eerste skool in daardie hele gebied was. Hy trek Vrystaat toe omdat hy moeg geword het vir die landbou boerdery en sou met volstruise in die Vrystaat gaan boer. Die volstruisboerdery was nog nie op dreef nie toe die val van volstruisveerpryse veroorsaak dat daar oorgeslaan moet word na gemengde boerdery. Van die volstruise word geslag en biltong gemaak en die res was deur die Grootrivier gejaag. Omdat hy gewoond was aan die skool op sy plaas het hy ook \'n skool op Vergelegen begin waar sy kinders en ouer kleinkinders dan ook skoolgegaan het. Dit was sy twee kleinseuns Fred en Leonard se werk om elke oggend die klaskamer se vloer blink te vryf. Frikkie se skoondogter Lasea Abrama Coetzee, het op \'n stadium daar skoolgehou.', 'Graf in Bethulie.', '2026-07-11 19:06:46.519349', '2026-07-11 19:06:46.519392', NULL, NULL, NULL, NULL, 1, 0),
(57, 'Dirk', 'Cornelis', 'van Eeden', '', 'M', '', '21 APR 1861', '', '', '', 1, '', '', '2026-07-11 19:09:51.728568', '2026-07-11 19:09:51.728616', NULL, NULL, NULL, NULL, 1, 0),
(58, 'Aletta', 'Francina', 'van Eeden', '', 'F', '', '21 AUG 1863', '', '', '', 1, '', '', '2026-07-11 19:11:11.912520', '2026-07-11 19:11:11.912569', NULL, NULL, NULL, NULL, 1, 0),
(59, 'Martha', 'Elizabeth', 'van Eeden', '', 'F', '', '15 OCT 1865', '', '', '', 1, '', '', '2026-07-11 19:12:46.122578', '2026-07-11 19:12:46.122622', NULL, NULL, NULL, NULL, 1, 0),
(60, 'Jacoba', 'Jacomina', 'van Eeden', '', 'F', '', '6 JUL 1868', '', '', '', 1, '', '', '2026-07-11 19:14:10.169257', '2026-07-11 19:14:10.169298', NULL, NULL, NULL, NULL, 1, 0),
(61, 'Susanna', 'Johanna', 'van Eeden', '', 'F', '', '24 DEC 1870', '', '5 MAR 1897', 'Swellendam, South Africa', 1, '', 'Sterf op Goedgeloof, Swellendam.', '2026-07-11 19:17:16.243678', '2026-07-11 19:17:16.243715', NULL, NULL, NULL, NULL, 1, 0),
(62, 'Margaretha', 'Aletta', 'van Eeden', '', 'F', '', '5 JUL 1873', '', '', '', 1, '', '', '2026-07-11 19:18:50.816245', '2026-07-11 19:18:50.816276', NULL, NULL, NULL, NULL, 1, 0),
(63, 'Catharina', 'Johanna Jacoba', 'van Eeden', 'Rossouw', 'F', '', '17 AUG 1855', '', '28 JAN 1931', 'Bethulie, South Africa', 1, '', 'Sterf by haar seun te Vergelegen; graf op Bethulie; (d.v. Daniel Hendrik Rossouw & Susanna Catharina Burger).', '2026-07-11 19:30:40.895642', '2026-07-11 19:30:40.895690', NULL, NULL, NULL, NULL, 1, 0),
(64, 'Elizabeth', 'Margaretha Susanna', 'van Eeden', 'van Niekerk', 'F', '', '17 JUL 1873', '', '', '', 1, 'Wed. van Davis, wie voorheen \'n lemonade-fabriek op Bethulie gehad het toe lemonade nog in die bottel met die albaster in die nek vekry was.', '', '2026-07-11 19:51:48.571231', '2026-07-11 19:51:48.571282', NULL, NULL, NULL, NULL, 1, 0),
(65, 'Daniel', 'Hendrik', 'van Eeden', '', 'M', 'people/photos/Daniel_Hendeik_-_a1b4c5d1e1f10g3h1_ZxRugBv.jpeg', '10 APR 1877', '', '8 APR 1933', 'Umtali, Zimbabwe', 1, 'Boer; hy was alom bekend as Dan. Omdat hy die oudste was en reeds \'n gesin gehad het moes hy sy eie plaas besit. Met geldelike hulp van sy pa koop hy die plaas Klipfontein wat aan sy pa se plaas Vergelegen grens en verander die naam na Edendal, waar hy geboer het vanaf ongeveer 1912 tot omtrent 1923. Gedurende 1922 is sy koringoes verwoes deur springkane en het hy net 12 sakke geoes wat hy moes deel met sy twee seuns, Daantjie en Dawid. Hy was bitter kwaad vir sy twee seuns omdat hul hulle deel gevat het en hom met net 4 sakke koring gelos het waarmee hy sy verpligtinge moes nakom. Hy besluit om sy plaas te verkoop en trek in 1923 Rhodesië toe en neem sy dogter Kate - toe al 16 jaar oud - saam met hom om vir hom te gaan sorg. Sy seuns het hy agtergelaat en sovêr bekend het hy tot sy dood nooit weer kontak met hulle gemaak nie. Sovêr bekend, het Dan weer in Rhodesië \'n boerdery begin in die omgewing van Umtali en hy noem die plaas ook Eedendal. Hier het hy geboer met beeste en mielies en heelwat ontbeur. \'n Groot rivier was een van die plaas se grense maar daar was nie \'n brug oor die rivier nie en kon alleenlik oorgesteek word deur middel van \'n klipdrif in die rivier, gevolglik moes die rivier baie keer trotseer word terwyl die watervlak baie hoog was.', 'Sterf op sy plaas Eedendal aan swartwaterkoors. Graf op Umtali, Suid Rhodesië. Die foto wys hom en sy kinders, Daniel Hendrik (voor links), Dawid Burger (agter links) en Catharina Johanna (Agter regs).', '2026-07-12 09:15:40.423544', '2026-07-12 09:25:28.646646', NULL, NULL, NULL, NULL, 1, 0),
(66, 'Aletta', 'Susanna Francienna', 'van Eeden', '', 'F', '', '20 OCT 1881', '', '31 JAN 1967', '', 1, '', 'Graf op Stikland.', '2026-07-12 09:31:01.581495', '2026-07-12 21:06:39.968185', NULL, NULL, NULL, NULL, 1, 0),
(67, 'Gert', 'Christiaan', 'van Eeden', '', 'M', '', '15 OCT 1883', '', '', '', 1, '', '', '2026-07-12 15:55:10.178400', '2026-07-12 15:55:10.178445', NULL, NULL, NULL, NULL, 1, 0),
(68, 'Susanna', 'Catharina', 'van Eeden', '', 'F', 'people/photos/Susanna_Catharina_-_a1b4c5d1e1f10g3h4.jpeg', '19 AUG 1885', '', '18 DEC 1969', 'Bethulie, South Africa', 1, '', '', '2026-07-12 15:58:00.953604', '2026-07-13 06:02:23.404211', NULL, NULL, NULL, NULL, 1, 0),
(69, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', '16 OCT 1886', '', 'EST 1893', '', 1, '', '', '2026-07-12 15:59:11.992261', '2026-07-12 15:59:11.992298', NULL, NULL, NULL, NULL, 1, 0),
(70, 'Andreas', 'Bartholomeus', 'van Eeden', '', 'M', '', '8 JUN 1888', '', '', '', 1, '', '', '2026-07-12 16:00:53.744134', '2026-07-12 16:00:53.744170', NULL, NULL, NULL, NULL, 1, 0),
(71, 'Jacobus', 'Stefanus', 'van Eeden', '', 'M', 'people/photos/Jacobus_Stefanus_-_a1b4c5d1e1f10g3h7.jpeg', '6 FEB 1890', 'Montagu, South Africa', '4 NOV 1944', 'Bloemfontein, South Africa', 1, 'Hy het groot geword op Rietvlei nr 1 en het ook skool gegaan op die plaas. As jong seun van 16 jaar trek hy saam met sy ouers Vrystaat toe na die plaas Vergelegen langs die Oranjerivier, in Bethulie distrik, wat sy pa gekoop het. Hy en sy broer Fanie het op die onderste gedeelte van die plaas begin boer met volstruise. In die tyd is hy getroud met \'n meisie vir wie hy te perd in Smithfield distrik gaan kuier het. Sy twee oudste seuns Fred en Leonard is daar gebore. Toe sy pa dorp toe trek, gaan bly hy en sy gesin op die boonste deel van die plaas. Nadat \'n landmeter die plaas opgemeet het en verdeel het in Vergelegen A en B was die deel waar hy op bly Vergelegen A genoem en die ondertse gedeelte Vergelegen B. Eers na sy pa se dood kon hy die plaas op sy naam registreer. Op 24 Oktober 1935 onder Transport 2345/1935 registreer hy Rossouw nr 355 groot 100 morge op sy naam en op 18 Julie 1936 onder Transport nr 1876/1936 registreer hy Vergelegen A nr 342 (vroeër nr 563 distrik Rouxville) groot 665.6 morge op sy naam. Op 14 Julie 1925 onder Transport nr 2479/1925 registreer hy ook erf nr 652 groot 69 vk roede 64 vk vt wat hy gekoop het vir 255 pond op sy naam.\r\n\r\nToe Jacobus op Vergelegen A begin boer het was daar net \'n woonhuis, \'n waenhuis en een land onder lusern onderkant die woonhuis. Hy moes eerstens begin sorg vir water vir die land en koop toe \'n Imperial gasenjin by \'n boer langs die Caledonrivier. Die enjin is op \'n slee gelaai en met \'n span osse die rivierwalle uitgesleep en toe op \'n klipwa gelaai om te vervoer Vergelegen toe. (\'n Klipwa is \'n lae plat wa met houtblok rollers vir wiele, wat gebruik was om klippe uit die lande uit te ry). So \'n pompstelsel het bestaan uit \'n enjin, \'n generator en \'n gasreiniger (scrubber). Die generator het bestaan uit \'n hopper, \'n verdamper (vaporiser), \'n rooster en \'n aspan. Vuur is gemaak met antrasiet in die generator en die ingeboude verdamper het stoom deur die vuur laat trek om gasse te vorm en om versmelting en klinkering te voorkom. Vanaf die generator het die gas na die reiniger gegaan wat gevul was met kooks waardeur water gevloei het om die gas te reinig. Dan het die gas na \'n versamelkas (expansion box) gegaan wat by die enjin monteer was waar die gas versamel word om \'n standhoudende toevoer na die enjin te bewerkstellig. Die gas word dan deur die suier van die enjin ingesuig om deur \'n ontstekingsmagneet aan die brand gesteek te word. Twee groot vliegwiele aan weerskante van die enjin voorsien momentum en krag aan die suier wat \'n sentrifugale pomp moet aandryf om die water uit die rivier te pomp.\r\n\r\nNa die masjien opgerig is, het die eerste vloed in 1925 gekom. Die Oranjerivier het sy walle oorstroom en die hele masjien en die masjienhuis bedek onder die modderwater. In 1933, na die droogte, het die rivier vir die tweede keer sy walle oorstroom. Na elke vloed was dit \'n groot werk om die slik uit die masjienhuis te verwyder en die masjienerie weer skoon te kry voordat dit kon gebruik word. Antrasiet was die brandstof vir \'n gasenjin maar gedurende die depressie van 1931 - 1934 was dit onverkrygbaar en geld net so skaars. \'n Plaasvervanger is vervardig deur \'n groot gat te grawe en droë hout, wat na die vloed volop langs die rivier beskikbaar was, daarin te verbrand om houtskool te maak. Voordat die hout heeltemal uitgebrand was, is dit toegegooi met grond om te smoor en te verhoed dat dit tot as verbrand. Houtskool het net sulke goeie gas vervarrdig as antrasiet maar mens het meer daarvan gebruik. Gedurende die jare 1928 tot 1933 het \'n sak antrasiet 3 sjielings gekos. Daar is gewoonlik 10 ton antrasiet bestel wat 10 pond gekos het en die spoorvrag daarop was 11 pond. Daar kon \'n hele dag gepomp word met twee sakke antrasiet wat die lopende koste met arbeid op 10 sjielings per dag te staan gebring het.\r\n\r\nBy die gasenjin is ook \'n klipmeule opgerig wat deur die gasenjin aangedryf is. Die maalstene is van klip gemaak. Navorser kan nog onthou dat die maalstene af en toe uitgehaal is om skerp te maak. Dan is met hamer en beitel holtes in die platkant gekap wat skerp kantjies gevorm het wat die maalaksie bevorder het. Mielies en koring is gemaal vir huis gebruik. Die ongesifte mieliemeel het die geurigste pap gemaak en die koringmeel het die lekkerste bruinbrood gebak want die kiem van die pit is nie verwyder nie. Na die oprigting van die pomp moes landerye bygemaak word. Die rivier oewers is ontbos en doringbome en meestal bloubos met die hand uitgehaal.', 'Gebore op Rietvlei nr 1, dist. Montagu; Sterf in Nasionale Hospitaal, Bloemfontein aan lewerkanker; graf op Bethulie.\r\nFoto van hom en sy familie - Maria Magdalena Haasbroek (Vrou links agter), Frederik Jacobus (middel agter), Leonard Johannes (regs agter), Jacobus Stefanus (regs voor) en Daniel Hendrik (middel voor).', '2026-07-12 16:38:43.712622', '2026-07-12 18:04:42.311274', NULL, NULL, NULL, NULL, 1, 0),
(72, 'David', 'Jacobus Johannes', 'van Eeden', '', 'M', '', '8 OCT 1891', '', '', '', 1, '', '', '2026-07-12 18:07:56.937024', '2026-07-12 18:07:56.937054', NULL, NULL, NULL, NULL, 1, 0),
(73, 'Stefanus', 'Jacobus Albertus', 'van Eeden', '', 'M', 'people/photos/Stefanus_Jacobus_Albertus_-_a1b4c5d1e1f10g3h9.jpeg', '7 FEB 1893', '', '25 MAR 1972', 'Bloemfontein, South Africa', 1, 'Hy het geboer op plaas Vergelegen B, dist. Bethulie en later op \'n naby De Brug en voor sy aftrede op \'n plaas naby Barkley-Oos; Woonagtig te Koning Wilhelmstraat 22, Bayswater, Bloemfontein voor sy dood.', 'Fot van hom en sy vrou, Lasea A. Coetzee.', '2026-07-12 18:38:43.851219', '2026-07-12 18:38:43.851266', NULL, NULL, NULL, NULL, 1, 0),
(74, 'Catharina', 'Johanna', 'van Eeden', '', 'F', '', '10 MAY 1896', '', '', '', 1, '', '', '2026-07-12 18:42:22.571060', '2026-07-12 18:42:22.571095', NULL, NULL, NULL, NULL, 1, 0),
(75, 'Pieter', 'Alwyn', 'van Eeden', '', 'M', 'people/photos/Pieter_Alwyn_-_a1b4c5d1e1f10g3h11.jpeg', '22 JUL 1899', '', '5 AUG 1974', '', 1, 'Hy het in sy jong dae saam met sy pa geboer op Vergelegen A maar, toe hy trouplanne kry begin hy in 1920 \'n eenmansaak op Bethulie as skrynwerker, stoffeerder en restoureerder van ou meubels. As gevolg van die depressie was die besigheid later nie meer lewensvatbaar nie en besluit hy in 1933 om Johannesburg toe te trek waar hy toetree tot die boubedryf as skrynwerker (in daardie dae was deure en kosyne nog deur skrynwerkers gemaak). Na die uitbreek van die tweede Wêreldoorlog het Pieter met navorser deur al die industriële gebiede van Johannesburg geloop om vir navorser werk te soek maar oral was kennisgewings opgeplak dat net vroue benodig word. Uiteindelik het Pieter vir navorser werk gekry op die Spoorweë in Braamfontein. Na die dood van Pieter se vrou, trou hy met \'n weduwee wie \'n vis en skyfie winkel gehad het met tafels en stoele waar mense kon sit en eet. As gevolg van die oorlog moes hul die besigheid sluit. Pieter wend hom weer tot die boubedryf terwyl sy vrou begin loseerders inneem. So kom dit dat navorser na die oorlog weer by hul beland as loseerder nadat hy sy werk op die Spoorweë teruggekry het.\r\n\r\nTydens 1946 begin Pieter \'n tuisnywerheid saam met sy oudste seun en vervaardig speelgoed in sy agterplaas uit tamatiekasplanke. Hy het \'n goeie bestaan gevoer totdat plastiek speelgoed die mark oorgeneem het en hy weer moes terugkeer na die boubedryf. Na sy tweede vrou oorlede is, gaan bly hy tot sy dood by sy jongste seun Giep. Pieter Pieter was \'n gemoedelike man en het selde kwaad geword maar het geweet hoe om dissipline te handhaaf. Hy het baie geduld en deursettingsvermoë gehad en sy hande het vir niks verkeerd gestaan nie. Hy het \'n breë kennis gehad en het altyd gesê daar is net een ding waarmee jy kan steel sonder om tronk to te gaan en dit is om te steel met die oog. In sy werk was hy \'n perfeksionis en het geglo dat \'n mens altyd trots moet wees op jou werk sodat jy nooit skaam hoef te wees om te erken dat dit jou handewerk is nie. Hy was altyd bereid om te help en selfs toe hy baie siek was en baie pyn moes verduur was hy gewillig om te luister en te help met raad. Sy goeie hoedanighde het hy oorgedra aan sy kinders en veral sy jongste seun Giep wie self vier seuns het, probeer almal hard om in hulle oupa se voetspore te volg.', 'Graf op Grahamstad.\r\nFoto van hom alleen.', '2026-07-12 19:37:15.273712', '2026-07-12 19:37:15.273763', NULL, NULL, NULL, NULL, 1, 0),
(76, 'Maria', 'Magdalena Wilhelmina', 'van Eeden', 'Haasbroek', 'F', '', '19 NOV 1887', 'Bethulie, South Africa', '12 APR 1943', 'Bethulie, South Africa', 1, 'Van Oliefenfontein, Smithfield met huwelik. Sy was alom bekend as Meraai en was \'n sterk en hardwerkende boervrou - kort en geset en het eendag in haar kombuis \'n uitgegroeide jong swart met een klap plat teen die vloer geslaan. Sy was baie lief vir haar pluimvee en het geboer met hoenders, kalkoene, eende, makoue en \'n groot trop ganse. Die ganse is dikwels gepluk vir hul vere en donse. Die ganse kon geniepsig byt wanneer hulle gepluk word en navorser sien nou nog die prentjie van sy ma met \'n gans op haar skoot en die gans se kop met \'n kous daaroor getrek onder haar arm vasgeknyp.\r\n\r\nSy was \'n bobaas kok en kon die lekkerste boerekos kook wat altyd opspraak verwek het by elke kuiergas. Die gevolg was dat die plaas tydens skoolvakansies gewemel het van kuiermense en kinders. Sy het \'n boerekonsertina besit en kon dit ook bespeel. Sy was lief om namiddae wanneer sy naaldwerk doen, vir haar kleiner kinders wat nog nie op die lande kon werk nie, by haar voete op die vloer te llat sit en dan vir hulle stories te vertel, liedjies te sing en op die konsertina te speel. Sy was saam met haar moeder en jonger broers en susters in die konsentrasiekamp op Behulie waar sy ook twee van haar sustertjies aan die dood moes afstaan.\r\n\r\nEendag, nadat sy lank gekerm het oor die tekort aan vuurmaakhout op die werf, het sy die kos alles voorberei en op die dooie stoof in kastrolle gesit. Toe die mans van die lande af kom om te kom eet, sê sy vir hulle \'Daar staan julle rou kos op die stoof, eet dit as julle wil, want hoe moet ek dit gaarmaak sonder hout?\'. Hulle moes toe maar tevrede wees met brood en melk maar daarna was daar altyd berge hout op die werf, want hout was volop bekombaar langs die rivier en is aangery huis toe met \'n bokwa.\r\n\r\n\'n Ander buurplaas wat aan Vergelegen gegrens het was Grootrivier nr 445, groot 640 mrrge, \'n gedeelte van die plaas Damfontein nr 341 wat aan Ben Coetzee behoort het. Maria se pa koop toe Grootrivier by Ben Coetzee en gee dit later vir Maria as \'n geskenk. Op 16 Junie 1939 met Transport nr 1702/1939 word Grootrivier in haar man se naam geregistreer.', 'Gebore op plaas Pandam, dist. Bethulie; sterf in hul dorpshuis op Bethulie aan hartaanval; Graf in Bethulie. (d.v. Leendert Johannes Haasbroek & Johanna Margaretha Haasbroek).', '2026-07-12 20:29:12.377540', '2026-07-12 20:29:12.377575', NULL, NULL, NULL, NULL, 1, 0),
(77, 'Elizabeth', 'Cornelia', 'van Eeden', 'Haasbroek', 'F', '', '2 NOV 1898', 'Bethulie, South Africa', '23 MAY 1953', 'Bloemfontein, South Africa', 1, 'Van Sleutelpoort, dist. Bethulie tydens huwelik; wwomagtig in hul dorpshuis te Murraystraat16, Bethulie voor haar dood. Sy het vruggebruik van die dorpshuis gehad. Sy het tot 1952 in die oorspronklike dorpshuis gebly maar namate sy ouer geword het dit baie ongerieflik gevind omdat dit vêr van die winkels af was. Sy vra toe haar vyf stiefseuns om die erf te verkoop om \'n ander een nader na die middedorp te koop en onderneem om alle kostes self te betaal, wat te staan gekom het op 56 pond 16 sjielings en 8 pennies. Die rf word verkoo aan J Venter vir 800 pond en die seuns koop toe erf nr 263, groot 34 vk roede 104 vk vt in Murraystraat 16 vir 800 pond op 19 Mei 1952 by mev Maria Jacoba Steyn, waarop hul stiefma toe lewensreg kry en net een jaar woon tot sy sterf. Na haar dood word die erf verkoop aan PWA Nel vir 900 pond. Nadat kostes afgetrek is, word die balans van 859 pond 12 sjielings en 11 pennies gelykop verdeel onder die vyf seuns en elkeen kry 171 pond 18 sjielings en 7 pennies. Bettie se eie bates van 476 pond 19 sjielings en 10 pennies word onder haar broers en susters verdeel. Die huisraad is op die vendusie verkoop vir 48 pond 13 sjielings. Die breekgoed en ander klein losgoed is in vyf hope verdeel en die vyf seuns moes elk \'n lootjie trek vir \'n hopie goed.', 'Sterf in die Nasionale Hospitaal, Bloemfontein.\r\n(d.v. Johannes Bernardus Haasbroek & Johanna Margaretha Haasbroek)', '2026-07-12 20:58:08.435107', '2026-07-12 20:58:08.435177', NULL, NULL, NULL, NULL, 1, 0),
(78, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', 'people/photos/Frederik_Jacobus_-_a1b4c5d1f10g3h7i1.jpeg', '15 DEC 1912', 'Bethulie, South Africa', '26 AUG 1979', 'Bloemfontein, South Africa', 1, 'Hy was woonagtig te Victoria Hotel, Bloemfontein, tydens huwelik. Hy was \'n man met \'n ingenieurskop. As seun het hy altyd gepeuter met \'n wekker of \'n horlosie om te sien hoe dit werk. \'n Vliegtuig het hom altyd beindruk as \'n wonderlike stel masjienerie. Sy skoolloopbaan begin by die plaasskool op Vergelegen A en hy moes elke dag twee myl ver loop van Vergelegen B om by die skool te kom. Vanaf std 3 het hy op Bethulie skoolgegaan. Toe hy 12 jaar oud was, is hy saam met sy oom Fanie Oudshoorn toe om daar \'n Tangy gasenjin te gaan afbreek en dit op die trein te laai Bethulie toe om die stoomenjin te vervang wat in gebruik was op Vergelegen B. Op hierdie ouderdom het hy meerendeels die enjin alleen aanmekaar gesit.\r\n\r\nOp \'n dag het hy gewaag om by sy oupa op Vergelegen A, in die volstruise se broeikamp in te gaan maar een kwaai volstruismannetjie storm hom en hy moes vlug en was nog besig om deur die draad te kruip toe die mannetjie hom skop en vinnig deur die draad help.\r\n\r\nFred verlaat skool na std 7, hoofsaaklik omdat hy skaam geword het vir die klere wat hy moes aantrek. Die baadjies se moue was te kort en die broeke se pype het bokant sy enkels gesit. Hy kom toe met sy pa ooreen dat hy sal gaan boer maar dat hy sy eie land sal aanlê waarop hy kan saai en oes en hy maak toe \'n stuk grond skoon vanaf die pomphuis to by die grensdraad van Vergelegen B. Hy bou \'n leivoor teen die rantjies; die klipbank het hy self geskiet met dinamiet; die gate met hamer en beitel geboor. In die voormaak proses het hy byna sy lewe verloor nadat hy \'n gat gelaai en die lont aan die brand gesteek het, maar toe hy moes weghardloop, sit sy voet in \'n klipskeur vas. Hy het egter teenwoordigheid van gees behou en net plat bly lê en sodoende sy lewe behou. Toe die eerste oes van die land af kom vat sy pa dit vir homself en gee vir Fred net drie sakke met die verskoning dat hy eers sy kostes moet verhaal. Dit het vir Fred gebreek en hy verlaat die plaas om vir oom Willie van Tonder op die buurplaas te gaan werk en bedryf sy dorsmasjien vir hom vir een en \'n half jaar. In diè tyd koop oom Willie van Tonder die meule op Bethulie en Fred gaan help hom om die meule te bedryf. In die tyd voltooi Fred \'n diploma kursus as passer en draaier en verwerf \'n NTS 3 diploma. Die meule speel egter bankrot en Fred moes Bloemfontein toe gaan om te gaan werk soek. Hy kry werk by Feddels Foundry as passer en draaier, maar na twee jaar besluit hy en oom Willie van Tonder se dogter, Anna, met wie hy toe al sewe jaar lank uitgaan, om op 20 Augustus 1941 op haar 24ste verjaardag verloof te raak en op Fred se 29ste verjaardag op Bethulie te trou.\r\n\r\nNa \'n suksesvolle loopbaan by Feddels Foundry besluit Fred om vir die Bloemfonteinse munisipaliteit te gaan werk by hul Tempe steengroef. Op 22 Augustus kry hy \'n vaste aanstelling. Gedurende 1947 gaan die Superintendent van die steengroef met langverlof en in Mei 1947 word Fred aangestel as waarnemende superintendent. Op 1 Augustus 1948 word Fred aangestel as voorman passer en draaier teen \'n salarisskaal van 480 pond per jaar. Op 1 September 1949 word hy aangestel as waarnemende superintendent van Tempe steengroef teen \'n salaris van 540 pond per jaar. In Junie 1954 kry hy \'n salarisverhoging na 620 pond per jaar. Op 1 April 1956 word sy salaris verhoog na 810 pond.\r\n\r\nIn diè tyd was daar nie \'n gesertifiseerde ingenieur by die groef nie en Fred word aangestel om die ingenieur se pligte op hom te neem vanaf 2 Oktober 1956. Op 1 November 1961 word hy bevorder van Groefsuperintendent na Groefbestuurder. Vanaf 22 November 1962 word alle verantwoordelikheid van springstowwe en skietwerk binne en buite die groef op hom geplaas. Eers nadat die verantwoordelikheid op hom geplaas is, word daar ontdek dat hy nie \'n skietsertifikaat besit nie en word daar op 28 Maart 1963 \'n skietsertifikaat aan hom uitgereik. Op 1 Julie 1963 word sy salaris verhoog na R2 700 per jaar. Op 21 Oktober 1965 word hy geloof vir sy doeltreffende bestuur en berging van springstowwe.\r\n\r\nHy was ook afgevaardig om ander munisipale klipgroewe raad te bedien. Op 4 Oktober 1971 word hy aangestel as bestuurder van die Petra groef (afgelei van Petrus wat rots beteken). Ten spyte van al sy verantwoordelikhede by die groef kon hy nog tyd vind om op komitees te dien van die Vereniging van Munisipale Werkers, Traduna en die Mediese Hulpvereniging. Na 28 jaar diens het Fred besluit om die tuig neer te lê.', 'Bekend as Fred.\r\nSterf as pensioenaris in sy woonstel Harmike 4, 2de Straat, Bloemfontein aan hartaanval; Graf in Bloemfontein.\r\nFoto van hom en gesinslede - v.l.n.r Frederik Jacobus, Jacobus Willem, Anna Fransina (vrou) en Willem Johannes van Tonder (skoonpa).', '2026-07-13 07:32:50.835665', '2026-07-13 07:33:39.392119', NULL, NULL, NULL, NULL, 1, 0),
(79, 'Leonard', 'Johannes Haasbroek', 'van Eeden', '', 'M', 'people/photos/Leonard_Johannes_Haasbroek_-_a1b4c5d1e1f10g3h7i2.jpeg', '2 DEC 1915', 'Bethulie, South Africa', '28 OCT 1979', 'Vanderbijlpark', 1, 'Hy het sy skoolloopbaan in Vergelegen A se plaasskool begin. Toe hy in std 1 was het sy ouers reeds op Vergelegen A gebly. Die dag toe die nuwe veedip klaar bebou was en vol water gemaak was, word hy onder begeleiding van sy oudste broer, Fred, deur mej Vorster na sy pa gestuur omdat hy so baie spelvoute gemaak het. Sy pa sê toe vir hom, jy wil nie leer nie, nou sal ek jou maar in die dip moet gooi, maar groet eers al die mense wat hier om die dip staan. Nadat hy almal gegroet het, vat sy pa hom aan sy arms en laat sak hom in die water en hou hom daar. Hy dompel hom so paar keer onder die water dat hy hyg na sy asem. Toe dit vir sy broer Fred lyk dat hy nou gaan verdrink, hardloop hy in trane van die toneel af weg. Nadat hy sy skoolloopbaan op Bethulie beëindig het, gaan boer hy saam met sy pa op Vergelegen A. Toe sy vader te sterwe kom, koop hy Vergelegen A en Rossouw op die vendusie vir 2 105 pond asook \'n klompie plaasgereedskap vir 314 pond. Hy het nie genoeg geld gehad nie maar met \'n Landraad lening registreer hy die grond onder Transportakte nr 4929/1945. Hy was baie lief vir sy merino skape en doen weg met mielies en koring saaiery en sit al die lande onder lusern vir voer vir sy skape. Na \'n paar jaar koop hy \'n Southern Cross diesel enjin en vervang die ou gasenjin waarmee gepomp was. In 1954 koop hy die huurplaas Grootrivier by sy oudste broer Fred vir 4 480 pond. Na verloop van tyd koop die regering al die plase stroomop van Bethulie af uit om plek te maak vir die HF Verwoerd dam en moes Leonard \'n ander plaas gaan soek. Hy koop toe vir hom die plaas Kransfontein in Trompsburg distrik. Kransfontein het bestaan uit drie dele naamlik Langholm, Gretna en Hartebeesfontein en was geleë waar die grense van Trompsburg, Bethulie en Smithfield bymekaar kom. Die plaas was baie verwaarloos en die veld uitgetrap. Hy moes \'n gronddam bou om water op te gaar en talle kampe aanbring vir wisselweiding en dit voorsien van water met lang pyplyne. Nadat hy die plaas klaar ontwikkel het en net nadat hy die laaste paaiement betaal het en die boerdery bietjie kon afskaal om rustiger te lewe, sterf hy. Tydens die besigtiging van die lyk het die vroue lykbesorger aan sy gesig gevat en gesê: \'Waar gaan die arm mense nou kos vaandaan kry?\'. Dit was sy gewoonte om vir die behoeftiges van Trompsburg te voorsien van groente en vleis. Na sy dood word die plaas en alles daarop op \'n vendusie verkoop vir R289 000. Elke kind erf R65 863.17 en  sy vrou die polisse, \'n huis op die dorp en R27 547.94.\r\n\r\nLeonard kon altyd met \'n koddige handeling of sêding vorendag kom. Eendag op die strand terwyl almal besig was om hulle sakke te vat om huistoe te gaan, vat hy sy oudste seun wie toe al begin kruip het, ook so aan sy klere op sy rug en dra hom soos \'n sak van die strand af tot groot vermaak van party mense en die misnoeë van ander. So sê hy eendag vir een van sy broers dat ons broers nie moet toelaat dat ander mense se kinders ons broers se liefde vir mekaar moet belemmer nie. Hy was \'n hardwerkende boer. Hy het \'n rievierplaas se skuins landerye met breë akkers wat agt arbeiders moes natlei, so omskep in terras akkers met sement vore en sluise sodat hy dit alleen kan natlei en nog dorp toe kan gaan om inkopies te doen. \'n Ander plaas se veld was so vol miershope en brak kolle wat morge weiveld in beslag geneem het. Deur die brak kolle op te breek sodat die water kan insink en die miershope se grond te gebruik om keerwalle in die veld te gooi, was daar binne twee jaar nie \'n kolletjie wat nie weiding op gehad het nie. As die dorpskinders op die plaas kom kuier wou hulle altyd by hom weet hoe hy dit regkry om die skape te tel as hulle so vinnig by hom verbykom, dan sê hy dit is maklik, hy tel net die pootjies en deel dit deur vier. Leonard het nooit gedans nie en as hy daarom uitgevra word, het hy altyd gesê hy lê liewer en vry voordat hy so loop en vry.', 'Sterf aan koronêre trombose te waar hy vir sy oudste seun gekuier het; Begrawe in Trompsburg op 1 November.\r\nFoto van hom en sy vrou, Miemie Hartman en \'n kleinkind.', '2026-07-13 11:42:33.298680', '2026-07-13 11:42:33.298770', NULL, NULL, NULL, NULL, 1, 0),
(80, 'Jacobus', 'Stefanus', 'van Eeden', '', 'M', '', '5 FEB 1919', 'Bethulie, South Africa', '1 APR 1965', 'Klerksorp, South Africa', 1, 'Koos het na sy skoolloopbaan by die Spesiale Diens Batljon (SDB) te Robertshoogte aangesluit en daar onder die aanvoering van Pappa Brits hom bekwaam vir die polisiemag. Hy word oorgeplaas en gestasioneer te Wynberg, Kaap. Na \'n liefdesteleurstelling vra hy en word verplaas Johannesburg toe en word gestasioneer te Hospitaal Heuwel. Hier het hy betrokke geraak in ;n worsteling met \'n inbreker wie sy rewolwer by hom wou afneem en in die proses per ongeluk doodgeskiet word. Hy word aangekla vir moord maar deur die Hof vrygespreek waarna hy hom uitkoop. Hy gaan werk by Stork en Ogon en vervaardig drukkokers tot hy \'n aanstelling kry by ERPM se reduksie-aanleg. Hierna gaan werk hy ondergrond as skofbaas by een van die goudmyne op Orkney waar hy gebly het tot sy dood.', 'Bekend as Koos.\r\nSterf in Klerksdorp Hospitaal aan koronêre trombose; begrawe in Orkney.', '2026-07-13 11:54:31.037279', '2026-07-13 12:08:13.149901', NULL, NULL, NULL, NULL, 1, 0),
(81, 'Dina', 'Maria Christina', 'van Eeden', '', 'F', '', '29 OCT 1922', 'Bethulie, South Africa', '22 JAN 1927', 'Bethulie, South Africa', 1, 'Sy en haar broer Koos het winkel gespeel deur die voorhuisvenster; dan gaan sy buite en staan op die klipfondament wat \'n trappie gevorm het, om te koop. In die wyl het \'n koperkapêl wat in \'n gat gebly het uitgekom en haar enkel gepik. Haar broer Leonard het snytjies gemaak en die gif probeer uitsuig. Haar pa was op \'n buurplaas en moes geroep word met \'n spieël wat van \'n rantjie af geskyn word want daar was nog nie telefone nie. Die naaste dokter was 17 myl van die plaas af. Halfpad Bethulie toe sterf sy in haar ma se arms.', 'Sterf aan slangbyt; begrawe op Bethulie', '2026-07-13 12:19:31.559365', '2026-07-13 12:19:31.559394', NULL, NULL, NULL, NULL, 1, 0),
(82, 'Daniel', 'Hendrik', 'van Eeden', '', 'M', 'people/photos/Daniel_Hendrik_-_a1b4c5d1e1f10g3h7i5_wu8mPzL.jpeg', '3 AUG 1925', 'Vergelegen, Bethulie, South Africa', '13 SEP 2002', 'Brackenfell, Cape Town, South Africa', 1, 'Daniel beteken \'my regter is God\' en Hendrik beteken \'regeerder van sy huis\'. Navorser en Opsteller van die van Eeden en Willers/Wilders geslagsregisters tydens verblyf in Valhalla, Pretoria. Op die dag van sy begrafnis is die eerste vyf eksemplare van sy voltooide gebinde boek by die huis afgelewer. Daniel was die enigste kind wat op die plaas gebore was om 3 vm en hy het 11 pond geweeg. Hy het \'n opwindende werksloopbaan gehad waartydens hy baie ondervinding en mensekennis opgedoen het. Na sy skoolloopbaan op Bethulie gaan soek hy werk in Johannesburg. Sy eerste werk was die van \'n rottevanger vir Johannesgurg Fumigators. Die werk staan hom nie aan nie en na \'n maand kry hy werk op die Spoorweg maar na 3 maande besluit hy dat die oorlog meer opwindend sal wees en sluit aan by die weermag. Tydens sy 3 jaar en 3 maande in die Staande Mag was hy op aktiewe diens vir 2 jaar in Italië saam met die I.L.H. Kimberley en Pretoria regimente in die 6de divisie. Na die oorlog gaan werk hy weer op die Spoorweg as stoker vir 2 jaar 4 maande, maar bedank om vir Alrite Engineering te gaan werk vir 1 jaar en 6 maande. Hierna gaan kwalifiseer hy as eksploreermeester by Unidrilling Beperk. en werk vir hulle vir 18 jaar waartydens hy as areabestuurder optree vir Unidrilling Rhodesië Bpk. vir 5 jaar en 3 maande in beide Suid en Noord Rhodesië en daarna vir Unidrilling UK Ltd. in Engeland vir 2 jaar en ook vir 3 maande in Duitsland. Tydens sy verblyf in Engeland gaan tor=er hy en sy vrou deur Europa. Hy bedank by die firma om mede-eienaar te word van Eedenberg Motors (Edms) Bpk., \'n motorhandelsaak op Pietersburg (nou Polokwane) en bestuur dit vir 12 jaar. Hierna word hy mede-eienaar van Andy\'s Roadhouse (padkafee) vir 3 maande en gaan toe op sy eie en begin Easy Eats wat hy na 3 jaar en 6 maande verkoop en aftree. Hy was vir 5 jaar bestuurslid op die Pietersburg Afrikaanse Sakekamer en onder sy voorsitterskap het hy die Sakekamer Studiebeurs Fonds begin wat vandag nog bestaan. Tydens sy voorsitterskap moes hy ook \'n spreekbeurt op die AHI kongres te Pretoria waarneem. Tydens sy verblyf in Pietersburg was hy \'n stigterslid van die Pietersburg Filateliste Vereniging en het gedien as ondervoorsitter op die bestuur en was ook redakteur van die Vereniging se maandelikse nuusblad.', 'Gebore op Vergelegen, Bethulie; Sterf aan hartaanval in sy motor by winkelsentrum tterwyl hy wag vir sy vrou om uit die winkels te kom.; begrawe in Stikland begraafplaas, Bellville.\r\nFoto van hom en sy agterkleinseun Ivan Dean Enslin.', '2026-07-13 12:29:03.942662', '2026-07-13 13:20:00.736050', NULL, NULL, NULL, NULL, 1, 0),
(83, 'Daniel', 'Gerbrand', 'van Eeden', '', 'M', '', '17 JUL 1929', 'Bethulie, South Africa', '10 OCT 1983', 'Johannesburg', 1, 'Bekend as Gert. Na \'n hewige woordewisseling met sy vrou gaan hy na sy werkswinkel by die kleuterskool en skiet homself met \'n .38 rewolwer. Hy was \'n opgeleide ambagsman en later direkteur in hul kleuterskool besigheid.', '', '2026-07-13 13:28:12.089435', '2026-07-15 16:04:17.740342', NULL, NULL, NULL, NULL, 1, 0),
(84, 'Anna', 'Fransina', 'van Eeden', 'van Tonder', 'F', '', '20 AUG 1917', '', '26 AUG 2000', 'Vereeniging, South Africa', 1, '', 'Sterf in Vereeniging Hospitaal; Begrawe uit die NGK Moedergergemeente, Parys en word in Bloemfontein langs haar man begrawe op 30/08/2000; Adres tydens afsterwe, Amalia, Endstraat, Parys.\r\n(d.v. Willem Johannes van Tonder & Maria Magdalena Petronella Kruger)', '2026-07-13 15:58:31.725156', '2026-07-13 15:58:31.725224', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `genealogy_person` (`id`, `first_name`, `middle_name`, `last_name`, `maiden_name`, `gender`, `photo`, `birth_date`, `birth_place`, `death_date`, `death_place`, `is_deceased`, `biography`, `notes`, `created_at`, `updated_at`, `birth_lat`, `birth_lng`, `death_lat`, `death_lng`, `created_by_id`, `is_root`) VALUES
(85, 'Maria', 'Johanna', 'van Eeden', 'Hartman', 'F', '', '23 AUG 1922', '', '', '', 0, 'Bekend as Miemie. Klerk van Hebron met eerste huwelik. 1990 Woon op Kransfontein, Trompsburg.', '(d.v. Johan Georg Hartman & Margaretha Marè)', '2026-07-13 16:58:12.321243', '2026-07-13 16:58:12.321278', NULL, NULL, NULL, NULL, 1, 0),
(86, 'Maria', 'Elizabeth', 'van Eeden', 'Dreyer', 'F', '', '31 JUL 1923', '', '22 OCT 1992', 'Bloemfontein, South Africa', 1, 'Bekend as Marie. Sterf in Universitas Hospitaal, Bloemfontein. Begrawe langs eerste man in Orkney begraafplaas.', '(d.v. Thomas (Tom) Frederik Freyer & Maria Elizabeth van Rensburg)', '2026-07-13 17:10:20.543220', '2026-07-13 17:18:25.391974', NULL, NULL, NULL, NULL, 1, 0),
(87, 'Margaret', '', 'van Eeden', 'Willers', 'F', '', '18 JAN 1930', 'Marydale, South Africa', '8 DEC 2023', 'Bellville, Cape Town, South Africa', 1, 'Vernoem na haar ouma Magrieta van Wyk.', '(d.v. Markus Wynand Willers & Johanna Catharina Theron)', '2026-07-13 17:39:00.327630', '2026-07-13 17:39:00.327672', NULL, NULL, NULL, NULL, 1, 0),
(88, 'Josina', '', 'van Eeden', 'Metselaar', 'F', '', '2 APR 1933', '', '', '', 0, 'Bekend as Jos. Vyf maande na haar eerste man se dood hertrou sy met Floris Johannes Stefanus Coetzee, gebore 16/08/1932 te Fauresmith, verkoopsman wie voorheen twee keer getroud was.', '', '2026-07-13 17:48:07.473775', '2026-07-13 17:48:07.473807', NULL, NULL, NULL, NULL, 1, 0),
(89, 'Maria', 'Magdalena', 'van Eeden', '', 'F', '', '13 SEP 1944', '', '', '', 0, 'Bekend as Madria. Sy voltooi haar skolloopbaan in 1962 by die Sentrale Hoërskool op Bloemfontein. Na skool verwerf sy \'n BA-graad in Biblioteekkunde vanaf 1963 tot 1966 aan die Universiteit van Pretoria. Daarna studeer sy aan die Universiteit van Potchefstrrom vir CHO en verwerf \'n BA-graad in Sielkunde in 1990. In diè tyd votooi sy ook in 1984 \'n Beradingskursus met Life Line. In 1991 word sy erelid van die Instituut vir Kommunikasie en Verhoudinge. In 1994 voltooi sy \'n Lewe, Dood en Oorgangskursus aan die Elizabeth Kubler-Ross Sentrum. In 1995 voltooi sy \'n NPAT kursus oor Trauma en Beradingsopleiding.', '', '2026-07-13 18:04:54.309928', '2026-07-13 18:04:54.309968', NULL, NULL, NULL, NULL, 1, 0),
(90, 'Jacobus', 'Willem', 'van Eeden', '', 'M', '', '22 SEP 1954', '', '', '', 0, 'Bekend as Cobus. 1990 Onderwyser, woon op John Calitz Straat, Henneman.', '', '2026-07-13 18:23:53.869025', '2026-07-13 18:23:53.869064', NULL, NULL, NULL, NULL, 1, 0),
(91, 'Johan', 'Georg', 'van Eeden', '', 'M', 'people/photos/Johan_Georg_-_a1b4c5d1e1f10g3h7i2j1_7x5wTmC.jpeg', '28 OCT 1946', 'Bethulie, South Africa', '', '', 0, '1990 fabrieksingenieur.', 'Foto van hom en gesin - Johan Georg (links bo), Johan (regs bo), Leonard J H (links onder) en sy vrou Hester M D Vorster (regs onder).', '2026-07-13 18:36:28.763714', '2026-07-13 19:48:41.255981', NULL, NULL, NULL, NULL, 1, 0),
(92, 'Jacobus', 'Stefanus', 'van Eeden', '', 'M', 'people/photos/jacobus_Stefanus_-_a1b4c5d1e1f10g3h7i2j2.jpeg', '2 OCT 1949', '', '', '', 0, 'Bekend as Kosie. 1990 werktuigkundige.', 'Foto van hom en gesin - v.l.n.r. Jacobus S, Kosie, sy vrou Petronella J Kruger en Erika.', '2026-07-13 19:46:52.611384', '2026-07-13 19:46:52.611479', NULL, NULL, NULL, NULL, 1, 0),
(93, 'Maria', 'Magdalena Wilhelmina', 'van Eeden', '', 'F', '', '16 JAN 1953', '', '', '', 0, 'Bekend as Marlene.', '', '2026-07-13 19:51:31.151783', '2026-07-13 19:51:31.151819', NULL, NULL, NULL, NULL, 1, 0),
(94, 'Leonard', 'Johannes', 'van Eeden', '', 'M', '', '28 OCT 1956', '', '', '', 0, '1990 sakeman', '', '2026-07-13 19:53:21.915060', '2026-07-13 19:53:21.915088', NULL, NULL, NULL, NULL, 1, 0),
(95, 'Hester', 'Magreetha Dorothea', 'van Eeden', 'Vorster', 'F', '', '7 AUG 1943', '', '', '', 0, 'Klerk van Hebron met eerste huwelik. 1990 tuisteskepper.', '', '2026-07-13 20:01:12.895710', '2026-07-13 20:01:12.895740', NULL, NULL, NULL, NULL, 1, 0),
(96, 'Petronella', 'Jacoba', 'van Eeden', 'Kruger', 'F', '', '14 JAN 1957', '', '', '', 0, 'Bekend as Pieta.', '', '2026-07-13 20:08:29.313235', '2026-07-13 20:08:29.313293', NULL, NULL, NULL, NULL, 1, 0),
(97, 'Louise', '', 'van Eeden', 'Wolfaardt', 'F', '', 'EST 1956', '', '', '', 0, '', '', '2026-07-13 20:13:46.833412', '2026-07-13 20:13:46.833444', NULL, NULL, NULL, NULL, 1, 0),
(98, 'Petrus', 'Johannes', 'Visser', '', 'M', '', '6 SEP 1947', '', '', '', 0, '', '', '2026-07-13 20:20:51.576541', '2026-07-13 20:20:51.576571', NULL, NULL, NULL, NULL, 1, 0),
(99, 'Revè', '', 'van Eeden', 'Prinsloo', 'F', '', '26 DEC 1959', '', '', '', 0, '', '(d.v. Willem Jacobus Prinsloo & Martha Le Roux)', '2026-07-13 20:24:59.167337', '2026-07-13 20:24:59.167362', NULL, NULL, NULL, NULL, 1, 0),
(100, 'Maria', 'Elizabeth', 'van Eeden', '', 'F', '', '2 OCT 1942', '', '4 AUG 2001', 'Klerksdorp, South Africa', 1, 'Bekend as Poppie. Sterf in die Sunningdal Kliniek aan hartversaking a.g. emfiseem. Begrawe op 08/08/2001 in Orkney begraafplaas.', '', '2026-07-13 20:33:51.633471', '2026-07-13 20:33:51.633502', NULL, NULL, NULL, NULL, 1, 0),
(101, 'Jacobus', 'Stefanus', 'van Eeden', '', 'M', 'people/photos/Jacobus_Stefanus_-_a1b4c5d1e1f10g3h7i3j2.jpeg', '30 MAR 1944', 'Johannesburg, South Africa', '', '', 0, 'Gebore in die Queen Victoria Kraaminrigting; Bekend as Kobus. Sy ouers woon in Maraisburg, Johannesburg, tot sy vyfde verjaardag, waarna hul verhuis na die plaas Hartenbos, dist, Leeudoringstad, vir drie jaar. Hier word hy as boerseun groot - hy en sy ma moes elke oggend en aand veertien koeie melk. Hy en sy oudste suster moes elke dag met fietse drie myl vê op \'n grondpad na Witpoort skool ry, \'n skool waar hulle ma ook skoolgegaan het. Van die plaas af verhuis hulle na Orkney waar sy pa op die myn gewerk het. Hy matrikuleer aan die Orkney Hoërskool. In sy matriekjaar is hy hoofseun en rugbykaptein van die 1ste span en is lid van Wes-Transvaalse skolespan. Na matriek gaan studeer hy aan die Potchefstroomse Universiteit vir C.H.O. maar weens die vroeë afsterwe van sy pa kon hy nie sy studies voltooi nie. Toe sy ma weer trou, gaan werk hy vir die Kooperasie op Leeudoringstad. In 1965 aanvaar hy \'n pos as Hoofklerk - Interne ouditeur by Stilfontein Munisipaliteit tot 1972. In 1972 koop hy \'n besproeingsplaas in Jacobsdal distrik waar hy in 1997 nog boer. Hy boer hoofsaaklik met koring, grondbone, mielies en wingerd. In 1996 neem hy deel aan \'n wingerdblok kompetisie en eindig tweede met sy blok. Hy sluit ook aan by die polisie se reserviste mag vanaf 1971 tot 1993; word bevorder tot adjudant-offisier en dien as hoofreservis. Hy dien op die Rietrivier Boere-vereniging van 1980 tot 1990; word gekies as sekretaris en later as voorsitter. Vir sy onbaatsigtige diens in die boeregemeenskap word hy bekroon met \'n eerbewys deur die Vrystaatse Landbou-unie. Sy stokpertjie is wedvlug duiwe.', 'Foto van hom, sy vrou Bets Smith en dogter Amanda.', '2026-07-13 21:08:15.019991', '2026-07-13 21:08:15.020035', NULL, NULL, NULL, NULL, 1, 0),
(102, 'Cynthia', '', 'van Eeden', '', 'F', '', '26 OCT 1947', '', '', '', 0, '', '', '2026-07-13 21:11:44.811733', '2026-07-13 21:11:44.811794', NULL, NULL, NULL, NULL, 1, 0),
(103, 'Jeanette', '', 'van Eeden', '', 'F', '', '22 JUL 1949', '', '', '', 0, '', '', '2026-07-13 21:12:59.628547', '2026-07-13 21:12:59.628589', NULL, NULL, NULL, NULL, 1, 0),
(104, 'Albert', '', 'van Drimmelen', '', 'M', '', 'EST 1943', '', '', '', 0, '', '', '2026-07-13 21:36:43.540532', '2026-07-13 21:36:43.540558', NULL, NULL, NULL, NULL, 1, 0),
(105, 'Terence', 'Albert Oliver', 'Jensen', '', 'M', '', '7 OCT 1943', '', '', '', 0, 'Instrumentasi ingenieur.', '(s.v. Holgar Hercules Siegusmund Jensen & Dorothy Nina Freeme)', '2026-07-13 21:43:10.660328', '2026-07-13 21:43:10.660366', NULL, NULL, NULL, NULL, 1, 0),
(107, 'Lucas', 'Cornelius Lourens', 'Holtzhausen', '', 'M', '', '31 JUL 1930', '', '21 AUG 1961', '', 1, 'Dterf in suurbad op die myn. Begrawe in Klerksdorp.', '', '2026-07-14 11:51:47.387775', '2026-07-14 11:51:47.387805', NULL, NULL, NULL, NULL, 1, 0),
(108, 'Pieter', 'Gorton', 'Malherbe', '', 'M', '', '13 JUL 1940', '', '', '', 0, 'Skofbaas op Vaal Reefs.', '', '2026-07-14 11:57:19.642280', '2026-07-14 11:57:19.642308', NULL, NULL, NULL, NULL, 1, 0),
(109, 'Elizabeth', 'Justine', 'Malherbe', '', 'F', '', '23 JAN 1966', '', '18 SEP 1997', 'Johannesburg', 1, 'Sterf van \'n asma aanval in die gimnasium waar sy geoefen het na \'n kwaai griep.', '', '2026-07-14 12:04:48.760218', '2026-07-14 12:04:48.760259', NULL, NULL, NULL, NULL, 1, 0),
(110, 'Stefan', 'Johan', 'Malherbe', '', 'M', '', '15 MAR 1975', '', '', '', 0, '', '', '2026-07-14 12:06:05.579480', '2026-07-14 12:06:05.579507', NULL, NULL, NULL, NULL, 1, 0),
(111, 'Elizabeth', 'Johanna', 'van Eeden', 'Smit', 'F', '', '29 MAY 1947', '', '', '', 0, 'Bekend as Bets. 1990 woon op Rietrivier', '(d.v.Marthinus Jacobus Lourens Smit & Johanna Marthina Catharina Mans)', '2026-07-14 12:14:24.248229', '2026-07-14 12:27:55.157298', NULL, NULL, NULL, NULL, 1, 0),
(112, 'Elize', '', 'van Eeden', '', 'F', '', '3 MAR 1970', 'Klerksdorp, South Africa', '', '', 0, 'Sy kry haar skoolopleiding vanaf sub A tot std 10 in die Jacobsdal Hoër Landbouskool. Na skool word sy opgelei aan die Technikon OVS vir een jaar en doen nog ses jaar na-skoolse opleiding en verwerf  ;n Nasionale Hoër Diploma in kantoor administrasie. Op 16 Februarie 1995 begin sy haar werksloopbaan as sekretaresse by Departement Waterwesw, Bloemfontein. Op 1 Mei 1995 begin sy as assistent rekenmeester by Agri-Info Rekenmeesters. Op 1 April 1996 begin sy werk by Geo-Hidro Tegnologie te Bloemfontein as algemene kantoor assistent. In Junie1997 gaan sy en haar man op \'\'n 4 weke toer na Europa.', '', '2026-07-14 12:47:28.972801', '2026-07-14 12:47:28.972836', NULL, NULL, NULL, NULL, 1, 0),
(115, 'Amanda', '', 'van Eeden', '', 'F', '', '6 OCT 1982', '', '', '', 0, 'In 1997 is sy \'n skolier aan die Jacobsdal Hoër Landbouskool en in die jaar word sy aangewys as die sewende beste skoolatleet in die OVS in die 100 en 200 meter naelloop.', '', '2026-07-14 20:20:53.676248', '2026-07-14 20:20:53.676280', NULL, NULL, NULL, NULL, 1, 0),
(116, 'Jan', 'Petrus Johannes', 'Wagner', '', 'M', '', '22 OCT 1943', '', '', '', 0, 'Bekend as Poen.', '(s.v. Andries Jacobus Wagner & Anna Jacoba Johanna Gentle)', '2026-07-14 20:26:07.421869', '2026-07-14 20:26:07.421932', NULL, NULL, NULL, NULL, 1, 0),
(117, 'Vicky', '', 'Wagner', '', 'F', '', '27 JUL 1971', '', '', '', 0, 'Sy matrikuleer in 1989 aan Hoërskool Sentraal te Bloemfontein. In 1994 behaal sy aan UOVS \'n graad in B.Prim.Ed in Primêre Onderwys, sub A tot std 5. In 1995 verwerf sy aan UOVS \'n graad in B.Ed.Psig. cum laude (Baccalareus Educationis Psigopedagogiek) met Honeurs in Sielkunde - Psigometris, Psigometriese toetse en evaluasies, In 1996 verwerf sy aan UOVS \'n diploma DSRO cum laude (Diploma in Spesialiserings Remediërende Onderwys) Privaat Remediëring vir leergestremde en Leergeremde kinders. Na voltooing van haar skripsie wat handel oor \'Visualisering as Leeshulpverleningstegniek vir tweede taal leerders in graad vyf in die multikulturele skool\' verwerf sy in 1999 \'n Magister Graad in Opvoedkundige Sielkunde van die Universiteit van Pretoria.', '', '2026-07-14 21:13:00.423871', '2026-07-14 21:13:00.423943', NULL, NULL, NULL, NULL, 1, 0),
(118, 'Werner', '', 'Wagner', '', 'M', '', '11 APR 1973', '', '', '', 0, '', '', '2026-07-14 21:14:53.892977', '2026-07-14 21:14:53.893006', NULL, NULL, NULL, NULL, 1, 0),
(119, 'Marthinus', '', 'Lindeque', '', 'M', '', '28 JUN 1946', '', '', '', 0, '', '(s.v. Stephanus Sebastiaan Lindeque & Martha Johanna Magdalena Joubert)', '2026-07-14 21:24:19.622523', '2026-07-14 21:24:19.622566', NULL, NULL, NULL, NULL, 1, 0),
(120, 'Liezel', '', 'Lindeque', '', 'F', '', '10 AUG 1973', 'Klerksdorp, South Africa', '10 AUG 1973', '', 1, '', '', '2026-07-15 06:59:22.415100', '2026-07-17 09:09:45.959808', NULL, NULL, NULL, NULL, 1, 0),
(121, 'Helen', '', 'Lindeque', '', 'F', '', '9 AUG 1974', '', '', '', 0, 'In 1992 matrikuleer sy aan die Hoërskool Schoonspruit waarna sy in 1993 vir \'n jaar lank op Klerksdorp werk. I 1994 verhuis sy na Pretoria en begin werk vir Compucheck. In 1998 werk sy vir Kelly Personeel as tydelike waarnemer vir Klerklike Sekretariële maatskappy.', '', '2026-07-15 07:03:57.368489', '2026-07-17 09:09:03.324791', NULL, NULL, NULL, NULL, 1, 0),
(122, 'Wanda', '', 'Lindeque', '', 'F', '', '23 NOV 1975', 'Klerksdorp, South Africa', '', '', 0, 'In 1993 slaag sy matriek aan die Hoërskool Schoonspruit waarna sy tussen 1994 en 1996 \'n B.Soc.Sc graad verwerf in suiwer Sielkunde. In 1997 begin sy werk by Ariel Technologies in Verwoerdburgstad, as tegniese steunbeampte. In 1998 gaan werk sy vir Ariel Enterprise Systems as steunbeampte vir Sun Toerusting.', '', '2026-07-15 07:10:27.302309', '2026-07-17 09:10:33.892764', NULL, NULL, NULL, NULL, 1, 0),
(123, 'Lani', '', 'Lindeque', '', 'F', '', '30 APR 1983', 'Klerksdorp, South Africa', '', '', 0, '', '', '2026-07-15 07:11:20.729559', '2026-07-17 09:10:58.163517', NULL, NULL, NULL, NULL, 1, 0),
(124, 'Johanna', 'Maria', 'van Eeden', '', 'F', '', '10 APR 1952', 'Wolmaransstad, South Africa', '', '', 1, 'Bekend as Meisie by die huis en in die openbaar. Diè neomnaam is so vasgekleef dat sy self nie reageer het op \'n ander naam nie. Sy het wel Johanna as naam aanvaar by die werksplek. Weeg 3 pond 11 onse met geboorte en kwalik 12 duim lank; maar sterk en liggaamlik volmaak. Sy begin haar skoolloopbaan in \'n Engelse skool op Gatooma, Suid-Rhodesië. As gevolg van haar vader se werk en baie verplasings moes sy in agt verskillende skole, waarvan drie Engels en vyf Afrikaans, skoolgaan. Ten spyte van die verwisseling van skole het sy nooit probleme gehad om aan te pas nie. Sy het verskeie diplomas verwerf. Die gedwonge aanpassing in haar skoolloopbaan het haar egter goed te pas gekom in haar latere werksloopbaan wat net so veelvuldig en wisselend was. As gevolg van haar man se verwisseling van werk moes hulle baie rondtrek met die gevolg dat sy by 15 verskillende firmas gewerk het. Sy het begin as bloemiste en met verloop van tyd verwissel na haarkapster, verpleegster, lughawe assistent en kantoorklerk met \'n groot verskeidenheid poste. Haar werkgewers het haar almal beskryf as pligsgetrou, aanpasbaar en flink om te leer en kan haarself handhaaf teen enige uitdaging wat haar aangebied is. Sy het \'n vriendelike geaardheid met \'n goeie gesindheid en kommunikeer goed met mense op alle vlakke.', '', '2026-07-15 14:20:48.625159', '2026-07-15 14:20:48.625207', NULL, NULL, NULL, NULL, 1, 0),
(125, 'Margaret', '', 'van Eeden', '', 'F', '', '17 MAR 1957', 'Douglas, South Africa', '', '', 0, 'Sy slaag matriek in 1975 te Pietersburg Hoërskool. Verwerf graad B.A. (Verpleegkunde) 1979 aan Potchefstroom Universiteit. vir C.H.O. Verwerf Onderwysdiploma 1983 aan Umiversiteit Pretoria en in 1993 \'n M.Kur graad aan die Randse Afrikaanse Universiteit en skryf \'n verhandeling oor voorgeboorte klasse. In 1996 is sy verpleegdiensbestuurder te Medi-Clinic op Worcester.', '', '2026-07-15 15:40:39.280354', '2026-07-15 15:40:39.280393', NULL, NULL, NULL, NULL, 1, 0),
(126, 'Daniel', 'Markus', 'van Eeden', '', 'M', '', '6 NOV 1959', 'Kitwe, Zambia', '', '', 0, 'Bekend as Danie. Hy begin sy skoolloopbaan in Camborne, Cornwall, Engeland en gaan daar skool vir twee jaar. Het verder skoolgegaan in die Pres. Steyn laerskool op Alberton en sy skoolloopbaan voltooi in die Pietersburg Hoërskool op Pietersburg waar hy in 1977 sy Senior Sertifikaat verwerf het met Universiteitstoelating. In 1978 begin hy \'n militêre loopbaan in die Staande Mag met die doel om verder te studeer. Vir die eerste jaar doen hy net diensplig opleiding en aan die begin van sy tweede jaar skryf hy in vir \'n korrespondensie kursus by die Pretoria Technikon vir die Nasionale Diploma in Siviele Ingenieurswese, T3, wat hy in 1983 voltooi. Vanaf 1984 tot in 1986 doen hy diens in die weermag as tegnikus waartydens hy kwalifiseer as Stafsersant, Hy koop hom vry uit die weermag en gaan werk vir Raadgewende Ingenieurs. In 1986 doen hy \'n diploma kursus vir een jaar by Unisa. In 1989 skryf hy in vir die T4 Diploma Kursus in Siviele Ingenieurswese maar voltooi dit nie. Sederdien werk hy by verskeie Siviele Raadgewende Ingenieurs en Kontrakteurs; 1990 tegnikus.', '', '2026-07-15 15:57:24.645755', '2026-07-15 15:57:24.645805', NULL, NULL, NULL, NULL, 1, 0),
(127, 'Renee', '', 'van Eeden', '', 'F', '', '8 JUL 1964', '', '', '', 0, '', '', '2026-07-15 16:47:07.606244', '2026-07-15 16:47:07.606280', NULL, NULL, NULL, NULL, 1, 0),
(128, 'Linda', '', 'van Eeden', '', 'F', '', '3 JUN 1966', '', '', '', 0, '1990 onderwyseres.', '', '2026-07-15 16:49:29.277522', '2026-07-15 16:49:29.277559', NULL, NULL, NULL, NULL, 1, 0),
(129, 'Eduard', '', 'van Drimmelen', '', 'M', '', '21 JAN 1969', '', '14 NOV 1991', 'Vereeniging, South Africa', 1, 'Hy was ongetroud; prefek van sy skool en \'n baie aktiewe sportman, presteer in tennis, krieket en boogskiet. Op 26/10/1970 word hy deur sy stiefpa aangeneem en verander sy van na Jensen.', 'Op slag dood toe hy in die nag in staande vragmotor se sleepwa vasgery het.', '2026-07-15 17:02:34.081623', '2026-07-15 17:02:50.095730', NULL, NULL, NULL, NULL, 1, 0),
(130, 'Annien', '', 'van Drimmelen', '', 'F', '', '26 OCT 1970', '', '', '', 0, 'Sy was \'n skolier van die Generaal Smuts Hoërskool en het ook die titel van Mej. Smuts ingepalm.', '', '2026-07-15 17:15:33.709160', '2026-07-15 17:15:33.709201', NULL, NULL, NULL, NULL, 1, 0),
(131, 'Louise', '', 'Jensen', '', 'F', '', '12 SEP 1974', '', '', '', 0, '', '', '2026-07-15 17:17:44.565349', '2026-07-15 17:17:44.565382', NULL, NULL, NULL, NULL, 1, 0),
(132, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', '5 FEB 1981', '', '', '', 0, '', '', '2026-07-15 17:25:15.020592', '2026-07-15 17:25:15.020635', NULL, NULL, NULL, NULL, 1, 0),
(133, 'Helena', 'Aletta', 'van Eeden', 'Sauer', 'F', '', '26 JUL 1957', '', '', '', 0, '1990 onderwyseres.', '', '2026-07-15 17:27:06.601315', '2026-07-18 09:27:07.276584', NULL, NULL, NULL, NULL, 1, 0),
(134, 'Hanko', '', 'van Eeden', '', 'M', '', 'BEF 1 AUG 1983', '', '1 AUG 1983', '', 1, '', '', '2026-07-15 17:32:27.780977', '2026-07-15 17:32:27.781057', NULL, NULL, NULL, NULL, 1, 0),
(135, 'Mariette', '', 'van Eeden', '', 'F', '', '9 MAY 1985', '', '25 APR 2021', '', 1, '', '', '2026-07-15 17:35:26.256927', '2026-07-15 17:35:26.256976', NULL, NULL, NULL, NULL, 1, 0),
(136, 'Leonard', 'Johannes Haasbroek', 'van Eeden', '', 'M', '', '10 AUG 1976', '', '', '', 0, 'Bekend as Len.', '', '2026-07-15 17:38:52.014267', '2026-07-15 17:38:52.014319', NULL, NULL, NULL, NULL, 1, 0),
(137, 'Johan', 'Georg', 'van Eeden', '', 'M', '', '9 OCT 1978', '', '', '', 0, '', '', '2026-07-15 17:44:02.801848', '2026-07-15 17:44:02.801904', NULL, NULL, NULL, NULL, 1, 0),
(138, 'Jacobus', 'Stefanus', 'van Eeden', '', 'M', '', '9 SEP 1977', '', '', '', 0, '', '', '2026-07-15 17:48:25.773053', '2026-07-15 17:48:25.773079', NULL, NULL, NULL, NULL, 1, 0),
(139, 'Erika', '', 'van Eeden', '', 'F', '', '5 APR 1980', '', '', '', 0, '', '', '2026-07-15 17:51:10.424532', '2026-07-15 17:51:10.424576', NULL, NULL, NULL, NULL, 1, 0),
(140, 'Stefan', 'Jordaan', 'van Eeden', '', 'M', '', '29 SEP 1987', '', '', '', 0, '', '', '2026-07-15 17:53:59.772564', '2026-07-15 17:53:59.772602', NULL, NULL, NULL, NULL, 1, 0),
(141, 'Eone', '', 'van Eeden', '', 'F', '', '18 APR 1983', '', '', '', 0, '', '', '2026-07-17 05:46:23.984528', '2026-07-17 05:46:23.984552', NULL, NULL, NULL, NULL, 1, 0),
(142, 'Ruard', '', 'van Eeden', '', 'M', '', '16 NOV 1985', 'Bloemfontein, South Africa', '', '', 0, '', '', '2026-07-17 05:48:00.137449', '2026-07-17 05:48:00.137478', NULL, NULL, NULL, NULL, 1, 0),
(143, 'Erik', 'Paul', 'Broere', '', 'M', '', '31 DEC 1969', '', '', '', 0, 'Vliegtuigmonteur.', '(s.v. Abraham Broere & Ellie Stump)', '2026-07-17 06:10:50.561448', '2026-07-17 06:10:50.561480', NULL, NULL, NULL, NULL, 1, 0),
(144, 'Marco', '', 'Broere', '', 'M', '', '31 MAR 1998', 'Bloemfontein, South Africa', '', '', 0, 'Gebore in die Universitas Hospitaal.', '', '2026-07-17 06:14:51.105864', '2026-07-17 06:14:51.105909', NULL, NULL, NULL, NULL, 1, 0),
(145, 'Luan', '', 'Broere', '', 'M', '', '15 JUN 2001', 'Bloemfontein, South Africa', '', '', 0, 'Gebore in die 3 Militêre Hospitaal.', '', '2026-07-17 06:16:40.546952', '2026-07-17 06:16:40.546978', NULL, NULL, NULL, NULL, 1, 0),
(146, 'Hanele', '', 'van Eeden', '', 'F', '', '3 MAR 1970', '', '', '', 0, 'Sy doen haar skoolopleiding vanaf sub A tot Std 10 aan die Jacobsdal Hoër Landbouskool. Na skool doen sy \'n driejaar kursus aan die Technikon OVS en verwerf \'n Nasionale Diploma in Sekretariële Kantooradministrasie. Hierna verwerf sy \'n Nasionale Diploma in Sekretariële Handelsrekenarisering wat sy met een jaar voltydse en vier jaar deeltydse studies voltooi.  Na haar opleiding keer sy terug na Jacobsdal en begin haar werksloopbaan by die Dept. Waterwese, waar sy in 1997 nog werksaam is. Sy het haar diploma-kursus met lof geslaag en is aangewys as die tweede beste student van die jaar.', '', '2026-07-17 07:14:11.386742', '2026-07-17 07:14:11.386778', NULL, NULL, NULL, NULL, 1, 0),
(147, 'Albertus', 'Stefanus', 'van der Watt', '', 'M', '', '19 NOV 1970', 'Hoopstad, South Africa', '', '', 0, 'Polisiesersant in 1993.', '(s.v. Albertus Stefanus van der Watt & Martha Catharina van Rensburg)', '2026-07-17 08:15:26.500824', '2026-07-17 08:21:03.093614', NULL, NULL, NULL, NULL, 1, 0),
(148, 'Marize', '', 'van der Watt', '', 'U', '', '4 DEC 1995', 'Kimberley, South Africa', '', '', 0, 'Gebore in die Medi City Hospitaal.', '', '2026-07-17 08:24:05.293944', '2026-07-17 08:24:05.294010', NULL, NULL, NULL, NULL, 1, 0),
(149, 'Chantè', '', 'van der Watt', '', 'F', '', '26 NOV 1997', 'Kimberley, South Africa', '', '', 0, 'Gebore 4nm in die Medi City Hospitaal.', '', '2026-07-17 08:27:06.862829', '2026-07-17 08:27:06.862876', NULL, NULL, NULL, NULL, 1, 0),
(150, 'Jacobus', 'Stefanus', 'van Eeden', '', 'M', '', '26 AUG 1977', '', '', '', 0, 'Bekend as Kobus. In 1999 boer saam met sy pa op Gannahoek, Jacobsdal.', '', '2026-07-17 08:36:49.417712', '2026-07-17 08:36:49.417770', NULL, NULL, NULL, NULL, 1, 0),
(151, 'Mariana', '', 'Bloem', '', 'F', '', '5 JAN 1977', '', '', '', 0, '', '(d.v. Rasmus Pieter Bloem & Gertruida Anna Susanna Kleynhans)', '2026-07-17 08:47:46.068268', '2026-07-17 08:47:46.068298', NULL, NULL, NULL, NULL, 1, 0),
(152, 'Ardu', '', 'Theron', '', 'M', '', '18 FEB 1969', '', '', '', 0, '', '(s.v. Hendrik Carl Theron & Catharina Helena Bester)', '2026-07-17 09:02:56.327093', '2026-07-17 09:02:56.327121', NULL, NULL, NULL, NULL, 1, 0),
(153, 'Mornè', '', 'van Dyk', '', 'M', '', '15 OCT 1971', '', '26 JAN 2002', '', 1, 'Sterf op die R21 toe sy motor rol en hy sy nek breek.', 'Begrawe op 27/05/2001 in Pretoria. (s.v. Alexander van Dyk & Susanna Johanna Magdalena Fourie)', '2026-07-17 09:17:39.629326', '2026-07-17 09:17:39.629357', NULL, NULL, NULL, NULL, 1, 0),
(154, 'Mornè', '', 'van Dyk', '', 'M', '', '28 JAN 2001', '', '', '', 0, '', '', '2026-07-17 09:23:18.758526', '2026-07-17 09:23:18.758566', NULL, NULL, NULL, NULL, 1, 0),
(155, 'Felix', '', 'Myburgh', '', 'M', '', '17 OCT 1968', 'Bellville, Cape Town, South Africa', '', '', 0, 'Hy matrikuleer in 1986 aan die Hoërskool Linden. Daarna gaan hy studeer vanaf 1987 tot 1988 vir \'n jaar lank, aan die Universiteit van Stellenbosch in B. Ingenieurswese (Meganies) maar toe die lugmag hom laat weet dat hy gekeur is vir vlieënier, verander hy sy loopbaan en sluit in 1989 aan by die SA Lugmagen hy word \'n helikoptervlieënier tot 1997.  Vanaf 1997 word hy \'n kommersiële helikopter- en vliegtuigvlieënier vir National Airways Corporation.', '(s.v. Aubrey Bronkhorst & Isabella Lodewina Hauman)', '2026-07-17 12:00:54.976935', '2026-07-17 12:00:54.977022', NULL, NULL, NULL, NULL, 1, 0),
(156, 'Joseph', 'Martin Fry', 'Enslin', '', 'M', '', '23 FEB 1948', '', '', '', 0, '', '(s.v. Johannes Jacobus Enslin & Alberta Maria Johanna Bezuidenhout)', '2026-07-17 12:14:12.839046', '2026-07-17 12:14:12.839156', NULL, NULL, NULL, NULL, 1, 0),
(157, 'Vanessa', '', 'Enslin', '', 'F', '', '15 AUG 1973', 'Pietersburg', '', '', 0, 'Die naam Vanessa is van Griekse oorsprong en beteken \'die skoenlapper\', met die volgende karaktereienskappe. Sy is \'n persoon van vrede en reinheid, en is altyd bereid om goeie raad te aanvaar.  As sy iets wil doen, dan doen sy dit en sy boesem vertroue in. Sy kyk altyd vorm toe, nie terug nie, en veroorsaak pyn aan geeneen nie. Alles wat vir \'n verpleegster belangrik is, vra maar enige ou oom of tannie, wat deur haar versorg word navorser.', '', '2026-07-17 12:25:40.309615', '2026-07-17 12:25:40.309671', NULL, NULL, NULL, NULL, 1, 0),
(158, 'Johan', 'Martin', 'Enslin', '', 'M', '', '15 AUG 1979', 'Pretoria', '', '', 0, 'Bekend as Martin. Die naam Martin is van Latynse oorsprong en beteken \"die strydlustige\" en het die volgende karaktereienskappe. Al is hy opvlieënd, is hy bereid om jammer te sê. Hy glo in gesonde verstand en het \'n onbekommerde geaardheid. Hy is hardnekkig en vindingryk maar is gelukkig en vol liefde. Hy sal nie aan die slaap gevang word nie. Leierskap en verantwoordelikheid is vir hom maklik en sy glimlag is eerlik en opreg.', '', '2026-07-17 12:32:04.890729', '2026-07-17 12:32:04.890758', NULL, NULL, NULL, NULL, 1, 0),
(159, 'Ivan', 'Dean', 'Enslin', '', 'M', '', '1 SEP 1995', '', '', '', 0, '', '', '2026-07-17 16:07:55.121080', '2026-07-17 16:07:55.121114', NULL, NULL, NULL, NULL, 1, 0),
(160, 'Vincent', '', 'van Huizen', '', 'M', '', '6 APR 1970', '', '', '', 0, 'Militêre Polisieman', '(s.v. Frederik Johannes van Huizen & Adrasina Jacoba Schoeman)', '2026-07-17 16:10:45.656345', '2026-07-17 16:10:45.656385', NULL, NULL, NULL, NULL, 1, 0),
(161, 'Abraham', 'Josua', 'van Huizen', '', 'M', '', '30 JUN 1998', '', '', '', 0, '', '', '2026-07-17 16:14:52.409181', '2026-07-17 16:14:52.409229', NULL, NULL, NULL, NULL, 1, 0),
(162, 'Vincent', 'Mario', 'van Huizen', '', 'M', '', '22 NOV 1999', '', '', '', 0, '', '', '2026-07-17 16:17:29.406954', '2026-07-17 16:17:29.406992', NULL, NULL, NULL, NULL, 1, 0),
(163, 'Daniel', 'Hendrik', 'van Huizen', '', 'M', '', '22 FEB 2001', '', '', '', 0, '', '', '2026-07-17 16:18:26.330553', '2026-07-17 16:18:26.330606', NULL, NULL, NULL, NULL, 1, 0),
(164, 'Stephen', 'Richard', 'Smith', '', 'M', '', '13 AUG 1954', '', '', '', 0, '', '(s.v. David Stephen Smith & Edith Nerene Stopford)', '2026-07-17 16:24:58.306723', '2026-07-17 16:24:58.306782', NULL, NULL, NULL, NULL, 1, 0),
(165, 'William', 'James Hurst', 'Botha', '', 'M', '', '8 AUG 1958', '', '', '', 0, 'Behend as Willie, elektrisiën.', '', '2026-07-17 16:29:09.501774', '2026-07-17 16:29:09.501833', NULL, NULL, NULL, NULL, 1, 0),
(166, 'Margaret', 'Nerine', 'Smith', '', 'F', '', '5 FEB 1986', 'Pretoria, South Africa', '', '', 0, '', '', '2026-07-17 16:32:39.996461', '2026-07-17 16:32:39.996493', NULL, NULL, NULL, NULL, 1, 0),
(167, 'Willem', 'Daniel', 'Botha', '', 'M', '', '20 MAY 1996', 'Paarl', '', '', 0, '', '', '2026-07-17 16:33:47.988679', '2026-07-17 16:33:47.988733', NULL, NULL, NULL, NULL, 1, 0),
(168, 'Terresa', '', 'van Eeden', 'Breytenbach', 'F', '', '14 AUG 1960', 'Kimberley', '31 MAR 2022', 'Pinetown, Durban, South Africa', 1, 'Tuisteskepper', '(d.v. Gert Andries Cornelia Breytenbach & Cavell Cecilia du Preez)', '2026-07-17 16:37:34.604772', '2026-07-17 16:43:24.346688', NULL, NULL, NULL, NULL, 1, 0),
(169, 'Ronald', '', 'Hennig', '', 'M', '', '', '', 'EST MAY 1995', '', 1, '', '', '2026-07-17 16:48:36.733957', '2026-07-17 16:53:48.613619', NULL, NULL, NULL, NULL, 1, 0),
(170, 'Candice', 'Ursula', 'van Eeden', 'Breytenbach', 'F', '', '3 SEP 1986', '', '', '', 0, '', '', '2026-07-17 16:56:19.747539', '2026-07-17 16:57:59.869822', NULL, NULL, NULL, NULL, 1, 0),
(171, 'Anika', '', 'van Eeden', '', 'F', '', '13 JUN 1993', 'Johannesburg, South Africa', '2 APR 1995', 'Melmoth, Natal, South Africa', 1, 'Sterf aan kopbeserings in \'n motorongeluk.', '', '2026-07-17 17:02:49.801316', '2026-07-17 17:02:49.801365', NULL, NULL, NULL, NULL, 1, 0),
(172, 'Karina', '', 'van Eeden', '', 'F', '', '11 JUN 1998', 'Richards Bay, Natal, South Africa', '', '', 0, 'Gebore 8:20 vm in die Bay Kliniek - gewig 3.82kg, lengte 51cm, kopgrootte 38cm, donker hare.', '', '2026-07-17 17:06:42.930222', '2026-07-17 17:06:42.930256', NULL, NULL, NULL, NULL, 1, 0),
(173, 'Deon', '', 'Brits', '', 'M', '', '', '', '', '', 0, '', '', '2026-07-17 17:11:36.569249', '2026-07-17 17:11:36.569277', NULL, NULL, NULL, NULL, 1, 0),
(174, 'Darius?', '', 'du Plessis', '', 'M', '', '', '', '', '', 0, '', '', '2026-07-17 17:12:41.297290', '2026-07-17 17:17:15.864012', NULL, NULL, NULL, NULL, 1, 0),
(175, 'Darius', 'Gerbrand', 'du Plessis', '', 'M', '', '4 JUL 1991', '', '', '', 0, '', '', '2026-07-17 17:16:57.370733', '2026-07-17 17:16:57.370764', NULL, NULL, NULL, NULL, 1, 0),
(176, 'Benjamin', '', 'van Eeden', '', 'M', '', '6 SEP 1963', '', '', '', 0, 'Passer en Draaier by Eskom in 1990.', '(s.v. Jan Lodewyk van Eeden & Una Mabel Goose)', '2026-07-17 17:24:02.302083', '2026-07-17 17:24:02.302122', NULL, NULL, NULL, NULL, 1, 0),
(177, 'Regina', 'Christina', 'van Eeden', 'Andresen', 'F', '', '11 MAY 1692', '', '', '', 1, 'Bekend as Regina Christina Deetlof, en Regina de Jonker (Jonkers); woon later in die Roodesand omgewing.', '(d.v. Jonker Johan Andresen & Lysbeth Jansen (Jansz))', '2026-07-18 15:54:04.984880', '2026-07-18 15:54:04.984920', NULL, NULL, NULL, NULL, 1, 0),
(178, 'Maria', 'Elizabeth', 'van Eeden', '', 'F', '', 'BEF 19 APR 1711', '', '', '', 1, '', '', '2026-07-18 15:59:32.786180', '2026-07-18 15:59:32.786208', NULL, NULL, NULL, NULL, 1, 0),
(179, 'Catharina', '', 'van Eeden', '', 'F', '', 'BEF 24 JUL 1712', '', 'EST 1758', '', 1, 'Geertruy genoem in haar pa se testament.', '', '2026-07-18 16:03:36.999060', '2026-07-18 16:03:36.999088', NULL, NULL, NULL, NULL, 1, 0),
(180, 'Gideon', '', 'van Zyl', '', 'M', '', 'BEF 9 DEC 1703', '', '', '', 1, 'Burger van Drakenstein.', '(s.v. Willem van Zyl & Christina van Loveren)', '2026-07-18 16:09:36.745742', '2026-07-18 16:09:36.745787', NULL, NULL, NULL, NULL, 1, 0),
(181, 'Johannes', '', 'van Zyl', '', 'M', '', 'EST 1701', '', '', '', 1, 'Burger va Drakenstein.', '(s.v. Willem van Zyl & Christina van Loveren)', '2026-07-18 16:14:12.998730', '2026-07-18 16:14:12.998762', NULL, NULL, NULL, NULL, 1, 0),
(182, 'Johann', 'Christoffel', 'Dietlof(f)', '', 'M', '', 'BEF 1738', '', 'EST OCT 1780', 'Swellendam, South Africa', 1, '1738? aankoms van Stettin in Pommere, Duitsland.', '(s.v. Peter Dietloff & Maria Scherping)', '2026-07-18 16:22:54.361565', '2026-07-18 16:22:54.361610', NULL, NULL, NULL, NULL, 1, 0),
(183, 'Hendrina', '', 'Stevens', '', 'F', '', 'BEF 15 FEB 1695', '', '', '', 1, '', '(d.v. Joost Stevens (van Druten) & Pietertjie Gerrits)', '2026-07-18 16:31:58.721906', '2026-07-18 16:36:32.002870', NULL, NULL, NULL, NULL, 1, 0),
(184, 'Johannes', 'Harmensz', 'Potgieter', '', 'M', '', 'BEF 23 SEP 1674', '', '', '', 1, '', '(s.v. Harmen Jansen(Jansz) Potgieter & Isabella Frederiks)', '2026-07-18 16:40:46.268641', '2026-07-18 16:43:07.519220', NULL, NULL, NULL, NULL, 1, 0),
(185, 'Theunis', '', 'Botha', '', 'M', '', 'BEF 1734', '', '', '', 1, '', '', '2026-07-18 16:45:11.538198', '2026-07-18 17:04:00.054801', NULL, NULL, NULL, NULL, 1, 0),
(186, 'Hester', '', 'Potgieter', '', 'F', '', 'BEF 23 FEB 1716', '', '', '', 1, '', '', '2026-07-18 16:50:08.965873', '2026-07-18 16:50:08.965923', NULL, NULL, NULL, NULL, 1, 0),
(187, 'Christoffel', '', 'Botha', '', 'M', '', 'BEF 11 FEB 1713', '', '', '', 1, 'Burger van Drakenstein.', '(s.v. Theunis Botha & Maria Magdalena Snyman)', '2026-07-18 16:55:46.283294', '2026-07-18 16:55:46.283322', NULL, NULL, NULL, NULL, 1, 0),
(188, 'Theunis', '', 'Botha', '', 'M', '', 'BEF 1736', '', '', '', 1, '', '', '2026-07-18 16:59:24.826452', '2026-07-18 16:59:24.826515', NULL, NULL, NULL, NULL, 1, 0),
(189, 'Maria', 'Magdalena', 'Botha', '', 'F', '', 'BEF 5 FEB 1736', '', '27 FEB 1775', '', 1, '', '', '2026-07-18 17:07:02.128474', '2026-07-18 17:07:02.128531', NULL, NULL, NULL, NULL, 1, 0),
(190, 'Emerentia', '', 'Potgieter', '', 'F', '', 'BEF 29 OCT 1719', '', '', '', 1, '', '', '2026-07-18 17:13:58.733483', '2026-07-18 17:13:58.733528', NULL, NULL, NULL, NULL, 1, 0),
(191, 'Jacobus', '', 'Botha', '', 'M', '', 'BEF 8 AUG 1717', '', '', '', 1, 'Burger van Drakenstein.', '(s.v. Theunis Botha & Maria Magdalena Snyman)', '2026-07-18 17:20:35.499145', '2026-07-18 17:20:35.499186', NULL, NULL, NULL, NULL, 1, 0),
(192, 'Maria', 'Catharina', 'Botha', '', 'F', '', 'BEF 7 APR 1738', '', '', '', 1, '', '', '2026-07-18 19:20:09.733614', '2026-07-18 19:20:09.733664', NULL, NULL, NULL, NULL, 1, 0),
(193, 'Margaretha', 'Isabella', 'Botha', '', 'F', '', 'BEF 31 JUN 1740', '', '', '', 1, '', '', '2026-07-18 19:21:41.528297', '2026-07-18 19:21:41.528324', NULL, NULL, NULL, NULL, 1, 0),
(194, 'Jacobus', 'Johannes', 'Botha', '', 'M', '', 'BEF 3 SEP 1741', '', '', '', 1, '', '', '2026-07-18 19:22:41.808288', '2026-07-18 19:22:41.808335', NULL, NULL, NULL, NULL, 1, 0),
(195, 'Theunis', '', 'Botha', '', 'M', '', 'BEF 17 FEB 1743', '', '', '', 1, '', '', '2026-07-18 19:23:35.820728', '2026-07-18 19:23:35.820760', NULL, NULL, NULL, NULL, 1, 0),
(196, 'Ambrensia', '', 'Botha', '', 'F', '', 'BEF 6 OCT 1748', '', '', '', 1, '', 'of Emerentia', '2026-07-18 19:25:04.234347', '2026-07-18 19:25:04.234408', NULL, NULL, NULL, NULL, 1, 0),
(197, 'Theunis', '', 'Botha', '', 'M', '', 'BEF 20 DEC 1750', '', '', '', 1, '', '', '2026-07-18 19:26:02.965184', '2026-07-18 19:26:02.965230', NULL, NULL, NULL, NULL, 1, 0),
(198, 'Frederik', '', 'Botha', '', 'M', '', 'BEF 10 OCT 1752', '', '', '', 1, '', '', '2026-07-18 19:26:50.029803', '2026-07-18 19:26:50.029828', NULL, NULL, NULL, NULL, 1, 0),
(199, 'Christoffel', '', 'Botha', '', 'M', '', 'BEF 7 OCT 1753', '', 'EST 1803', '', 1, '', '', '2026-07-18 19:28:06.716484', '2026-07-18 19:47:13.425020', NULL, NULL, NULL, NULL, 1, 0),
(200, 'Johanna', 'Elizabeth', 'Botha', '', 'F', '', 'BEF 19 SEP 1756', '', '', '', 1, '', '', '2026-07-18 19:29:13.439394', '2026-07-18 19:29:13.439434', NULL, NULL, NULL, NULL, 1, 0),
(201, 'Philippus', 'Rudolphus', 'Botha', '', 'M', '', 'BEF 26 MAR 1758', '', '', '', 1, '', '', '2026-07-18 19:30:39.897082', '2026-07-18 19:30:39.897108', NULL, NULL, NULL, NULL, 1, 0),
(202, 'Johannes', '', 'Botha', '', 'M', '', 'BEF 27 JAN 1760', '', '', '', 1, '', '', '2026-07-18 19:31:27.209123', '2026-07-18 19:31:27.209206', NULL, NULL, NULL, NULL, 1, 0),
(203, 'Maria', 'Magdalena', 'Botha', '', 'F', '', 'BEF 13 MAR 1763', '', '', '', 1, '', '', '2026-07-18 19:32:25.514500', '2026-07-18 19:32:25.514583', NULL, NULL, NULL, NULL, 1, 0),
(204, 'Hester', 'Magdalena', 'Botha', '', 'F', '', 'BEF 16 JUL 1744', '', '', '', 1, '', '', '2026-07-18 19:39:24.304072', '2026-07-21 11:44:04.598308', NULL, NULL, NULL, NULL, 1, 0),
(205, 'Theunis', '', 'Botha', '', 'M', '', 'BEF 10 APR 1746', '', '', '', 1, '', '', '2026-07-18 19:40:14.049195', '2026-07-18 19:40:14.049223', NULL, NULL, NULL, NULL, 1, 0),
(206, 'Johannes', '', 'Potgieter', '', 'M', '', 'BEF 1 MAR 1722', '', '', '', 1, 'Burger van Swellendam.', '', '2026-07-19 10:14:43.927310', '2026-07-19 10:22:20.612924', NULL, NULL, NULL, NULL, 1, 0),
(207, 'Aletta', '', 'van Rooyen', '', 'F', '', 'BEF 27 AUG 1724', '', '', '', 1, '', '(d.v. Cornelis van Rooyen & Jacomyntje(Jacomina) van Deventer(Gerritsz))', '2026-07-19 10:19:49.628102', '2026-07-19 10:22:58.554108', NULL, NULL, NULL, NULL, 1, 0),
(208, 'Johannes', 'Fredericus', 'Potgieter', '', 'M', '', 'BEF 23 JAN 1752', '', '', '', 1, '', '', '2026-07-19 10:26:30.139852', '2026-07-19 10:26:30.139893', NULL, NULL, NULL, NULL, 1, 0),
(209, 'Jacomina', '', 'Potgieter', '', 'F', '', 'BEF 24 JUN 1753', '', '', '', 1, '', '', '2026-07-19 10:28:22.633588', '2026-07-21 11:43:36.012466', NULL, NULL, NULL, NULL, 1, 0),
(210, 'Maria', 'Catharina', 'Potgieter', '', 'F', '', 'BEF 8 JUN 1755', '', '', '', 1, '', '', '2026-07-19 10:29:21.804593', '2026-07-19 10:29:21.804633', NULL, NULL, NULL, NULL, 1, 0),
(211, 'Cornelis', '', 'Potgieter', '', 'M', '', 'BEF 29 APR 1759', '', '', '', 1, '', '', '2026-07-19 10:30:30.134630', '2026-07-19 10:30:30.134656', NULL, NULL, NULL, NULL, 1, 0),
(212, 'Hermanus', 'Lambertus', 'Potgieter', '', 'M', '', 'BEF 12 APR 1761', '', '', '', 1, '', '', '2026-07-19 10:31:31.466684', '2026-07-19 10:31:31.466721', NULL, NULL, NULL, NULL, 1, 0),
(213, 'Ester', 'Magdalena', 'Potgieter', '', 'F', '', 'BEF 2 OCT 1763', '', '', '', 1, 'Ook bekend as Hester', '', '2026-07-19 10:32:53.996493', '2026-07-19 10:32:53.996531', NULL, NULL, NULL, NULL, 1, 0),
(214, 'Aletta', 'Jacoba', 'Potgieter', '', 'F', '', 'BEF 10 AUG 1766', '', '', '', 1, '', '', '2026-07-19 10:33:52.051004', '2026-07-19 10:33:52.051031', NULL, NULL, NULL, NULL, 1, 0),
(215, 'Frederik', '', 'Potgieter', '', 'M', '', 'BEF 11 JUN 1724', '', 'EST SEP 1785', '', 1, 'Burger van Stellenbosch.', '', '2026-07-19 12:29:53.445017', '2026-07-19 12:29:53.445047', NULL, NULL, NULL, NULL, 1, 0),
(216, 'Eva', 'Catharina', 'Kriel', '', 'F', '', 'BEF 21 DEC 1727', '', '', '', 1, '', '(d.v. Hermanus Kriel & Elizabeth Anna Malan)', '2026-07-19 12:34:41.914467', '2026-07-19 12:34:41.914527', NULL, NULL, NULL, NULL, 1, 0),
(217, 'Magdalena', 'Maria', 'Landman', '', 'F', '', 'BEF 23 JUN 1748', '', '', '', 1, '', '(d.v. Willem Landman & Catharina Hoffman)', '2026-07-19 12:36:43.348995', '2026-07-19 12:42:11.795148', NULL, NULL, NULL, NULL, 1, 0),
(218, 'Maria', 'Catharina', 'Potgieter', '', 'F', '', 'BEF 5 APR 1749', '', '', '', 1, '', '', '2026-07-19 12:45:36.353172', '2026-07-19 12:45:36.353197', NULL, NULL, NULL, NULL, 1, 0),
(219, 'Johannes', 'Hermanus', 'Potgieter', '', 'M', '', 'BEF 20 MAY 1751', '', '', '', 1, '', '', '2026-07-19 12:46:51.510317', '2026-07-19 12:46:51.510382', NULL, NULL, NULL, NULL, 1, 0),
(220, 'Elizabeth', 'Anna', 'Potgieter', '', 'F', '', 'BEF 13 AUG 1752', '', '', '', 1, '', '', '2026-07-19 12:47:58.066349', '2026-07-19 12:47:58.066397', NULL, NULL, NULL, NULL, 1, 0),
(221, 'Isabella', '', 'Potgieter', '', 'F', '', 'BEF 29 MAR 1755', '', '', '', 1, '', '', '2026-07-19 12:48:47.016722', '2026-07-19 12:48:47.016753', NULL, NULL, NULL, NULL, 1, 0),
(222, 'Hermanus', 'Lambertus', 'Potgieter', '', 'M', '', 'BEF 24 OCT 1756', '', '', '', 1, '', '', '2026-07-19 12:50:53.753266', '2026-07-19 12:50:53.753297', NULL, NULL, NULL, NULL, 1, 0),
(223, 'Amerentia', 'Hester', 'Potgieter', '', 'F', '', 'BEF 5 NOV 1758', '', '', '', 1, '', '', '2026-07-19 12:52:15.918921', '2026-07-19 12:52:15.918965', NULL, NULL, NULL, NULL, 1, 0),
(224, 'Evert', 'Frederik', 'Potgieter', '', 'M', '', 'BEF 12 OCT 1760', '', '', '', 1, '', '', '2026-07-19 12:53:24.013835', '2026-07-19 12:53:24.013870', NULL, NULL, NULL, NULL, 1, 0),
(225, 'Jacobus', 'Theodorus', 'Potgieter', '', 'M', '', 'BEF 2 OCT 1763', '', '', '', 1, '', '', '2026-07-19 12:54:44.878696', '2026-07-19 12:54:44.878721', NULL, NULL, NULL, NULL, 1, 0),
(226, 'Maria', 'Catharina', 'Potgieter', '', 'F', '', 'BEF 17 APR 1768', '', '', '', 1, '', '', '2026-07-19 14:32:16.489493', '2026-07-19 14:32:16.489526', NULL, NULL, NULL, NULL, 1, 0),
(227, 'Willem', 'Hans Jurgen', 'Potgieter', '', 'M', '', 'BEF 17 MAR 1766', '', '', '', 1, '', '', '2026-07-19 14:33:21.896153', '2026-07-19 14:33:21.896185', NULL, NULL, NULL, NULL, 1, 0),
(228, 'Jan', 'Frederik', 'Potgieter', '', 'M', '', 'BEF 14 APR 1771', '', '', '', 1, '', '', '2026-07-19 14:34:14.604132', '2026-07-19 14:34:14.604173', NULL, NULL, NULL, NULL, 1, 0),
(229, 'Catharina', '', 'Potgieter', '', 'F', '', 'BEF 1 NOV 1772', '', '', '', 1, '', '', '2026-07-19 14:35:02.627336', '2026-07-19 14:35:02.627362', NULL, NULL, NULL, NULL, 1, 0),
(230, 'Maria', 'Magdalena Jacoba', 'Potgieter', '', 'F', '', 'BEF 2 APR 1775', '', '', '', 1, '', '', '2026-07-19 14:36:04.079755', '2026-07-19 14:36:04.079783', NULL, NULL, NULL, NULL, 1, 0),
(231, 'Beatrix', 'Johanna', 'Potgieter', '', 'F', '', 'BEF 19 JAN 1777', '', '26 OCT 1841', '', 1, '', '', '2026-07-19 14:37:28.567373', '2026-07-19 14:37:28.567424', NULL, NULL, NULL, NULL, 1, 0),
(232, 'Frederik', 'Johannes Abraham', 'Potgieter', '', 'M', '', 'BEF 25 APR 1779', '', '25 SEP 1863', '', 1, '', '', '2026-07-19 14:39:05.290592', '2026-07-19 14:39:05.290617', NULL, NULL, NULL, NULL, 1, 0),
(233, 'Theunis', '', 'Potgieter', '', 'M', '', 'BEF 17 FEB 1782', '', '', '', 1, '', '', '2026-07-19 14:39:56.184086', '2026-07-19 14:39:56.184114', NULL, NULL, NULL, NULL, 1, 0),
(234, 'Catharina', '', 'Potgieter', '', 'F', '', 'BEF 18 APR 1784', '', '', '', 1, '', '', '2026-07-19 14:40:44.521072', '2026-07-19 14:40:44.521099', NULL, NULL, NULL, NULL, 1, 0),
(235, 'Frederica', '', 'Potgieter', '', 'F', '', 'BEF 29 JAN 1786', '', '', '', 1, '', '', '2026-07-19 14:41:36.824030', '2026-07-19 14:41:36.824066', NULL, NULL, NULL, NULL, 1, 0),
(236, 'Theodorus', '', 'Potgieter', '', 'M', '', 'BEF 7 APR 1726', '', '', '', 1, 'Burger van Stellenbosch.', '', '2026-07-19 15:00:29.379481', '2026-07-19 15:00:29.379524', NULL, NULL, NULL, NULL, 1, 0),
(237, 'Hester', '', 'Marais', '', 'F', '', 'BEF 7 MAR 1728', '', '', '', 1, '', '(d.v. Daniel Marais & Aletta Rousseau)', '2026-07-19 15:03:08.325748', '2026-07-19 15:04:05.704993', NULL, NULL, NULL, NULL, 1, 0),
(238, 'Johannes', '', 'Potgieter', '', 'M', '', 'BEF 29 MAR 1750', '', '', '', 1, '', '', '2026-07-19 15:07:38.928832', '2026-07-19 15:07:38.928894', NULL, NULL, NULL, NULL, 1, 0),
(239, 'Daniel', '', 'Potgieter', '', 'M', '', 'BEF 3 OCT 1751', '', '', '', 1, '', '', '2026-07-19 15:08:24.412125', '2026-07-19 15:08:24.412154', NULL, NULL, NULL, NULL, 1, 0),
(240, 'Theodorus', '', 'Potgieter', '', 'M', '', 'BEF 21 OCT 1753', '', '', '', 1, '', '', '2026-07-19 15:09:49.053027', '2026-07-19 15:09:49.053061', NULL, NULL, NULL, NULL, 1, 0),
(241, 'Aletta', 'Maria', 'Potgieter', '', 'F', '', 'BEF 6 MAR 1768', '', '', '', 1, '', '', '2026-07-19 15:11:03.413264', '2026-07-19 15:11:03.413300', NULL, NULL, NULL, NULL, 1, 0),
(242, 'Hester', 'Anna', 'Potgieter', '', 'F', '', 'BEF 14 APR 1771', '', '6 JUL 1842', '', 1, '', '', '2026-07-19 15:12:17.549533', '2026-07-19 15:12:17.549582', NULL, NULL, NULL, NULL, 1, 0),
(243, 'Hermanus', 'Lambertus', 'Potgieter', '', 'M', '', 'BEF 16 MAY 1728', '', '', '', 1, '', '', '2026-07-19 15:20:51.648957', '2026-07-19 15:20:51.648995', NULL, NULL, NULL, NULL, 1, 0),
(244, 'Maria', 'Johanna', 'Potgieter', '', 'F', '', 'BEF 27 AUG 1730', '', '', '', 1, '', '', '2026-07-19 15:22:36.550771', '2026-07-19 15:22:36.550825', NULL, NULL, NULL, NULL, 1, 0),
(245, 'Pieter', '', 'Grobler', '', 'M', '', 'BEF 4 MAR 1764', '', '', '', 1, 'Burger van Swellendam.', '(s.v. Nicolaas Grobler & Johanna Hendrina Combrinck)', '2026-07-22 06:00:01.030218', '2026-07-22 06:08:20.376953', NULL, NULL, NULL, NULL, 1, 0),
(246, 'Maria', '', 'Booysen', '', 'F', '', 'BEF 4 MAR 1742', '', '', '', 1, '', '(d.v. Dirk(Dick) Booysen & Aletta Potgieter)', '2026-07-22 06:06:15.849726', '2026-07-22 06:06:15.849773', NULL, NULL, NULL, NULL, 1, 0),
(247, 'Matthys', '', 'Calitz', '', 'M', '', 'BEF 1734', '', '', '', 1, 'Ook genoem Gallitz Matthias van Rheinsberg, aankoms 1734, soldaat by die kompanjiepos op Roetvallei van 1735-1737, kneg sedert 1737, burger 1747.', '', '2026-07-22 06:27:58.263113', '2026-07-22 06:27:58.263141', NULL, NULL, NULL, NULL, 1, 0),
(248, 'Johan', 'Hendrik Christoffel', 'Kock', '', 'M', '', 'BEF 1745', '', '', '', 1, 'Van Waldeck. Ook bekend as Johann Heinrich Christoph Kok, aankoms 1745,soldaat, boukneg 1745-1747, burger van Swellendam 1747.', '', '2026-07-22 06:37:21.129004', '2026-07-22 06:39:45.901644', NULL, NULL, NULL, NULL, 1, 0),
(249, 'Matthys', '', 'de Beer', '', 'M', '', 'BEF 8 JUN 1721', '', '', '', 1, 'Sy handtekening verskyn op sy skoonpa se testament.', '(s.v. Matthys Andries de Beer & Hilletje Smit)', '2026-07-22 06:49:43.290964', '2026-07-22 06:49:43.291011', NULL, NULL, NULL, NULL, 1, 0),
(250, 'Cornelia', 'Margaretha', 'van Eeden', 'van Deventer', 'F', '', 'BEF 1 JUL 1736', '', '', '', 1, '', '(d.v. Jacob van Deventer(Gerritsz) & Dorothea Coetzer)', '2026-07-22 06:57:09.063532', '2026-07-22 06:57:09.063565', NULL, NULL, NULL, NULL, 1, 0),
(251, 'Cornelia', 'Margaretha', 'van Eeden', 'van Zyl', 'F', '', 'BEF 25 DEC 1764', 'Swellendam, South Africa', '23 JUL 1842', 'Swellendam, South Africa', 1, 'Gebore voor Cogmanskloof, Swellendam, sterf op Bosmanspad Veldkornetskop Kliprivier dist. Swellendam.', '(d.v. Albertus Jacobus van Zyl & Zacharia Geertruy Geldenhuyzen)', '2026-07-22 21:01:38.605485', '2026-07-22 21:04:16.259344', NULL, NULL, NULL, NULL, 1, 0),
(252, 'Maria', 'Elizabeth', 'van Eeden', 'le Roux', 'F', '', '16 AUG 1791', '', '16 APR 1844', 'Swellendam, South Africa', 1, 'Sterf op plaas Faandelsdrift, Veldkornetskop Kluitjieskraal dist. Swellendam. Volgens haar boedel laat sy 6708 pond na slegs 10 kinders, word op haar sterfkennis genoem sy het 12 gehad.', '(d.v. Gabriel le Roux & Hermina Elizabeth de Jager)', '2026-07-22 21:28:26.972742', '2026-07-22 21:28:26.972770', NULL, NULL, NULL, NULL, 1, 0),
(253, 'Michiel', 'Casparus', 'Eksteen', '', 'M', '', '', '', '', '', 1, '', '(s.v. Hendrik Oostwald Eksteen & Elizabeth Francina Adendorff)', '2026-07-22 21:43:10.343014', '2026-07-22 21:48:22.681655', NULL, NULL, NULL, NULL, 1, 0),
(254, 'Hermanus', '', 'Steyn', '', 'M', '', 'BEF 14 DEC 1800', '', '', '', 1, '', '(s.v. Jacobus Frederik Steyn & Beatrix Steyn)', '2026-07-22 21:54:19.457445', '2026-07-22 21:54:19.457490', NULL, NULL, NULL, NULL, 1, 0),
(255, 'Hester', 'Magdalena', 'van Eeden', 'Joubert', 'F', '', 'EST 1814', '', '', '', 1, '', '(d.v. Johannes Stephanus Joubert & Anna Margaretha Jordaan)', '2026-07-23 06:17:19.448043', '2026-07-23 06:19:31.159526', NULL, NULL, NULL, NULL, 1, 0),
(256, 'Anna', 'Margaretha', 'van Eeden', '', 'F', '', '24 AUG 1841', '', '10 OCT 1902', 'Swellendam, South Africa', 1, '', '', '2026-07-23 10:05:13.361110', '2026-07-23 10:05:13.361170', NULL, NULL, NULL, NULL, 1, 0),
(257, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', '20 DEC 1836', '', '27 FEB 1885', 'Swellendam, South Africa', 1, 'Hy het ook op Rynendal gewoon, was \'n transportryer en het verongeluk toe \'n baal wol op die wa losgeruk, hom bo van die wa afgestamp het en hy onder die wa se wiele beland het. Hy het \'n paar dae later gesterf. Sy seuns het met die transportbesigheid aangegaan totdat sy seun, Frederik Jacobus, Transvaal toe getrek het.', '(s.v. Jacob van Eeden & Elizabeth Judith Rousseau)', '2026-07-23 10:13:32.242023', '2026-07-23 10:13:32.242069', NULL, NULL, NULL, NULL, 1, 0),
(258, 'Hansie', '', 'De Waal', '', 'M', '', '17 OCT 1968', 'Bethal', '', '', 0, '', '', '2026-07-25 09:41:41.160526', '2026-07-25 09:41:41.160581', NULL, NULL, NULL, NULL, 3, 0),
(259, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', '1 OCT 1843', '', '', '', 1, 'Volgens familie het hulle hul moontlik in Rhodesië gevestig.', '', '2026-07-26 08:47:30.093737', '2026-07-26 08:47:30.093763', NULL, NULL, NULL, NULL, 1, 0),
(260, 'Maria', 'Elizabeth', 'van Eeden', 'Hendricks', 'F', '', 'EST 1844', '', '', '', 1, '', 'Moontlik (d.v. Stephanus Jacobus Hendrikse & Margaretha Johanna Catharina van Eeden)', '2026-07-26 08:51:52.311384', '2026-07-26 08:51:52.311410', NULL, NULL, NULL, NULL, 1, 0),
(261, 'Johannes', 'Stephanus', 'van Eeden', '', 'M', '', '18 JUL 1845', '', '18 JUL 1929', 'Lang Straat, Villiersdorp, South Africa', 1, 'Bekend as Jan. Boer naby Villiersdorp en daar begrawe.', '', '2026-07-26 08:59:29.454156', '2026-07-26 08:59:29.454185', NULL, NULL, NULL, NULL, 1, 0),
(262, 'Anna', 'Margaretha', 'van Eeden', 'Hendriks', 'F', '', 'EST 1846', '', '', '', 1, '', '', '2026-07-26 09:03:27.166007', '2026-07-26 09:03:27.166053', NULL, NULL, NULL, NULL, 1, 0),
(263, 'Susarah', 'Magdalena', 'van Eeden', 'Wolfaardt', 'F', '', 'EST OCT 1850', '', '20 DEC 1929', 'Villiersdorp, South Africa', 1, 'Sterf in haar huis te Langstraat, Villiersdorp.', '(d.v. Georg Sebastiaan Wolfaardt & Wilhelmina Magrita ?)', '2026-07-26 09:09:37.273337', '2026-07-26 09:09:37.273384', NULL, NULL, NULL, NULL, 1, 0),
(264, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', '15 OCT 1883', '', '1 JUN 1972', 'Swellendam, South Africa', 1, 'Bekend as Frikkie Mos. Gebore op Caledon of Swellendam. Het geboer op Bakleiplaas, Buffeljagsrivier, \'n wingerdplaas, maar het ook gedeeltelik geld gemaak met die verkoop van druiwemos. Vroeër jare het hy ook \'n wettige witblits stokery gehad. In 1934, gedurende die depressie, het hy vir hom \'n splinternuwe vragmotor gekoop vir eenhonderd pond, waarmee hy dan ook die meeste van sy tyd transport gery het. Dit was die eerste vragmotoer in Swellendam distrik. Hy was rustende boer en pesioenaris woonagtig in Kerkstraat 20, Swellendam voor sy dood.', '', '2026-07-26 09:25:30.371553', '2026-07-26 09:25:30.371610', NULL, NULL, NULL, NULL, 1, 0),
(265, 'Johannes', 'Stephanus', 'van Eeden', '', 'M', '', '5 JUL 1887', '', '6 FEB 1957', 'Swellendam, South Africa', 1, 'Hy het tussen Caledon en Villiersdorp geboer. Hy is begrawe op Swellendam.', '', '2026-07-26 13:07:35.302052', '2026-07-26 13:07:35.302097', NULL, NULL, NULL, NULL, 1, 0),
(266, 'Anna', 'Magdalena', 'van Eeden', 'Fick', 'F', '', '21 JUN 1889', '', '16 JAN 1951', 'Swellendam, South Africa', 1, 'Tweede naam Catharina toe sy sterf.', '(d.v. Lambert Hendrik Fick & Isabella Lodewika Theresia Smal)', '2026-07-26 13:11:51.908447', '2026-07-26 13:11:51.908499', NULL, NULL, NULL, NULL, 1, 0);
INSERT INTO `genealogy_person` (`id`, `first_name`, `middle_name`, `last_name`, `maiden_name`, `gender`, `photo`, `birth_date`, `birth_place`, `death_date`, `death_place`, `is_deceased`, `biography`, `notes`, `created_at`, `updated_at`, `birth_lat`, `birth_lng`, `death_lat`, `death_lng`, `created_by_id`, `is_root`) VALUES
(267, 'Gabriel', 'Jacobus', 'van Eeden', '', 'M', '', '5 SEP 1890', 'Swellendam, South Africa', '22 MAY 1959', 'Paarl, Western Cape, South Africa', 1, 'Hy sterf in die Paarl Hospitaal. Wit Gawie genoem omdat hy besonder wit was; boer/voorman van Voorzorg, Rawsonville.', '', '2026-07-26 13:17:46.383789', '2026-07-26 13:17:46.383824', NULL, NULL, NULL, NULL, 1, 0),
(268, 'Geertruyda', 'Alida Magdalena', 'van Eeden', 'Fick', 'F', '', '3 FEB 1900', '', '29 OCT 1979', 'Somerset-Wes, South Africa', 1, '', '(d.v. Lambert Hendrik Fick & Isabella Lodewika Theresia Smal)', '2026-07-26 13:23:28.542164', '2026-07-26 13:23:28.542202', NULL, NULL, NULL, NULL, 1, 0),
(269, 'Gideon', 'Jacobus', 'van Eeden', '', 'M', '', '20 OCT 1893', 'Greyton, South Africa', '13 JUN 1987', 'Swellendam, South Africa', 1, 'Hy boer op die plaas Eastbrook, Sedgefield tot September 1986, daarna woonagtig in Huis AA Tomlinson, Swellendam. Toe hy 66 jaar was het hy op \'n skyfskietkompetisie op Swellendam met \'n oop visier geweer 25 kolskote agtermekaar geskiet en moes toe ophou omdat sy patrone op was.', '', '2026-07-26 13:31:38.654476', '2026-07-26 13:31:38.654518', NULL, NULL, NULL, NULL, 1, 0),
(270, 'Wilhelmina', 'Christina', 'van Eeden', 'Fouchè', 'F', '', '29 JUN 1900', 'Oudtshoorn, South Africa', '4 MAR 1972', 'Swellendam, South Africa', 1, 'Sy sterf in die Swellendam Hospitaal, begrawe in Swellendam. Pensioenaris woonagtig te Bergstr 14, Swellendam voor haar dood.', '(d.v. Paul Fouchè & Margaretha Fourie)', '2026-07-26 13:38:15.081279', '2026-07-26 13:38:15.081305', NULL, NULL, NULL, NULL, 1, 0),
(271, 'Susara', 'Magdalena', 'van Eeden', '', 'F', '', 'EST 1894', '', '', '', 1, '', '', '2026-07-26 13:42:10.984554', '2026-07-26 13:42:10.984579', NULL, NULL, NULL, NULL, 1, 0),
(272, 'Jacobus', 'Marthinus', 'van Eeden', '', 'M', '', 'EST 1895', '', '', 'Villiersdorp, South Africa', 1, 'Nooit getroud. Begrawe in Villiersdorp.', '', '2026-07-26 13:45:08.723481', '2026-07-26 13:45:08.723523', NULL, NULL, NULL, NULL, 1, 0),
(273, 'Gert', 'Christiaan', 'van Eeden', '', 'M', '', '14 MAY 1896', 'Caledon, South Africa', '13 NOV 1968', 'Villiersdorp, South Africa', 1, 'Boer van dist. Villiersdorp.', '', '2026-07-26 13:49:14.186133', '2026-07-26 13:49:14.186181', NULL, NULL, NULL, NULL, 1, 0),
(274, 'Renske', 'Jacoba', 'van Eeden', 'Botes', 'F', '', '9 OCT 1903', 'Villiersdorp, South Africa', '9 JUL 1980', 'Cape Town, South Africa', 1, 'Bekend as Daisy. Sterf in die Tygerberg Hospitaal.', '', '2026-07-26 13:53:07.377595', '2026-07-26 13:53:07.377632', NULL, NULL, NULL, NULL, 1, 0),
(275, 'Hester', 'Magdalena', 'van Eeden', '', 'F', '', 'EST 1900', '', '', '', 1, '', '', '2026-07-26 13:57:11.797067', '2026-07-26 13:57:11.797103', NULL, NULL, NULL, NULL, 1, 0),
(276, 'Sophia', 'Maria', 'van Eeden', '', 'F', '', 'EST 1902', '', '', '', 1, '', '', '2026-07-26 13:58:43.349624', '2026-07-26 13:58:43.349649', NULL, NULL, NULL, NULL, 1, 0),
(277, 'Johanna', 'Christina Helena', 'van Eeden', 'Kriel', 'F', '', '29 JUN 1883', 'Swellendam, South Africa', '10 JAN 1919', 'Caledon, South Africa', 1, 'Gebore op Buffeljachtsrivier, sterf op die plaas Millrivier.', '(d.v. Hendrik Johannes Kriel & Cornelia Frederika Wessels)', '2026-07-26 14:13:22.631125', '2026-07-26 14:13:22.631176', NULL, NULL, NULL, NULL, 1, 0),
(278, 'Anna', 'Petronella', 'van Eeden', 'du Toit', 'F', '', '6 JUN 1897', '', '', '', 0, 'In 1987 woonagtig in ouetehuis op wellendam.', '(d.v. Floris Johannes du Toit & Anna Petronella Erasmus)', '2026-07-26 14:18:23.641603', '2026-07-26 14:21:17.661677', NULL, NULL, NULL, NULL, 1, 0),
(279, 'Cornelia', 'Frederika', 'van Eeden', '', 'F', '', '23 FEB 1914', 'Swellendam, South Africa', '', '', 1, 'Klerk en huisvrou.', '', '2026-07-26 14:43:41.239611', '2026-07-26 14:43:41.239638', NULL, NULL, NULL, NULL, 1, 0),
(280, 'Johannes', '', 'van Wyk', '', 'M', '', '10 JAN 1911', 'Heidelberg, Western Cape, South Africa', '18 MAY 1968', 'Pongola, South Africa', 1, 'Boer.', '(s.v. Jacobus Johannes van Wyk & Johanna Magdalena Coetzee)', '2026-07-26 14:49:26.249977', '2026-07-26 14:53:12.948210', NULL, NULL, NULL, NULL, 1, 0),
(281, 'Jacobus', '', 'van Wyk', '', 'M', '', 'EST NOV 1951', 'Pongola, South Africa', '', '', 0, '', '', '2026-07-26 14:58:37.704080', '2026-07-26 14:58:37.704116', NULL, NULL, NULL, NULL, 1, 0),
(282, 'Johannes', '', 'van Wyk', '', 'M', '', 'EST JUL 1953', 'Pongola, South Africa', '', '', 0, '', '', '2026-07-26 15:00:06.617757', '2026-07-26 15:00:06.617801', NULL, NULL, NULL, NULL, 1, 0),
(283, 'Susara', 'Magdalena', 'van Eeden', '', 'F', '', '14 OCT 1915', 'Caledon, South Africa', '3 NOV 1933', 'Swellendam, South Africa', 1, 'Gebore op Greyton, Caledon; sterf aan huis van haar vader te Bakleiplaas, Buffeljachtsrivier, Swellendam. Onderwyseres.', '', '2026-07-26 15:06:34.768254', '2026-07-26 15:06:34.768322', NULL, NULL, NULL, NULL, 1, 0),
(284, 'Johanna', 'Christina', 'van Eeden', '', 'F', '', '19 MAR 1917', '', '', '', 1, '', '', '2026-07-26 15:11:03.692835', '2026-07-26 15:11:03.692880', NULL, NULL, NULL, NULL, 1, 0),
(285, 'Daniel', '', 'Craigen', '', 'M', '', '26 APR 1913', 'Cape Town, South Africa', '', '', 1, 'Inspekteur stadstremweë, Kaapstad.', '(s.v. William McGregor Craigen & Elizabeth McFerren)', '2026-07-26 15:16:29.342184', '2026-07-26 15:16:29.342220', NULL, NULL, NULL, NULL, 1, 0),
(286, 'Helene', 'Coral', 'Craigen', '', 'F', '', '22 JUL 1946', 'Cape Town, South Africa', '', '', 0, '', '', '2026-07-26 15:20:10.482186', '2026-07-26 15:20:10.482213', NULL, NULL, NULL, NULL, 1, 0),
(287, 'Brian', 'Dennis', 'Butler', '', 'M', '', '', '', '', '', 0, '', '', '2026-07-26 15:21:32.720286', '2026-07-26 15:21:32.720309', NULL, NULL, NULL, NULL, 1, 0),
(288, 'Anne', 'Elizabeth', 'Craigen', '', 'F', '', '2 APR 1950', 'Cape Town, South Africa', '', '', 0, '', '', '2026-07-26 15:24:07.352483', '2026-07-26 15:24:07.352550', NULL, NULL, NULL, NULL, 1, 0),
(289, 'Ronald', 'Montague', 'Matthews', '', 'M', '', '', '', '', '', 0, '', '', '2026-07-26 15:25:57.132860', '2026-07-26 15:25:57.132903', NULL, NULL, NULL, NULL, 1, 0),
(290, 'Daniel', 'Frederik', 'Craigen', '', 'M', '', '5 NOV 1951', 'Cape Town, South Africa', '11 NOV 1959', 'Bellville, Cape Town, South Africa', 1, '', '', '2026-07-26 15:28:53.894679', '2026-07-26 15:28:53.894705', NULL, NULL, NULL, NULL, 1, 0),
(291, 'Hester', 'Maria', 'van Eeden', '', 'F', '', 'EST 1919', '', '', '', 1, '', '', '2026-07-26 15:30:42.649942', '2026-07-26 15:31:47.944983', NULL, NULL, NULL, NULL, 1, 0),
(292, 'Anna', 'Petronella', 'van Eeden', '', 'F', '', '4 SEP 1921', 'Caledon, South Africa', '20 SEP 1979', 'Cape Town, South Africa', 1, 'Gebore op Buffeljachtsrivier, Sterf in die Tygerberg Hospitaal.', '', '2026-07-26 15:35:23.514831', '2026-07-26 15:35:23.514862', NULL, NULL, NULL, NULL, 1, 0),
(293, 'Abraham', 'Albertus Petrus', 'Odendaal', '', 'M', '', '26 SEP 1917', '', '', '', 1, 'Gebore op Buffeljachtsrivier. Boer.', '(s.v. Willem Johannes Odendaal & Hester Aletta Susanna Cilliers)', '2026-07-26 15:41:12.284436', '2026-07-26 15:41:12.284496', NULL, NULL, NULL, NULL, 1, 0),
(294, 'Willem', 'Johannes', 'Odendaal', '', 'M', '', '29 AUG 1949', 'Buffeljachtsrivier, South Africa', '', '', 0, 'Hoof Techniese Dienste, Viginia OVS Munisipaliteit.', '', '2026-07-26 15:45:54.123183', '2026-07-26 15:45:54.123213', NULL, NULL, NULL, NULL, 1, 0),
(295, 'Mariana', '', 'Haasbroek', '', 'F', '', '17 JUL 1952', 'Carltonville, South Africa', '', '', 0, '', '(d.v. Charl Francois Haasbroek & Hermina Christina Maria Isabella Raper)', '2026-07-26 15:50:38.400473', '2026-07-26 15:50:38.400524', NULL, NULL, NULL, NULL, 1, 0),
(296, 'Hermine', '', 'Odendaal', '', 'F', '', '20 NOV 1980', '', '', '', 0, '', '', '2026-07-26 15:54:47.065660', '2026-07-26 15:54:47.065700', NULL, NULL, NULL, NULL, 1, 0),
(297, 'Nanette', '', 'Odendaal', '', 'F', '', '5 NOV 1983', '', '', '', 0, '', '', '2026-07-26 15:56:03.847734', '2026-07-26 15:56:03.847814', NULL, NULL, NULL, NULL, 1, 0),
(298, 'Frederik', 'Jacobus', 'Odendaal', '', 'M', '', '29 JUN 1952', '', '', '', 0, '', '', '2026-07-26 15:58:45.970501', '2026-07-26 15:58:45.970542', NULL, NULL, NULL, NULL, 1, 0),
(299, 'Mariaan', '', 'Wolhuter', '', 'F', '', '', '', '', '', 0, '', '', '2026-07-26 16:00:13.775937', '2026-07-26 16:00:13.775966', NULL, NULL, NULL, NULL, 1, 0),
(300, 'Anna', 'Petronella', 'Odendaal', '', 'F', '', '15 NOV 1956', 'Buffeljachtsrivier, South Africa', '', '', 0, '', '', '2026-07-26 16:02:41.910670', '2026-07-26 16:02:41.910720', NULL, NULL, NULL, NULL, 1, 0),
(301, 'Hermanus', 'Hendrik', 'Giliomee', '', 'M', '', 'EST 1954', '', '', '', 0, '', '', '2026-07-26 16:04:46.726594', '2026-07-26 16:04:46.726634', NULL, NULL, NULL, NULL, 1, 0),
(302, 'Johannes', 'Stephanus', 'van Eeden', '', 'M', '', '2 JUL 1923', 'Swellendam, South Africa', '16 OCT 1996', '', 1, 'Bekend as Boetie Mos. Sterf aan hartaanval; begrawe in NG Kerk begraafplaas, Swellendam. 1990 Boer gemengde boerdery en met waterblommetjies; ook \'n kortverhaalskrywer - sien Sandybay kortverhaal; woon in Kerkstr, Swellendam voor dood.', '', '2026-07-26 16:29:15.507656', '2026-07-26 16:29:15.507736', NULL, NULL, NULL, NULL, 1, 0),
(303, 'Hester', 'Magdalena', 'van Eeden', 'Kapp', 'F', '', '2 APR 1934', 'Knysna, South Africa', '', '', 0, '1990 Tikster/klerk, woom Kerkstr, Swellendam.', '(d.v. Christiaan Gerber Kapp & Susara Salomina van der Watt)', '2026-07-26 16:33:59.973281', '2026-07-26 16:33:59.973344', NULL, NULL, NULL, NULL, 1, 0),
(304, 'Frederik', 'Jacobus', 'van Eeden', '', 'M', '', '16 OCT 1959', 'Swellendam, South Africa', '23 AUG 1992', 'Johannesburg, South Africa', 1, '1990 student.', '', '2026-07-26 16:50:06.738469', '2026-07-26 16:50:06.738501', NULL, NULL, NULL, NULL, 1, 0),
(305, 'Amanda', '', 'van Eeden', '', 'U', '', '13 OCT 1962', 'Swellendam, South Africa', '', '', 0, 'Bekend as Mandie. Onderwyseres te Kaapstad 1987.', '', '2026-07-26 16:52:27.234501', '2026-07-26 16:52:27.234539', NULL, NULL, NULL, NULL, 1, 0),
(306, 'Pierre', '', 'le Grange', '', 'M', '', '19 MAY 1960', 'Stellenbosch, Western Cape, South Africa', '', '', 0, 'Tegniese Direkteur.', '', '2026-07-26 16:57:49.935035', '2026-07-26 16:57:49.935076', NULL, NULL, NULL, NULL, 1, 0),
(307, 'Nadia', '', 'le Grange', '', 'F', '', '8 JUN 1989', 'Riversdale, South Africa', '', '', 0, '', '', '2026-07-26 17:00:55.158601', '2026-07-26 17:00:55.158644', NULL, NULL, NULL, NULL, 1, 0),
(308, 'Eeden', '', 'le Grange', '', 'M', '', '23 OCT 1991', 'Riversdale, South Africa', '', '', 0, '', '', '2026-07-26 17:02:23.901245', '2026-07-26 17:02:23.901275', NULL, NULL, NULL, NULL, 1, 0),
(309, 'Sophia', 'Maria', 'van Eeden', '', 'F', '', '19 SEP 1925', 'Swellendam, South Africa', '', '', 0, 'Skei haar eerste man, trou weer met hom en skei \'n tweede keer nadat sy in 1986 by \'n skool re-unie op Swellendam \'n ou skoolmaat ontmoet van wie sy baie gehou het.', '', '2026-07-26 17:13:35.518927', '2026-07-26 17:13:35.518963', NULL, NULL, NULL, NULL, 1, 0),
(310, 'Daniel', 'Johannes', 'Gerrits', '', 'M', '', '', '', '', '', 0, '', '', '2026-07-26 17:17:34.026862', '2026-07-26 17:17:34.026910', NULL, NULL, NULL, NULL, 1, 0),
(311, 'Dirk', 'Cornelius', 'Human', '', 'M', '', 'EST 1925', '', '', '', 0, '', '', '2026-07-26 17:20:07.781837', '2026-07-26 17:20:07.781867', NULL, NULL, NULL, NULL, 1, 0),
(312, 'Daniel', 'Johannes', 'Gerrits', '', 'M', '', 'EST 1946', '', '', '', 0, 'Hy was Punt Jansen se privaat sekretaris; werk daarna by KWV.', '', '2026-07-26 17:23:04.006385', '2026-07-26 17:23:04.006422', NULL, NULL, NULL, NULL, 1, 0),
(313, 'Anna-Marie', '', 'Gerrits', '', 'F', '', 'EST 1948', '', '', '', 0, 'Werk by KWV; ontmoet haar man in London met \'n KWV reklameveldtog, trou en skei weer.', '', '2026-07-26 17:25:54.792271', '2026-07-26 17:25:54.792316', NULL, NULL, NULL, NULL, 1, 0),
(314, 'Maria', 'Catharina', 'van Eeden', '', 'F', '', '21 MAY 1929', 'Buffeljachtsrivier, South Africa', '', '', 0, '', '', '2026-07-26 17:29:10.284067', '2026-07-26 17:29:10.284100', NULL, NULL, NULL, NULL, 1, 0),
(315, 'Johannes', 'Christiaan', 'Rust', '', 'M', '', 'EST 1925', '', '8 AUG 1958', '', 1, '', '', '2026-07-26 17:39:01.428713', '2026-07-26 17:39:01.428740', NULL, NULL, NULL, NULL, 1, 0),
(316, 'Petrus', 'Johannes', 'Blom', '', 'M', '', '16 OCT 1933', 'Rietfontein, Western Cape, South Africa', '', '', 0, 'Wynboerplaasbestuurder.', '(s.v. Daniel Johannes Blom & Susanna Maria ?)', '2026-07-26 17:43:47.338851', '2026-07-26 17:43:47.338876', NULL, NULL, NULL, NULL, 1, 0),
(317, 'Johannes', 'Christiaan', 'Rust', '', 'M', '', '4 MAY 1953', 'Franschhoek, Western Cape, South Africa', '', '', 0, '', '', '2026-07-26 17:48:33.655274', '2026-07-26 17:48:33.655298', NULL, NULL, NULL, NULL, 1, 0),
(318, 'Lorraine', '', 'du Plessis', '', 'F', '', '', '', '', '', 0, 'Van Pretoria.', '', '2026-07-26 17:50:50.560972', '2026-07-26 17:50:50.561025', NULL, NULL, NULL, NULL, 1, 0),
(319, 'Frederik', 'Jacobus', 'Rust', '', 'M', '', '11 FEB 1955', 'Franschhoek, Western Cape, South Africa', '', '', 0, '', '', '2026-07-26 17:52:50.658932', '2026-07-26 17:52:50.658958', NULL, NULL, NULL, NULL, 1, 0),
(320, 'Heidie', '', 'van Staden', '', 'F', '', 'EST 1956', '', '', '', 0, '', '', '2026-07-26 17:56:41.908709', '2026-07-26 17:56:41.908777', NULL, NULL, NULL, NULL, 1, 0),
(321, 'Annelize', '', 'Rust', '', 'F', '', '16 MAY 1978', '', '', '', 0, '', '', '2026-07-26 17:59:28.117621', '2026-07-26 17:59:28.117667', NULL, NULL, NULL, NULL, 1, 0),
(322, 'Petrus', 'Johannes', 'Rust', '', 'M', '', '24 FEB 1982', '', '', '', 0, '', '', '2026-07-26 18:00:43.358830', '2026-07-26 18:00:43.358854', NULL, NULL, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_relationship`
--

CREATE TABLE `genealogy_relationship` (
  `id` bigint NOT NULL,
  `relationship_type` varchar(20) NOT NULL,
  `notes` longtext NOT NULL,
  `person_id` bigint NOT NULL,
  `relative_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_relationship`
--

INSERT INTO `genealogy_relationship` (`id`, `relationship_type`, `notes`, `person_id`, `relative_id`) VALUES
(1, 'parent', '', 1, 4),
(2, 'parent', '', 1, 5),
(5, 'parent', '', 2, 4),
(6, 'parent', '', 3, 5),
(7, 'parent', '', 1, 8),
(8, 'parent', '', 3, 8),
(9, 'parent', '', 1, 9),
(10, 'parent', '', 3, 9),
(11, 'parent', '', 1, 10),
(12, 'parent', '', 3, 10),
(13, 'parent', '', 1, 11),
(14, 'parent', '', 3, 11),
(15, 'parent', '', 9, 12),
(16, 'parent', '', 9, 13),
(17, 'parent', '', 9, 15),
(18, 'parent', '', 9, 16),
(19, 'parent', '', 9, 17),
(20, 'parent', '', 9, 18),
(22, 'parent', '', 9, 20),
(23, 'parent', '', 9, 21),
(24, 'parent', '', 9, 22),
(25, 'parent', '', 9, 14),
(26, 'parent', '', 12, 23),
(27, 'parent', '', 16, 24),
(28, 'parent', '', 16, 25),
(29, 'parent', '', 16, 26),
(30, 'parent', '', 16, 27),
(31, 'parent', '', 16, 28),
(32, 'parent', '', 24, 30),
(33, 'parent', '', 24, 31),
(34, 'parent', '', 24, 29),
(35, 'parent', '', 24, 32),
(36, 'parent', '', 24, 33),
(37, 'parent', '', 24, 34),
(38, 'parent', '', 24, 35),
(39, 'parent', '', 24, 36),
(40, 'parent', '', 24, 37),
(41, 'parent', '', 24, 38),
(42, 'parent', '', 24, 39),
(43, 'parent', '', 24, 40),
(46, 'parent', '', 29, 42),
(47, 'parent', '', 29, 43),
(48, 'parent', '', 29, 44),
(49, 'parent', '', 29, 45),
(50, 'parent', '', 29, 46),
(51, 'parent', '', 29, 41),
(52, 'parent', '', 29, 47),
(53, 'parent', '', 29, 48),
(54, 'parent', '', 29, 49),
(55, 'parent', '', 29, 50),
(56, 'parent', '', 29, 51),
(57, 'parent', '', 29, 52),
(58, 'parent', '', 50, 54),
(59, 'parent', '', 50, 55),
(60, 'parent', '', 50, 56),
(61, 'parent', '', 50, 57),
(62, 'parent', '', 50, 58),
(63, 'parent', '', 50, 59),
(64, 'parent', '', 50, 60),
(65, 'parent', '', 50, 61),
(66, 'parent', '', 50, 62),
(67, 'parent', '', 56, 65),
(68, 'parent', '', 56, 66),
(69, 'parent', '', 56, 67),
(70, 'parent', '', 56, 68),
(71, 'parent', '', 56, 69),
(72, 'parent', '', 56, 70),
(73, 'parent', '', 56, 71),
(74, 'parent', '', 56, 72),
(75, 'parent', '', 56, 73),
(77, 'parent', '', 56, 75),
(78, 'parent', '', 56, 74),
(79, 'parent', '', 71, 78),
(80, 'parent', '', 71, 79),
(82, 'parent', '', 71, 81),
(83, 'parent', '', 71, 82),
(84, 'parent', '', 71, 83),
(85, 'parent', '', 78, 89),
(86, 'parent', '', 78, 90),
(87, 'parent', '', 79, 91),
(88, 'parent', '', 79, 92),
(89, 'parent', '', 79, 93),
(90, 'parent', '', 79, 94),
(91, 'parent', '', 80, 101),
(92, 'parent', '', 80, 100),
(93, 'parent', '', 80, 102),
(94, 'parent', '', 80, 103),
(95, 'parent', '', 108, 109),
(96, 'parent', '', 108, 110),
(97, 'step_parent', '', 100, 109),
(98, 'step_parent', '', 100, 110),
(103, 'parent', '', 102, 117),
(104, 'parent', '', 102, 118),
(105, 'parent', '', 103, 120),
(106, 'parent', '', 103, 121),
(107, 'parent', '', 103, 122),
(108, 'parent', '', 103, 123),
(109, 'parent', '', 82, 124),
(110, 'parent', '', 82, 125),
(111, 'parent', '', 82, 126),
(112, 'parent', '', 83, 127),
(113, 'parent', '', 83, 128),
(114, 'parent', '', 89, 129),
(115, 'parent', '', 104, 129),
(116, 'adoptive_parent', 'Aangeneem op 29/10/1976', 105, 129),
(117, 'parent', '', 89, 130),
(118, 'parent', '', 104, 130),
(119, 'parent', '', 89, 131),
(120, 'parent', '', 105, 131),
(121, 'parent', '', 90, 132),
(122, 'parent', '', 133, 132),
(123, 'parent', '', 90, 134),
(124, 'parent', '', 133, 134),
(125, 'parent', '', 90, 135),
(126, 'parent', '', 133, 135),
(127, 'parent', '', 91, 136),
(128, 'parent', '', 95, 136),
(129, 'parent', '', 91, 137),
(130, 'parent', '', 95, 137),
(134, 'parent', '', 92, 139),
(135, 'parent', '', 96, 139),
(137, 'parent', '', 92, 140),
(138, 'parent', '', 97, 140),
(141, 'parent', '', 71, 80),
(142, 'parent', '', 92, 138),
(143, 'parent', '', 96, 138),
(144, 'parent', '', 94, 141),
(145, 'parent', '', 94, 142),
(146, 'parent', '', 101, 112),
(147, 'parent', '', 112, 144),
(148, 'parent', '', 112, 145),
(149, 'parent', '', 143, 144),
(150, 'parent', '', 143, 145),
(151, 'parent', '', 111, 112),
(152, 'parent', '', 101, 146),
(153, 'parent', '', 111, 146),
(154, 'parent', '', 146, 148),
(155, 'parent', '', 146, 149),
(156, 'parent', '', 147, 148),
(157, 'parent', '', 147, 149),
(158, 'parent', '', 101, 150),
(159, 'parent', '', 111, 150),
(160, 'parent', '', 101, 115),
(161, 'parent', '', 111, 115),
(162, 'parent', '', 119, 120),
(163, 'parent', '', 119, 121),
(164, 'parent', '', 121, 154),
(165, 'parent', '', 153, 154),
(166, 'parent', '', 119, 122),
(167, 'parent', '', 119, 123),
(168, 'parent', '', 87, 124),
(169, 'parent', '', 87, 125),
(170, 'parent', '', 87, 126),
(171, 'parent', '', 124, 157),
(173, 'parent', '', 124, 158),
(174, 'parent', '', 156, 157),
(175, 'parent', '', 156, 158),
(176, 'parent', '', 157, 159),
(177, 'step_parent', '', 160, 159),
(178, 'parent', '', 157, 161),
(179, 'parent', '', 160, 161),
(180, 'parent', '', 157, 162),
(181, 'parent', '', 157, 163),
(182, 'parent', '', 160, 162),
(183, 'parent', '', 160, 163),
(184, 'parent', '', 125, 166),
(185, 'parent', '', 125, 167),
(186, 'parent', '', 164, 166),
(187, 'parent', '', 165, 167),
(188, 'adoptive_parent', '', 126, 170),
(189, 'parent', '', 168, 170),
(190, 'parent', '', 169, 170),
(191, 'parent', '', 126, 171),
(192, 'parent', '', 126, 172),
(193, 'parent', '', 168, 171),
(194, 'parent', '', 168, 172),
(195, 'parent', '', 127, 175),
(196, 'parent', '', 174, 175),
(198, 'parent', '', 5, 7),
(199, 'parent', '', 6, 7),
(200, 'parent', '', 8, 178),
(201, 'parent', '', 8, 179),
(202, 'parent', '', 177, 178),
(203, 'parent', '', 177, 179),
(204, 'parent', '', 10, 186),
(205, 'parent', '', 184, 186),
(206, 'parent', '', 186, 188),
(207, 'parent', '', 186, 189),
(208, 'parent', '', 187, 188),
(209, 'parent', '', 187, 189),
(210, 'parent', '', 10, 190),
(211, 'parent', '', 184, 190),
(212, 'parent', '', 190, 192),
(213, 'parent', '', 190, 193),
(214, 'parent', '', 190, 194),
(215, 'parent', '', 190, 195),
(216, 'parent', '', 190, 204),
(217, 'parent', '', 190, 205),
(218, 'parent', '', 190, 196),
(219, 'parent', '', 190, 197),
(220, 'parent', '', 190, 198),
(222, 'parent', '', 190, 199),
(223, 'parent', '', 190, 200),
(224, 'parent', '', 190, 201),
(225, 'parent', '', 190, 202),
(226, 'parent', '', 190, 203),
(227, 'parent', '', 191, 192),
(228, 'parent', '', 191, 193),
(229, 'parent', '', 191, 194),
(230, 'parent', '', 191, 195),
(231, 'parent', '', 191, 204),
(232, 'parent', '', 191, 205),
(233, 'parent', '', 191, 196),
(234, 'parent', '', 191, 197),
(235, 'parent', '', 191, 198),
(236, 'parent', '', 191, 199),
(237, 'parent', '', 191, 200),
(238, 'parent', '', 191, 201),
(239, 'parent', '', 191, 202),
(240, 'parent', '', 191, 203),
(241, 'parent', '', 10, 206),
(242, 'parent', '', 184, 206),
(243, 'parent', '', 206, 208),
(244, 'parent', '', 206, 209),
(245, 'parent', '', 206, 210),
(246, 'parent', '', 206, 211),
(247, 'parent', '', 206, 212),
(248, 'parent', '', 206, 213),
(249, 'parent', '', 206, 214),
(250, 'parent', '', 207, 208),
(251, 'parent', '', 207, 209),
(252, 'parent', '', 207, 210),
(253, 'parent', '', 207, 211),
(254, 'parent', '', 207, 212),
(255, 'parent', '', 207, 213),
(256, 'parent', '', 207, 214),
(257, 'parent', '', 10, 215),
(258, 'parent', '', 184, 215),
(259, 'parent', '', 215, 218),
(260, 'parent', '', 215, 219),
(261, 'parent', '', 215, 220),
(262, 'parent', '', 215, 221),
(263, 'parent', '', 215, 222),
(264, 'parent', '', 215, 223),
(265, 'parent', '', 215, 224),
(266, 'parent', '', 215, 225),
(267, 'parent', '', 216, 218),
(268, 'parent', '', 216, 219),
(269, 'parent', '', 216, 220),
(270, 'parent', '', 216, 221),
(271, 'parent', '', 216, 222),
(272, 'parent', '', 216, 223),
(273, 'parent', '', 216, 224),
(274, 'parent', '', 216, 225),
(275, 'parent', '', 215, 226),
(276, 'parent', '', 215, 227),
(277, 'parent', '', 215, 228),
(278, 'parent', '', 215, 229),
(279, 'parent', '', 215, 230),
(280, 'parent', '', 215, 231),
(281, 'parent', '', 215, 232),
(282, 'parent', '', 215, 233),
(283, 'parent', '', 215, 234),
(284, 'parent', '', 215, 235),
(285, 'parent', '', 217, 227),
(286, 'parent', '', 217, 226),
(287, 'parent', '', 217, 228),
(288, 'parent', '', 217, 229),
(289, 'parent', '', 217, 230),
(290, 'parent', '', 217, 231),
(291, 'parent', '', 217, 232),
(292, 'parent', '', 217, 233),
(293, 'parent', '', 217, 234),
(294, 'parent', '', 217, 235),
(295, 'parent', '', 10, 236),
(296, 'parent', '', 184, 236),
(297, 'parent', '', 237, 238),
(298, 'parent', '', 237, 239),
(299, 'parent', '', 237, 240),
(300, 'parent', '', 237, 241),
(301, 'parent', '', 237, 242),
(302, 'parent', '', 236, 238),
(303, 'parent', '', 236, 239),
(304, 'parent', '', 236, 240),
(305, 'parent', '', 236, 242),
(306, 'parent', '', 236, 241),
(307, 'parent', '', 10, 243),
(308, 'parent', '', 10, 244),
(309, 'parent', '', 63, 65),
(310, 'parent', '', 63, 66),
(311, 'parent', '', 63, 67),
(312, 'parent', '', 63, 68),
(313, 'parent', '', 63, 69),
(314, 'parent', '', 63, 70),
(315, 'parent', '', 63, 71),
(316, 'parent', '', 63, 72),
(317, 'parent', '', 63, 73),
(318, 'parent', '', 63, 74),
(319, 'parent', '', 63, 75),
(320, 'parent', '', 76, 78),
(321, 'parent', '', 76, 79),
(322, 'parent', '', 76, 80),
(323, 'parent', '', 76, 81),
(324, 'parent', '', 76, 82),
(325, 'parent', '', 76, 83),
(326, 'parent', '', 84, 89),
(327, 'parent', '', 84, 90),
(328, 'parent', '', 85, 91),
(329, 'parent', '', 85, 92),
(330, 'parent', '', 85, 93),
(331, 'parent', '', 85, 94),
(332, 'parent', '', 86, 100),
(333, 'parent', '', 86, 101),
(334, 'parent', '', 86, 102),
(335, 'parent', '', 86, 103),
(336, 'parent', '', 88, 127),
(337, 'parent', '', 88, 128),
(344, 'parent', '', 9, 19),
(345, 'parent', '', 183, 12),
(346, 'parent', '', 183, 13),
(347, 'parent', '', 183, 14),
(348, 'parent', '', 183, 15),
(349, 'parent', '', 183, 16),
(350, 'parent', '', 183, 17),
(351, 'parent', '', 183, 18),
(352, 'parent', '', 183, 19),
(353, 'parent', '', 183, 20),
(354, 'parent', '', 183, 21),
(355, 'parent', '', 183, 22),
(356, 'parent', '', 246, 23),
(357, 'parent', '', 250, 24),
(358, 'parent', '', 250, 25),
(359, 'parent', '', 250, 27),
(360, 'parent', '', 250, 26),
(361, 'parent', '', 250, 28),
(367, 'parent', '', 251, 29),
(368, 'parent', '', 251, 30),
(369, 'parent', '', 251, 31),
(370, 'parent', '', 251, 32),
(371, 'parent', '', 251, 33),
(372, 'parent', '', 251, 34),
(373, 'parent', '', 251, 35),
(374, 'parent', '', 251, 36),
(375, 'parent', '', 251, 37),
(376, 'parent', '', 251, 38),
(377, 'parent', '', 251, 39),
(378, 'parent', '', 251, 40),
(379, 'parent', '', 252, 41),
(380, 'parent', '', 252, 42),
(381, 'parent', '', 252, 43),
(382, 'parent', '', 252, 44),
(383, 'parent', '', 252, 45),
(384, 'parent', '', 252, 46),
(385, 'parent', '', 252, 47),
(386, 'parent', '', 252, 48),
(387, 'parent', '', 252, 49),
(388, 'parent', '', 252, 50),
(389, 'parent', '', 252, 51),
(390, 'parent', '', 252, 52),
(391, 'parent', '', 44, 256),
(392, 'parent', '', 44, 259),
(393, 'parent', '', 44, 261),
(394, 'parent', '', 261, 264),
(395, 'parent', '', 261, 265),
(396, 'parent', '', 261, 267),
(397, 'parent', '', 261, 269),
(398, 'parent', '', 261, 271),
(399, 'parent', '', 261, 272),
(400, 'parent', '', 261, 273),
(401, 'parent', '', 261, 275),
(402, 'parent', '', 261, 276),
(403, 'parent', '', 263, 264),
(404, 'parent', '', 263, 265),
(405, 'parent', '', 263, 267),
(406, 'parent', '', 263, 269),
(407, 'parent', '', 263, 271),
(408, 'parent', '', 263, 272),
(409, 'parent', '', 263, 273),
(410, 'parent', '', 263, 275),
(411, 'parent', '', 263, 276),
(412, 'parent', '', 264, 279),
(413, 'parent', '', 279, 281),
(414, 'parent', '', 279, 282),
(415, 'parent', '', 280, 281),
(416, 'parent', '', 280, 282),
(417, 'parent', '', 264, 283),
(418, 'parent', '', 264, 284),
(419, 'parent', '', 284, 286),
(420, 'parent', '', 284, 288),
(421, 'parent', '', 284, 290),
(422, 'parent', '', 264, 291),
(423, 'parent', '', 264, 292),
(424, 'parent', '', 292, 294),
(425, 'parent', '', 294, 296),
(426, 'parent', '', 294, 297),
(427, 'parent', '', 295, 296),
(428, 'parent', '', 295, 297),
(429, 'parent', '', 292, 298),
(430, 'parent', '', 292, 300),
(431, 'parent', '', 264, 302),
(432, 'parent', '', 285, 286),
(433, 'parent', '', 285, 288),
(434, 'parent', '', 285, 290),
(435, 'parent', '', 293, 294),
(436, 'parent', '', 293, 298),
(437, 'parent', '', 293, 300),
(438, 'parent', '', 302, 304),
(439, 'parent', '', 302, 305),
(440, 'parent', '', 303, 304),
(441, 'parent', '', 303, 305),
(442, 'parent', '', 305, 307),
(443, 'parent', '', 305, 308),
(444, 'parent', '', 306, 307),
(445, 'parent', '', 306, 308),
(446, 'parent', '', 264, 309),
(447, 'parent', '', 309, 312),
(448, 'parent', '', 309, 313),
(449, 'parent', '', 310, 312),
(450, 'parent', '', 310, 313),
(451, 'parent', '', 264, 314),
(452, 'parent', '', 277, 279),
(453, 'parent', '', 277, 283),
(454, 'parent', '', 277, 284),
(455, 'parent', '', 277, 291),
(456, 'parent', '', 278, 292),
(457, 'parent', '', 278, 302),
(458, 'parent', '', 278, 309),
(459, 'parent', '', 278, 314),
(460, 'parent', '', 314, 317),
(461, 'parent', '', 314, 319),
(462, 'parent', '', 315, 317),
(463, 'parent', '', 315, 319),
(464, 'parent', '', 319, 321),
(465, 'parent', '', 319, 322),
(466, 'parent', '', 320, 321),
(467, 'parent', '', 320, 322),
(468, 'parent', '', 273, 78),
(469, 'parent', '', 273, 79),
(470, 'parent', '', 273, 80),
(471, 'parent', '', 273, 81),
(472, 'parent', '', 273, 82),
(473, 'parent', '', 273, 83);

-- --------------------------------------------------------

--
-- Table structure for table `genealogy_userprofile`
--

CREATE TABLE `genealogy_userprofile` (
  `id` bigint NOT NULL,
  `role` varchar(10) NOT NULL,
  `bio` longtext NOT NULL,
  `joined` datetime(6) NOT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `approved_by_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `genealogy_userprofile`
--

INSERT INTO `genealogy_userprofile` (`id`, `role`, `bio`, `joined`, `approved_at`, `approved_by_id`, `user_id`) VALUES
(1, 'admin', '', '2026-07-08 12:02:33.186314', NULL, NULL, 1),
(3, 'trusted', 'Gebore Van Eeden', '2026-07-20 16:20:17.996652', '2026-07-20 19:39:42.272810', 1, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `blog_category`
--
ALTER TABLE `blog_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_comment_post_id_580e96ef_fk_blog_post_id` (`post_id`);

--
-- Indexes for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `blog_post_author_id_dd7a8485_fk_auth_user_id` (`author_id`),
  ADD KEY `blog_post_category_id_c326dbf8_fk_blog_category_id` (`category_id`);

--
-- Indexes for table `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_post_tags_post_id_tag_id_4925ec37_uniq` (`post_id`,`tag_id`),
  ADD KEY `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` (`tag_id`);

--
-- Indexes for table `blog_tag`
--
ALTER TABLE `blog_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `genealogy_auditlog`
--
ALTER TABLE `genealogy_auditlog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genealogy_auditlog_user_id_d7c789f0_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `genealogy_document`
--
ALTER TABLE `genealogy_document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genealogy_document_uploaded_by_id_d83e336c_fk_auth_user_id` (`uploaded_by_id`),
  ADD KEY `genealogy_document_event_id_c994a1a2_fk_genealogy_event_id` (`event_id`),
  ADD KEY `genealogy_document_marriage_id_ab706d85_fk_genealogy_marriage_id` (`marriage_id`),
  ADD KEY `genealogy_document_relationship_id_5fb93e70_fk_genealogy` (`relationship_id`);

--
-- Indexes for table `genealogy_document_people`
--
ALTER TABLE `genealogy_document_people`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `genealogy_document_people_document_id_person_id_0e0262df_uniq` (`document_id`,`person_id`),
  ADD KEY `genealogy_document_p_person_id_367021f6_fk_genealogy` (`person_id`);

--
-- Indexes for table `genealogy_event`
--
ALTER TABLE `genealogy_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genealogy_event_main_person_id_bc4ec5bb_fk_genealogy_person_id` (`main_person_id`);

--
-- Indexes for table `genealogy_event_people`
--
ALTER TABLE `genealogy_event_people`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `genealogy_event_people_event_id_person_id_d27e3efe_uniq` (`event_id`,`person_id`),
  ADD KEY `genealogy_event_people_person_id_b1bcc161_fk_genealogy_person_id` (`person_id`);

--
-- Indexes for table `genealogy_marriage`
--
ALTER TABLE `genealogy_marriage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genealogy_marriage_person1_id_ba0586a8_fk_genealogy_person_id` (`person1_id`),
  ADD KEY `genealogy_marriage_person2_id_a7ed3c34_fk_genealogy_person_id` (`person2_id`);

--
-- Indexes for table `genealogy_pendingedit`
--
ALTER TABLE `genealogy_pendingedit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genealogy_pendingedit_proposed_by_id_0b8bf487_fk_auth_user_id` (`proposed_by_id`),
  ADD KEY `genealogy_pendingedit_reviewed_by_id_722148e8_fk_auth_user_id` (`reviewed_by_id`);

--
-- Indexes for table `genealogy_person`
--
ALTER TABLE `genealogy_person`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genealogy_person_created_by_id_30e8d6f5_fk_auth_user_id` (`created_by_id`);

--
-- Indexes for table `genealogy_relationship`
--
ALTER TABLE `genealogy_relationship`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `genealogy_relationship_person_id_relative_id_re_5f2b14d8_uniq` (`person_id`,`relative_id`,`relationship_type`),
  ADD KEY `genealogy_relationsh_relative_id_04ed66e7_fk_genealogy` (`relative_id`);

--
-- Indexes for table `genealogy_userprofile`
--
ALTER TABLE `genealogy_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `genealogy_userprofile_approved_by_id_ec4f0b91_fk_auth_user_id` (`approved_by_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `blog_category`
--
ALTER TABLE `blog_category`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `blog_comment`
--
ALTER TABLE `blog_comment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `blog_post`
--
ALTER TABLE `blog_post`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_tag`
--
ALTER TABLE `blog_tag`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `genealogy_auditlog`
--
ALTER TABLE `genealogy_auditlog`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1023;

--
-- AUTO_INCREMENT for table `genealogy_document`
--
ALTER TABLE `genealogy_document`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `genealogy_document_people`
--
ALTER TABLE `genealogy_document_people`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `genealogy_event`
--
ALTER TABLE `genealogy_event`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `genealogy_event_people`
--
ALTER TABLE `genealogy_event_people`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `genealogy_marriage`
--
ALTER TABLE `genealogy_marriage`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `genealogy_pendingedit`
--
ALTER TABLE `genealogy_pendingedit`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genealogy_person`
--
ALTER TABLE `genealogy_person`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=323;

--
-- AUTO_INCREMENT for table `genealogy_relationship`
--
ALTER TABLE `genealogy_relationship`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=474;

--
-- AUTO_INCREMENT for table `genealogy_userprofile`
--
ALTER TABLE `genealogy_userprofile`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD CONSTRAINT `blog_comment_post_id_580e96ef_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`);

--
-- Constraints for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD CONSTRAINT `blog_post_author_id_dd7a8485_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `blog_post_category_id_c326dbf8_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`);

--
-- Constraints for table `blog_post_tags`
--
ALTER TABLE `blog_post_tags`
  ADD CONSTRAINT `blog_post_tags_post_id_a1c71c8a_fk_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`),
  ADD CONSTRAINT `blog_post_tags_tag_id_0875c551_fk_blog_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `genealogy_auditlog`
--
ALTER TABLE `genealogy_auditlog`
  ADD CONSTRAINT `genealogy_auditlog_user_id_d7c789f0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `genealogy_document`
--
ALTER TABLE `genealogy_document`
  ADD CONSTRAINT `genealogy_document_event_id_c994a1a2_fk_genealogy_event_id` FOREIGN KEY (`event_id`) REFERENCES `genealogy_event` (`id`),
  ADD CONSTRAINT `genealogy_document_marriage_id_ab706d85_fk_genealogy_marriage_id` FOREIGN KEY (`marriage_id`) REFERENCES `genealogy_marriage` (`id`),
  ADD CONSTRAINT `genealogy_document_relationship_id_5fb93e70_fk_genealogy` FOREIGN KEY (`relationship_id`) REFERENCES `genealogy_relationship` (`id`),
  ADD CONSTRAINT `genealogy_document_uploaded_by_id_d83e336c_fk_auth_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `genealogy_document_people`
--
ALTER TABLE `genealogy_document_people`
  ADD CONSTRAINT `genealogy_document_p_document_id_3d110c21_fk_genealogy` FOREIGN KEY (`document_id`) REFERENCES `genealogy_document` (`id`),
  ADD CONSTRAINT `genealogy_document_p_person_id_367021f6_fk_genealogy` FOREIGN KEY (`person_id`) REFERENCES `genealogy_person` (`id`);

--
-- Constraints for table `genealogy_event`
--
ALTER TABLE `genealogy_event`
  ADD CONSTRAINT `genealogy_event_main_person_id_bc4ec5bb_fk_genealogy_person_id` FOREIGN KEY (`main_person_id`) REFERENCES `genealogy_person` (`id`);

--
-- Constraints for table `genealogy_event_people`
--
ALTER TABLE `genealogy_event_people`
  ADD CONSTRAINT `genealogy_event_people_event_id_90f6e023_fk_genealogy_event_id` FOREIGN KEY (`event_id`) REFERENCES `genealogy_event` (`id`),
  ADD CONSTRAINT `genealogy_event_people_person_id_b1bcc161_fk_genealogy_person_id` FOREIGN KEY (`person_id`) REFERENCES `genealogy_person` (`id`);

--
-- Constraints for table `genealogy_marriage`
--
ALTER TABLE `genealogy_marriage`
  ADD CONSTRAINT `genealogy_marriage_person1_id_ba0586a8_fk_genealogy_person_id` FOREIGN KEY (`person1_id`) REFERENCES `genealogy_person` (`id`),
  ADD CONSTRAINT `genealogy_marriage_person2_id_a7ed3c34_fk_genealogy_person_id` FOREIGN KEY (`person2_id`) REFERENCES `genealogy_person` (`id`);

--
-- Constraints for table `genealogy_pendingedit`
--
ALTER TABLE `genealogy_pendingedit`
  ADD CONSTRAINT `genealogy_pendingedit_proposed_by_id_0b8bf487_fk_auth_user_id` FOREIGN KEY (`proposed_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `genealogy_pendingedit_reviewed_by_id_722148e8_fk_auth_user_id` FOREIGN KEY (`reviewed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `genealogy_person`
--
ALTER TABLE `genealogy_person`
  ADD CONSTRAINT `genealogy_person_created_by_id_30e8d6f5_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `genealogy_relationship`
--
ALTER TABLE `genealogy_relationship`
  ADD CONSTRAINT `genealogy_relationsh_relative_id_04ed66e7_fk_genealogy` FOREIGN KEY (`relative_id`) REFERENCES `genealogy_person` (`id`),
  ADD CONSTRAINT `genealogy_relationship_person_id_01a4755b_fk_genealogy_person_id` FOREIGN KEY (`person_id`) REFERENCES `genealogy_person` (`id`);

--
-- Constraints for table `genealogy_userprofile`
--
ALTER TABLE `genealogy_userprofile`
  ADD CONSTRAINT `genealogy_userprofile_approved_by_id_ec4f0b91_fk_auth_user_id` FOREIGN KEY (`approved_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `genealogy_userprofile_user_id_a7b092ad_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
