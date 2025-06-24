-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2025 at 02:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `parstech_db1`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `log_name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `person_id` bigint(20) UNSIGNED NOT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `iban` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `image`, `created_at`, `updated_at`) VALUES
(1, 'تسکو', NULL, '2025-05-21 07:52:14', '2025-05-21 07:52:14');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `category_type` varchar(255) NOT NULL DEFAULT 'کالا',
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `type`, `code`, `category_type`, `parent_id`, `description`, `image`, `created_at`, `updated_at`) VALUES
(1, 'خدمات', NULL, 'ser1001', 'service', NULL, NULL, NULL, '2025-05-21 03:17:38', '2025-05-21 03:17:38'),
(2, 'اشخاص', NULL, 'per1001', 'person', NULL, NULL, NULL, '2025-05-21 07:51:42', '2025-05-21 07:51:42'),
(3, 'کالا', NULL, 'pro1001', 'product', NULL, NULL, NULL, '2025-05-21 07:51:51', '2025-05-21 07:51:51');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `province_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `province_id`, `created_at`, `updated_at`) VALUES
(1, 'آب بر', 14, NULL, NULL),
(2, 'آب پخش', 7, NULL, NULL),
(3, 'آباد', 7, NULL, NULL),
(4, 'آبادان', 13, NULL, NULL),
(5, 'آباده', 17, NULL, NULL),
(6, 'آباده طشک', 17, NULL, NULL),
(7, 'آبدان', 7, NULL, NULL),
(8, 'آبدانان', 6, NULL, NULL),
(9, 'آبژدان', 13, NULL, NULL),
(10, 'آبسرد', 8, NULL, NULL),
(11, 'آبش احمد', 1, NULL, NULL),
(12, 'آبعلی', 8, NULL, NULL),
(13, 'آبگرم', 18, NULL, NULL),
(14, 'آبی بیگلو', 3, NULL, NULL),
(15, 'آبیز', 10, NULL, NULL),
(16, 'آبیک', 18, NULL, NULL),
(17, 'آجین', 30, NULL, NULL),
(18, 'آذرشهر', 1, NULL, NULL),
(19, 'آرادان', 15, NULL, NULL),
(20, 'آراللو', 3, NULL, NULL),
(21, 'آران وبیدگل', 4, NULL, NULL),
(22, 'آرمرده', 20, NULL, NULL),
(23, 'آرین شهر', 10, NULL, NULL),
(24, 'آزادشهر', 24, NULL, NULL),
(25, 'آزادی', 13, NULL, NULL),
(26, 'آسارا', 5, NULL, NULL),
(27, 'آستارا', 25, NULL, NULL),
(28, 'آستانه', 28, NULL, NULL),
(29, 'آستانه اشرفیه', 25, NULL, NULL),
(30, 'آسمان آباد', 6, NULL, NULL),
(31, 'آشار', 16, NULL, NULL),
(32, 'آشتیان', 28, NULL, NULL),
(33, 'آشخانه', 12, NULL, NULL),
(34, 'آغاجاری', 13, NULL, NULL),
(35, 'آق قلا', 24, NULL, NULL),
(36, 'آقکند', 1, NULL, NULL),
(37, 'آلاشت', 27, NULL, NULL),
(38, 'آلونی', 9, NULL, NULL),
(39, 'آمل', 27, NULL, NULL),
(40, 'آوا', 12, NULL, NULL),
(41, 'آواجیق', 2, NULL, NULL),
(42, 'آوج', 18, NULL, NULL),
(43, 'آوه', 28, NULL, NULL),
(44, 'آیسک', 10, NULL, NULL),
(45, 'ابرکوه', 31, NULL, NULL),
(46, 'ابریشم', 4, NULL, NULL),
(47, 'ابوحمیظه', 13, NULL, NULL),
(48, 'ابوزیدآباد', 4, NULL, NULL),
(49, 'ابوموسی', 29, NULL, NULL),
(50, 'ابهر', 14, NULL, NULL),
(51, 'اچاچی', 1, NULL, NULL),
(52, 'احمد آباد مستوفی', 8, NULL, NULL),
(53, 'احمدآباد', 31, NULL, NULL),
(54, 'احمدابادصولت', 11, NULL, NULL),
(55, 'احمدسرگوراب', 25, NULL, NULL),
(56, 'اختیارآباد', 21, NULL, NULL),
(57, 'ادیمی', 16, NULL, NULL),
(58, 'اراک', 28, NULL, NULL),
(59, 'اربطان', 1, NULL, NULL),
(60, 'ارجمند', 8, NULL, NULL),
(61, 'ارد', 17, NULL, NULL),
(62, 'ارداق', 18, NULL, NULL),
(63, 'اردبیل', 3, NULL, NULL),
(64, 'اردستان', 4, NULL, NULL),
(65, 'اردکان', 17, NULL, NULL),
(66, 'اردکان', 31, NULL, NULL),
(67, 'اردل', 9, NULL, NULL),
(68, 'اردیموسی', 3, NULL, NULL),
(69, 'ارزوییه', 21, NULL, NULL),
(70, 'ارسک', 10, NULL, NULL),
(71, 'ارسنجان', 17, NULL, NULL),
(72, 'ارطه', 27, NULL, NULL),
(73, 'ارکواز', 6, NULL, NULL),
(74, 'ارمغانخانه', 14, NULL, NULL),
(75, 'ارومیه', 2, NULL, NULL),
(76, 'اروندکنار', 13, NULL, NULL),
(77, 'ازگله', 22, NULL, NULL),
(78, 'ازنا', 26, NULL, NULL),
(79, 'ازندریان', 30, NULL, NULL),
(80, 'اژیه', 4, NULL, NULL),
(81, 'اسالم', 25, NULL, NULL),
(82, 'اسپکه', 16, NULL, NULL),
(83, 'استهبان', 17, NULL, NULL),
(84, 'اسدآباد', 30, NULL, NULL),
(85, 'اسدیه', 10, NULL, NULL),
(86, 'اسفدن', 10, NULL, NULL),
(87, 'اسفراین', 12, NULL, NULL),
(88, 'اسفرورین', 18, NULL, NULL),
(89, 'اسکو', 1, NULL, NULL),
(90, 'اسلام آبادغرب', 22, NULL, NULL),
(91, 'اسلام اباد', 3, NULL, NULL),
(92, 'اسلام شهر آق گل', 30, NULL, NULL),
(93, 'اسلامشهر', 8, NULL, NULL),
(94, 'اسلامیه', 10, NULL, NULL),
(95, 'اسماعیل آباد', 16, NULL, NULL),
(96, 'اسیر', 17, NULL, NULL),
(97, 'اشترینان', 26, NULL, NULL),
(98, 'اشتهارد', 5, NULL, NULL),
(99, 'اشکذر', 31, NULL, NULL),
(100, 'اشکنان', 17, NULL, NULL),
(101, 'اشنویه', 2, NULL, NULL),
(102, 'اصغرآباد', 4, NULL, NULL),
(103, 'اصفهان', 4, NULL, NULL),
(104, 'اصلاندوز', 3, NULL, NULL),
(105, 'اطاقور', 25, NULL, NULL),
(106, 'افزر', 17, NULL, NULL),
(107, 'افوس', 4, NULL, NULL),
(108, 'اقبالیه', 18, NULL, NULL),
(109, 'اقلید', 17, NULL, NULL),
(110, 'الشتر', 26, NULL, NULL),
(111, 'النی', 3, NULL, NULL),
(112, 'الوان', 13, NULL, NULL),
(113, 'الوند', 18, NULL, NULL),
(114, 'الهایی', 13, NULL, NULL),
(115, 'الیگودرز', 26, NULL, NULL),
(116, 'امام حسن', 7, NULL, NULL),
(117, 'امام شهر', 17, NULL, NULL),
(118, 'امامزاده عبدالله', 27, NULL, NULL),
(119, 'املش', 25, NULL, NULL),
(120, 'امیدیه', 13, NULL, NULL),
(121, 'امیرکلا', 27, NULL, NULL),
(122, 'امیریه', 15, NULL, NULL),
(123, 'امین شهر', 21, NULL, NULL),
(124, 'انابد', 11, NULL, NULL),
(125, 'انار', 21, NULL, NULL),
(126, 'انارستان', 7, NULL, NULL),
(127, 'انارک', 4, NULL, NULL),
(128, 'انبارآلوم', 24, NULL, NULL),
(129, 'اندوهجرد', 21, NULL, NULL),
(130, 'اندیشه', 8, NULL, NULL),
(131, 'اندیمشک', 13, NULL, NULL),
(132, 'اورامان تخت', 20, NULL, NULL),
(133, 'اوز', 17, NULL, NULL),
(134, 'اهر', 1, NULL, NULL),
(135, 'اهرم', 7, NULL, NULL),
(136, 'اهل', 17, NULL, NULL),
(137, 'اهواز', 13, NULL, NULL),
(138, 'ایج', 17, NULL, NULL),
(139, 'ایذه', 13, NULL, NULL),
(140, 'ایرانشهر', 16, NULL, NULL),
(141, 'ایزدخواست', 17, NULL, NULL),
(142, 'ایزدشهر', 27, NULL, NULL),
(143, 'ایلام', 6, NULL, NULL),
(144, 'ایلخچی', 1, NULL, NULL),
(145, 'ایمانشهر', 4, NULL, NULL),
(146, 'اینچه برون', 24, NULL, NULL),
(147, 'ایوان', 6, NULL, NULL),
(148, 'ایوانکی', 15, NULL, NULL),
(149, 'ایواوغلی', 2, NULL, NULL),
(150, 'ایور', 12, NULL, NULL),
(151, 'باب انار', 17, NULL, NULL),
(152, 'باباحیدر', 9, NULL, NULL),
(153, 'بابارشانی', 20, NULL, NULL),
(154, 'بابامنیر', 17, NULL, NULL),
(155, 'بابکان', 27, NULL, NULL),
(156, 'بابل', 27, NULL, NULL),
(157, 'بابلسر', 27, NULL, NULL),
(158, 'باجگیران', 11, NULL, NULL),
(159, 'باخرز', 11, NULL, NULL),
(160, 'بادرود', 4, NULL, NULL),
(161, 'بادوله', 7, NULL, NULL),
(162, 'بار', 11, NULL, NULL),
(163, 'باروق', 2, NULL, NULL),
(164, 'بازار جمعه', 25, NULL, NULL),
(165, 'بازرگان', 2, NULL, NULL),
(166, 'بازفت', 9, NULL, NULL),
(167, 'باسمنج', 1, NULL, NULL),
(168, 'باشت', 23, NULL, NULL),
(169, 'باغ بهادران', 4, NULL, NULL),
(170, 'باغ ملک', 13, NULL, NULL),
(171, 'باغستان', 8, NULL, NULL),
(172, 'باغشاد', 4, NULL, NULL),
(173, 'باغین', 21, NULL, NULL),
(174, 'بافت', 21, NULL, NULL),
(175, 'بافران', 4, NULL, NULL),
(176, 'بافق', 31, NULL, NULL),
(177, 'باقرشهر', 8, NULL, NULL),
(178, 'بالاده', 17, NULL, NULL),
(179, 'بالاشهر', 29, NULL, NULL),
(180, 'بانوره', 22, NULL, NULL),
(181, 'بانه', 20, NULL, NULL),
(182, 'بایک', 11, NULL, NULL),
(183, 'باینگان', 22, NULL, NULL),
(184, 'بجستان', 11, NULL, NULL),
(185, 'بجنورد', 12, NULL, NULL),
(186, 'بخ', 31, NULL, NULL),
(187, 'بخشایش', 1, NULL, NULL),
(188, 'بدره', 6, NULL, NULL),
(189, 'برازجان', 7, NULL, NULL),
(190, 'بردخون', 7, NULL, NULL),
(191, 'بردستان', 7, NULL, NULL),
(192, 'بردسکن', 11, NULL, NULL),
(193, 'بردسیر', 21, NULL, NULL),
(194, 'برده رشه', 20, NULL, NULL),
(195, 'برزک', 4, NULL, NULL),
(196, 'برزول', 30, NULL, NULL),
(197, 'برف انبار', 4, NULL, NULL),
(198, 'بروات', 21, NULL, NULL),
(199, 'بروجرد', 26, NULL, NULL),
(200, 'بروجن', 9, NULL, NULL),
(201, 'بره سر', 25, NULL, NULL),
(202, 'بزمان', 16, NULL, NULL),
(203, 'بزنجان', 21, NULL, NULL),
(204, 'بستان', 13, NULL, NULL),
(205, 'بستان آباد', 1, NULL, NULL),
(206, 'بستک', 29, NULL, NULL),
(207, 'بسطام', 15, NULL, NULL),
(208, 'بشرویه', 10, NULL, NULL),
(209, 'بفروییه', 31, NULL, NULL),
(210, 'بلاوه', 6, NULL, NULL),
(211, 'بلبان آباد', 20, NULL, NULL),
(212, 'بلداجی', 9, NULL, NULL),
(213, 'بلده', 27, NULL, NULL),
(214, 'بلورد', 21, NULL, NULL),
(215, 'بلوک', 21, NULL, NULL),
(216, 'بم', 21, NULL, NULL),
(217, 'بمپور', 16, NULL, NULL),
(218, 'بن', 9, NULL, NULL),
(219, 'بناب', 1, NULL, NULL),
(220, 'بناب مرند', 1, NULL, NULL),
(221, 'بنارویه', 17, NULL, NULL),
(222, 'بنت', 16, NULL, NULL),
(223, 'بنجار', 16, NULL, NULL),
(224, 'بندرامام خمینی', 13, NULL, NULL),
(225, 'بندرانزلی', 25, NULL, NULL),
(226, 'بندرترکمن', 24, NULL, NULL),
(227, 'بندرجاسک', 29, NULL, NULL),
(228, 'بندردیر', 7, NULL, NULL),
(229, 'بندردیلم', 7, NULL, NULL),
(230, 'بندرریگ', 7, NULL, NULL),
(231, 'بندرعباس', 29, NULL, NULL),
(232, 'بندرکنگان', 7, NULL, NULL),
(233, 'بندرگز', 24, NULL, NULL),
(234, 'بندرگناوه', 7, NULL, NULL),
(235, 'بندرلنگه', 29, NULL, NULL),
(236, 'بندرماهشهر', 13, NULL, NULL),
(237, 'بندزرک', 29, NULL, NULL),
(238, 'بنک', 7, NULL, NULL),
(239, 'بوانات', 17, NULL, NULL),
(240, 'بوستان', 23, NULL, NULL),
(241, 'بوشکان', 7, NULL, NULL),
(242, 'بوشهر', 7, NULL, NULL),
(243, 'بوکان', 2, NULL, NULL),
(244, 'بومهن', 8, NULL, NULL),
(245, 'بویین زهرا', 18, NULL, NULL),
(246, 'بویین سفلی', 20, NULL, NULL),
(247, 'بویین ومیاندشت', 4, NULL, NULL),
(248, 'بهاباد', 31, NULL, NULL),
(249, 'بهار', 30, NULL, NULL),
(250, 'بهاران شهر', 4, NULL, NULL),
(251, 'بهارستان', 4, NULL, NULL),
(252, 'بهارستان', 7, NULL, NULL),
(253, 'بهبهان', 13, NULL, NULL),
(254, 'بهرمان', 21, NULL, NULL),
(255, 'بهشهر', 27, NULL, NULL),
(256, 'بهمن', 17, NULL, NULL),
(257, 'بهنمیر', 27, NULL, NULL),
(258, 'بیارجمند', 15, NULL, NULL),
(259, 'بیجار', 20, NULL, NULL),
(260, 'بیدخت', 11, NULL, NULL),
(261, 'بیدخون', 7, NULL, NULL),
(262, 'بیدروبه', 13, NULL, NULL),
(263, 'بیدستان', 18, NULL, NULL),
(264, 'بیده', 4, NULL, NULL),
(265, 'بیران شهر', 26, NULL, NULL),
(266, 'بیرجند', 10, NULL, NULL),
(267, 'بیرم', 17, NULL, NULL),
(268, 'بیستون', 22, NULL, NULL),
(269, 'بیضا', 17, NULL, NULL),
(270, 'بیکاء', 29, NULL, NULL),
(271, 'بیله سوار', 3, NULL, NULL),
(272, 'پاتاوه', 23, NULL, NULL),
(273, 'پارس آباد', 3, NULL, NULL),
(274, 'پارسیان', 29, NULL, NULL),
(275, 'پارود', 16, NULL, NULL),
(276, 'پاریز', 21, NULL, NULL),
(277, 'پاکدشت', 8, NULL, NULL),
(278, 'پاوه', 22, NULL, NULL),
(279, 'پایین هولار', 27, NULL, NULL),
(280, 'پردنجان', 9, NULL, NULL),
(281, 'پردیس', 8, NULL, NULL),
(282, 'پرند', 8, NULL, NULL),
(283, 'پرندک', 28, NULL, NULL),
(284, 'پره سر', 25, NULL, NULL),
(285, 'پل', 29, NULL, NULL),
(286, 'پل سفید', 27, NULL, NULL),
(287, 'پلان', 16, NULL, NULL),
(288, 'پلدختر', 26, NULL, NULL),
(289, 'پلدشت', 2, NULL, NULL),
(290, 'پلنگ آباد', 5, NULL, NULL),
(291, 'پول', 27, NULL, NULL),
(292, 'پهله', 6, NULL, NULL),
(293, 'پیرانشهر', 2, NULL, NULL),
(294, 'پیربکران', 4, NULL, NULL),
(295, 'پیرتاج', 20, NULL, NULL),
(296, 'پیش قلعه', 12, NULL, NULL),
(297, 'پیشوا', 8, NULL, NULL),
(298, 'پیشین', 16, NULL, NULL),
(299, 'تاتارعلیا', 24, NULL, NULL),
(300, 'تازه آباد', 22, NULL, NULL),
(301, 'تازه شهر', 2, NULL, NULL),
(302, 'تازه کندانگوت', 3, NULL, NULL),
(303, 'تازه کندنصرت آباد', 2, NULL, NULL),
(304, 'تازیان پایین', 29, NULL, NULL),
(305, 'تاکستان', 18, NULL, NULL),
(306, 'تایباد', 11, NULL, NULL),
(307, 'تبریز', 1, NULL, NULL),
(308, 'تجریش', 8, NULL, NULL),
(309, 'تخت', 29, NULL, NULL),
(310, 'تربت جام', 11, NULL, NULL),
(311, 'تربت حیدریه', 11, NULL, NULL),
(312, 'ترک', 1, NULL, NULL),
(313, 'ترکالکی', 13, NULL, NULL),
(314, 'ترکمانچای', 1, NULL, NULL),
(315, 'تسوج', 1, NULL, NULL),
(316, 'تشان', 13, NULL, NULL),
(317, 'تفت', 31, NULL, NULL),
(318, 'تفرش', 28, NULL, NULL),
(319, 'تکاب', 2, NULL, NULL),
(320, 'تلخاب', 28, NULL, NULL),
(321, 'تنکابن', 27, NULL, NULL),
(322, 'تنکمان', 5, NULL, NULL),
(323, 'تنگ ارم', 7, NULL, NULL),
(324, 'توپ آغاج', 20, NULL, NULL),
(325, 'توتکابن', 25, NULL, NULL),
(326, 'توحید', 6, NULL, NULL),
(327, 'تودشک', 4, NULL, NULL),
(328, 'توره', 28, NULL, NULL),
(329, 'تویسرکان', 30, NULL, NULL),
(330, 'تهران', 8, NULL, NULL),
(331, 'تیتکانلو', 12, NULL, NULL),
(332, 'تیران', 4, NULL, NULL),
(333, 'تیرور', 29, NULL, NULL),
(334, 'تیکمه داش', 1, NULL, NULL),
(335, 'تیمورلو', 1, NULL, NULL),
(336, 'ثمرین', 3, NULL, NULL),
(337, 'جاجرم', 12, NULL, NULL),
(338, 'جالق', 16, NULL, NULL),
(339, 'جاورسیان', 28, NULL, NULL),
(340, 'جایزان', 13, NULL, NULL),
(341, 'جبالبارز', 21, NULL, NULL),
(342, 'جزینک', 16, NULL, NULL),
(343, 'جعفرآباد', 3, NULL, NULL),
(344, 'جعفراباد', 6, NULL, NULL),
(345, 'جعفریه', 19, NULL, NULL),
(346, 'جغتای', 11, NULL, NULL),
(347, 'جلفا', 1, NULL, NULL),
(348, 'جلین', 24, NULL, NULL),
(349, 'جم', 7, NULL, NULL),
(350, 'جناح', 29, NULL, NULL),
(351, 'جنت شهر', 17, NULL, NULL),
(352, 'جنت مکان', 13, NULL, NULL),
(353, 'جندق', 4, NULL, NULL),
(354, 'جنگل', 11, NULL, NULL),
(355, 'جوادآباد', 8, NULL, NULL),
(356, 'جوادیه الهیه', 21, NULL, NULL),
(357, 'جوان قلعه', 1, NULL, NULL),
(358, 'جوانرود', 22, NULL, NULL),
(359, 'جوپار', 21, NULL, NULL),
(360, 'جورقان', 30, NULL, NULL),
(361, 'جوزدان', 4, NULL, NULL),
(362, 'جوزم', 21, NULL, NULL),
(363, 'جوشقان قالی', 4, NULL, NULL),
(364, 'جوکار', 30, NULL, NULL),
(365, 'جولکی', 13, NULL, NULL),
(366, 'جونقان', 9, NULL, NULL),
(367, 'جویبار', 27, NULL, NULL),
(368, 'جویم', 17, NULL, NULL),
(369, 'جهرم', 17, NULL, NULL),
(370, 'جیرفت', 21, NULL, NULL),
(371, 'جیرنده', 25, NULL, NULL),
(372, 'چابکسر', 25, NULL, NULL),
(373, 'چاپشلو', 11, NULL, NULL),
(374, 'چادگان', 4, NULL, NULL),
(375, 'چارک', 29, NULL, NULL),
(376, 'چاف و چمخاله', 25, NULL, NULL),
(377, 'چالانچولان', 26, NULL, NULL),
(378, 'چالوس', 27, NULL, NULL),
(379, 'چاه بهار', 16, NULL, NULL),
(380, 'چاه دادخدا', 21, NULL, NULL),
(381, 'چاه مبارک', 7, NULL, NULL),
(382, 'چاه ورز', 17, NULL, NULL),
(383, 'چترود', 21, NULL, NULL),
(384, 'چخماق', 11, NULL, NULL),
(385, 'چرام', 23, NULL, NULL),
(386, 'چرمهین', 4, NULL, NULL),
(387, 'چشمه شیرین', 6, NULL, NULL),
(388, 'چغادک', 7, NULL, NULL),
(389, 'چغامیش', 13, NULL, NULL),
(390, 'چقابل', 26, NULL, NULL),
(391, 'چکنه', 11, NULL, NULL),
(392, 'چگرد', 16, NULL, NULL),
(393, 'چلگرد', 9, NULL, NULL),
(394, 'چلیچه', 9, NULL, NULL),
(395, 'چم پلک', 26, NULL, NULL),
(396, 'چم گلک', 13, NULL, NULL),
(397, 'چمران', 13, NULL, NULL),
(398, 'چمستان', 27, NULL, NULL),
(399, 'چمگردان', 4, NULL, NULL),
(400, 'چمن سلطان', 26, NULL, NULL),
(401, 'چناران', 11, NULL, NULL),
(402, 'چناران شهر', 12, NULL, NULL),
(403, 'چناره', 20, NULL, NULL),
(404, 'چوار', 6, NULL, NULL),
(405, 'چوبر', 25, NULL, NULL),
(406, 'چورزق', 14, NULL, NULL),
(407, 'چویبده', 13, NULL, NULL),
(408, 'چهارباغ', 5, NULL, NULL),
(409, 'چهاربرج', 2, NULL, NULL),
(410, 'چهاردانگه', 8, NULL, NULL),
(411, 'چیتاب', 23, NULL, NULL),
(412, 'حاجی آباد', 10, NULL, NULL),
(413, 'حاجی آباد', 17, NULL, NULL),
(414, 'حاجی اباد', 29, NULL, NULL),
(415, 'حاجیلار', 2, NULL, NULL),
(416, 'حبیب آباد', 4, NULL, NULL),
(417, 'حر', 13, NULL, NULL),
(418, 'حسامی', 17, NULL, NULL),
(419, 'حسن آباد', 8, NULL, NULL),
(420, 'حسن اباد', 4, NULL, NULL),
(421, 'حسن اباد', 17, NULL, NULL),
(422, 'حسین آباد', 20, NULL, NULL),
(423, 'حسینیه', 13, NULL, NULL),
(424, 'حصارگرمخان', 12, NULL, NULL),
(425, 'حکم اباد', 11, NULL, NULL),
(426, 'حلب', 14, NULL, NULL),
(427, 'حمزه', 13, NULL, NULL),
(428, 'حمیدیا', 31, NULL, NULL),
(429, 'حمیدیه', 13, NULL, NULL),
(430, 'حمیل', 22, NULL, NULL),
(431, 'حنا', 4, NULL, NULL),
(432, 'حویق', 25, NULL, NULL),
(433, 'خاتون اباد', 21, NULL, NULL),
(434, 'خارک', 7, NULL, NULL),
(435, 'خاروانا', 1, NULL, NULL),
(436, 'خاش', 16, NULL, NULL),
(437, 'خاکعلی', 18, NULL, NULL),
(438, 'خالدآباد', 4, NULL, NULL),
(439, 'خامنه', 1, NULL, NULL),
(440, 'خان ببین', 24, NULL, NULL),
(441, 'خانوک', 21, NULL, NULL),
(442, 'خانه زنیان', 17, NULL, NULL),
(443, 'خانیمن', 17, NULL, NULL),
(444, 'خاوران', 17, NULL, NULL),
(445, 'خداجو(خراجو)', 1, NULL, NULL),
(446, 'خرامه', 17, NULL, NULL),
(447, 'خرم آباد', 26, NULL, NULL),
(448, 'خرم آباد', 27, NULL, NULL),
(449, 'خرمدره', 14, NULL, NULL),
(450, 'خرمدشت', 18, NULL, NULL),
(451, 'خرمشهر', 13, NULL, NULL),
(452, 'خرو', 11, NULL, NULL),
(453, 'خسروشاه', 1, NULL, NULL),
(454, 'خشت', 17, NULL, NULL),
(455, 'خشکبیجار', 25, NULL, NULL),
(456, 'خشکرود', 28, NULL, NULL),
(457, 'خضرآباد', 31, NULL, NULL),
(458, 'خضری دشت بیاض', 10, NULL, NULL),
(459, 'خلخال', 3, NULL, NULL),
(460, 'خلیفان', 2, NULL, NULL),
(461, 'خلیل آباد', 11, NULL, NULL),
(462, 'خلیل شهر', 27, NULL, NULL),
(463, 'خمارلو', 1, NULL, NULL),
(464, 'خمام', 25, NULL, NULL),
(465, 'خمیر', 29, NULL, NULL),
(466, 'خمین', 28, NULL, NULL),
(467, 'خمینی شهر', 4, NULL, NULL),
(468, 'خنافره', 13, NULL, NULL),
(469, 'خنج', 17, NULL, NULL),
(470, 'خنجین', 28, NULL, NULL),
(471, 'خنداب', 28, NULL, NULL),
(472, 'خواجو شهر', 21, NULL, NULL),
(473, 'خواجه', 1, NULL, NULL),
(474, 'خواف', 11, NULL, NULL),
(475, 'خوانسار', 4, NULL, NULL),
(476, 'خور', 4, NULL, NULL),
(477, 'خور', 17, NULL, NULL),
(478, 'خورزوق', 4, NULL, NULL),
(479, 'خورسند', 21, NULL, NULL),
(480, 'خورموج', 7, NULL, NULL),
(481, 'خوزی', 17, NULL, NULL),
(482, 'خوسف', 10, NULL, NULL),
(483, 'خوش رودپی', 27, NULL, NULL),
(484, 'خوشه مهر', 1, NULL, NULL),
(485, 'خومه زار', 17, NULL, NULL),
(486, 'خوی', 2, NULL, NULL),
(487, 'خیراباد', 17, NULL, NULL),
(488, 'دابودشت', 27, NULL, NULL),
(489, 'داراب', 17, NULL, NULL),
(490, 'داران', 4, NULL, NULL),
(491, 'دارخوین', 13, NULL, NULL),
(492, 'داریان', 1, NULL, NULL),
(493, 'داریان', 17, NULL, NULL),
(494, 'دالکی', 7, NULL, NULL),
(495, 'دامغان', 15, NULL, NULL),
(496, 'دامنه', 4, NULL, NULL),
(497, 'دانسفهان', 18, NULL, NULL),
(498, 'داودآباد', 28, NULL, NULL),
(499, 'داورزن', 11, NULL, NULL),
(500, 'دبیران', 17, NULL, NULL),
(501, 'درب بهشت', 21, NULL, NULL),
(502, 'درب گنبد', 26, NULL, NULL),
(503, 'درجزین', 15, NULL, NULL),
(504, 'درچه', 4, NULL, NULL),
(505, 'درح', 10, NULL, NULL),
(506, 'درق', 12, NULL, NULL),
(507, 'درگز', 11, NULL, NULL),
(508, 'درگهان', 29, NULL, NULL),
(509, 'درود', 11, NULL, NULL),
(510, 'دره شهر', 6, NULL, NULL),
(511, 'دزج', 20, NULL, NULL),
(512, 'دزفول', 13, NULL, NULL),
(513, 'دژکرد', 17, NULL, NULL),
(514, 'دستجرد', 19, NULL, NULL),
(515, 'دستگرد', 4, NULL, NULL),
(516, 'دستنا', 9, NULL, NULL),
(517, 'دشتک', 9, NULL, NULL),
(518, 'دشتکار', 21, NULL, NULL),
(519, 'دشتی', 29, NULL, NULL),
(520, 'دلبران', 20, NULL, NULL),
(521, 'دلگشا', 6, NULL, NULL),
(522, 'دلند', 24, NULL, NULL),
(523, 'دلوار', 7, NULL, NULL),
(524, 'دلیجان', 28, NULL, NULL),
(525, 'دماوند', 8, NULL, NULL),
(526, 'دمق', 30, NULL, NULL),
(527, 'دندی', 14, NULL, NULL),
(528, 'دوبرجی', 17, NULL, NULL),
(529, 'دوراهک', 7, NULL, NULL),
(530, 'دورود', 26, NULL, NULL),
(531, 'دوزدوزان', 1, NULL, NULL),
(532, 'دوزه', 17, NULL, NULL),
(533, 'دوزین', 24, NULL, NULL),
(534, 'دوساری', 21, NULL, NULL),
(535, 'دوست محمد', 16, NULL, NULL),
(536, 'دوگنبدان', 23, NULL, NULL),
(537, 'دولت آباد', 4, NULL, NULL),
(538, 'دولت آباد', 11, NULL, NULL),
(539, 'ده رییس', 16, NULL, NULL),
(540, 'ده سرخ', 4, NULL, NULL),
(541, 'ده کهان', 21, NULL, NULL),
(542, 'دهاقان', 4, NULL, NULL),
(543, 'دهبارز', 29, NULL, NULL),
(544, 'دهج', 21, NULL, NULL),
(545, 'دهدز', 13, NULL, NULL),
(546, 'دهدشت', 23, NULL, NULL),
(547, 'دهرم', 17, NULL, NULL),
(548, 'دهق', 4, NULL, NULL),
(549, 'دهکویه', 17, NULL, NULL),
(550, 'دهگلان', 20, NULL, NULL),
(551, 'دهلران', 6, NULL, NULL),
(552, 'دیباج', 15, NULL, NULL),
(553, 'دیزج دیز', 2, NULL, NULL),
(554, 'دیزیچه', 4, NULL, NULL),
(555, 'دیشموک', 23, NULL, NULL),
(556, 'دیلمان', 25, NULL, NULL),
(557, 'دیواندره', 20, NULL, NULL),
(558, 'دیهوک', 10, NULL, NULL),
(559, 'رابر', 21, NULL, NULL),
(560, 'راز', 12, NULL, NULL),
(561, 'رازقان', 28, NULL, NULL),
(562, 'رازمیان', 18, NULL, NULL),
(563, 'راسک', 16, NULL, NULL),
(564, 'رامجرد', 17, NULL, NULL),
(565, 'رامسر', 27, NULL, NULL),
(566, 'رامشیر', 13, NULL, NULL),
(567, 'رامهرمز', 13, NULL, NULL),
(568, 'رامیان', 24, NULL, NULL),
(569, 'رانکوه', 25, NULL, NULL),
(570, 'راور', 21, NULL, NULL),
(571, 'راین', 21, NULL, NULL),
(572, 'رباط', 22, NULL, NULL),
(573, 'رباط سنگ', 11, NULL, NULL),
(574, 'رباطکریم', 8, NULL, NULL),
(575, 'ربط', 2, NULL, NULL),
(576, 'رحیم آباد', 25, NULL, NULL),
(577, 'رزن', 30, NULL, NULL),
(578, 'رزوه', 4, NULL, NULL),
(579, 'رستاق', 17, NULL, NULL),
(580, 'رستم آباد', 25, NULL, NULL),
(581, 'رستمکلا', 27, NULL, NULL),
(582, 'رشت', 25, NULL, NULL),
(583, 'رشتخوار', 11, NULL, NULL),
(584, 'رضوانشهر', 4, NULL, NULL),
(585, 'رضوانشهر', 25, NULL, NULL),
(586, 'رضویه', 11, NULL, NULL),
(587, 'رضی', 3, NULL, NULL),
(588, 'رفسنجان', 21, NULL, NULL),
(589, 'رفیع', 13, NULL, NULL),
(590, 'رمشک', 21, NULL, NULL),
(591, 'روانسر', 22, NULL, NULL),
(592, 'رود زرد ماشین', 13, NULL, NULL),
(593, 'روداب', 11, NULL, NULL),
(594, 'رودبار', 21, NULL, NULL),
(595, 'رودبار', 25, NULL, NULL),
(596, 'رودبنه', 25, NULL, NULL),
(597, 'رودسر', 25, NULL, NULL),
(598, 'رودهن', 8, NULL, NULL),
(599, 'رودیان', 15, NULL, NULL),
(600, 'رونیز', 17, NULL, NULL),
(601, 'رویان', 27, NULL, NULL),
(602, 'رویدر', 29, NULL, NULL),
(603, 'ری', 8, NULL, NULL),
(604, 'ریجاب', 22, NULL, NULL),
(605, 'ریحان', 21, NULL, NULL),
(606, 'ریز', 7, NULL, NULL),
(607, 'ریگ ملک', 16, NULL, NULL),
(608, 'رینه', 27, NULL, NULL),
(609, 'ریواده', 11, NULL, NULL),
(610, 'ریوش', 11, NULL, NULL),
(611, 'زابل', 16, NULL, NULL),
(612, 'زارچ', 31, NULL, NULL),
(613, 'زازران', 4, NULL, NULL),
(614, 'زاغه', 26, NULL, NULL),
(615, 'زاووت', 13, NULL, NULL),
(616, 'زاویه', 28, NULL, NULL),
(617, 'زاهدان', 16, NULL, NULL),
(618, 'زاهدشهر', 17, NULL, NULL),
(619, 'زاینده رود', 4, NULL, NULL),
(620, 'زرآباد', 2, NULL, NULL),
(621, 'زرآباد', 16, NULL, NULL),
(622, 'زرقان', 17, NULL, NULL),
(623, 'زرگرمحله', 27, NULL, NULL),
(624, 'زرند', 21, NULL, NULL),
(625, 'زرنق', 1, NULL, NULL),
(626, 'زرنه', 6, NULL, NULL),
(627, 'زرین آباد', 14, NULL, NULL),
(628, 'زرین رود', 14, NULL, NULL),
(629, 'زرین شهر', 4, NULL, NULL),
(630, 'زرینه', 20, NULL, NULL),
(631, 'زنجان', 14, NULL, NULL),
(632, 'زنگنه', 30, NULL, NULL),
(633, 'زنگی آباد', 21, NULL, NULL),
(634, 'زنگی اباد', 17, NULL, NULL),
(635, 'زنوز', 1, NULL, NULL),
(636, 'زواره', 4, NULL, NULL),
(637, 'زهان', 10, NULL, NULL),
(638, 'زهرا', 3, NULL, NULL),
(639, 'زهره', 13, NULL, NULL),
(640, 'زهک', 16, NULL, NULL),
(641, 'زهکلوت', 21, NULL, NULL),
(642, 'زیار', 4, NULL, NULL),
(643, 'زیارت', 12, NULL, NULL),
(644, 'زیارتعلی', 29, NULL, NULL),
(645, 'زیباشهر', 4, NULL, NULL),
(646, 'زیدآباد', 21, NULL, NULL),
(647, 'زیرآب', 27, NULL, NULL),
(648, 'ساربوک', 16, NULL, NULL),
(649, 'ساروق', 28, NULL, NULL),
(650, 'ساری', 27, NULL, NULL),
(651, 'سالند', 13, NULL, NULL),
(652, 'سامان', 9, NULL, NULL),
(653, 'سامن', 30, NULL, NULL),
(654, 'ساوه', 28, NULL, NULL),
(655, 'سبزوار', 11, NULL, NULL),
(656, 'سپیددشت', 26, NULL, NULL),
(657, 'سجاس', 14, NULL, NULL),
(658, 'سجزی', 4, NULL, NULL),
(659, 'سده', 17, NULL, NULL),
(660, 'سده لنجان', 4, NULL, NULL),
(661, 'سراب', 1, NULL, NULL),
(662, 'سراب باغ', 6, NULL, NULL),
(663, 'سراب دوره', 26, NULL, NULL),
(664, 'سرابله', 6, NULL, NULL),
(665, 'سراوان', 16, NULL, NULL),
(666, 'سرایان', 10, NULL, NULL),
(667, 'سرباز', 16, NULL, NULL),
(668, 'سربیشه', 10, NULL, NULL),
(669, 'سرپل ذهاب', 22, NULL, NULL),
(670, 'سرجنگل', 16, NULL, NULL),
(671, 'سرخرود', 27, NULL, NULL),
(672, 'سرخس', 11, NULL, NULL),
(673, 'سرخنکلاته', 24, NULL, NULL),
(674, 'سرخون', 9, NULL, NULL),
(675, 'سرخه', 15, NULL, NULL),
(676, 'سرداران', 13, NULL, NULL),
(677, 'سردرود', 1, NULL, NULL),
(678, 'سردشت', 2, NULL, NULL),
(679, 'سردشت', 9, NULL, NULL),
(680, 'سردشت', 13, NULL, NULL),
(681, 'سردشت', 29, NULL, NULL),
(682, 'سرعین', 3, NULL, NULL),
(683, 'سرفاریاب', 23, NULL, NULL),
(684, 'سرکان', 30, NULL, NULL),
(685, 'سرگز', 29, NULL, NULL),
(686, 'سرمست', 22, NULL, NULL),
(687, 'سرو', 2, NULL, NULL),
(688, 'سروآباد', 20, NULL, NULL),
(689, 'سروستان', 17, NULL, NULL),
(690, 'سریش آباد', 20, NULL, NULL),
(691, 'سطر', 22, NULL, NULL),
(692, 'سعادت شهر', 17, NULL, NULL),
(693, 'سعد آباد', 7, NULL, NULL),
(694, 'سفیددشت', 9, NULL, NULL),
(695, 'سفیدسنگ', 11, NULL, NULL),
(696, 'سفیدشهر', 4, NULL, NULL),
(697, 'سقز', 20, NULL, NULL),
(698, 'سگزآباد', 18, NULL, NULL),
(699, 'سلامی', 11, NULL, NULL),
(700, 'سلطان آباد', 11, NULL, NULL),
(701, 'سلطان آباد', 13, NULL, NULL),
(702, 'سلطان شهر', 17, NULL, NULL),
(703, 'سلطانیه', 14, NULL, NULL),
(704, 'سلفچگان', 19, NULL, NULL),
(705, 'سلماس', 2, NULL, NULL),
(706, 'سلمان شهر', 27, NULL, NULL),
(707, 'سماله', 13, NULL, NULL),
(708, 'سمنان', 15, NULL, NULL),
(709, 'سمیرم', 4, NULL, NULL),
(710, 'سمیع آباد', 11, NULL, NULL),
(711, 'سنته', 20, NULL, NULL),
(712, 'سنخواست', 12, NULL, NULL),
(713, 'سندرک', 29, NULL, NULL),
(714, 'سنقر', 22, NULL, NULL),
(715, 'سنگان', 11, NULL, NULL),
(716, 'سنگدوین', 24, NULL, NULL),
(717, 'سنگر', 25, NULL, NULL),
(718, 'سنندج', 20, NULL, NULL),
(719, 'سودجان', 9, NULL, NULL),
(720, 'سوران', 16, NULL, NULL),
(721, 'سورشجان', 9, NULL, NULL),
(722, 'سورک', 27, NULL, NULL),
(723, 'سورمق', 17, NULL, NULL),
(724, 'سوری', 26, NULL, NULL),
(725, 'سوزا', 29, NULL, NULL),
(726, 'سوسنگرد', 13, NULL, NULL),
(727, 'سوق', 23, NULL, NULL),
(728, 'سومار', 22, NULL, NULL),
(729, 'سه قلعه', 10, NULL, NULL),
(730, 'سهرورد', 14, NULL, NULL),
(731, 'سهند', 1, NULL, NULL),
(732, 'سی سخت', 23, NULL, NULL),
(733, 'سیاه منصور', 13, NULL, NULL),
(734, 'سیاهکل', 25, NULL, NULL),
(735, 'سیجوال', 24, NULL, NULL),
(736, 'سیدان', 17, NULL, NULL),
(737, 'سیراف', 7, NULL, NULL),
(738, 'سیرجان', 21, NULL, NULL),
(739, 'سیردان', 18, NULL, NULL),
(740, 'سیرکان', 16, NULL, NULL),
(741, 'سیریز', 21, NULL, NULL),
(742, 'سیریک', 29, NULL, NULL),
(743, 'سیس', 1, NULL, NULL),
(744, 'سیلوانه', 2, NULL, NULL),
(745, 'سیمین شهر', 24, NULL, NULL),
(746, 'سیمینه', 2, NULL, NULL),
(747, 'سین', 4, NULL, NULL),
(748, 'سیه چشمه', 2, NULL, NULL),
(749, 'سیه رود', 1, NULL, NULL),
(750, 'شاپورآباد', 4, NULL, NULL),
(751, 'شادگان', 13, NULL, NULL),
(752, 'شادمهر', 11, NULL, NULL),
(753, 'شازند', 28, NULL, NULL),
(754, 'شال', 18, NULL, NULL),
(755, 'شاندیز', 11, NULL, NULL),
(756, 'شاوور', 13, NULL, NULL),
(757, 'شاهپوراباد', 26, NULL, NULL),
(758, 'شاهدشهر', 8, NULL, NULL),
(759, 'شاهدیه', 31, NULL, NULL),
(760, 'شاهرود', 15, NULL, NULL),
(761, 'شاهو', 22, NULL, NULL),
(762, 'شاهین دژ', 2, NULL, NULL),
(763, 'شاهین شهر', 4, NULL, NULL),
(764, 'شباب', 6, NULL, NULL),
(765, 'شبانکاره', 7, NULL, NULL),
(766, 'شبستر', 1, NULL, NULL),
(767, 'شرافت', 13, NULL, NULL),
(768, 'شربیان', 1, NULL, NULL),
(769, 'شرفخانه', 1, NULL, NULL),
(770, 'شروینه', 22, NULL, NULL),
(771, 'شریف آباد', 8, NULL, NULL),
(772, 'شریفیه', 18, NULL, NULL),
(773, 'ششتمد', 11, NULL, NULL),
(774, 'ششده', 17, NULL, NULL),
(775, 'شفت', 25, NULL, NULL),
(776, 'شلمان', 25, NULL, NULL),
(777, 'شلمزار', 9, NULL, NULL),
(778, 'شمس آباد', 13, NULL, NULL),
(779, 'شمشک', 8, NULL, NULL),
(780, 'شنبه', 7, NULL, NULL),
(781, 'شندآباد', 1, NULL, NULL),
(782, 'شوسف', 10, NULL, NULL),
(783, 'شوش', 13, NULL, NULL),
(784, 'شوشتر', 13, NULL, NULL),
(785, 'شوط', 2, NULL, NULL),
(786, 'شوقان', 12, NULL, NULL),
(787, 'شول آباد', 26, NULL, NULL),
(788, 'شویشه', 20, NULL, NULL),
(789, 'شهباز', 28, NULL, NULL),
(790, 'شهداد', 21, NULL, NULL),
(791, 'شهر امام', 13, NULL, NULL),
(792, 'شهراباد', 11, NULL, NULL),
(793, 'شهربابک', 21, NULL, NULL),
(794, 'شهرپیر', 17, NULL, NULL),
(795, 'شهرجدیدهشتگرد', 5, NULL, NULL),
(796, 'شهرزو', 11, NULL, NULL),
(797, 'شهرصدرا', 17, NULL, NULL),
(798, 'شهرضا', 4, NULL, NULL),
(799, 'شهرکرد', 9, NULL, NULL),
(800, 'شهریار', 8, NULL, NULL),
(801, 'شهمیرزاد', 15, NULL, NULL),
(802, 'شهیون', 13, NULL, NULL),
(803, 'شیبان', 13, NULL, NULL),
(804, 'شیراز', 17, NULL, NULL),
(805, 'شیرگاه', 27, NULL, NULL),
(806, 'شیروان', 12, NULL, NULL),
(807, 'شیرود', 27, NULL, NULL),
(808, 'شیرین سو', 30, NULL, NULL),
(809, 'صاحب', 20, NULL, NULL),
(810, 'صادق اباد', 24, NULL, NULL),
(811, 'صالح آباد', 6, NULL, NULL),
(812, 'صالح آباد', 11, NULL, NULL),
(813, 'صالح آباد', 30, NULL, NULL),
(814, 'صالح شهر', 13, NULL, NULL),
(815, 'صالحیه', 8, NULL, NULL),
(816, 'صایین قلعه', 14, NULL, NULL),
(817, 'صباشهر', 8, NULL, NULL),
(818, 'صحنه', 22, NULL, NULL),
(819, 'صغاد', 17, NULL, NULL),
(820, 'صفادشت', 8, NULL, NULL),
(821, 'صفاشهر', 17, NULL, NULL),
(822, 'صفاییه', 21, NULL, NULL),
(823, 'صفی آباد', 12, NULL, NULL),
(824, 'صفی آباد', 13, NULL, NULL),
(825, 'صمصامی', 9, NULL, NULL),
(826, 'صوفیان', 1, NULL, NULL),
(827, 'صومعه سرا', 25, NULL, NULL),
(828, 'صیدون', 13, NULL, NULL),
(829, 'ضیاآباد', 18, NULL, NULL),
(830, 'طاقانک', 9, NULL, NULL),
(831, 'طالخونچه', 4, NULL, NULL),
(832, 'طالقان', 5, NULL, NULL),
(833, 'طبس', 10, NULL, NULL),
(834, 'طبس مسینا', 10, NULL, NULL),
(835, 'طبقده', 27, NULL, NULL),
(836, 'طبل', 29, NULL, NULL),
(837, 'طرق رود', 4, NULL, NULL),
(838, 'طرقبه', 11, NULL, NULL),
(839, 'طسوج', 17, NULL, NULL),
(840, 'عاشقلو', 1, NULL, NULL),
(841, 'عالی شهر', 7, NULL, NULL),
(842, 'عباس اباد', 27, NULL, NULL),
(843, 'عجب شیر', 1, NULL, NULL),
(844, 'عرب حسن', 13, NULL, NULL),
(845, 'عسگران', 4, NULL, NULL),
(846, 'عسلویه', 7, NULL, NULL),
(847, 'عشق آباد', 10, NULL, NULL),
(848, 'عشق آباد', 11, NULL, NULL),
(849, 'عقدا', 31, NULL, NULL),
(850, 'علامرودشت', 17, NULL, NULL),
(851, 'علویجه', 4, NULL, NULL),
(852, 'علی اباد', 21, NULL, NULL),
(853, 'علی اباد', 24, NULL, NULL),
(854, 'علی اکبر', 16, NULL, NULL),
(855, 'علیشاه', 1, NULL, NULL),
(856, 'عماد شهر', 17, NULL, NULL),
(857, 'عنبر', 13, NULL, NULL),
(858, 'عنبرآباد', 21, NULL, NULL),
(859, 'عنبران', 3, NULL, NULL),
(860, 'غرق آباد', 28, NULL, NULL),
(861, 'غلامان', 12, NULL, NULL),
(862, 'فارسان', 9, NULL, NULL),
(863, 'فارغان', 29, NULL, NULL),
(864, 'فاروج', 12, NULL, NULL),
(865, 'فاروق', 17, NULL, NULL),
(866, 'فاریاب', 21, NULL, NULL),
(867, 'فاضل آباد', 24, NULL, NULL),
(868, 'فال', 17, NULL, NULL),
(869, 'فامنین', 30, NULL, NULL),
(870, 'فتح آباد', 4, NULL, NULL),
(871, 'فتح المبین', 13, NULL, NULL),
(872, 'فخراباد', 3, NULL, NULL),
(873, 'فدامی', 17, NULL, NULL),
(874, 'فرادبنه', 9, NULL, NULL),
(875, 'فراشبند', 17, NULL, NULL),
(876, 'فراغی', 24, NULL, NULL),
(877, 'فرح آباد', 27, NULL, NULL),
(878, 'فرخ شهر', 9, NULL, NULL),
(879, 'فرخی', 4, NULL, NULL),
(880, 'فردوس', 10, NULL, NULL),
(881, 'فردوسیه', 8, NULL, NULL),
(882, 'فرسفج', 30, NULL, NULL),
(883, 'فرمهین', 28, NULL, NULL),
(884, 'فرون اباد', 8, NULL, NULL),
(885, 'فرهادگرد', 11, NULL, NULL),
(886, 'فریدونشهر', 4, NULL, NULL),
(887, 'فریدونکنار', 27, NULL, NULL),
(888, 'فریم', 27, NULL, NULL),
(889, 'فریمان', 11, NULL, NULL),
(890, 'فسا', 17, NULL, NULL),
(891, 'فشم', 8, NULL, NULL),
(892, 'فلاورجان', 4, NULL, NULL),
(893, 'فنوج', 16, NULL, NULL),
(894, 'فولادشهر', 4, NULL, NULL),
(895, 'فومن', 25, NULL, NULL),
(896, 'فهرج', 21, NULL, NULL),
(897, 'فیرورق', 2, NULL, NULL),
(898, 'فیروزآباد', 17, NULL, NULL),
(899, 'فیروزآباد', 26, NULL, NULL),
(900, 'فیروزان', 30, NULL, NULL),
(901, 'فیروزکوه', 8, NULL, NULL),
(902, 'فیروزه', 11, NULL, NULL),
(903, 'فیض آباد', 11, NULL, NULL),
(904, 'فیل اباد', 9, NULL, NULL),
(905, 'فین', 29, NULL, NULL),
(906, 'قادراباد', 17, NULL, NULL),
(907, 'قاسم آباد', 11, NULL, NULL),
(908, 'قاضی', 12, NULL, NULL),
(909, 'قایم شهر', 27, NULL, NULL),
(910, 'قایمیه', 17, NULL, NULL),
(911, 'قاین', 10, NULL, NULL),
(912, 'قدس', 8, NULL, NULL),
(913, 'قدمگاه', 11, NULL, NULL),
(914, 'قرچک', 8, NULL, NULL),
(915, 'قرق', 24, NULL, NULL),
(916, 'قرقری', 16, NULL, NULL),
(917, 'قروه', 20, NULL, NULL),
(918, 'قروه درگزین', 30, NULL, NULL),
(919, 'قره آغاج', 1, NULL, NULL),
(920, 'قره بلاغ', 17, NULL, NULL),
(921, 'قره ضیاءالدین', 2, NULL, NULL),
(922, 'قزوین', 18, NULL, NULL),
(923, 'قشم', 29, NULL, NULL),
(924, 'قصابه', 3, NULL, NULL),
(925, 'قصرشیرین', 22, NULL, NULL),
(926, 'قصرقند', 16, NULL, NULL),
(927, 'قطب آباد', 17, NULL, NULL),
(928, 'قطرویه', 17, NULL, NULL),
(929, 'قطور', 2, NULL, NULL),
(930, 'قلعه', 22, NULL, NULL),
(931, 'قلعه تل', 13, NULL, NULL),
(932, 'قلعه خواجه', 13, NULL, NULL),
(933, 'قلعه رییسی', 23, NULL, NULL),
(934, 'قلعه قاضی', 29, NULL, NULL),
(935, 'قلعه گنج', 21, NULL, NULL),
(936, 'قلعه نو', 8, NULL, NULL),
(937, 'قلعه نوعلیا', 11, NULL, NULL),
(938, 'قلندرآباد', 11, NULL, NULL),
(939, 'قم', 19, NULL, NULL),
(940, 'قمصر', 4, NULL, NULL),
(941, 'قنوات', 19, NULL, NULL),
(942, 'قوچان', 11, NULL, NULL),
(943, 'قورچی باشی', 28, NULL, NULL),
(944, 'قوشچی', 2, NULL, NULL),
(945, 'قوشخانه', 12, NULL, NULL),
(946, 'قهاوند', 30, NULL, NULL),
(947, 'قهجاورستان', 4, NULL, NULL),
(948, 'قهدریجان', 4, NULL, NULL),
(949, 'قهستان', 10, NULL, NULL),
(950, 'قیام دشت', 8, NULL, NULL),
(951, 'قیدار', 14, NULL, NULL),
(952, 'قیر', 17, NULL, NULL),
(953, 'کاج', 9, NULL, NULL),
(954, 'کاخک', 11, NULL, NULL),
(955, 'کارچان', 28, NULL, NULL),
(956, 'کارزین (فتح آباد)', 17, NULL, NULL),
(957, 'کاریز', 11, NULL, NULL),
(958, 'کازرون', 17, NULL, NULL),
(959, 'کاشان', 4, NULL, NULL),
(960, 'کاشمر', 11, NULL, NULL),
(961, 'کاظم آباد', 21, NULL, NULL),
(962, 'کاکی', 7, NULL, NULL),
(963, 'کامفیروز', 17, NULL, NULL),
(964, 'کامو و چوگان', 4, NULL, NULL),
(965, 'کامیاران', 20, NULL, NULL),
(966, 'کانی دینار', 20, NULL, NULL),
(967, 'کانی سور', 20, NULL, NULL),
(968, 'کبودرآهنگ', 30, NULL, NULL),
(969, 'کتالم وسادات شهر', 27, NULL, NULL),
(970, 'کجور', 27, NULL, NULL),
(971, 'کدکن', 11, NULL, NULL),
(972, 'کرج', 5, NULL, NULL),
(973, 'کردکوی', 24, NULL, NULL),
(974, 'کرسف', 14, NULL, NULL),
(975, 'کرفس', 30, NULL, NULL),
(976, 'کرکوند', 4, NULL, NULL),
(977, 'کرمان', 21, NULL, NULL),
(978, 'کرمانشاه', 22, NULL, NULL),
(979, 'کرند', 22, NULL, NULL),
(980, 'کره ای', 17, NULL, NULL),
(981, 'کشاورز', 2, NULL, NULL),
(982, 'کشکسرای', 1, NULL, NULL),
(983, 'کشکوییه', 21, NULL, NULL),
(984, 'کلات', 11, NULL, NULL),
(985, 'کلاته', 15, NULL, NULL),
(986, 'کلاته خیج', 15, NULL, NULL),
(987, 'کلاچای', 25, NULL, NULL),
(988, 'کلارآباد', 27, NULL, NULL),
(989, 'کلاردشت', 27, NULL, NULL),
(990, 'کلاله', 24, NULL, NULL),
(991, 'کلمه', 7, NULL, NULL),
(992, 'کلوانق', 1, NULL, NULL),
(993, 'کلور', 3, NULL, NULL),
(994, 'کلیبر', 1, NULL, NULL),
(995, 'کلیشادوسودرجان', 4, NULL, NULL),
(996, 'کمال شهر', 5, NULL, NULL),
(997, 'کمشچه', 4, NULL, NULL),
(998, 'کمه', 4, NULL, NULL),
(999, 'کمیجان', 28, NULL, NULL),
(1000, 'کنارتخته', 17, NULL, NULL),
(1001, 'کنارک', 16, NULL, NULL),
(1002, 'کندر', 11, NULL, NULL),
(1003, 'کنگ', 29, NULL, NULL),
(1004, 'کنگاور', 22, NULL, NULL),
(1005, 'کوار', 17, NULL, NULL),
(1006, 'کوپن', 17, NULL, NULL),
(1007, 'کوت سیدنعیم', 13, NULL, NULL),
(1008, 'کوت عبداله', 13, NULL, NULL),
(1009, 'کوچصفهان', 25, NULL, NULL),
(1010, 'کوراییم', 3, NULL, NULL),
(1011, 'کوزران', 22, NULL, NULL),
(1012, 'کوزه کنان', 1, NULL, NULL),
(1013, 'کوشک', 4, NULL, NULL),
(1014, 'کوشکنار', 29, NULL, NULL),
(1015, 'کومله', 25, NULL, NULL),
(1016, 'کوهبنان', 21, NULL, NULL),
(1017, 'کوهپایه', 4, NULL, NULL),
(1018, 'کوهدشت', 26, NULL, NULL),
(1019, 'کوهسار', 5, NULL, NULL),
(1020, 'کوهستک', 29, NULL, NULL),
(1021, 'کوهنانی', 26, NULL, NULL),
(1022, 'کوهنجان', 17, NULL, NULL),
(1023, 'کوهی خیل', 27, NULL, NULL),
(1024, 'کوهیچ', 29, NULL, NULL),
(1025, 'کوهین', 18, NULL, NULL),
(1026, 'کهریزسنگ', 4, NULL, NULL),
(1027, 'کهریزک', 8, NULL, NULL),
(1028, 'کهک', 19, NULL, NULL),
(1029, 'کهن آباد', 15, NULL, NULL),
(1030, 'کهنوج', 21, NULL, NULL),
(1031, 'کیاسر', 27, NULL, NULL),
(1032, 'کیاشهر', 25, NULL, NULL),
(1033, 'کیاکلا', 27, NULL, NULL),
(1034, 'کیان', 9, NULL, NULL),
(1035, 'کیانشهر', 21, NULL, NULL),
(1036, 'کیش', 29, NULL, NULL),
(1037, 'کیلان', 8, NULL, NULL),
(1038, 'گالیکش', 24, NULL, NULL),
(1039, 'گتاب', 27, NULL, NULL),
(1040, 'گتوند', 13, NULL, NULL),
(1041, 'گتیج', 16, NULL, NULL),
(1042, 'گراب', 26, NULL, NULL),
(1043, 'گراب سفلی', 23, NULL, NULL),
(1044, 'گراش', 17, NULL, NULL),
(1045, 'گرگاب', 4, NULL, NULL),
(1046, 'گرگان', 24, NULL, NULL),
(1047, 'گرماب', 14, NULL, NULL),
(1048, 'گرمدره', 5, NULL, NULL),
(1049, 'گرمسار', 15, NULL, NULL),
(1050, 'گرمه', 12, NULL, NULL),
(1051, 'گرمی', 3, NULL, NULL),
(1052, 'گروک', 29, NULL, NULL),
(1053, 'گزبرخوار', 4, NULL, NULL),
(1054, 'گزنک', 27, NULL, NULL),
(1055, 'گزیک', 10, NULL, NULL),
(1056, 'گشت', 16, NULL, NULL),
(1057, 'گل تپه', 30, NULL, NULL),
(1058, 'گلباف', 21, NULL, NULL),
(1059, 'گلبهار', 11, NULL, NULL),
(1060, 'گلپایگان', 4, NULL, NULL),
(1061, 'گلدشت', 4, NULL, NULL),
(1062, 'گلزار', 21, NULL, NULL),
(1063, 'گلسار', 5, NULL, NULL),
(1064, 'گلستان', 8, NULL, NULL),
(1065, 'گلشن', 4, NULL, NULL),
(1066, 'گلشهر', 4, NULL, NULL),
(1067, 'گلگیر', 13, NULL, NULL),
(1068, 'گلمکان', 11, NULL, NULL),
(1069, 'گلمورتی', 16, NULL, NULL),
(1070, 'گلوگاه', 27, NULL, NULL),
(1071, 'گله دار', 17, NULL, NULL),
(1072, 'گلیداغ', 24, NULL, NULL),
(1073, 'گمیش تپه', 24, NULL, NULL),
(1074, 'گناباد', 11, NULL, NULL),
(1075, 'گنبدکاووس', 24, NULL, NULL),
(1076, 'گنبکی', 21, NULL, NULL),
(1077, 'گندمان', 9, NULL, NULL),
(1078, 'گوجان', 9, NULL, NULL),
(1079, 'گودین', 22, NULL, NULL),
(1080, 'گوراب زرمیخ', 25, NULL, NULL),
(1081, 'گوریه', 13, NULL, NULL),
(1082, 'گوگ تپه', 2, NULL, NULL),
(1083, 'گوگان', 1, NULL, NULL),
(1084, 'گوگد', 4, NULL, NULL),
(1085, 'گوهران', 29, NULL, NULL),
(1086, 'گهرو', 9, NULL, NULL),
(1087, 'گهواره', 22, NULL, NULL),
(1088, 'گیان', 30, NULL, NULL),
(1089, 'گیلانغرب', 22, NULL, NULL),
(1090, 'گیوی', 3, NULL, NULL),
(1091, 'لاجان', 2, NULL, NULL),
(1092, 'لار', 17, NULL, NULL),
(1093, 'لاریجان', 1, NULL, NULL),
(1094, 'لالجین', 30, NULL, NULL),
(1095, 'لاله زار', 21, NULL, NULL),
(1096, 'لالی', 13, NULL, NULL),
(1097, 'لامرد', 17, NULL, NULL),
(1098, 'لاهرود', 3, NULL, NULL),
(1099, 'لاهیجان', 25, NULL, NULL),
(1100, 'لای بید', 4, NULL, NULL),
(1101, 'لپویی', 17, NULL, NULL),
(1102, 'لردگان', 9, NULL, NULL),
(1103, 'لشت نشاء', 25, NULL, NULL),
(1104, 'لطف آباد', 11, NULL, NULL),
(1105, 'لطیفی', 17, NULL, NULL),
(1106, 'لمزان', 29, NULL, NULL),
(1107, 'لنده', 23, NULL, NULL),
(1108, 'لنگرود', 25, NULL, NULL),
(1109, 'لواسان', 8, NULL, NULL),
(1110, 'لوجلی', 12, NULL, NULL),
(1111, 'لوشان', 25, NULL, NULL),
(1112, 'لولمان', 25, NULL, NULL),
(1113, 'لومار', 6, NULL, NULL),
(1114, 'لوندویل', 25, NULL, NULL),
(1115, 'لیردف', 29, NULL, NULL),
(1116, 'لیسار', 25, NULL, NULL),
(1117, 'لیکک', 23, NULL, NULL),
(1118, 'لیلان', 1, NULL, NULL),
(1119, 'مادرسلیمان', 17, NULL, NULL),
(1120, 'مادوان', 23, NULL, NULL),
(1121, 'مارگون', 23, NULL, NULL),
(1122, 'ماژین', 6, NULL, NULL),
(1123, 'ماسال', 25, NULL, NULL),
(1124, 'ماسوله', 25, NULL, NULL),
(1125, 'ماکلوان', 25, NULL, NULL),
(1126, 'ماکو', 2, NULL, NULL),
(1127, 'مال خلیفه', 9, NULL, NULL),
(1128, 'مامونیه', 28, NULL, NULL),
(1129, 'ماه نشان', 14, NULL, NULL),
(1130, 'ماهان', 21, NULL, NULL),
(1131, 'ماهدشت', 5, NULL, NULL),
(1132, 'مبارک آباددیز', 17, NULL, NULL),
(1133, 'مبارک شهر', 1, NULL, NULL),
(1134, 'مبارکه', 4, NULL, NULL),
(1135, 'مجلسی', 4, NULL, NULL),
(1136, 'مجن', 15, NULL, NULL),
(1137, 'محلات', 28, NULL, NULL),
(1138, 'محمدآباد', 4, NULL, NULL),
(1139, 'محمدآباد', 16, NULL, NULL),
(1140, 'محمدآباد', 21, NULL, NULL),
(1141, 'محمدان', 16, NULL, NULL),
(1142, 'محمدشهر', 5, NULL, NULL),
(1143, 'محمدشهر', 10, NULL, NULL),
(1144, 'محمدی', 16, NULL, NULL),
(1145, 'محمدیار', 2, NULL, NULL),
(1146, 'محمدیه', 18, NULL, NULL),
(1147, 'محمله', 17, NULL, NULL),
(1148, 'محمودآباد', 2, NULL, NULL),
(1149, 'محمودآباد', 27, NULL, NULL),
(1150, 'محمودآبادنمونه', 18, NULL, NULL),
(1151, 'محی آباد', 21, NULL, NULL),
(1152, 'مرادلو', 3, NULL, NULL),
(1153, 'مراغه', 1, NULL, NULL),
(1154, 'مراوه', 24, NULL, NULL),
(1155, 'مرجقل', 25, NULL, NULL),
(1156, 'مردهک', 21, NULL, NULL),
(1157, 'مرزن آباد', 27, NULL, NULL),
(1158, 'مرزیکلا', 27, NULL, NULL),
(1159, 'مرگنلر', 2, NULL, NULL),
(1160, 'مرند', 1, NULL, NULL),
(1161, 'مرودشت', 17, NULL, NULL),
(1162, 'مروست', 31, NULL, NULL),
(1163, 'مریانج', 30, NULL, NULL),
(1164, 'مریوان', 20, NULL, NULL),
(1165, 'مزایجان', 17, NULL, NULL),
(1166, 'مزدآوند', 11, NULL, NULL),
(1167, 'مزرعه', 24, NULL, NULL),
(1168, 'مس سرچشمه', 21, NULL, NULL),
(1169, 'مسجدسلیمان', 13, NULL, NULL),
(1170, 'مشراگه', 13, NULL, NULL),
(1171, 'مشکات', 4, NULL, NULL),
(1172, 'مشکان', 11, NULL, NULL),
(1173, 'مشکان', 17, NULL, NULL),
(1174, 'مشکین دشت', 5, NULL, NULL),
(1175, 'مشگین شهر', 3, NULL, NULL),
(1176, 'مشهد', 11, NULL, NULL),
(1177, 'مشهد ثامن', 11, NULL, NULL),
(1178, 'مشهدریزه', 11, NULL, NULL),
(1179, 'مصیری', 17, NULL, NULL),
(1180, 'معزابادجابری', 17, NULL, NULL),
(1181, 'معلم کلایه', 18, NULL, NULL),
(1182, 'معمولان', 26, NULL, NULL),
(1183, 'مغان سر', 3, NULL, NULL),
(1184, 'مقاومت', 13, NULL, NULL),
(1185, 'ملاثانی', 13, NULL, NULL),
(1186, 'ملارد', 8, NULL, NULL),
(1187, 'ملایر', 30, NULL, NULL),
(1188, 'ملک آباد', 11, NULL, NULL),
(1189, 'ملکان', 1, NULL, NULL),
(1190, 'ممقان', 1, NULL, NULL),
(1191, 'منتظران', 13, NULL, NULL),
(1192, 'منج', 9, NULL, NULL),
(1193, 'منجیل', 25, NULL, NULL),
(1194, 'منصوریه', 13, NULL, NULL),
(1195, 'منظریه', 4, NULL, NULL),
(1196, 'منوجان', 21, NULL, NULL),
(1197, 'موچش', 20, NULL, NULL),
(1198, 'مود', 10, NULL, NULL),
(1199, 'مورموری', 6, NULL, NULL),
(1200, 'موسیان', 6, NULL, NULL),
(1201, 'مومن آباد', 26, NULL, NULL),
(1202, 'مهاباد', 4, NULL, NULL),
(1203, 'مهاباد', 2, NULL, NULL),
(1204, 'مهاجران', 28, NULL, NULL),
(1205, 'مهاجران', 30, NULL, NULL),
(1206, 'مهدی شهر', 15, NULL, NULL),
(1207, 'مهر', 6, NULL, NULL),
(1208, 'مهر', 17, NULL, NULL),
(1209, 'مهران', 6, NULL, NULL),
(1210, 'مهربان', 1, NULL, NULL),
(1211, 'مهردشت', 31, NULL, NULL),
(1212, 'مهرستان', 16, NULL, NULL),
(1213, 'مهریز', 31, NULL, NULL),
(1214, 'میامی', 15, NULL, NULL),
(1215, 'میان راهان', 22, NULL, NULL),
(1216, 'میاندوآب', 2, NULL, NULL),
(1217, 'میانرود', 13, NULL, NULL),
(1218, 'میانشهر', 17, NULL, NULL),
(1219, 'میانکوه', 13, NULL, NULL),
(1220, 'میانه', 1, NULL, NULL),
(1221, 'میبد', 31, NULL, NULL),
(1222, 'میداود', 13, NULL, NULL),
(1223, 'میرآباد', 2, NULL, NULL),
(1224, 'میرآباد', 22, NULL, NULL),
(1225, 'میرجاوه', 16, NULL, NULL),
(1226, 'میلاجرد', 28, NULL, NULL),
(1227, 'میمند', 17, NULL, NULL),
(1228, 'میمه', 4, NULL, NULL),
(1229, 'میمه', 6, NULL, NULL),
(1230, 'میناب', 29, NULL, NULL),
(1231, 'مینودشت', 24, NULL, NULL),
(1232, 'مینوشهر', 13, NULL, NULL),
(1233, 'نازک علیا', 2, NULL, NULL),
(1234, 'ناغان', 9, NULL, NULL),
(1235, 'نافچ', 9, NULL, NULL),
(1236, 'نالوس', 2, NULL, NULL),
(1237, 'نایین', 4, NULL, NULL),
(1238, 'نجف آباد', 4, NULL, NULL),
(1239, 'نجف شهر', 21, NULL, NULL),
(1240, 'نخل تقی', 7, NULL, NULL),
(1241, 'ندوشن', 31, NULL, NULL),
(1242, 'نراق', 28, NULL, NULL),
(1243, 'نرجه', 18, NULL, NULL),
(1244, 'نرماشیر', 21, NULL, NULL),
(1245, 'نسیم شهر', 8, NULL, NULL),
(1246, 'نشتارود', 27, NULL, NULL),
(1247, 'نشتیفان', 11, NULL, NULL),
(1248, 'نصرآباد', 4, NULL, NULL),
(1249, 'نصرآباد', 11, NULL, NULL),
(1250, 'نصرت آباد', 16, NULL, NULL),
(1251, 'نصیرشهر', 8, NULL, NULL),
(1252, 'نطنز', 4, NULL, NULL),
(1253, 'نظام شهر', 21, NULL, NULL),
(1254, 'نظرآباد', 5, NULL, NULL),
(1255, 'نظرکهریزی', 1, NULL, NULL),
(1256, 'نقاب', 11, NULL, NULL),
(1257, 'نقده', 2, NULL, NULL),
(1258, 'نقنه', 9, NULL, NULL),
(1259, 'نکا', 27, NULL, NULL),
(1260, 'نگار', 21, NULL, NULL),
(1261, 'نگور', 16, NULL, NULL),
(1262, 'نگین شهر', 24, NULL, NULL),
(1263, 'نلاس', 2, NULL, NULL),
(1264, 'نمین', 3, NULL, NULL),
(1265, 'نوبران', 28, NULL, NULL),
(1266, 'نوبندگان', 17, NULL, NULL),
(1267, 'نوجین', 17, NULL, NULL),
(1268, 'نوخندان', 11, NULL, NULL),
(1269, 'نودان', 17, NULL, NULL),
(1270, 'نودژ', 21, NULL, NULL),
(1271, 'نودشه', 22, NULL, NULL),
(1272, 'نوده خاندوز', 24, NULL, NULL),
(1273, 'نور', 27, NULL, NULL),
(1274, 'نورآباد', 17, NULL, NULL),
(1275, 'نورآباد', 26, NULL, NULL),
(1276, 'نوربهار', 14, NULL, NULL),
(1277, 'نوسود', 22, NULL, NULL),
(1278, 'نوش آباد', 4, NULL, NULL),
(1279, 'نوشهر', 27, NULL, NULL),
(1280, 'نوشین', 2, NULL, NULL),
(1281, 'نوک آباد', 16, NULL, NULL),
(1282, 'نوکنده', 24, NULL, NULL),
(1283, 'نهاوند', 30, NULL, NULL),
(1284, 'نهبندان', 10, NULL, NULL),
(1285, 'نی ریز', 17, NULL, NULL),
(1286, 'نیاسر', 4, NULL, NULL),
(1287, 'نیر', 3, NULL, NULL),
(1288, 'نیر', 31, NULL, NULL),
(1289, 'نیشابور', 11, NULL, NULL),
(1290, 'نیک آباد', 4, NULL, NULL),
(1291, 'نیک پی', 14, NULL, NULL),
(1292, 'نیک شهر', 16, NULL, NULL),
(1293, 'نیل شهر', 11, NULL, NULL),
(1294, 'نیمبلوک', 10, NULL, NULL),
(1295, 'نیمور', 28, NULL, NULL),
(1296, 'واجارگاه', 25, NULL, NULL),
(1297, 'وایقان', 1, NULL, NULL),
(1298, 'وحدتیه', 7, NULL, NULL),
(1299, 'وحیدیه', 8, NULL, NULL),
(1300, 'ورامین', 8, NULL, NULL),
(1301, 'وراوی', 17, NULL, NULL),
(1302, 'وردنجان', 9, NULL, NULL),
(1303, 'ورزقان', 1, NULL, NULL),
(1304, 'ورزنه', 4, NULL, NULL),
(1305, 'ورنامخواست', 4, NULL, NULL),
(1306, 'وزوان', 4, NULL, NULL),
(1307, 'ونایی', 26, NULL, NULL),
(1308, 'ونک', 4, NULL, NULL),
(1309, 'ویس', 13, NULL, NULL),
(1310, 'ویسیان', 26, NULL, NULL),
(1311, 'هادی شهر', 27, NULL, NULL),
(1312, 'هادیشهر', 1, NULL, NULL),
(1313, 'هارونی', 9, NULL, NULL),
(1314, 'هجدک', 21, NULL, NULL),
(1315, 'هچیرود', 27, NULL, NULL),
(1316, 'هرات', 31, NULL, NULL),
(1317, 'هرسین', 22, NULL, NULL),
(1318, 'هرمز', 29, NULL, NULL),
(1319, 'هرند', 4, NULL, NULL),
(1320, 'هریس', 1, NULL, NULL),
(1321, 'هزارکانیان', 20, NULL, NULL),
(1322, 'هشتبندی', 29, NULL, NULL),
(1323, 'هشتپر (تالش)', 25, NULL, NULL),
(1324, 'هشتجین', 3, NULL, NULL),
(1325, 'هشترود', 1, NULL, NULL),
(1326, 'هشتگرد', 5, NULL, NULL),
(1327, 'هفت چشمه', 26, NULL, NULL),
(1328, 'هفتگل', 13, NULL, NULL),
(1329, 'هفشجان', 9, NULL, NULL),
(1330, 'هلشی', 22, NULL, NULL),
(1331, 'هماشهر', 17, NULL, NULL),
(1332, 'هماشهر', 21, NULL, NULL),
(1333, 'همت آباد', 11, NULL, NULL),
(1334, 'همدان', 30, NULL, NULL),
(1335, 'هندودر', 28, NULL, NULL),
(1336, 'هندیجان', 13, NULL, NULL),
(1337, 'هنزا', 21, NULL, NULL),
(1338, 'هنگوییه', 29, NULL, NULL),
(1339, 'هوراند', 1, NULL, NULL),
(1340, 'هوره', 9, NULL, NULL),
(1341, 'هویزه', 13, NULL, NULL),
(1342, 'هیدج', 14, NULL, NULL),
(1343, 'هیدوچ', 16, NULL, NULL),
(1344, 'هیر', 3, NULL, NULL),
(1345, 'یاسوج', 23, NULL, NULL),
(1346, 'یاسوکند', 20, NULL, NULL),
(1347, 'یامچی', 1, NULL, NULL),
(1348, 'یان چشمه', 9, NULL, NULL),
(1349, 'یزد', 31, NULL, NULL),
(1350, 'یزدان شهر', 21, NULL, NULL),
(1351, 'یکه سعود', 12, NULL, NULL),
(1352, 'یولاگلدی', 2, NULL, NULL),
(1353, 'یونسی', 11, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `symbol` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `title`, `symbol`, `code`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'ارز', 'ارز', 'ارز', 1, '2025-05-20 06:08:08', '2025-05-20 06:08:08');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_purchases`
--

CREATE TABLE `customer_purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` double NOT NULL DEFAULT 0,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `expense_date` date DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `income_date` date DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_number` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `price` bigint(20) NOT NULL,
  `total` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journal_entries`
--

CREATE TABLE `journal_entries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entry_number` varchar(255) NOT NULL COMMENT 'شماره سند روزنامه',
  `entry_date` date NOT NULL COMMENT 'تاریخ سند',
  `description` varchar(255) DEFAULT NULL COMMENT 'شرح کلی سند',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ایجادکننده',
  `related_invoice_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ارتباط با فاکتور فروش/خرید',
  `document_type` varchar(255) DEFAULT NULL COMMENT 'نوع سند (فروش، خرید، هزینه، درآمد و...)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journal_entry_items`
--

CREATE TABLE `journal_entry_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `journal_entry_id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL COMMENT 'حساب معین',
  `debit` decimal(20,2) NOT NULL DEFAULT 0.00 COMMENT 'مبلغ بدهکار',
  `credit` decimal(20,2) NOT NULL DEFAULT 0.00 COMMENT 'مبلغ بستانکار',
  `description` varchar(255) DEFAULT NULL COMMENT 'شرح آیتم سند',
  `reference` varchar(255) DEFAULT NULL COMMENT 'شماره یا مرجع تراکنش',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2023_01_01_000001_create_service_categories_table', 1),
(5, '2024_05_07_000000_create_invoices_table', 1),
(6, '2024_05_07_000001_create_categories_table', 1),
(7, '2024_05_07_000001_create_units_table', 1),
(8, '2024_05_07_000002_create_brands_table', 1),
(9, '2024_05_07_000003_create_products_table', 1),
(10, '2024_05_11_002051_create_sellers_table', 1),
(11, '2024_05_12_000001_create_persons_table', 1),
(12, '2024_05_13_000001_add_customer_id_to_invoices_table', 1),
(13, '2025_05_05_165450_create_customers_table', 1),
(14, '2025_05_05_165529_create_incomes_table', 1),
(15, '2025_05_05_165648_create_expenses_table', 1),
(16, '2025_05_07_000001_add_columns_to_products_table', 1),
(17, '2025_05_07_133000_create_sessions_table', 1),
(18, '2025_05_08_042553_add_type_to_categories_table', 1),
(19, '2025_05_09_181243_create_provinces_table', 1),
(20, '2025_05_09_184747_create_cities_table', 1),
(21, '2025_05_10_074702_create_bank_accounts_table', 1),
(22, '2025_05_10_190407_create_currencies_table', 1),
(23, '2025_05_11_011033_create_seller_bank_accounts_table', 1),
(24, '2025_05_11_071453_add_price_to_products_table', 1),
(25, '2025_05_11_193651_create_invoice_items_table', 1),
(26, '2025_05_11_194732_add_invoice_number_to_invoices_table', 1),
(27, '2025_05_12_035154_create_people_table', 1),
(28, '2025_05_14_000001_create_sales_table', 1),
(29, '2025_05_15_000001_create_customer_purchases_table', 1),
(30, '2025_05_16_194835_create_sale_items_table', 1),
(31, '2025_05_16_201819_add_purchase_percent_to_persons_table', 1),
(32, '2025_05_16_202806_add_photo_to_persons_table', 1),
(33, '2025_05_16_211750_add_total_amount_and_discount_to_sales_table', 1),
(34, '2025_05_16_212824_update_persons_and_sellers_table', 1),
(35, '2025_05_16_213643_update_sales_table_add_amount_fields', 1),
(36, '2025_05_16_214415_update_sales_table_add_payment_fields', 1),
(37, '2025_05_17_175459_create_activity_log_table', 1),
(38, '2025_05_17_175500_add_event_column_to_activity_log_table', 1),
(39, '2025_05_17_175501_add_batch_uuid_column_to_activity_log_table', 1),
(40, '2025_05_17_180905_create_services_table', 1),
(41, '2025_05_19_162909_add_title_to_sales_table', 1),
(42, '2025_05_20_063347_add_fields_to_sales_table', 1),
(43, '2025_05_20_083428_create_service_fields_table', 1),
(44, '2025_05_20_083429_create_service_sales_table', 1),
(45, '2025_05_20_091435_create_service_sale_items_table', 1),
(46, '2025_05_20_091437_create_service_field_values_table', 1),
(47, '2025_05_20_163832_create_service_dynamic_forms_table', 2),
(48, '2025_05_21_060822_create_contact_messages_table', 3),
(49, '2025_05_21_060917_create_contacts_table', 3),
(50, '2025_05_22_131500_add_image_to_services_table', 4),
(51, '2025_05_22_131916_add_type_to_products_table', 5),
(52, '2025_05_22_140855_add_service_info_to_services_table', 6),
(53, '2025_05_22_144530_add_unit_id_to_services_table', 7),
(54, '2025_05_22_144910_add_missing_fields_to_services_table', 8),
(55, '2025_05_22_191941_add_product_id_to_services_table', 9),
(56, '2025_05_22_213857_add_payment_fields_to_sales_table', 10),
(57, '2025_05_22_225112_add_phone_to_users_table', 11),
(58, '2025_05_22_230819_add_share_percent_to_persons_table', 12),
(59, '2025_05_22_230852_create_product_shareholder_table', 12),
(60, '2025_05_23_001540_create_journal_entries_table', 13);

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `share_percent` decimal(5,2) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `accounting_code` varchar(255) DEFAULT NULL,
  `credit_limit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `price_list` varchar(255) DEFAULT NULL,
  `tax_type` varchar(255) DEFAULT NULL,
  `national_code` varchar(255) DEFAULT NULL,
  `economic_code` varchar(255) DEFAULT NULL,
  `registration_number` varchar(255) DEFAULT NULL,
  `branch_code` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `phone1` varchar(255) DEFAULT NULL,
  `phone2` varchar(255) DEFAULT NULL,
  `phone3` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `marriage_date` date DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `last_purchase_at` timestamp NULL DEFAULT NULL,
  `total_purchases` bigint(20) NOT NULL DEFAULT 0,
  `purchase_percent` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `full_name` varchar(255) GENERATED ALWAYS AS (concat(coalesce(`first_name`,''),' ',coalesce(`last_name`,''))) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `first_name`, `last_name`, `company_name`, `title`, `photo`, `type`, `share_percent`, `nickname`, `accounting_code`, `credit_limit`, `price_list`, `tax_type`, `national_code`, `economic_code`, `registration_number`, `branch_code`, `description`, `address`, `country`, `province`, `city`, `postal_code`, `phone`, `mobile`, `fax`, `phone1`, `phone2`, `phone3`, `email`, `website`, `birth_date`, `marriage_date`, `join_date`, `last_purchase_at`, `total_purchases`, `purchase_percent`, `created_at`, `updated_at`) VALUES
(1, 'مصطفی', 'عباس آبادی', NULL, NULL, NULL, 'customer', NULL, NULL, 'persons=-1001', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'یسبل', 'ایران', '11', '1256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2025-05-21 07:53:21', '2025-05-21 07:53:21'),
(2, 'مشتری', 'حضوری', NULL, NULL, NULL, 'guest', NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2025-05-22 14:41:15', '2025-05-22 14:41:15'),
(3, 'مصطفی', 'اکرادی', 'پارس تک', NULL, NULL, 'shareholder', NULL, NULL, 'persons=-1002', 0.00, NULL, NULL, '5730008971', NULL, NULL, NULL, NULL, 'نقاب خ ابوترابی', 'ایران', '11', '1256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2025-05-22 19:01:26', '2025-05-22 19:01:26');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `gallery` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`gallery`)),
  `video` varchar(255) DEFAULT NULL,
  `short_desc` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `price` decimal(16,2) DEFAULT NULL,
  `min_stock` int(11) NOT NULL DEFAULT 0,
  `unit` varchar(255) NOT NULL DEFAULT 'عدد',
  `barcode` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `buy_price` bigint(20) DEFAULT NULL,
  `sell_price` bigint(20) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `store_barcode` varchar(100) DEFAULT NULL,
  `attributes` text DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'product'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `code`, `category_id`, `brand_id`, `image`, `gallery`, `video`, `short_desc`, `description`, `stock`, `price`, `min_stock`, `unit`, `barcode`, `is_active`, `created_at`, `updated_at`, `weight`, `buy_price`, `sell_price`, `discount`, `store_barcode`, `attributes`, `type`) VALUES
(1, 'موس', '0001', 3, 1, 'products/4cdYDZD4TvBwSZGwA4kjYrAYe8TQts2VsoPz2bMf.jpg', NULL, NULL, 'سیب', NULL, 4, NULL, 2, 'عدد', 'BARCODE-812475', 1, '2025-05-21 07:52:47', '2025-05-22 15:59:25', NULL, 150000, 200000, NULL, 'BARCODE-890361', NULL, 'product'),
(2, 'ویندوز', 'services-1002', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, '1', NULL, 0, '2025-05-22 09:36:16', '2025-05-22 09:36:16', NULL, NULL, 150000, NULL, NULL, NULL, 'service'),
(3, 'نصب', 'services-1004', 1, NULL, NULL, NULL, NULL, NULL, 'شسی', 0, NULL, 0, 'ساعت', NULL, 1, '2025-05-22 10:50:58', '2025-05-22 10:50:58', NULL, NULL, 1500, NULL, NULL, NULL, 'service'),
(4, 'نصب دوربین مداربسته', 'services-1005', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 'عدد', NULL, 1, '2025-05-22 15:14:22', '2025-05-22 15:14:22', NULL, NULL, 2000000, NULL, NULL, NULL, 'service'),
(5, 'نصب دوربین مداربسته', 'services-1006', 1, NULL, 'services/2tZjEzRou4Mvr9EhsmyAWJU8qooN9hM4RDMsrHmD.png', NULL, NULL, 'سیب', 'بقصضث', 0, NULL, 0, 'روز', NULL, 1, '2025-05-22 15:16:15', '2025-05-22 15:16:15', NULL, NULL, 2000000, NULL, NULL, NULL, 'service'),
(6, 'نصب دوربین مداربسته', 'services-1007', 1, NULL, NULL, NULL, NULL, 'سیب', 'بقصضث', 0, NULL, 0, 'روز', NULL, 1, '2025-05-22 15:20:34', '2025-05-22 15:20:34', NULL, NULL, 2000000, NULL, NULL, NULL, 'service');

-- --------------------------------------------------------

--
-- Table structure for table `product_shareholder`
--

CREATE TABLE `product_shareholder` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `person_id` bigint(20) UNSIGNED NOT NULL,
  `percent` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_shareholder`
--

INSERT INTO `product_shareholder` (`id`, `product_id`, `person_id`, `percent`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 100.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `provinces`
--

INSERT INTO `provinces` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'آذربایجان شرقی', NULL, NULL),
(2, 'آذربایجان غربی', NULL, NULL),
(3, 'اردبیل', NULL, NULL),
(4, 'اصفهان', NULL, NULL),
(5, 'البرز', NULL, NULL),
(6, 'ایلام', NULL, NULL),
(7, 'بوشهر', NULL, NULL),
(8, 'تهران', NULL, NULL),
(9, 'چهارمحال و بختیاری', NULL, NULL),
(10, 'خراسان جنوبی', NULL, NULL),
(11, 'خراسان رضوی', NULL, NULL),
(12, 'خراسان شمالی', NULL, NULL),
(13, 'خوزستان', NULL, NULL),
(14, 'زنجان', NULL, NULL),
(15, 'سمنان', NULL, NULL),
(16, 'سیستان و بلوچستان', NULL, NULL),
(17, 'فارس', NULL, NULL),
(18, 'قزوین', NULL, NULL),
(19, 'قم', NULL, NULL),
(20, 'کردستان', NULL, NULL),
(21, 'کرمان', NULL, NULL),
(22, 'کرمانشاه', NULL, NULL),
(23, 'کهگیلویه و بویراحمد', NULL, NULL),
(24, 'گلستان', NULL, NULL),
(25, 'گیلان', NULL, NULL),
(26, 'لرستان', NULL, NULL),
(27, 'مازندران', NULL, NULL),
(28, 'مرکزی', NULL, NULL),
(29, 'هرمزگان', NULL, NULL),
(30, 'همدان', NULL, NULL),
(31, 'یزد', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_number` varchar(255) NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(15,2) NOT NULL DEFAULT 0.00,
  `final_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `remaining_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `paid_at` timestamp NULL DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL DEFAULT 'unpaid',
  `cash_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `cash_reference` varchar(255) DEFAULT NULL,
  `cash_paid_at` timestamp NULL DEFAULT NULL,
  `card_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `card_reference` varchar(255) DEFAULT NULL,
  `card_number` varchar(16) DEFAULT NULL,
  `card_paid_at` timestamp NULL DEFAULT NULL,
  `pos_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `pos_reference` varchar(255) DEFAULT NULL,
  `pos_paid_at` timestamp NULL DEFAULT NULL,
  `cheque_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `cheque_number` varchar(255) DEFAULT NULL,
  `cheque_bank` varchar(255) DEFAULT NULL,
  `cheque_due_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `issued_at` timestamp NULL DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `payment_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `invoice_number`, `reference`, `customer_id`, `seller_id`, `currency_id`, `total_price`, `total_amount`, `discount`, `tax`, `final_amount`, `paid_amount`, `remaining_amount`, `status`, `paid_at`, `payment_status`, `cash_amount`, `cash_reference`, `cash_paid_at`, `card_amount`, `card_reference`, `card_number`, `card_paid_at`, `pos_amount`, `pos_reference`, `pos_paid_at`, `cheque_amount`, `cheque_number`, `cheque_bank`, `cheque_due_date`, `description`, `created_at`, `updated_at`, `deleted_at`, `title`, `issued_at`, `payment_method`, `payment_notes`) VALUES
(1, 'invoices-10001', NULL, 1, 1, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'pending', NULL, 'unpaid', 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, '2025-05-21 08:45:39', '2025-05-21 08:45:39', NULL, 'قبف', '2025-05-21 08:45:39', NULL, NULL),
(6, 'invoices-10002', NULL, 1, 1, 1, 150000.00, 0.00, 0.00, 0.00, 150000.00, 150000.00, 0.00, 'paid', '2025-05-22 19:58:13', 'unpaid', 140000.00, NULL, '2025-05-22 19:58:13', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, '2025-05-22 11:04:14', '2025-05-22 19:58:13', NULL, NULL, '2025-05-22 11:04:14', 'cash', NULL),
(7, 'invoices-10003', NULL, 2, 1, 1, 800000.00, 0.00, 0.00, 0.00, 800000.00, 0.00, 0.00, 'pending', NULL, 'unpaid', 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, '2025-05-22 14:41:15', '2025-05-22 14:41:15', NULL, NULL, '2025-05-22 14:41:15', NULL, NULL),
(8, 'invoices-10004', NULL, 2, 1, 1, 400000.00, 0.00, 0.00, 0.00, 400000.00, 0.00, 0.00, 'pending', NULL, 'unpaid', 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, '2025-05-22 14:42:33', '2025-05-22 14:42:33', NULL, NULL, '2025-05-22 14:42:33', NULL, NULL),
(9, 'invoices-10005', NULL, 2, 1, 1, 150000.00, 0.00, 0.00, 0.00, 150000.00, 0.00, 0.00, 'pending', NULL, 'unpaid', 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, '2025-05-22 14:43:02', '2025-05-22 14:43:02', NULL, NULL, '2025-05-22 14:43:02', NULL, NULL),
(10, 'invoices-10006', NULL, 1, 1, 1, 201500.00, 0.00, 0.00, 0.00, 201500.00, 0.00, 0.00, 'pending', NULL, 'unpaid', 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, '2025-05-22 15:54:19', '2025-05-22 15:54:19', NULL, NULL, '2025-05-22 15:54:19', NULL, NULL),
(11, 'invoices-10007', NULL, 2, 1, 1, 201500.00, 0.00, 0.00, 0.00, 201500.00, 0.00, 0.00, 'pending', NULL, 'unpaid', 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, '2025-05-22 15:59:25', '2025-05-22 15:59:25', NULL, NULL, '2025-05-22 15:59:25', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `discount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `description`, `unit`, `quantity`, `unit_price`, `discount`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'سیب', '-', 1, 0.00, 0.00, 0.00, 0.00, '2025-05-21 08:45:39', '2025-05-21 08:45:39'),
(7, 6, 3, '', '-', 1, 150000.00, 0.00, 0.00, 150000.00, '2025-05-22 11:04:14', '2025-05-22 11:04:14'),
(8, 7, 1, '', '', 2, 200000.00, 0.00, 0.00, 400000.00, '2025-05-22 14:41:15', '2025-05-22 14:41:15'),
(9, 7, 1, '', '', 1, 200000.00, 0.00, 0.00, 200000.00, '2025-05-22 14:41:15', '2025-05-22 14:41:15'),
(10, 7, 1, '', '', 1, 200000.00, 0.00, 0.00, 200000.00, '2025-05-22 14:41:15', '2025-05-22 14:41:15'),
(11, 8, 1, '', '', 2, 200000.00, 0.00, 0.00, 400000.00, '2025-05-22 14:42:33', '2025-05-22 14:42:33'),
(12, 9, 2, '', '', 1, 150000.00, 0.00, 0.00, 150000.00, '2025-05-22 14:43:02', '2025-05-22 14:43:02'),
(13, 10, 1, '', 'عدد', 1, 200000.00, 0.00, 0.00, 200000.00, '2025-05-22 15:54:19', '2025-05-22 15:54:19'),
(14, 10, 6, '', 'ساعت', 1, 1500.00, 0.00, 0.00, 1500.00, '2025-05-22 15:54:19', '2025-05-22 15:54:19'),
(15, 11, 1, '', 'عدد', 1, 200000.00, 0.00, 0.00, 200000.00, '2025-05-22 15:59:25', '2025-05-22 15:59:25'),
(16, 11, 6, '', 'ساعت', 1, 1500.00, 0.00, 0.00, 1500.00, '2025-05-22 15:59:25', '2025-05-22 15:59:25');

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_code` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `code_editable` tinyint(1) NOT NULL DEFAULT 0,
  `company_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `national_code` varchar(255) DEFAULT NULL,
  `economic_code` varchar(255) DEFAULT NULL,
  `registration_number` varchar(255) DEFAULT NULL,
  `branch_code` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `full_name` varchar(255) GENERATED ALWAYS AS (concat(coalesce(`first_name`,''),' ',coalesce(`last_name`,''))) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sellers`
--

INSERT INTO `sellers` (`id`, `seller_code`, `first_name`, `last_name`, `nickname`, `mobile`, `image`, `code_editable`, `company_name`, `title`, `national_code`, `economic_code`, `registration_number`, `branch_code`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Seller-10001', 'مصطفی', 'اکرادی', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-21 07:53:51', '2025-05-21 07:53:51');

-- --------------------------------------------------------

--
-- Table structure for table `seller_bank_accounts`
--

CREATE TABLE `seller_bank_accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED NOT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `iban` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `service_code` varchar(255) DEFAULT NULL,
  `service_info` varchar(255) DEFAULT NULL,
  `service_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `tax` int(11) DEFAULT NULL,
  `execution_cost` bigint(20) DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `info_link` text DEFAULT NULL,
  `full_description` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_vat_included` tinyint(1) NOT NULL DEFAULT 1,
  `is_discountable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `product_id`, `title`, `service_code`, `service_info`, `service_category_id`, `unit_id`, `unit`, `price`, `tax`, `execution_cost`, `short_description`, `info_link`, `full_description`, `description`, `image`, `is_active`, `is_vat_included`, `is_discountable`, `created_at`, `updated_at`) VALUES
(6, NULL, 'نصب', 'services-1004', 'نثب دوربین', NULL, 2, 'ساعت', 1500, NULL, NULL, NULL, NULL, NULL, 'شسی', NULL, 1, 1, 1, '2025-05-22 10:50:58', '2025-05-22 10:50:58'),
(9, 6, 'نصب دوربین مداربسته', 'services-1007', 'سیب', 1, 5, 'روز', 2000000, NULL, NULL, 'سیب', NULL, 'یسبسیسیب', 'بقصضث', NULL, 1, 1, 1, '2025-05-22 15:20:34', '2025-05-22 15:20:34');

-- --------------------------------------------------------

--
-- Table structure for table `service_categories`
--

CREATE TABLE `service_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_dynamic_forms`
--

CREATE TABLE `service_dynamic_forms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `form_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`form_data`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_fields`
--

CREATE TABLE `service_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `label` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `options` text DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_field_values`
--

CREATE TABLE `service_field_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_sale_item_id` bigint(20) UNSIGNED NOT NULL,
  `service_field_id` bigint(20) UNSIGNED NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_sales`
--

CREATE TABLE `service_sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_number` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_national_id` varchar(255) DEFAULT NULL,
  `customer_mobile` varchar(255) DEFAULT NULL,
  `total_price` bigint(20) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_sale_items`
--

CREATE TABLE `service_sale_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_sale_id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `price` bigint(20) NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('aeZwmC9uEFVR9kEhAAA3WMy36eucQDP7QN8muPMj', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiS3lTS0pTaTR2RHBIQko3T2JtZWpPRTlIRTMzMks5Q2xNZ1AzMUg0diI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zaGFyZWhvbGRlcnMvMyI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1747958845);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'عدد', '2025-05-21 07:52:34', '2025-05-21 07:52:34'),
(2, 'ساعت', '2025-05-22 08:10:59', '2025-05-22 08:10:59'),
(3, 'ساعت 1', '2025-05-22 08:16:48', '2025-05-22 08:16:48'),
(4, '1', '2025-05-22 09:05:09', '2025-05-22 09:05:09'),
(5, 'روز', '2025-05-22 15:15:57', '2025-05-22 15:15:57');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`) VALUES
(1, 'مصطفی اکرادی', 'akradim@hotmail.com', NULL, '$2y$12$7onK3ZLrdzGY3pt0/ZBjfuafgHfDX.9jundcsWCFq2xvmmgTLE4Wu', 'N5NWHS5whnl8FgenJJ0o2HyEAZ2yajtVwalnfcRlN3EVHnSDazLxrKlT3af9', '2025-05-20 05:37:53', '2025-05-20 05:37:53', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bank_accounts_person_id_index` (`person_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cities_province_id_foreign` (`province_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`);

--
-- Indexes for table `customer_purchases`
--
ALTER TABLE `customer_purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_purchases_customer_id_foreign` (`customer_id`),
  ADD KEY `customer_purchases_invoice_id_foreign` (`invoice_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `incomes_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoices_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_items_invoice_id_foreign` (`invoice_id`),
  ADD KEY `invoice_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journal_entries`
--
ALTER TABLE `journal_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `journal_entries_entry_number_unique` (`entry_number`),
  ADD KEY `journal_entries_user_id_foreign` (`user_id`),
  ADD KEY `journal_entries_related_invoice_id_foreign` (`related_invoice_id`);

--
-- Indexes for table `journal_entry_items`
--
ALTER TABLE `journal_entry_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journal_entry_items_journal_entry_id_foreign` (`journal_entry_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_code_unique` (`code`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

--
-- Indexes for table `product_shareholder`
--
ALTER TABLE `product_shareholder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_shareholder_product_id_foreign` (`product_id`),
  ADD KEY `product_shareholder_person_id_foreign` (`person_id`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_invoice_number_unique` (`invoice_number`),
  ADD KEY `sales_customer_id_foreign` (`customer_id`),
  ADD KEY `sales_seller_id_foreign` (`seller_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_items_sale_id_foreign` (`sale_id`),
  ADD KEY `sale_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sellers_seller_code_unique` (`seller_code`);

--
-- Indexes for table `seller_bank_accounts`
--
ALTER TABLE `seller_bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_bank_accounts_seller_id_foreign` (`seller_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `services_service_code_unique` (`service_code`);

--
-- Indexes for table `service_categories`
--
ALTER TABLE `service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_dynamic_forms`
--
ALTER TABLE `service_dynamic_forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_fields`
--
ALTER TABLE `service_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_fields_service_id_foreign` (`service_id`);

--
-- Indexes for table `service_field_values`
--
ALTER TABLE `service_field_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_field_values_service_sale_item_id_foreign` (`service_sale_item_id`),
  ADD KEY `service_field_values_service_field_id_foreign` (`service_field_id`);

--
-- Indexes for table `service_sales`
--
ALTER TABLE `service_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_sale_items`
--
ALTER TABLE `service_sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_sale_items_service_sale_id_foreign` (`service_sale_id`),
  ADD KEY `service_sale_items_service_id_foreign` (`service_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `units_title_unique` (`title`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1354;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_purchases`
--
ALTER TABLE `customer_purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journal_entries`
--
ALTER TABLE `journal_entries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journal_entry_items`
--
ALTER TABLE `journal_entry_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_shareholder`
--
ALTER TABLE `product_shareholder`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `seller_bank_accounts`
--
ALTER TABLE `seller_bank_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `service_categories`
--
ALTER TABLE `service_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_dynamic_forms`
--
ALTER TABLE `service_dynamic_forms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_fields`
--
ALTER TABLE `service_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_field_values`
--
ALTER TABLE `service_field_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_sales`
--
ALTER TABLE `service_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_sale_items`
--
ALTER TABLE `service_sale_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD CONSTRAINT `bank_accounts_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_purchases`
--
ALTER TABLE `customer_purchases`
  ADD CONSTRAINT `customer_purchases_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `customer_purchases_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `incomes`
--
ALTER TABLE `incomes`
  ADD CONSTRAINT `incomes_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invoice_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `journal_entries`
--
ALTER TABLE `journal_entries`
  ADD CONSTRAINT `journal_entries_related_invoice_id_foreign` FOREIGN KEY (`related_invoice_id`) REFERENCES `invoices` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `journal_entries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `journal_entry_items`
--
ALTER TABLE `journal_entry_items`
  ADD CONSTRAINT `journal_entry_items_journal_entry_id_foreign` FOREIGN KEY (`journal_entry_id`) REFERENCES `journal_entries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_shareholder`
--
ALTER TABLE `product_shareholder`
  ADD CONSTRAINT `product_shareholder_person_id_foreign` FOREIGN KEY (`person_id`) REFERENCES `persons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_shareholder_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `persons` (`id`),
  ADD CONSTRAINT `sales_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`);

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `sale_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sale_items_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seller_bank_accounts`
--
ALTER TABLE `seller_bank_accounts`
  ADD CONSTRAINT `seller_bank_accounts_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_fields`
--
ALTER TABLE `service_fields`
  ADD CONSTRAINT `service_fields_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_field_values`
--
ALTER TABLE `service_field_values`
  ADD CONSTRAINT `service_field_values_service_field_id_foreign` FOREIGN KEY (`service_field_id`) REFERENCES `service_fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `service_field_values_service_sale_item_id_foreign` FOREIGN KEY (`service_sale_item_id`) REFERENCES `service_sale_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_sale_items`
--
ALTER TABLE `service_sale_items`
  ADD CONSTRAINT `service_sale_items_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `service_sale_items_service_sale_id_foreign` FOREIGN KEY (`service_sale_id`) REFERENCES `service_sales` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
