-- phpMyAdmin SQL Dump
-- version 5.2.2deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 04, 2025 at 08:07 AM
-- Server version: 8.4.6-0ubuntu0.25.04.3
-- PHP Version: 8.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `em-be-air`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-00468ae750bf6c5a9d826854ffc898c0', 'i:1;', 1762069170),
('laravel-cache-00468ae750bf6c5a9d826854ffc898c0:timer', 'i:1762069170;', 1762069170),
('laravel-cache-019603491ffd1a6fe8ee00ebb91a56bb', 'i:1;', 1762228459),
('laravel-cache-019603491ffd1a6fe8ee00ebb91a56bb:timer', 'i:1762228459;', 1762228459),
('laravel-cache-0201a9fae9ec54c2910548a04548ec94', 'i:1;', 1762160963),
('laravel-cache-0201a9fae9ec54c2910548a04548ec94:timer', 'i:1762160962;', 1762160962),
('laravel-cache-026e18f3b98dddb0e4585b1b00bb7b5b', 'i:1;', 1762228554),
('laravel-cache-026e18f3b98dddb0e4585b1b00bb7b5b:timer', 'i:1762228554;', 1762228554),
('laravel-cache-02a90da5512c8cfb5042c22562d394c8', 'i:1;', 1761909139),
('laravel-cache-02a90da5512c8cfb5042c22562d394c8:timer', 'i:1761909139;', 1761909139),
('laravel-cache-02c406532cf38e6114cba50dfb29ed1f', 'i:1;', 1761901392),
('laravel-cache-02c406532cf38e6114cba50dfb29ed1f:timer', 'i:1761901392;', 1761901392),
('laravel-cache-0303519d0e045014f9c90e9d8ffb7da2', 'i:1;', 1762228849),
('laravel-cache-0303519d0e045014f9c90e9d8ffb7da2:timer', 'i:1762228849;', 1762228849),
('laravel-cache-0371f84bc5e584fd970836d648776b11', 'i:1;', 1762122063),
('laravel-cache-0371f84bc5e584fd970836d648776b11:timer', 'i:1762122063;', 1762122063),
('laravel-cache-03a0403e9ca0c3d33280281376309516', 'i:1;', 1761983291),
('laravel-cache-03a0403e9ca0c3d33280281376309516:timer', 'i:1761983291;', 1761983291),
('laravel-cache-042a0796ed00422d562f5dd1d4c88cdf', 'i:1;', 1761908201),
('laravel-cache-042a0796ed00422d562f5dd1d4c88cdf:timer', 'i:1761908201;', 1761908201),
('laravel-cache-04d3b8192e6c12d0fb5cfae12161d1b8', 'i:1;', 1762243264),
('laravel-cache-04d3b8192e6c12d0fb5cfae12161d1b8:timer', 'i:1762243263;', 1762243263),
('laravel-cache-052d0cfc17f3095d12f44b9660828559', 'i:1;', 1762222418),
('laravel-cache-052d0cfc17f3095d12f44b9660828559:timer', 'i:1762222418;', 1762222418),
('laravel-cache-0550607e2131d61dba5d995aae94b0e7', 'i:1;', 1762013580),
('laravel-cache-0550607e2131d61dba5d995aae94b0e7:timer', 'i:1762013579;', 1762013580),
('laravel-cache-0554e37157ad30dbc0baa42463d4787b', 'i:1;', 1762228438),
('laravel-cache-0554e37157ad30dbc0baa42463d4787b:timer', 'i:1762228438;', 1762228438),
('laravel-cache-06003012e885316d771f93e296714bf9', 'i:1;', 1761996135),
('laravel-cache-06003012e885316d771f93e296714bf9:timer', 'i:1761996135;', 1761996135),
('laravel-cache-08df6f1e4fb1bfe9b97d3f75a4664a1e', 'i:2;', 1761919478),
('laravel-cache-08df6f1e4fb1bfe9b97d3f75a4664a1e:timer', 'i:1761919477;', 1761919478),
('laravel-cache-09805588a996335398c31e7f06cb5744', 'i:1;', 1762117956),
('laravel-cache-09805588a996335398c31e7f06cb5744:timer', 'i:1762117956;', 1762117956),
('laravel-cache-0cddd87015ee8748bb758c1a00e6c513', 'i:1;', 1762210891),
('laravel-cache-0cddd87015ee8748bb758c1a00e6c513:timer', 'i:1762210891;', 1762210891),
('laravel-cache-0d88b5e9e45d8c3922fd01c4daba46f4', 'i:1;', 1762103386),
('laravel-cache-0d88b5e9e45d8c3922fd01c4daba46f4:timer', 'i:1762103385;', 1762103385),
('laravel-cache-0d9345baf1660549e73d15e9b3318730', 'i:1;', 1762241387),
('laravel-cache-0d9345baf1660549e73d15e9b3318730:timer', 'i:1762241387;', 1762241387),
('laravel-cache-0e4bf9c15d5adb09fa1e8b98027ff3e3', 'i:1;', 1762121882),
('laravel-cache-0e4bf9c15d5adb09fa1e8b98027ff3e3:timer', 'i:1762121882;', 1762121882),
('laravel-cache-0e6c89f7b513cecb5288a8842c81d7da', 'i:1;', 1762004974),
('laravel-cache-0e6c89f7b513cecb5288a8842c81d7da:timer', 'i:1762004974;', 1762004974),
('laravel-cache-0e835797c51dfe81d19d252d6323899f', 'i:2;', 1762055193),
('laravel-cache-0e835797c51dfe81d19d252d6323899f:timer', 'i:1762055193;', 1762055193),
('laravel-cache-0e97be420d29425eb64b5e8989c4ad5d', 'i:1;', 1762136614),
('laravel-cache-0e97be420d29425eb64b5e8989c4ad5d:timer', 'i:1762136614;', 1762136614),
('laravel-cache-0f6e04c3873ad0eb464624e989fb3f21', 'i:1;', 1762044009),
('laravel-cache-0f6e04c3873ad0eb464624e989fb3f21:timer', 'i:1762044009;', 1762044009),
('laravel-cache-0f9007203fe5b09e8849910f6899b433', 'i:1;', 1762211462),
('laravel-cache-0f9007203fe5b09e8849910f6899b433:timer', 'i:1762211462;', 1762211462),
('laravel-cache-0f99a224ff2341bbf2052aeea253d820', 'i:1;', 1762053349),
('laravel-cache-0f99a224ff2341bbf2052aeea253d820:timer', 'i:1762053349;', 1762053349),
('laravel-cache-0fa45cdce752268dda13a817a0a64179', 'i:1;', 1762108940),
('laravel-cache-0fa45cdce752268dda13a817a0a64179:timer', 'i:1762108940;', 1762108940),
('laravel-cache-10b5bffca66243192b05805377ce53bf', 'i:1;', 1762103153),
('laravel-cache-10b5bffca66243192b05805377ce53bf:timer', 'i:1762103153;', 1762103153),
('laravel-cache-116f91f0a1ef31f61359996fe77f12b9', 'i:1;', 1762004440),
('laravel-cache-116f91f0a1ef31f61359996fe77f12b9:timer', 'i:1762004440;', 1762004440),
('laravel-cache-11bdf11577fe9ecc8d72d4ee8e391ac3', 'i:1;', 1762182752),
('laravel-cache-11bdf11577fe9ecc8d72d4ee8e391ac3:timer', 'i:1762182752;', 1762182752),
('laravel-cache-1211cc0dad8bfb35713d437e942f98f3', 'i:1;', 1762133379),
('laravel-cache-1211cc0dad8bfb35713d437e942f98f3:timer', 'i:1762133379;', 1762133379),
('laravel-cache-122cdf1e8712a7377108ce2e54f98208', 'i:1;', 1761920974),
('laravel-cache-122cdf1e8712a7377108ce2e54f98208:timer', 'i:1761920974;', 1761920974),
('laravel-cache-127e51153ff6d73d2c7284919788daaf', 'i:1;', 1762055886),
('laravel-cache-127e51153ff6d73d2c7284919788daaf:timer', 'i:1762055886;', 1762055886),
('laravel-cache-1288a46d23bbc80d048e21ae40ce296c', 'i:1;', 1762228613),
('laravel-cache-1288a46d23bbc80d048e21ae40ce296c:timer', 'i:1762228613;', 1762228613),
('laravel-cache-13953c219356bb0cbda69a7e60a62d07', 'i:2;', 1762062682),
('laravel-cache-13953c219356bb0cbda69a7e60a62d07:timer', 'i:1762062682;', 1762062682),
('laravel-cache-145a3553a893fe3b5f7827928e033cc5', 'i:1;', 1762056911),
('laravel-cache-145a3553a893fe3b5f7827928e033cc5:timer', 'i:1762056911;', 1762056911),
('laravel-cache-14f50bad568cb5ca0e96fbce3245010f', 'i:3;', 1762209903),
('laravel-cache-14f50bad568cb5ca0e96fbce3245010f:timer', 'i:1762209903;', 1762209903),
('laravel-cache-1583e120f54141612e2701740c279aae', 'i:1;', 1762166465),
('laravel-cache-1583e120f54141612e2701740c279aae:timer', 'i:1762166465;', 1762166465),
('laravel-cache-164cf800cd292ed933d3541b60356b4d', 'i:1;', 1762183057),
('laravel-cache-164cf800cd292ed933d3541b60356b4d:timer', 'i:1762183057;', 1762183057),
('laravel-cache-16febd4a186eae55c21173e566ef9049', 'i:3;', 1762108651),
('laravel-cache-16febd4a186eae55c21173e566ef9049:timer', 'i:1762108651;', 1762108651),
('laravel-cache-179202d3971eaea870b6d6b143b87a09', 'i:1;', 1762214181),
('laravel-cache-179202d3971eaea870b6d6b143b87a09:timer', 'i:1762214181;', 1762214181),
('laravel-cache-188d81e4276761a309069b9e69de2b4b', 'i:3;', 1762133685),
('laravel-cache-188d81e4276761a309069b9e69de2b4b:timer', 'i:1762133685;', 1762133685),
('laravel-cache-194e4c5416b47aea7b6e5cf5a2ac0935', 'i:1;', 1762136411),
('laravel-cache-194e4c5416b47aea7b6e5cf5a2ac0935:timer', 'i:1762136410;', 1762136410),
('laravel-cache-1a5190d8a69477e6c89da50bcef30288', 'i:1;', 1762116982),
('laravel-cache-1a5190d8a69477e6c89da50bcef30288:timer', 'i:1762116982;', 1762116982),
('laravel-cache-1a61c1da4d4aa8e3e446dc9a3c6efdb0', 'i:1;', 1762177977),
('laravel-cache-1a61c1da4d4aa8e3e446dc9a3c6efdb0:timer', 'i:1762177977;', 1762177977),
('laravel-cache-1b4f1554e74bf7405b6ea140bd157ffa', 'i:1;', 1762108745),
('laravel-cache-1b4f1554e74bf7405b6ea140bd157ffa:timer', 'i:1762108745;', 1762108745),
('laravel-cache-1b99a9488a59249223b089526b259283', 'i:1;', 1761906906),
('laravel-cache-1b99a9488a59249223b089526b259283:timer', 'i:1761906906;', 1761906906),
('laravel-cache-1bc44ac6075af2965696fe504e918ceb', 'i:2;', 1762067924),
('laravel-cache-1bc44ac6075af2965696fe504e918ceb:timer', 'i:1762067924;', 1762067924),
('laravel-cache-1c491b439c87df0314ea2f194bc3229f', 'i:1;', 1762221687),
('laravel-cache-1c491b439c87df0314ea2f194bc3229f:timer', 'i:1762221687;', 1762221687),
('laravel-cache-1c5dfdd9577097dde43e89c4a048fcfa', 'i:1;', 1762240242),
('laravel-cache-1c5dfdd9577097dde43e89c4a048fcfa:timer', 'i:1762240241;', 1762240241),
('laravel-cache-1cf82848072338be0b02a33567d953fb', 'i:1;', 1762226525),
('laravel-cache-1cf82848072338be0b02a33567d953fb:timer', 'i:1762226525;', 1762226525),
('laravel-cache-1d6e1c73529b9bbb17ef712ceffb5eeb', 'i:2;', 1762240502),
('laravel-cache-1d6e1c73529b9bbb17ef712ceffb5eeb:timer', 'i:1762240502;', 1762240502),
('laravel-cache-1e142d2cd69b7076fc92580eac79e1e0', 'i:1;', 1762219921),
('laravel-cache-1e142d2cd69b7076fc92580eac79e1e0:timer', 'i:1762219920;', 1762219920),
('laravel-cache-1f309bd460e1c08d6b89f5c755927cc1', 'i:2;', 1762231618),
('laravel-cache-1f309bd460e1c08d6b89f5c755927cc1:timer', 'i:1762231618;', 1762231618),
('laravel-cache-209156ad173039936a5b662545e65dfa', 'i:1;', 1761978856),
('laravel-cache-209156ad173039936a5b662545e65dfa:timer', 'i:1761978856;', 1761978856),
('laravel-cache-20edc67fdd7d809d0a138a474b821d18', 'i:1;', 1762057149),
('laravel-cache-20edc67fdd7d809d0a138a474b821d18:timer', 'i:1762057149;', 1762057149),
('laravel-cache-20f488a2ce18a202fddfb8a446ad6aef', 'i:1;', 1762221778),
('laravel-cache-20f488a2ce18a202fddfb8a446ad6aef:timer', 'i:1762221778;', 1762221778),
('laravel-cache-22454ffa1df04115997cf7afa71e8626', 'i:1;', 1762243135),
('laravel-cache-22454ffa1df04115997cf7afa71e8626:timer', 'i:1762243135;', 1762243135),
('laravel-cache-230038a119c9c900cd32b8eb571643fe', 'i:1;', 1762140110),
('laravel-cache-230038a119c9c900cd32b8eb571643fe:timer', 'i:1762140110;', 1762140110),
('laravel-cache-2355ac4808972d450950a2c948cdcb91', 'i:1;', 1762063619),
('laravel-cache-2355ac4808972d450950a2c948cdcb91:timer', 'i:1762063619;', 1762063619),
('laravel-cache-247d5dfb823401a6a31cb725f9ee59eb', 'i:1;', 1762144597),
('laravel-cache-247d5dfb823401a6a31cb725f9ee59eb:timer', 'i:1762144597;', 1762144597),
('laravel-cache-248c8be74fea60c20f45a81122f5289f', 'i:1;', 1761959765),
('laravel-cache-248c8be74fea60c20f45a81122f5289f:timer', 'i:1761959764;', 1761959764),
('laravel-cache-25493f592e5e00d60df823767973832c', 'i:1;', 1762209263),
('laravel-cache-25493f592e5e00d60df823767973832c:timer', 'i:1762209263;', 1762209263),
('laravel-cache-26bf69abcdb3b7e406999b6b88b3b24f', 'i:2;', 1762014381),
('laravel-cache-26bf69abcdb3b7e406999b6b88b3b24f:timer', 'i:1762014381;', 1762014381),
('laravel-cache-26f0fe5bcf2c1d85b03fb4768f380cc0', 'i:1;', 1762013057),
('laravel-cache-26f0fe5bcf2c1d85b03fb4768f380cc0:timer', 'i:1762013057;', 1762013057),
('laravel-cache-27b07f1bd9922f3aaa60cb2c8f48072b', 'i:1;', 1762242819),
('laravel-cache-27b07f1bd9922f3aaa60cb2c8f48072b:timer', 'i:1762242819;', 1762242819),
('laravel-cache-27f01fb047c65f41bf7fce9254851f53', 'i:1;', 1762183851),
('laravel-cache-27f01fb047c65f41bf7fce9254851f53:timer', 'i:1762183851;', 1762183851),
('laravel-cache-2859f1df89cf20d25cc68956688be5ef', 'i:2;', 1762067909),
('laravel-cache-2859f1df89cf20d25cc68956688be5ef:timer', 'i:1762067909;', 1762067909),
('laravel-cache-2987418a68ad2f4f015eefb7e813ab50', 'i:1;', 1762065920),
('laravel-cache-2987418a68ad2f4f015eefb7e813ab50:timer', 'i:1762065920;', 1762065920),
('laravel-cache-29c2ce3b8cb3d15a70397357124f61b9', 'i:2;', 1762183570),
('laravel-cache-29c2ce3b8cb3d15a70397357124f61b9:timer', 'i:1762183570;', 1762183570),
('laravel-cache-2a6c577c58799d0f5219316ffbc9b4d5', 'i:1;', 1762121891),
('laravel-cache-2a6c577c58799d0f5219316ffbc9b4d5:timer', 'i:1762121891;', 1762121891),
('laravel-cache-2a9dddc38c98319c490cd9bb1848f5de', 'i:1;', 1762076875),
('laravel-cache-2a9dddc38c98319c490cd9bb1848f5de:timer', 'i:1762076875;', 1762076875),
('laravel-cache-2acdb5f49b45e685c709743925e7bbf3', 'i:1;', 1761997077),
('laravel-cache-2acdb5f49b45e685c709743925e7bbf3:timer', 'i:1761997077;', 1761997077),
('laravel-cache-2b5dddf98a2f5c84cb13d11f7fa335b0', 'i:1;', 1762243172),
('laravel-cache-2b5dddf98a2f5c84cb13d11f7fa335b0:timer', 'i:1762243172;', 1762243172),
('laravel-cache-2bd507f35cb1c26310cbb6405065439d', 'i:1;', 1762228618),
('laravel-cache-2bd507f35cb1c26310cbb6405065439d:timer', 'i:1762228618;', 1762228618),
('laravel-cache-2c1724b4ed3e83a4060de165791df2bd', 'i:1;', 1762009120),
('laravel-cache-2c1724b4ed3e83a4060de165791df2bd:timer', 'i:1762009120;', 1762009120),
('laravel-cache-2c73934547c3bd8a02e11d6a619a7199', 'i:1;', 1762228699),
('laravel-cache-2c73934547c3bd8a02e11d6a619a7199:timer', 'i:1762228699;', 1762228699),
('laravel-cache-2d7b6b2937253288c3e95ef122cdf8d7', 'i:1;', 1762141683),
('laravel-cache-2d7b6b2937253288c3e95ef122cdf8d7:timer', 'i:1762141683;', 1762141683),
('laravel-cache-2d99b71cbacd3c4e1a8a2eb5ad537285', 'i:3;', 1762241339),
('laravel-cache-2d99b71cbacd3c4e1a8a2eb5ad537285:timer', 'i:1762241339;', 1762241339),
('laravel-cache-2dd2194026d4e6ea959821d339f45da2', 'i:1;', 1762009269),
('laravel-cache-2dd2194026d4e6ea959821d339f45da2:timer', 'i:1762009269;', 1762009269),
('laravel-cache-2ddd76cc24c5eddd1fa6d4c1794b4f49', 'i:1;', 1762065953),
('laravel-cache-2ddd76cc24c5eddd1fa6d4c1794b4f49:timer', 'i:1762065953;', 1762065953),
('laravel-cache-2eda00ebe8371fce94aabe80e8d06666', 'i:1;', 1762116891),
('laravel-cache-2eda00ebe8371fce94aabe80e8d06666:timer', 'i:1762116891;', 1762116891),
('laravel-cache-2eeb083c05a06d0d607f08812297548e', 'i:1;', 1762056605),
('laravel-cache-2eeb083c05a06d0d607f08812297548e:timer', 'i:1762056605;', 1762056605),
('laravel-cache-2f0cd64850a3ee2e65ee42bb746f17fd', 'i:1;', 1761911118),
('laravel-cache-2f0cd64850a3ee2e65ee42bb746f17fd:timer', 'i:1761911118;', 1761911118),
('laravel-cache-2fcdda4a54571801614e084e9c986762', 'i:1;', 1762077631),
('laravel-cache-2fcdda4a54571801614e084e9c986762:timer', 'i:1762077631;', 1762077631),
('laravel-cache-30698d9bf2fed6bcab14c2fa71f6245b', 'i:1;', 1762056147),
('laravel-cache-30698d9bf2fed6bcab14c2fa71f6245b:timer', 'i:1762056147;', 1762056147),
('laravel-cache-30703dcb72f8ec18cf675be313bd296b', 'i:1;', 1762152803),
('laravel-cache-30703dcb72f8ec18cf675be313bd296b:timer', 'i:1762152803;', 1762152803),
('laravel-cache-3145eb39c3808cc1b4a9e436c6b87a77', 'i:1;', 1762228531),
('laravel-cache-3145eb39c3808cc1b4a9e436c6b87a77:timer', 'i:1762228531;', 1762228531),
('laravel-cache-31ffb16ecbfd8ef71935f1db2b85b343', 'i:1;', 1762180834),
('laravel-cache-31ffb16ecbfd8ef71935f1db2b85b343:timer', 'i:1762180834;', 1762180834),
('laravel-cache-32dd1d23a54f3b41134f8960280a98f6', 'i:1;', 1761952104),
('laravel-cache-32dd1d23a54f3b41134f8960280a98f6:timer', 'i:1761952104;', 1761952104),
('laravel-cache-33814e6b88d203f54e037c33045b1647', 'i:1;', 1762104627),
('laravel-cache-33814e6b88d203f54e037c33045b1647:timer', 'i:1762104627;', 1762104627),
('laravel-cache-34527ccb3815b16b68580d78b269989a', 'i:1;', 1762057173),
('laravel-cache-34527ccb3815b16b68580d78b269989a:timer', 'i:1762057173;', 1762057173),
('laravel-cache-34d17e82c7f39b92a61f6f40e05fe444', 'i:1;', 1762082106),
('laravel-cache-34d17e82c7f39b92a61f6f40e05fe444:timer', 'i:1762082106;', 1762082106),
('laravel-cache-352ef4135201422ccf1daed59df86af1', 'i:1;', 1762008875),
('laravel-cache-352ef4135201422ccf1daed59df86af1:timer', 'i:1762008875;', 1762008875),
('laravel-cache-36347d3ccdb02c4cbf54cdb16a872b7d', 'i:1;', 1762210651),
('laravel-cache-36347d3ccdb02c4cbf54cdb16a872b7d:timer', 'i:1762210651;', 1762210651),
('laravel-cache-3657a4cd421b3a83f3f9c725c491f5de', 'i:1;', 1762139037),
('laravel-cache-3657a4cd421b3a83f3f9c725c491f5de:timer', 'i:1762139037;', 1762139037),
('laravel-cache-36791474f042664577be21c3652b7e04', 'i:1;', 1762151424),
('laravel-cache-36791474f042664577be21c3652b7e04:timer', 'i:1762151424;', 1762151424),
('laravel-cache-36f0b6e3cc88e8092989c197177f9c4b', 'i:1;', 1762106024),
('laravel-cache-36f0b6e3cc88e8092989c197177f9c4b:timer', 'i:1762106024;', 1762106024),
('laravel-cache-3856bf538c7d5378becdbf861d9d085f', 'i:1;', 1762211348),
('laravel-cache-3856bf538c7d5378becdbf861d9d085f:timer', 'i:1762211347;', 1762211347),
('laravel-cache-38acedab253b7e3785e843ab8f0782ba', 'i:1;', 1762059017),
('laravel-cache-38acedab253b7e3785e843ab8f0782ba:timer', 'i:1762059017;', 1762059017),
('laravel-cache-38e16d0427fc60977f185052279b36dd', 'i:2;', 1761917188),
('laravel-cache-38e16d0427fc60977f185052279b36dd:timer', 'i:1761917188;', 1761917188),
('laravel-cache-3944a04e4f4b1cb6e9cb71fc854f3675', 'i:1;', 1762072498),
('laravel-cache-3944a04e4f4b1cb6e9cb71fc854f3675:timer', 'i:1762072498;', 1762072498),
('laravel-cache-3aa90102ae56c23714899c695b77197c', 'i:2;', 1762057550),
('laravel-cache-3aa90102ae56c23714899c695b77197c:timer', 'i:1762057550;', 1762057550),
('laravel-cache-3bd218523737eec6c9950c0d018d84fc', 'i:1;', 1761998577),
('laravel-cache-3bd218523737eec6c9950c0d018d84fc:timer', 'i:1761998576;', 1761998577),
('laravel-cache-3c67f9d334724e69246d70b76112c7a0', 'i:1;', 1761908190),
('laravel-cache-3c67f9d334724e69246d70b76112c7a0:timer', 'i:1761908190;', 1761908190),
('laravel-cache-3e35eac23b49c229145f3667d8e5a550', 'i:2;', 1762106929),
('laravel-cache-3e35eac23b49c229145f3667d8e5a550:timer', 'i:1762106929;', 1762106929),
('laravel-cache-3e76812eb7ee36b5c6aea78bc423a452', 'i:1;', 1762240274),
('laravel-cache-3e76812eb7ee36b5c6aea78bc423a452:timer', 'i:1762240273;', 1762240273),
('laravel-cache-3ead7a2a1358403261bc74058e13bcb0', 'i:1;', 1762235987),
('laravel-cache-3ead7a2a1358403261bc74058e13bcb0:timer', 'i:1762235987;', 1762235987),
('laravel-cache-3ed0d62bf8d99adb4f143875da4efb92', 'i:1;', 1762053834),
('laravel-cache-3ed0d62bf8d99adb4f143875da4efb92:timer', 'i:1762053834;', 1762053834),
('laravel-cache-3f439117fc44b601c9f4e4d9fc85398d', 'i:1;', 1762236831),
('laravel-cache-3f439117fc44b601c9f4e4d9fc85398d:timer', 'i:1762236831;', 1762236831),
('laravel-cache-40353e9af833231196fe69cd296f88b1', 'i:1;', 1762181959),
('laravel-cache-40353e9af833231196fe69cd296f88b1:timer', 'i:1762181959;', 1762181959),
('laravel-cache-4105b0690fcc8e1312a63f3016e62c09', 'i:1;', 1762023436),
('laravel-cache-4105b0690fcc8e1312a63f3016e62c09:timer', 'i:1762023436;', 1762023436),
('laravel-cache-41f7ec719ac4e692fe6f0d72abbf9b14', 'i:1;', 1762055422),
('laravel-cache-41f7ec719ac4e692fe6f0d72abbf9b14:timer', 'i:1762055422;', 1762055422),
('laravel-cache-4346e26b3db3feb64bd41fc6a4db5efe', 'i:1;', 1762228495),
('laravel-cache-4346e26b3db3feb64bd41fc6a4db5efe:timer', 'i:1762228495;', 1762228495),
('laravel-cache-43df6951cf503cd551458a4c62f847f7', 'i:1;', 1762150663),
('laravel-cache-43df6951cf503cd551458a4c62f847f7:timer', 'i:1762150663;', 1762150663),
('laravel-cache-47664139a8825d3cf59d0f5ae5f8400f', 'i:1;', 1762139970),
('laravel-cache-47664139a8825d3cf59d0f5ae5f8400f:timer', 'i:1762139970;', 1762139970),
('laravel-cache-484619fb0376afbe72516d2972a4c0c4', 'i:1;', 1762161960),
('laravel-cache-484619fb0376afbe72516d2972a4c0c4:timer', 'i:1762161960;', 1762161960),
('laravel-cache-4888df283dbc5260fde71853558bb523', 'i:1;', 1761922561),
('laravel-cache-4888df283dbc5260fde71853558bb523:timer', 'i:1761922561;', 1761922561),
('laravel-cache-488a0d69ab79dcd0d16a43e87f7ba63c', 'i:1;', 1762082531),
('laravel-cache-488a0d69ab79dcd0d16a43e87f7ba63c:timer', 'i:1762082531;', 1762082531),
('laravel-cache-498ee0a7d0f64f2f6a651fd077ab885e', 'i:2;', 1762065361),
('laravel-cache-498ee0a7d0f64f2f6a651fd077ab885e:timer', 'i:1762065361;', 1762065361),
('laravel-cache-4ae1ad87397a4e59ab873529880e502e', 'i:1;', 1762239367),
('laravel-cache-4ae1ad87397a4e59ab873529880e502e:timer', 'i:1762239367;', 1762239367),
('laravel-cache-4b1a32bc9c301ac6c283ecf157d1061f', 'i:2;', 1762243083),
('laravel-cache-4b1a32bc9c301ac6c283ecf157d1061f:timer', 'i:1762243082;', 1762243083),
('laravel-cache-4b7a9e8a37e1c3c3d711bb4c13557e0e', 'i:1;', 1762151785),
('laravel-cache-4b7a9e8a37e1c3c3d711bb4c13557e0e:timer', 'i:1762151785;', 1762151785),
('laravel-cache-4bf4bd2097fa63f971b27abc0b23e841', 'i:1;', 1762072249),
('laravel-cache-4bf4bd2097fa63f971b27abc0b23e841:timer', 'i:1762072249;', 1762072249),
('laravel-cache-4c31b15ebe1603310ffa28d5727de830', 'i:2;', 1761920882),
('laravel-cache-4c31b15ebe1603310ffa28d5727de830:timer', 'i:1761920882;', 1761920882),
('laravel-cache-4c5e2ffb3f93c89d5d77eb8a2a476017', 'i:1;', 1762224137),
('laravel-cache-4c5e2ffb3f93c89d5d77eb8a2a476017:timer', 'i:1762224136;', 1762224136),
('laravel-cache-4cd06e861047a82dda00bdb6789afb23', 'i:1;', 1762212158),
('laravel-cache-4cd06e861047a82dda00bdb6789afb23:timer', 'i:1762212158;', 1762212158),
('laravel-cache-4cfe780588b9bb189714ef52f2e989d2', 'i:1;', 1761999233),
('laravel-cache-4cfe780588b9bb189714ef52f2e989d2:timer', 'i:1761999233;', 1761999233),
('laravel-cache-4df0621d9cae0b26e18286d4990554a3', 'i:1;', 1762240698),
('laravel-cache-4df0621d9cae0b26e18286d4990554a3:timer', 'i:1762240697;', 1762240698),
('laravel-cache-4f47229d144c2a420de6dcf00e457de6', 'i:1;', 1762139848),
('laravel-cache-4f47229d144c2a420de6dcf00e457de6:timer', 'i:1762139848;', 1762139848),
('laravel-cache-4fa457914504234d06e00a85c915bbaf', 'i:2;', 1762182072),
('laravel-cache-4fa457914504234d06e00a85c915bbaf:timer', 'i:1762182072;', 1762182072),
('laravel-cache-4fb5c4cc8d38a991a5634a262e897e36', 'i:1;', 1761918162),
('laravel-cache-4fb5c4cc8d38a991a5634a262e897e36:timer', 'i:1761918162;', 1761918162),
('laravel-cache-50c5c43a4231c0459bb6055ff630c023', 'i:1;', 1761979859),
('laravel-cache-50c5c43a4231c0459bb6055ff630c023:timer', 'i:1761979859;', 1761979859),
('laravel-cache-5133f3b6ed1340cb0454cdb65fb677ed', 'i:1;', 1761992304),
('laravel-cache-5133f3b6ed1340cb0454cdb65fb677ed:timer', 'i:1761992304;', 1761992304),
('laravel-cache-51fea7def0f3e1201de1ff75a0016f58', 'i:1;', 1762058582),
('laravel-cache-51fea7def0f3e1201de1ff75a0016f58:timer', 'i:1762058582;', 1762058582),
('laravel-cache-5244706abf2cf2c38a23476abdc4a1d4', 'i:1;', 1762106788),
('laravel-cache-5244706abf2cf2c38a23476abdc4a1d4:timer', 'i:1762106788;', 1762106788),
('laravel-cache-52ab4ff122530611efd3750c397b43ae', 'i:1;', 1762152723),
('laravel-cache-52ab4ff122530611efd3750c397b43ae:timer', 'i:1762152722;', 1762152723),
('laravel-cache-53475f3efccad9815827d90447069ab0', 'i:1;', 1762118822),
('laravel-cache-53475f3efccad9815827d90447069ab0:timer', 'i:1762118822;', 1762118822),
('laravel-cache-537565b83018cac4a778eb332a23d555', 'i:1;', 1762214744),
('laravel-cache-537565b83018cac4a778eb332a23d555:timer', 'i:1762214744;', 1762214744),
('laravel-cache-5394715e1636e103616fbca47accba30', 'i:2;', 1762067649),
('laravel-cache-5394715e1636e103616fbca47accba30:timer', 'i:1762067648;', 1762067649),
('laravel-cache-5416eea48d251959be2450e939ed54fa', 'i:1;', 1762178114),
('laravel-cache-5416eea48d251959be2450e939ed54fa:timer', 'i:1762178114;', 1762178114),
('laravel-cache-5472063a85a25e22c680620fc9474a9c', 'i:1;', 1762239776),
('laravel-cache-5472063a85a25e22c680620fc9474a9c:timer', 'i:1762239776;', 1762239776),
('laravel-cache-5570b4e3bcbf934105a18a249b91a115', 'i:2;', 1762005106),
('laravel-cache-5570b4e3bcbf934105a18a249b91a115:timer', 'i:1762005106;', 1762005106),
('laravel-cache-5701dc549becc2dd700d638eed138f9f', 'i:1;', 1761917379),
('laravel-cache-5701dc549becc2dd700d638eed138f9f:timer', 'i:1761917379;', 1761917379),
('laravel-cache-5789dcf0c7a429e8387ba9f10f31fb74', 'i:1;', 1762075571),
('laravel-cache-5789dcf0c7a429e8387ba9f10f31fb74:timer', 'i:1762075571;', 1762075571),
('laravel-cache-5894e550c4293e732a588bfcdd9b8058', 'i:1;', 1762057517),
('laravel-cache-5894e550c4293e732a588bfcdd9b8058:timer', 'i:1762057516;', 1762057516),
('laravel-cache-58afbdfbbf52f5da9bc5cc8ee93e6577', 'i:1;', 1762100376),
('laravel-cache-58afbdfbbf52f5da9bc5cc8ee93e6577:timer', 'i:1762100376;', 1762100376),
('laravel-cache-597e237add209306be581e43814d82ea', 'i:1;', 1762069744),
('laravel-cache-597e237add209306be581e43814d82ea:timer', 'i:1762069744;', 1762069744),
('laravel-cache-5a751fc523153310d6b96cb78d306b0c', 'i:1;', 1762136345),
('laravel-cache-5a751fc523153310d6b96cb78d306b0c:timer', 'i:1762136345;', 1762136345),
('laravel-cache-5a7783ab53531ec49aeb93f96d8b9c46', 'i:1;', 1762182016),
('laravel-cache-5a7783ab53531ec49aeb93f96d8b9c46:timer', 'i:1762182016;', 1762182016),
('laravel-cache-5acecd1d983f6401dbe447565a0306b8', 'i:3;', 1762076568),
('laravel-cache-5acecd1d983f6401dbe447565a0306b8:timer', 'i:1762076568;', 1762076568),
('laravel-cache-5b8cd5bc3168eabd8ce9aed0e61eb37c', 'i:1;', 1762068609),
('laravel-cache-5b8cd5bc3168eabd8ce9aed0e61eb37c:timer', 'i:1762068609;', 1762068609),
('laravel-cache-5bb47b24eda8e1f000ce31a2bd7abf10', 'i:1;', 1762243430),
('laravel-cache-5bb47b24eda8e1f000ce31a2bd7abf10:timer', 'i:1762243429;', 1762243429),
('laravel-cache-5c0b99fa5c67a72594a4fa262a56d0ee', 'i:1;', 1762239241),
('laravel-cache-5c0b99fa5c67a72594a4fa262a56d0ee:timer', 'i:1762239240;', 1762239240),
('laravel-cache-5d1c08b15532ce859bfeb0efc95d0115', 'i:1;', 1762232344),
('laravel-cache-5d1c08b15532ce859bfeb0efc95d0115:timer', 'i:1762232344;', 1762232344),
('laravel-cache-5d6d7377dc87e4d80c425438b11f432c', 'i:5;', 1762136336),
('laravel-cache-5d6d7377dc87e4d80c425438b11f432c:timer', 'i:1762136336;', 1762136336),
('laravel-cache-5db829798466a3a765c1186a6050429f', 'i:4;', 1762183310),
('laravel-cache-5db829798466a3a765c1186a6050429f:timer', 'i:1762183310;', 1762183310),
('laravel-cache-5e5d17186d94a51ff1c39ad1e8c53422', 'i:1;', 1762183037),
('laravel-cache-5e5d17186d94a51ff1c39ad1e8c53422:timer', 'i:1762183037;', 1762183037),
('laravel-cache-5eb9ff061728b9bf57c5b01750960fbd', 'i:1;', 1762142916),
('laravel-cache-5eb9ff061728b9bf57c5b01750960fbd:timer', 'i:1762142916;', 1762142916),
('laravel-cache-5ed259014874e36f1902e1499e05933c', 'i:1;', 1762114652),
('laravel-cache-5ed259014874e36f1902e1499e05933c:timer', 'i:1762114652;', 1762114652),
('laravel-cache-6083366c52f89912e37d7bd123cfaf94', 'i:1;', 1762175770),
('laravel-cache-6083366c52f89912e37d7bd123cfaf94:timer', 'i:1762175770;', 1762175770),
('laravel-cache-611e140f8fb6f7d8a72db3dbd90960e0', 'i:1;', 1762183698),
('laravel-cache-611e140f8fb6f7d8a72db3dbd90960e0:timer', 'i:1762183698;', 1762183698),
('laravel-cache-617f24de007480676978b7e20b44f060', 'i:1;', 1761998968),
('laravel-cache-617f24de007480676978b7e20b44f060:timer', 'i:1761998968;', 1761998968),
('laravel-cache-61bfeef2455fb6f10b37bb02a40c61da', 'i:1;', 1762010753),
('laravel-cache-61bfeef2455fb6f10b37bb02a40c61da:timer', 'i:1762010753;', 1762010753),
('laravel-cache-622baa25253922dd3afa004c3f163fd3', 'i:1;', 1762239018),
('laravel-cache-622baa25253922dd3afa004c3f163fd3:timer', 'i:1762239017;', 1762239018),
('laravel-cache-6288f7f67273227ba45443b96518f98b', 'i:1;', 1762242912),
('laravel-cache-6288f7f67273227ba45443b96518f98b:timer', 'i:1762242912;', 1762242912),
('laravel-cache-62b7bd87a4008f684b3540242b516e91', 'i:1;', 1762014017),
('laravel-cache-62b7bd87a4008f684b3540242b516e91:timer', 'i:1762014017;', 1762014017),
('laravel-cache-62c24c3c4c0f0be265e7419d214cfb15', 'i:1;', 1762079637),
('laravel-cache-62c24c3c4c0f0be265e7419d214cfb15:timer', 'i:1762079637;', 1762079637),
('laravel-cache-631d413819cdad039dfde11cb8949185', 'i:1;', 1762023386),
('laravel-cache-631d413819cdad039dfde11cb8949185:timer', 'i:1762023386;', 1762023386),
('laravel-cache-6320b04b902b105fd43174432c510129', 'i:1;', 1762083411),
('laravel-cache-6320b04b902b105fd43174432c510129:timer', 'i:1762083411;', 1762083411),
('laravel-cache-634306d9aaff01fa4bfa179ee5ccddc3', 'i:1;', 1762137346),
('laravel-cache-634306d9aaff01fa4bfa179ee5ccddc3:timer', 'i:1762137345;', 1762137345),
('laravel-cache-63b356f133567d4cb20a4525441be9a0', 'i:1;', 1761978209),
('laravel-cache-63b356f133567d4cb20a4525441be9a0:timer', 'i:1761978209;', 1761978209),
('laravel-cache-646eed48279752db5217d09381b2bc77', 'i:1;', 1761977519),
('laravel-cache-646eed48279752db5217d09381b2bc77:timer', 'i:1761977519;', 1761977519),
('laravel-cache-65267ea47aa0ff6640736305b2f16b22', 'i:1;', 1762243675),
('laravel-cache-65267ea47aa0ff6640736305b2f16b22:timer', 'i:1762243675;', 1762243675),
('laravel-cache-657513e533f6545601ff713106427705', 'i:1;', 1762058605),
('laravel-cache-657513e533f6545601ff713106427705:timer', 'i:1762058605;', 1762058605),
('laravel-cache-6611996c44adef19563b62b8dcb10a36', 'i:1;', 1762219749),
('laravel-cache-6611996c44adef19563b62b8dcb10a36:timer', 'i:1762219749;', 1762219749),
('laravel-cache-66bf28385dd72b0beb10a85d91c74f57', 'i:1;', 1762056355),
('laravel-cache-66bf28385dd72b0beb10a85d91c74f57:timer', 'i:1762056355;', 1762056355),
('laravel-cache-66df0ccd16fa3591b004c467c5ec8130', 'i:1;', 1762219743),
('laravel-cache-66df0ccd16fa3591b004c467c5ec8130:timer', 'i:1762219743;', 1762219743),
('laravel-cache-67055595420bfa499150398a02a56493', 'i:1;', 1761997564),
('laravel-cache-67055595420bfa499150398a02a56493:timer', 'i:1761997564;', 1761997564),
('laravel-cache-67bbd4e64aa1ac0489979228c9bfafbb', 'i:1;', 1762000042),
('laravel-cache-67bbd4e64aa1ac0489979228c9bfafbb:timer', 'i:1762000042;', 1762000042),
('laravel-cache-67d9e4f758fe600b6180ca2d6117ab50', 'i:1;', 1762061437),
('laravel-cache-67d9e4f758fe600b6180ca2d6117ab50:timer', 'i:1762061437;', 1762061437),
('laravel-cache-6801a6a94f7611b3c36ad377834a6ae0', 'i:3;', 1762228541),
('laravel-cache-6801a6a94f7611b3c36ad377834a6ae0:timer', 'i:1762228541;', 1762228541),
('laravel-cache-6834b3675295b782f127d76c94b72486', 'i:1;', 1761959703),
('laravel-cache-6834b3675295b782f127d76c94b72486:timer', 'i:1761959703;', 1761959703),
('laravel-cache-68390fd70e27da298781c027b36d5623', 'i:1;', 1762124683),
('laravel-cache-68390fd70e27da298781c027b36d5623:timer', 'i:1762124683;', 1762124683),
('laravel-cache-6873ebe331bef1908a24cced1dc789df', 'i:1;', 1762124318),
('laravel-cache-6873ebe331bef1908a24cced1dc789df:timer', 'i:1762124318;', 1762124318),
('laravel-cache-68cafc5bebb55fb1649680791ce635ed', 'i:1;', 1762223492),
('laravel-cache-68cafc5bebb55fb1649680791ce635ed:timer', 'i:1762223492;', 1762223492),
('laravel-cache-68d32664caf5051625a8fb32b3a1dcb4', 'i:2;', 1762011824),
('laravel-cache-68d32664caf5051625a8fb32b3a1dcb4:timer', 'i:1762011824;', 1762011824),
('laravel-cache-6a10d6bd392cadbeb5faaa73b40d047b', 'i:1;', 1762211014),
('laravel-cache-6a10d6bd392cadbeb5faaa73b40d047b:timer', 'i:1762211014;', 1762211014),
('laravel-cache-6a85e6d08e8eeb64976f4dbf4c087ef7', 'i:1;', 1762227577),
('laravel-cache-6a85e6d08e8eeb64976f4dbf4c087ef7:timer', 'i:1762227576;', 1762227576),
('laravel-cache-6aa1a06264c9b181b31612d2a92ef45a', 'i:2;', 1762203862),
('laravel-cache-6aa1a06264c9b181b31612d2a92ef45a:timer', 'i:1762203862;', 1762203862),
('laravel-cache-6af059a4582b0305ac907e8d6e65de35', 'i:1;', 1762223458),
('laravel-cache-6af059a4582b0305ac907e8d6e65de35:timer', 'i:1762223458;', 1762223458),
('laravel-cache-6b7ebde72ca5b8c80afefad030a96418', 'i:1;', 1762046770),
('laravel-cache-6b7ebde72ca5b8c80afefad030a96418:timer', 'i:1762046770;', 1762046770),
('laravel-cache-6b9b62055ce15e35df950c855709bf33', 'i:1;', 1761978877),
('laravel-cache-6b9b62055ce15e35df950c855709bf33:timer', 'i:1761978877;', 1761978877),
('laravel-cache-6c82eed58df2780512e7f17bed94f811', 'i:1;', 1762211191),
('laravel-cache-6c82eed58df2780512e7f17bed94f811:timer', 'i:1762211191;', 1762211191),
('laravel-cache-6cda63070945aedb1ca20aea7d4e047e', 'i:1;', 1762229344),
('laravel-cache-6cda63070945aedb1ca20aea7d4e047e:timer', 'i:1762229344;', 1762229344),
('laravel-cache-6d1c07bf0faab93066f89bf67399d515', 'i:1;', 1761993559),
('laravel-cache-6d1c07bf0faab93066f89bf67399d515:timer', 'i:1761993559;', 1761993559),
('laravel-cache-6d4afb7c8967c9b03ce49a0d007f948e', 'i:1;', 1762242129),
('laravel-cache-6d4afb7c8967c9b03ce49a0d007f948e:timer', 'i:1762242129;', 1762242129),
('laravel-cache-6e07353e146e246a0e5bcc8cb35f9432', 'i:1;', 1761992151),
('laravel-cache-6e07353e146e246a0e5bcc8cb35f9432:timer', 'i:1761992151;', 1761992151),
('laravel-cache-6e45c09767894dc0af1b7a9713636a1c', 'i:1;', 1762116692),
('laravel-cache-6e45c09767894dc0af1b7a9713636a1c:timer', 'i:1762116691;', 1762116692),
('laravel-cache-6e63ac9e3ef035a343ec304c0932d2d7', 'i:1;', 1762051078),
('laravel-cache-6e63ac9e3ef035a343ec304c0932d2d7:timer', 'i:1762051078;', 1762051078),
('laravel-cache-6ea5172f42f4dcfd22e3ab122c1dab39', 'i:1;', 1762242926),
('laravel-cache-6ea5172f42f4dcfd22e3ab122c1dab39:timer', 'i:1762242925;', 1762242925),
('laravel-cache-6f255f90be2a0215d412670733d62339', 'i:1;', 1762066566),
('laravel-cache-6f255f90be2a0215d412670733d62339:timer', 'i:1762066566;', 1762066566),
('laravel-cache-6f39b08196cdec9b05107fe407dd6b6a', 'i:1;', 1762131504),
('laravel-cache-6f39b08196cdec9b05107fe407dd6b6a:timer', 'i:1762131504;', 1762131504),
('laravel-cache-6f4acdc5a45ac025909d38e291177ae3', 'i:1;', 1762061750),
('laravel-cache-6f4acdc5a45ac025909d38e291177ae3:timer', 'i:1762061750;', 1762061750),
('laravel-cache-6f66985ebb5cb5b9dc24d49f1225a13c', 'i:1;', 1762144310),
('laravel-cache-6f66985ebb5cb5b9dc24d49f1225a13c:timer', 'i:1762144310;', 1762144310),
('laravel-cache-707358453a7d85655ec8d83f064873bc', 'i:1;', 1762177952),
('laravel-cache-707358453a7d85655ec8d83f064873bc:timer', 'i:1762177952;', 1762177952),
('laravel-cache-723bf1f9fd90ca8cb276eda31b9215fd', 'i:1;', 1762242704),
('laravel-cache-723bf1f9fd90ca8cb276eda31b9215fd:timer', 'i:1762242704;', 1762242704),
('laravel-cache-743c73a15273585a29126bea75200222', 'i:1;', 1762243709),
('laravel-cache-743c73a15273585a29126bea75200222:timer', 'i:1762243709;', 1762243709),
('laravel-cache-75abfac763668190efc1832ff1ee10e8', 'i:1;', 1761997068),
('laravel-cache-75abfac763668190efc1832ff1ee10e8:timer', 'i:1761997067;', 1761997067),
('laravel-cache-7629e6533e6bf1fef0037532b461ca3b', 'i:1;', 1762100368),
('laravel-cache-7629e6533e6bf1fef0037532b461ca3b:timer', 'i:1762100368;', 1762100368),
('laravel-cache-764f8b79a71383658276c78fedca0a93', 'i:1;', 1762132368),
('laravel-cache-764f8b79a71383658276c78fedca0a93:timer', 'i:1762132368;', 1762132368),
('laravel-cache-7696fa85246d0a1413c48c99af43d5c3', 'i:1;', 1762072512),
('laravel-cache-7696fa85246d0a1413c48c99af43d5c3:timer', 'i:1762072512;', 1762072512),
('laravel-cache-76ceccda5aebb43ba8f5241c0d9dced9', 'i:1;', 1762058277),
('laravel-cache-76ceccda5aebb43ba8f5241c0d9dced9:timer', 'i:1762058277;', 1762058277),
('laravel-cache-772a2f290472d3cbd3495380e383549d', 'i:1;', 1762061424),
('laravel-cache-772a2f290472d3cbd3495380e383549d:timer', 'i:1762061424;', 1762061424),
('laravel-cache-78339912cee36847b72cb7eeaedeba0e', 'i:1;', 1762178110),
('laravel-cache-78339912cee36847b72cb7eeaedeba0e:timer', 'i:1762178110;', 1762178110),
('laravel-cache-7844ab5bb993adaf3a391c2ab8673986', 'i:1;', 1762240327),
('laravel-cache-7844ab5bb993adaf3a391c2ab8673986:timer', 'i:1762240327;', 1762240327),
('laravel-cache-78574d90d4419e4e3a2e0f8ff4c2ea0c', 'i:1;', 1762224428),
('laravel-cache-78574d90d4419e4e3a2e0f8ff4c2ea0c:timer', 'i:1762224428;', 1762224428),
('laravel-cache-7882a8b6d79c1819842e7b534d97b5d1', 'i:6;', 1762145712),
('laravel-cache-7882a8b6d79c1819842e7b534d97b5d1:timer', 'i:1762145712;', 1762145712),
('laravel-cache-79ad371c99402c6582b3931abd87a4b2', 'i:1;', 1762243731),
('laravel-cache-79ad371c99402c6582b3931abd87a4b2:timer', 'i:1762243730;', 1762243730),
('laravel-cache-79aee3f6eb6a4c85432bde0e6956f4ca', 'i:1;', 1762211010),
('laravel-cache-79aee3f6eb6a4c85432bde0e6956f4ca:timer', 'i:1762211009;', 1762211010),
('laravel-cache-7aebff77a9a09c7ca7821949427fc2c3', 'i:1;', 1761974346),
('laravel-cache-7aebff77a9a09c7ca7821949427fc2c3:timer', 'i:1761974345;', 1761974345),
('laravel-cache-7c2c63721fb4a8a7a163c6dc0ffa284d', 'i:1;', 1762109297),
('laravel-cache-7c2c63721fb4a8a7a163c6dc0ffa284d:timer', 'i:1762109296;', 1762109296),
('laravel-cache-7ca312c8abb0dbf159905738bcca4aa2', 'i:1;', 1762117160),
('laravel-cache-7ca312c8abb0dbf159905738bcca4aa2:timer', 'i:1762117160;', 1762117160),
('laravel-cache-7d1ac01d6ad5edb83862531ded11f6fe', 'i:1;', 1762215967),
('laravel-cache-7d1ac01d6ad5edb83862531ded11f6fe:timer', 'i:1762215967;', 1762215967),
('laravel-cache-7d6d3bd3d9b634b7c8f293874b4f25d0', 'i:3;', 1761974465),
('laravel-cache-7d6d3bd3d9b634b7c8f293874b4f25d0:timer', 'i:1761974465;', 1761974465),
('laravel-cache-7d8709eeb79e4185793f3143d68059f2', 'i:2;', 1762056121),
('laravel-cache-7d8709eeb79e4185793f3143d68059f2:timer', 'i:1762056120;', 1762056120),
('laravel-cache-80ef93e2e07d0a43447dcf0d0af3fb74', 'i:1;', 1762235956),
('laravel-cache-80ef93e2e07d0a43447dcf0d0af3fb74:timer', 'i:1762235956;', 1762235956),
('laravel-cache-816a63f7e1a08234b7715b38611161d2', 'i:1;', 1761973478),
('laravel-cache-816a63f7e1a08234b7715b38611161d2:timer', 'i:1761973478;', 1761973478),
('laravel-cache-81809ff61eebee73cf76f701c0f01d8c', 'i:2;', 1761909140),
('laravel-cache-81809ff61eebee73cf76f701c0f01d8c:timer', 'i:1761909140;', 1761909140),
('laravel-cache-81ba560948a4ae53d18b581add2db4aa', 'i:1;', 1762177923),
('laravel-cache-81ba560948a4ae53d18b581add2db4aa:timer', 'i:1762177923;', 1762177923),
('laravel-cache-81c254a0a968d61e5c9b7239a22f9566', 'i:1;', 1761992297),
('laravel-cache-81c254a0a968d61e5c9b7239a22f9566:timer', 'i:1761992297;', 1761992297),
('laravel-cache-81f6b86c4f92970a4a9941913695001e', 'i:1;', 1762077750),
('laravel-cache-81f6b86c4f92970a4a9941913695001e:timer', 'i:1762077749;', 1762077749),
('laravel-cache-8315fe2b47eebd435017e19dfb3291f3', 'i:2;', 1762238699),
('laravel-cache-8315fe2b47eebd435017e19dfb3291f3:timer', 'i:1762238699;', 1762238699),
('laravel-cache-83453cf054625a463750e8fddd889470', 'i:1;', 1762039140),
('laravel-cache-83453cf054625a463750e8fddd889470:timer', 'i:1762039140;', 1762039140),
('laravel-cache-835f88923b635209859487ec9a6e4e4c', 'i:1;', 1762015776),
('laravel-cache-835f88923b635209859487ec9a6e4e4c:timer', 'i:1762015776;', 1762015776),
('laravel-cache-8362f2fd8f6e2df111cd25a2b324e1ce', 'i:1;', 1761951300),
('laravel-cache-8362f2fd8f6e2df111cd25a2b324e1ce:timer', 'i:1761951300;', 1761951300),
('laravel-cache-841c65787f2eb4e444142430677ece1d', 'i:1;', 1762223966),
('laravel-cache-841c65787f2eb4e444142430677ece1d:timer', 'i:1762223966;', 1762223966),
('laravel-cache-84601d181b240b902fc8296d3449ecf4', 'i:1;', 1762053698),
('laravel-cache-84601d181b240b902fc8296d3449ecf4:timer', 'i:1762053698;', 1762053698),
('laravel-cache-849d43f8db98b4547b0e5cd0bbef39ee', 'i:1;', 1761920945),
('laravel-cache-849d43f8db98b4547b0e5cd0bbef39ee:timer', 'i:1761920945;', 1761920945),
('laravel-cache-84df32cdba210bad67f321902121aa5c', 'i:1;', 1762181999),
('laravel-cache-84df32cdba210bad67f321902121aa5c:timer', 'i:1762181999;', 1762181999),
('laravel-cache-87188d0ad7845de23334bb88d5b3313f', 'i:1;', 1762063252),
('laravel-cache-87188d0ad7845de23334bb88d5b3313f:timer', 'i:1762063252;', 1762063252),
('laravel-cache-88226f548ee347e26c0339c4e8ba68c6', 'i:1;', 1762144295),
('laravel-cache-88226f548ee347e26c0339c4e8ba68c6:timer', 'i:1762144295;', 1762144295),
('laravel-cache-889839b5a0b5d6a7dabd04e5d663628c', 'i:2;', 1762057396),
('laravel-cache-889839b5a0b5d6a7dabd04e5d663628c:timer', 'i:1762057396;', 1762057396),
('laravel-cache-8910c1b3dbb234d7696d523906dd2378', 'i:1;', 1761977792),
('laravel-cache-8910c1b3dbb234d7696d523906dd2378:timer', 'i:1761977792;', 1761977792),
('laravel-cache-8942867eed5de601e0ed3a4355d199ef', 'i:1;', 1762107473),
('laravel-cache-8942867eed5de601e0ed3a4355d199ef:timer', 'i:1762107473;', 1762107473),
('laravel-cache-897f07f25d8fa26833bfcf90a59a6290', 'i:3;', 1762229347),
('laravel-cache-897f07f25d8fa26833bfcf90a59a6290:timer', 'i:1762229347;', 1762229347),
('laravel-cache-89d8a8bf7e4b877b781095f9c223d332', 'i:1;', 1762041161),
('laravel-cache-89d8a8bf7e4b877b781095f9c223d332:timer', 'i:1762041161;', 1762041161),
('laravel-cache-8a5ca0a95d68959e041ab9334d612f2b', 'i:1;', 1762223981),
('laravel-cache-8a5ca0a95d68959e041ab9334d612f2b:timer', 'i:1762223981;', 1762223981),
('laravel-cache-8a898977de9e104bb85d113b7f625068', 'i:1;', 1762228476),
('laravel-cache-8a898977de9e104bb85d113b7f625068:timer', 'i:1762228476;', 1762228476),
('laravel-cache-8a89a6298981a934f6e4ad11d45c1ed8', 'i:1;', 1762087970),
('laravel-cache-8a89a6298981a934f6e4ad11d45c1ed8:timer', 'i:1762087970;', 1762087970),
('laravel-cache-8b128ef84f6cf24a5ff6cb2cd1ec2f55', 'i:2;', 1762053749),
('laravel-cache-8b128ef84f6cf24a5ff6cb2cd1ec2f55:timer', 'i:1762053749;', 1762053749),
('laravel-cache-8b943eca0b19875682f7973f68e7c90b', 'i:1;', 1762069225),
('laravel-cache-8b943eca0b19875682f7973f68e7c90b:timer', 'i:1762069225;', 1762069225),
('laravel-cache-8bbd8ba5f57a9f69c5134d93d1a9e197', 'i:1;', 1762069434),
('laravel-cache-8bbd8ba5f57a9f69c5134d93d1a9e197:timer', 'i:1762069434;', 1762069434),
('laravel-cache-8d9d9a2c295b2360cd35ffcc71b68415', 'i:2;', 1762091818),
('laravel-cache-8d9d9a2c295b2360cd35ffcc71b68415:timer', 'i:1762091818;', 1762091818),
('laravel-cache-8e0751a5190270510ef32be861b1914c', 'i:1;', 1762045478),
('laravel-cache-8e0751a5190270510ef32be861b1914c:timer', 'i:1762045478;', 1762045478),
('laravel-cache-8e657ba74dfc85bfb156918c6d395bcf', 'i:1;', 1762057497),
('laravel-cache-8e657ba74dfc85bfb156918c6d395bcf:timer', 'i:1762057496;', 1762057496),
('laravel-cache-8e94cc4e1c808c3a20d0a85b46478df8', 'i:1;', 1762142260),
('laravel-cache-8e94cc4e1c808c3a20d0a85b46478df8:timer', 'i:1762142260;', 1762142260),
('laravel-cache-8ec0005387a68e6cae63b3d6aa535d8c', 'i:1;', 1762239386),
('laravel-cache-8ec0005387a68e6cae63b3d6aa535d8c:timer', 'i:1762239386;', 1762239386),
('laravel-cache-8ee2f9ef6558dff804e75782bebe62ff', 'i:1;', 1761978754),
('laravel-cache-8ee2f9ef6558dff804e75782bebe62ff:timer', 'i:1761978754;', 1761978754),
('laravel-cache-8f21146f9e1dbc28d46aab9af467b2d8', 'i:1;', 1761901365),
('laravel-cache-8f21146f9e1dbc28d46aab9af467b2d8:timer', 'i:1761901365;', 1761901365),
('laravel-cache-8f2bf83659d21f80c7b408ffbce3fc20', 'i:1;', 1762120029),
('laravel-cache-8f2bf83659d21f80c7b408ffbce3fc20:timer', 'i:1762120029;', 1762120029),
('laravel-cache-8fc3462fef35d841c8043526a6f20c0c', 'i:1;', 1762140016),
('laravel-cache-8fc3462fef35d841c8043526a6f20c0c:timer', 'i:1762140016;', 1762140016),
('laravel-cache-8fe800a99b2befab1c47fb126e62db95', 'i:1;', 1761977002),
('laravel-cache-8fe800a99b2befab1c47fb126e62db95:timer', 'i:1761977002;', 1761977002),
('laravel-cache-90caf244aa5a6d3f32a5a03ed049b05c', 'i:1;', 1762208709),
('laravel-cache-90caf244aa5a6d3f32a5a03ed049b05c:timer', 'i:1762208708;', 1762208708),
('laravel-cache-90ddf34c0fbc3fc38c2677ead4fb5909', 'i:1;', 1762181274),
('laravel-cache-90ddf34c0fbc3fc38c2677ead4fb5909:timer', 'i:1762181274;', 1762181274),
('laravel-cache-915f57c03d6ce515c239b347b9f1d84c', 'i:1;', 1762152891),
('laravel-cache-915f57c03d6ce515c239b347b9f1d84c:timer', 'i:1762152891;', 1762152891),
('laravel-cache-91f41c38d3a204fe119d13d5812b32e4', 'i:1;', 1762238508),
('laravel-cache-91f41c38d3a204fe119d13d5812b32e4:timer', 'i:1762238508;', 1762238508),
('laravel-cache-924226cff908bbc495d24fab988b590e', 'i:1;', 1762221772),
('laravel-cache-924226cff908bbc495d24fab988b590e:timer', 'i:1762221772;', 1762221772),
('laravel-cache-931f05d6f4c8fce5ca2fd9104f5b9d0e', 'i:1;', 1762181902),
('laravel-cache-931f05d6f4c8fce5ca2fd9104f5b9d0e:timer', 'i:1762181902;', 1762181902),
('laravel-cache-93641d1d5517e313114f941ace17be3a', 'i:1;', 1762223444),
('laravel-cache-93641d1d5517e313114f941ace17be3a:timer', 'i:1762223444;', 1762223444),
('laravel-cache-936be705fffaa2c394f606c2f2cc4fab', 'i:1;', 1762067537),
('laravel-cache-936be705fffaa2c394f606c2f2cc4fab:timer', 'i:1762067537;', 1762067537),
('laravel-cache-9396ffd4e918331c5b308743a19d178a', 'i:1;', 1762242189),
('laravel-cache-9396ffd4e918331c5b308743a19d178a:timer', 'i:1762242188;', 1762242188),
('laravel-cache-947897dc8f7abc9825f8fafae71a7206', 'i:1;', 1762064606),
('laravel-cache-947897dc8f7abc9825f8fafae71a7206:timer', 'i:1762064606;', 1762064606),
('laravel-cache-947b3d54d01dc5db9f2ba9949dd9c263', 'i:1;', 1762111234),
('laravel-cache-947b3d54d01dc5db9f2ba9949dd9c263:timer', 'i:1762111233;', 1762111233),
('laravel-cache-948e1362059538526a47e172d6dc8bf4', 'i:1;', 1762053034),
('laravel-cache-948e1362059538526a47e172d6dc8bf4:timer', 'i:1762053034;', 1762053034),
('laravel-cache-94c7177a41ce4a4f0c5759a5009ad7cb', 'i:1;', 1762064550),
('laravel-cache-94c7177a41ce4a4f0c5759a5009ad7cb:timer', 'i:1762064550;', 1762064550),
('laravel-cache-958fe46711bd35ce657af0f4d92d757f', 'i:1;', 1761919605),
('laravel-cache-958fe46711bd35ce657af0f4d92d757f:timer', 'i:1761919605;', 1761919605),
('laravel-cache-959121ac5c4fc88f9ddced5fe3715ff0', 'i:1;', 1762104993),
('laravel-cache-959121ac5c4fc88f9ddced5fe3715ff0:timer', 'i:1762104993;', 1762104993),
('laravel-cache-95d181e451e4424e7c8201c6c600c90c', 'i:1;', 1762238131),
('laravel-cache-95d181e451e4424e7c8201c6c600c90c:timer', 'i:1762238131;', 1762238131),
('laravel-cache-96ca0a0c2bf0db349af4cf2d17ba0e2c', 'i:1;', 1762222469),
('laravel-cache-96ca0a0c2bf0db349af4cf2d17ba0e2c:timer', 'i:1762222468;', 1762222468),
('laravel-cache-96d4c03468529cb69eff34e03033a64b', 'i:1;', 1762153220),
('laravel-cache-96d4c03468529cb69eff34e03033a64b:timer', 'i:1762153220;', 1762153220),
('laravel-cache-96eb2626daec5af948310cec9e8c5621', 'i:1;', 1762243112),
('laravel-cache-96eb2626daec5af948310cec9e8c5621:timer', 'i:1762243112;', 1762243112),
('laravel-cache-97e4358467af295b7d4d81acf41ce8b6', 'i:1;', 1762066349),
('laravel-cache-97e4358467af295b7d4d81acf41ce8b6:timer', 'i:1762066349;', 1762066349),
('laravel-cache-97eb7a144d7eb03c1fdd4668bf406759', 'i:1;', 1762183832),
('laravel-cache-97eb7a144d7eb03c1fdd4668bf406759:timer', 'i:1762183832;', 1762183832),
('laravel-cache-980004052b3f1df4d4ee1a3d4283a890', 'i:1;', 1761999780),
('laravel-cache-980004052b3f1df4d4ee1a3d4283a890:timer', 'i:1761999780;', 1761999780),
('laravel-cache-9887734d088c30ec3f825272cb558506', 'i:1;', 1762011853),
('laravel-cache-9887734d088c30ec3f825272cb558506:timer', 'i:1762011853;', 1762011853),
('laravel-cache-988975be01f73c4723e3ee62b418ac63', 'i:2;', 1761917491),
('laravel-cache-988975be01f73c4723e3ee62b418ac63:timer', 'i:1761917491;', 1761917491),
('laravel-cache-98c85a50039c4ba507b0705005401610', 'i:2;', 1761977019),
('laravel-cache-98c85a50039c4ba507b0705005401610:timer', 'i:1761977018;', 1761977018),
('laravel-cache-98f710c9b6a39d4f2c8f4ef4af35b8eb', 'i:1;', 1761918358),
('laravel-cache-98f710c9b6a39d4f2c8f4ef4af35b8eb:timer', 'i:1761918358;', 1761918358),
('laravel-cache-992e070c0438ad21e155a1950065735e', 'i:2;', 1761977984),
('laravel-cache-992e070c0438ad21e155a1950065735e:timer', 'i:1761977984;', 1761977984),
('laravel-cache-998a440a528761ba43fcfea27f8255ad', 'i:1;', 1761921719),
('laravel-cache-998a440a528761ba43fcfea27f8255ad:timer', 'i:1761921719;', 1761921719),
('laravel-cache-99b48264b6fba8ed4b1484cf58d9647a', 'i:1;', 1761982493),
('laravel-cache-99b48264b6fba8ed4b1484cf58d9647a:timer', 'i:1761982492;', 1761982492),
('laravel-cache-9b8b78f077cd629a7eab0915d69465db', 'i:1;', 1762228688),
('laravel-cache-9b8b78f077cd629a7eab0915d69465db:timer', 'i:1762228688;', 1762228688),
('laravel-cache-9ba6571971cb39f8230b991d841d1d5e', 'i:1;', 1761971310),
('laravel-cache-9ba6571971cb39f8230b991d841d1d5e:timer', 'i:1761971309;', 1761971309),
('laravel-cache-9bfc4465e5a07dd9529ba63afa071a4a', 'i:1;', 1762229040),
('laravel-cache-9bfc4465e5a07dd9529ba63afa071a4a:timer', 'i:1762229040;', 1762229040),
('laravel-cache-9c670ef29b85a4e2747d82bf9fae0eef', 'i:2;', 1762215218),
('laravel-cache-9c670ef29b85a4e2747d82bf9fae0eef:timer', 'i:1762215218;', 1762215218),
('laravel-cache-9c9294859562553d1341c10731aabc33', 'i:1;', 1762179844),
('laravel-cache-9c9294859562553d1341c10731aabc33:timer', 'i:1762179844;', 1762179844),
('laravel-cache-9cef9043408211bc9a2032d984711552', 'i:1;', 1762151566),
('laravel-cache-9cef9043408211bc9a2032d984711552:timer', 'i:1762151565;', 1762151565),
('laravel-cache-9d374d7a7b12578fbd448d79f3b73a7f', 'i:1;', 1762067896),
('laravel-cache-9d374d7a7b12578fbd448d79f3b73a7f:timer', 'i:1762067896;', 1762067896),
('laravel-cache-9dded9fe309f01c8d871c8b05e45614e', 'i:3;', 1761977874),
('laravel-cache-9dded9fe309f01c8d871c8b05e45614e:timer', 'i:1761977874;', 1761977874),
('laravel-cache-9f236c8fc4a9b8a3334d49df7ffebfb6', 'i:1;', 1762228701),
('laravel-cache-9f236c8fc4a9b8a3334d49df7ffebfb6:timer', 'i:1762228701;', 1762228701),
('laravel-cache-9f8453a4615aa753434e4730a606be85', 'i:1;', 1762103804),
('laravel-cache-9f8453a4615aa753434e4730a606be85:timer', 'i:1762103804;', 1762103804),
('laravel-cache-9fc5af7885094bfa3a8f027dd5ca58cc', 'i:1;', 1762239804),
('laravel-cache-9fc5af7885094bfa3a8f027dd5ca58cc:timer', 'i:1762239803;', 1762239803),
('laravel-cache-a006833e2dd34c49b9eb2e5ddb97e0a6', 'i:1;', 1762011884),
('laravel-cache-a006833e2dd34c49b9eb2e5ddb97e0a6:timer', 'i:1762011884;', 1762011884),
('laravel-cache-a0564798df7964ae64ad5643670e8ffa', 'i:1;', 1762077201),
('laravel-cache-a0564798df7964ae64ad5643670e8ffa:timer', 'i:1762077201;', 1762077201),
('laravel-cache-a0aeb47c51448122e339c92caf3f800f', 'i:1;', 1762005047),
('laravel-cache-a0aeb47c51448122e339c92caf3f800f:timer', 'i:1762005047;', 1762005047),
('laravel-cache-a0d9260f2539303a21e029f734e3282a', 'i:2;', 1762229699),
('laravel-cache-a0d9260f2539303a21e029f734e3282a:timer', 'i:1762229699;', 1762229699),
('laravel-cache-a137136c2ee9ac77c77db67b206b1561', 'i:3;', 1762202443),
('laravel-cache-a137136c2ee9ac77c77db67b206b1561:timer', 'i:1762202443;', 1762202443),
('laravel-cache-a156d900d7ea13439b1519468d9a582f', 'i:1;', 1762049621),
('laravel-cache-a156d900d7ea13439b1519468d9a582f:timer', 'i:1762049621;', 1762049621),
('laravel-cache-a174ed1e97a1511cef26c433a3db05e3', 'i:1;', 1762229040),
('laravel-cache-a174ed1e97a1511cef26c433a3db05e3:timer', 'i:1762229040;', 1762229040),
('laravel-cache-a23e79041d29ae0d7033e2cc9c30409d', 'i:1;', 1761917322),
('laravel-cache-a23e79041d29ae0d7033e2cc9c30409d:timer', 'i:1761917322;', 1761917322),
('laravel-cache-a32b704c1fe1f1502f0078c912a1b687', 'i:1;', 1762228880),
('laravel-cache-a32b704c1fe1f1502f0078c912a1b687:timer', 'i:1762228880;', 1762228880),
('laravel-cache-a3ac8a925334f62699b526dca0c9f91f', 'i:1;', 1762132735),
('laravel-cache-a3ac8a925334f62699b526dca0c9f91f:timer', 'i:1762132735;', 1762132735),
('laravel-cache-a3eea1f2f17a8884540464856889fe74', 'i:1;', 1762023631),
('laravel-cache-a3eea1f2f17a8884540464856889fe74:timer', 'i:1762023630;', 1762023630),
('laravel-cache-a4b0ddbc902fdcc0ea8a7a3ccabd529a', 'i:1;', 1761979018),
('laravel-cache-a4b0ddbc902fdcc0ea8a7a3ccabd529a:timer', 'i:1761979017;', 1761979018),
('laravel-cache-a4c588d2367d54b65ab0bcdb8361550f', 'i:1;', 1762064392),
('laravel-cache-a4c588d2367d54b65ab0bcdb8361550f:timer', 'i:1762064392;', 1762064392),
('laravel-cache-a4c964cad4f665baf25c476729accf87', 'i:1;', 1761993515),
('laravel-cache-a4c964cad4f665baf25c476729accf87:timer', 'i:1761993515;', 1761993515),
('laravel-cache-a554430e94945cee52dc41d423e21e9a', 'i:1;', 1762116677),
('laravel-cache-a554430e94945cee52dc41d423e21e9a:timer', 'i:1762116677;', 1762116677),
('laravel-cache-a5e54058c2dd9814ef0d778270f8f613', 'i:1;', 1762056992),
('laravel-cache-a5e54058c2dd9814ef0d778270f8f613:timer', 'i:1762056992;', 1762056992),
('laravel-cache-a6b1e2a3da9525e2f06d3244cfcefc1c', 'i:1;', 1762211967),
('laravel-cache-a6b1e2a3da9525e2f06d3244cfcefc1c:timer', 'i:1762211967;', 1762211967),
('laravel-cache-a6b5926a9c227eef7ab069d0531bcd9a', 'i:1;', 1762211329),
('laravel-cache-a6b5926a9c227eef7ab069d0531bcd9a:timer', 'i:1762211328;', 1762211328);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-a6f9d4c41e1f7dd1bb594a8ebd13e783', 'i:1;', 1762138755),
('laravel-cache-a6f9d4c41e1f7dd1bb594a8ebd13e783:timer', 'i:1762138755;', 1762138755),
('laravel-cache-a7244eb8d96d906ce5e56bfd71b52f58', 'i:1;', 1762057125),
('laravel-cache-a7244eb8d96d906ce5e56bfd71b52f58:timer', 'i:1762057124;', 1762057124),
('laravel-cache-a7be3c1b08370538b62ee43a0d67183d', 'i:1;', 1762055462),
('laravel-cache-a7be3c1b08370538b62ee43a0d67183d:timer', 'i:1762055462;', 1762055462),
('laravel-cache-a834ee7518a2ec0760e07a820359b8e8', 'i:1;', 1762153089),
('laravel-cache-a834ee7518a2ec0760e07a820359b8e8:timer', 'i:1762153089;', 1762153089),
('laravel-cache-a863386d5f61557b937c14ba4cc1a71f', 'i:1;', 1762212042),
('laravel-cache-a863386d5f61557b937c14ba4cc1a71f:timer', 'i:1762212042;', 1762212042),
('laravel-cache-abb00804c213e1680735a3ebb91a28b6', 'i:1;', 1761917216),
('laravel-cache-abb00804c213e1680735a3ebb91a28b6:timer', 'i:1761917216;', 1761917216),
('laravel-cache-ad6bae88409e083afe41a4a64de83207', 'i:1;', 1762109381),
('laravel-cache-ad6bae88409e083afe41a4a64de83207:timer', 'i:1762109381;', 1762109381),
('laravel-cache-adb33f280c6568db5f320a8f3ad78d71', 'i:1;', 1762056183),
('laravel-cache-adb33f280c6568db5f320a8f3ad78d71:timer', 'i:1762056182;', 1762056182),
('laravel-cache-ae048c35a6499c312a6f8771d49f0765', 'i:1;', 1762215688),
('laravel-cache-ae048c35a6499c312a6f8771d49f0765:timer', 'i:1762215688;', 1762215688),
('laravel-cache-ae10b803db0d9301529da65ec8a6d0ea', 'i:1;', 1762069302),
('laravel-cache-ae10b803db0d9301529da65ec8a6d0ea:timer', 'i:1762069302;', 1762069302),
('laravel-cache-ae7a2fea0ca0cd5065dbb1c17535e5a8', 'i:1;', 1762137866),
('laravel-cache-ae7a2fea0ca0cd5065dbb1c17535e5a8:timer', 'i:1762137866;', 1762137866),
('laravel-cache-ae98b3c3ea14b7ecceed8c60a837025d', 'i:1;', 1761994905),
('laravel-cache-ae98b3c3ea14b7ecceed8c60a837025d:timer', 'i:1761994905;', 1761994905),
('laravel-cache-af21e582059ff01ad570b61dfb381716', 'i:2;', 1762058596),
('laravel-cache-af21e582059ff01ad570b61dfb381716:timer', 'i:1762058596;', 1762058596),
('laravel-cache-af2d2a421f7c1f4c9b4164411ceb9eca', 'i:1;', 1761959168),
('laravel-cache-af2d2a421f7c1f4c9b4164411ceb9eca:timer', 'i:1761959168;', 1761959168),
('laravel-cache-af3af526d884ca16b0fb28a1f2244d59', 'i:1;', 1762136370),
('laravel-cache-af3af526d884ca16b0fb28a1f2244d59:timer', 'i:1762136370;', 1762136370),
('laravel-cache-b065a57472a41b465e31cf5057102332', 'i:1;', 1762241894),
('laravel-cache-b065a57472a41b465e31cf5057102332:timer', 'i:1762241892;', 1762241893),
('laravel-cache-b0ae9a237bab7c8edf33b96117693fc8', 'i:1;', 1762152647),
('laravel-cache-b0ae9a237bab7c8edf33b96117693fc8:timer', 'i:1762152647;', 1762152647),
('laravel-cache-b12bb5978343791f916a8701055f04de', 'i:2;', 1762056215),
('laravel-cache-b12bb5978343791f916a8701055f04de:timer', 'i:1762056215;', 1762056215),
('laravel-cache-b215985873a15f2609e727e48eb9c991', 'i:4;', 1762063181),
('laravel-cache-b215985873a15f2609e727e48eb9c991:timer', 'i:1762063181;', 1762063181),
('laravel-cache-b2970642587a09c21dcd3894cf1e6845', 'i:1;', 1762077032),
('laravel-cache-b2970642587a09c21dcd3894cf1e6845:timer', 'i:1762077032;', 1762077032),
('laravel-cache-b317a0c7921eb57b08ede4c3319dcb2e', 'i:1;', 1762080642),
('laravel-cache-b317a0c7921eb57b08ede4c3319dcb2e:timer', 'i:1762080642;', 1762080642),
('laravel-cache-b336c774e2586dfbe14130d3a0668bcd', 'i:1;', 1762091375),
('laravel-cache-b336c774e2586dfbe14130d3a0668bcd:timer', 'i:1762091375;', 1762091375),
('laravel-cache-b4334acbfc81f5d1b8c490f40b486cd9', 'i:1;', 1762053725),
('laravel-cache-b4334acbfc81f5d1b8c490f40b486cd9:timer', 'i:1762053725;', 1762053725),
('laravel-cache-b487d70f47a08b2769e2450b71f865fd', 'i:1;', 1762066575),
('laravel-cache-b487d70f47a08b2769e2450b71f865fd:timer', 'i:1762066575;', 1762066575),
('laravel-cache-b68ba5ca89af4e6b67ba2540d6997c50', 'i:1;', 1762215192),
('laravel-cache-b68ba5ca89af4e6b67ba2540d6997c50:timer', 'i:1762215192;', 1762215192),
('laravel-cache-b6a8c72a88c27a04468696d839222ba7', 'i:2;', 1762074853),
('laravel-cache-b6a8c72a88c27a04468696d839222ba7:timer', 'i:1762074853;', 1762074853),
('laravel-cache-b6b88eb290cadb8011965746d409c78b', 'i:1;', 1762068557),
('laravel-cache-b6b88eb290cadb8011965746d409c78b:timer', 'i:1762068557;', 1762068557),
('laravel-cache-b7ec483917f2c25a3ffeed277f67ef12', 'i:1;', 1762205516),
('laravel-cache-b7ec483917f2c25a3ffeed277f67ef12:timer', 'i:1762205516;', 1762205516),
('laravel-cache-b9ac0a73812bfb0605b4bbd1cb00080f', 'i:1;', 1762209145),
('laravel-cache-b9ac0a73812bfb0605b4bbd1cb00080f:timer', 'i:1762209144;', 1762209145),
('laravel-cache-bbda1b91cfc30458bee90769a6bc606f', 'i:1;', 1762000340),
('laravel-cache-bbda1b91cfc30458bee90769a6bc606f:timer', 'i:1762000340;', 1762000340),
('laravel-cache-bc59eea58fd97ae19620fe0385a25d25', 'i:1;', 1762133399),
('laravel-cache-bc59eea58fd97ae19620fe0385a25d25:timer', 'i:1762133399;', 1762133399),
('laravel-cache-bc78924b1c0a124763d6d1d755bd85b6', 'i:1;', 1761980189),
('laravel-cache-bc78924b1c0a124763d6d1d755bd85b6:timer', 'i:1761980189;', 1761980189),
('laravel-cache-bd0525ed50fb5cda739b17d7103f2280', 'i:2;', 1762243719),
('laravel-cache-bd0525ed50fb5cda739b17d7103f2280:timer', 'i:1762243719;', 1762243719),
('laravel-cache-bd3846554456de56e1edb1733c4fd688', 'i:1;', 1762212422),
('laravel-cache-bd3846554456de56e1edb1733c4fd688:timer', 'i:1762212422;', 1762212422),
('laravel-cache-bd42996116c78ca2d50e98279e2a8a2f', 'i:2;', 1762077806),
('laravel-cache-bd42996116c78ca2d50e98279e2a8a2f:timer', 'i:1762077806;', 1762077806),
('laravel-cache-bd74107b114380f0531511279c25e983', 'i:1;', 1762230489),
('laravel-cache-bd74107b114380f0531511279c25e983:timer', 'i:1762230489;', 1762230489),
('laravel-cache-bd7424fe08f6da85548f8fece9517e8c', 'i:1;', 1761994314),
('laravel-cache-bd7424fe08f6da85548f8fece9517e8c:timer', 'i:1761994313;', 1761994314),
('laravel-cache-bdd9d210f2aa8523bcd46fa61c8bd199', 'i:1;', 1762091206),
('laravel-cache-bdd9d210f2aa8523bcd46fa61c8bd199:timer', 'i:1762091206;', 1762091206),
('laravel-cache-be9ce113eaef91928b5a0437bbbdf109', 'i:2;', 1762208131),
('laravel-cache-be9ce113eaef91928b5a0437bbbdf109:timer', 'i:1762208130;', 1762208130),
('laravel-cache-bf4a1e0368758f63fc5ea91375a87eba', 'i:1;', 1762057753),
('laravel-cache-bf4a1e0368758f63fc5ea91375a87eba:timer', 'i:1762057753;', 1762057753),
('laravel-cache-bf5a8702fb384e49eb9c99750b1de783', 'i:1;', 1762134064),
('laravel-cache-bf5a8702fb384e49eb9c99750b1de783:timer', 'i:1762134064;', 1762134064),
('laravel-cache-c031d53ce6224773941fa564eaa80263', 'i:1;', 1762069366),
('laravel-cache-c031d53ce6224773941fa564eaa80263:timer', 'i:1762069366;', 1762069366),
('laravel-cache-c0667d741d6fced79740904a25fad883', 'i:2;', 1762067588),
('laravel-cache-c0667d741d6fced79740904a25fad883:timer', 'i:1762067588;', 1762067588),
('laravel-cache-c16e23720565fee8137436209481d2d2', 'i:1;', 1762008654),
('laravel-cache-c16e23720565fee8137436209481d2d2:timer', 'i:1762008654;', 1762008654),
('laravel-cache-c2e1004a7cea58007ba7008001cf5f9c', 'i:2;', 1762058871),
('laravel-cache-c2e1004a7cea58007ba7008001cf5f9c:timer', 'i:1762058871;', 1762058871),
('laravel-cache-c34a02d514f265b89d6f98fd9d4660d3', 'i:2;', 1762067835),
('laravel-cache-c34a02d514f265b89d6f98fd9d4660d3:timer', 'i:1762067835;', 1762067835),
('laravel-cache-c4470d91c4b8df101c823139e229bc39', 'i:2;', 1762069377),
('laravel-cache-c4470d91c4b8df101c823139e229bc39:timer', 'i:1762069377;', 1762069377),
('laravel-cache-c449e58b246470b6e665d896bfe8fbcc', 'i:2;', 1762078230),
('laravel-cache-c449e58b246470b6e665d896bfe8fbcc:timer', 'i:1762078230;', 1762078230),
('laravel-cache-c47652389aad278ef1a5354c3b187a30', 'i:1;', 1762121905),
('laravel-cache-c47652389aad278ef1a5354c3b187a30:timer', 'i:1762121905;', 1762121905),
('laravel-cache-c51b7ea9eb56e63a99bef68470ced9be', 'i:1;', 1762241038),
('laravel-cache-c51b7ea9eb56e63a99bef68470ced9be:timer', 'i:1762241038;', 1762241038),
('laravel-cache-c57f5be6d187782960906747e40ed0cd', 'i:1;', 1762065373),
('laravel-cache-c57f5be6d187782960906747e40ed0cd:timer', 'i:1762065373;', 1762065373),
('laravel-cache-c5af7ce0e6005f6a2f462f6436e87378', 'i:1;', 1762072806),
('laravel-cache-c5af7ce0e6005f6a2f462f6436e87378:timer', 'i:1762072806;', 1762072806),
('laravel-cache-c5db452247d117c59f2897d40471f85a', 'i:1;', 1762212460),
('laravel-cache-c5db452247d117c59f2897d40471f85a:timer', 'i:1762212459;', 1762212459),
('laravel-cache-c661d624bc915669f11edd6cecfe1d7b', 'i:1;', 1762091301),
('laravel-cache-c661d624bc915669f11edd6cecfe1d7b:timer', 'i:1762091300;', 1762091300),
('laravel-cache-c68b9afd7ed100b770af6a16248a4dcd', 'i:1;', 1762212296),
('laravel-cache-c68b9afd7ed100b770af6a16248a4dcd:timer', 'i:1762212296;', 1762212296),
('laravel-cache-c6a4c847be4c8930fef463a5e8fd19b6', 'i:1;', 1762055981),
('laravel-cache-c6a4c847be4c8930fef463a5e8fd19b6:timer', 'i:1762055981;', 1762055981),
('laravel-cache-c6eb18cccb771db4a1d536a949f04533', 'i:1;', 1762061728),
('laravel-cache-c6eb18cccb771db4a1d536a949f04533:timer', 'i:1762061728;', 1762061728),
('laravel-cache-c70078c09570be740e2454b326d060f3', 'i:1;', 1762100288),
('laravel-cache-c70078c09570be740e2454b326d060f3:timer', 'i:1762100288;', 1762100288),
('laravel-cache-c7283c03a93a2e771035bf4284341611', 'i:1;', 1761959392),
('laravel-cache-c7283c03a93a2e771035bf4284341611:timer', 'i:1761959392;', 1761959392),
('laravel-cache-c794cc00b78572bf3f1c18c3e5574934', 'i:1;', 1762169149),
('laravel-cache-c794cc00b78572bf3f1c18c3e5574934:timer', 'i:1762169149;', 1762169149),
('laravel-cache-c7a935251641d347aeb979708ae71a7f', 'i:1;', 1762074644),
('laravel-cache-c7a935251641d347aeb979708ae71a7f:timer', 'i:1762074644;', 1762074644),
('laravel-cache-c7b18515e5da4a3dc684bab584cf9d0e', 'i:1;', 1762053849),
('laravel-cache-c7b18515e5da4a3dc684bab584cf9d0e:timer', 'i:1762053848;', 1762053848),
('laravel-cache-c805485dc3b877a8aa210f1d44c15b34', 'i:1;', 1762056931),
('laravel-cache-c805485dc3b877a8aa210f1d44c15b34:timer', 'i:1762056931;', 1762056931),
('laravel-cache-c8d7fe508425cc16225a3b631da3fc8b', 'i:1;', 1762217885),
('laravel-cache-c8d7fe508425cc16225a3b631da3fc8b:timer', 'i:1762217885;', 1762217885),
('laravel-cache-c92d0287c80e5b341772af884251fb70', 'i:1;', 1762020762),
('laravel-cache-c92d0287c80e5b341772af884251fb70:timer', 'i:1762020762;', 1762020762),
('laravel-cache-ca3388268716b8d95873423e880c9155', 'i:1;', 1762057619),
('laravel-cache-ca3388268716b8d95873423e880c9155:timer', 'i:1762057618;', 1762057618),
('laravel-cache-ca96b04072e61fbcb0d2717a1e6707a5', 'i:1;', 1762227631),
('laravel-cache-ca96b04072e61fbcb0d2717a1e6707a5:timer', 'i:1762227631;', 1762227631),
('laravel-cache-cbc3d46119493dc72601421aa0bb8741', 'i:1;', 1762152211),
('laravel-cache-cbc3d46119493dc72601421aa0bb8741:timer', 'i:1762152210;', 1762152210),
('laravel-cache-cc123f9746756c4fe6dc1b3c8309c088', 'i:1;', 1761997011),
('laravel-cache-cc123f9746756c4fe6dc1b3c8309c088:timer', 'i:1761997011;', 1761997011),
('laravel-cache-cc4d6de61a4abbe993ba06064029eb65', 'i:1;', 1762212216),
('laravel-cache-cc4d6de61a4abbe993ba06064029eb65:timer', 'i:1762212216;', 1762212216),
('laravel-cache-cd310bd07bda7fe40a39bb3a6e8190fd', 'i:2;', 1761968866),
('laravel-cache-cd310bd07bda7fe40a39bb3a6e8190fd:timer', 'i:1761968866;', 1761968866),
('laravel-cache-cd3bdfbe4bf8b42bb357ad0f1facb760', 'i:1;', 1762155868),
('laravel-cache-cd3bdfbe4bf8b42bb357ad0f1facb760:timer', 'i:1762155868;', 1762155868),
('laravel-cache-cd8a0443754fd7c3f353497783f3970e', 'i:2;', 1762053289),
('laravel-cache-cd8a0443754fd7c3f353497783f3970e:timer', 'i:1762053289;', 1762053289),
('laravel-cache-ce43b649cb34f9d5586736c78d81efb0', 'i:1;', 1762151745),
('laravel-cache-ce43b649cb34f9d5586736c78d81efb0:timer', 'i:1762151745;', 1762151745),
('laravel-cache-cefad48a65d309f192825b6fec6a5c63', 'i:1;', 1762117513),
('laravel-cache-cefad48a65d309f192825b6fec6a5c63:timer', 'i:1762117513;', 1762117513),
('laravel-cache-d049fecd018b32e668b616c337f8092b', 'i:1;', 1762141957),
('laravel-cache-d049fecd018b32e668b616c337f8092b:timer', 'i:1762141957;', 1762141957),
('laravel-cache-d05a486ee6969417dee6641cefaf6fce', 'i:1;', 1762071066),
('laravel-cache-d05a486ee6969417dee6641cefaf6fce:timer', 'i:1762071066;', 1762071066),
('laravel-cache-d072a82868a237a367db0f8195817cc8', 'i:1;', 1762209725),
('laravel-cache-d072a82868a237a367db0f8195817cc8:timer', 'i:1762209725;', 1762209725),
('laravel-cache-d0e015391db1ba3073bcbedbec68bb7c', 'i:1;', 1762177620),
('laravel-cache-d0e015391db1ba3073bcbedbec68bb7c:timer', 'i:1762177620;', 1762177620),
('laravel-cache-d289370cfc4c5a4065e671f890d926d0', 'i:1;', 1761901484),
('laravel-cache-d289370cfc4c5a4065e671f890d926d0:timer', 'i:1761901483;', 1761901483),
('laravel-cache-d2b73741bf90de4e0e3b2686bbf6d7be', 'i:4;', 1762059132),
('laravel-cache-d2b73741bf90de4e0e3b2686bbf6d7be:timer', 'i:1762059132;', 1762059132),
('laravel-cache-d3033061f1beb764e4fb46da0174023a', 'i:1;', 1762153002),
('laravel-cache-d3033061f1beb764e4fb46da0174023a:timer', 'i:1762153002;', 1762153002),
('laravel-cache-d387baa64f29943edabe8bb3cf024e34', 'i:1;', 1762079993),
('laravel-cache-d387baa64f29943edabe8bb3cf024e34:timer', 'i:1762079993;', 1762079993),
('laravel-cache-d3a60c4aeb38a028b61f2fceb1bf9f04', 'i:1;', 1762208253),
('laravel-cache-d3a60c4aeb38a028b61f2fceb1bf9f04:timer', 'i:1762208252;', 1762208252),
('laravel-cache-d4057c6813c68fa1b999eefdf7cd99c7', 'i:1;', 1762238891),
('laravel-cache-d4057c6813c68fa1b999eefdf7cd99c7:timer', 'i:1762238890;', 1762238890),
('laravel-cache-d4694b92707ace4ce5f5d0b04090c683', 'i:2;', 1762056973),
('laravel-cache-d4694b92707ace4ce5f5d0b04090c683:timer', 'i:1762056973;', 1762056973),
('laravel-cache-d4ee96e6935b8cc301d994437fd8a4c0', 'i:1;', 1762231756),
('laravel-cache-d4ee96e6935b8cc301d994437fd8a4c0:timer', 'i:1762231756;', 1762231756),
('laravel-cache-d4fab5dd80401859b41af31b4c1d8658', 'i:1;', 1762015807),
('laravel-cache-d4fab5dd80401859b41af31b4c1d8658:timer', 'i:1762015807;', 1762015807),
('laravel-cache-d5b2008062b8f63ef1d546759a03b153', 'i:1;', 1761917839),
('laravel-cache-d5b2008062b8f63ef1d546759a03b153:timer', 'i:1761917839;', 1761917839),
('laravel-cache-d5fc38ea2dbb787a719907ebecc5ce61', 'i:3;', 1762182785),
('laravel-cache-d5fc38ea2dbb787a719907ebecc5ce61:timer', 'i:1762182785;', 1762182785),
('laravel-cache-d6079635c32047d02124cc61c1a4b834', 'i:1;', 1762003157),
('laravel-cache-d6079635c32047d02124cc61c1a4b834:timer', 'i:1762003157;', 1762003157),
('laravel-cache-d634ea8aaa11f20a49949d269278c6d5', 'i:1;', 1762238741),
('laravel-cache-d634ea8aaa11f20a49949d269278c6d5:timer', 'i:1762238741;', 1762238741),
('laravel-cache-d636f9d7562b48045c570779c54da376', 'i:1;', 1761995990),
('laravel-cache-d636f9d7562b48045c570779c54da376:timer', 'i:1761995990;', 1761995990),
('laravel-cache-d640bc34847b557b4029270e39758dc1', 'i:1;', 1762171870),
('laravel-cache-d640bc34847b557b4029270e39758dc1:timer', 'i:1762171870;', 1762171870),
('laravel-cache-d72790bd8f9312f9e43c620ce8ba3b70', 'i:1;', 1762179508),
('laravel-cache-d72790bd8f9312f9e43c620ce8ba3b70:timer', 'i:1762179508;', 1762179508),
('laravel-cache-d7855939b7780579674981b02adb39c9', 'i:1;', 1762228681),
('laravel-cache-d7855939b7780579674981b02adb39c9:timer', 'i:1762228681;', 1762228681),
('laravel-cache-d7b6a685b6f4bd8b841b68e1b775349a', 'i:1;', 1762183118),
('laravel-cache-d7b6a685b6f4bd8b841b68e1b775349a:timer', 'i:1762183117;', 1762183117),
('laravel-cache-d9734be95a5326006cac68062f2c9e41', 'i:2;', 1762210247),
('laravel-cache-d9734be95a5326006cac68062f2c9e41:timer', 'i:1762210247;', 1762210247),
('laravel-cache-d982bf1f61c8c1703134c1219b7f33bb', 'i:1;', 1762211305),
('laravel-cache-d982bf1f61c8c1703134c1219b7f33bb:timer', 'i:1762211305;', 1762211305),
('laravel-cache-d9e33e2730ad23ae49fc17bab6073c39', 'i:1;', 1762232438),
('laravel-cache-d9e33e2730ad23ae49fc17bab6073c39:timer', 'i:1762232438;', 1762232438),
('laravel-cache-da7d356aef15e7c3ec54ffb992633e57', 'i:1;', 1762230505),
('laravel-cache-da7d356aef15e7c3ec54ffb992633e57:timer', 'i:1762230505;', 1762230505),
('laravel-cache-dbb95ebab4b178ab6e5c987a321a4088', 'i:1;', 1762182745),
('laravel-cache-dbb95ebab4b178ab6e5c987a321a4088:timer', 'i:1762182745;', 1762182745),
('laravel-cache-dbd63b70d29e8c3994f2224cb55b844c', 'i:1;', 1762176728),
('laravel-cache-dbd63b70d29e8c3994f2224cb55b844c:timer', 'i:1762176728;', 1762176728),
('laravel-cache-dbecc369fa8cbf75631d6e28207cc9ab', 'i:1;', 1762240292),
('laravel-cache-dbecc369fa8cbf75631d6e28207cc9ab:timer', 'i:1762240291;', 1762240292),
('laravel-cache-dbef41eca68908fdf481468abc745d21', 'i:1;', 1762138374),
('laravel-cache-dbef41eca68908fdf481468abc745d21:timer', 'i:1762138373;', 1762138374),
('laravel-cache-dc0596c4d9d90e8218c20dcc04c87509', 'i:2;', 1762215255),
('laravel-cache-dc0596c4d9d90e8218c20dcc04c87509:timer', 'i:1762215255;', 1762215255),
('laravel-cache-dc59fb0ef8f36bc78b7ef3a4825730c4', 'i:1;', 1762223288),
('laravel-cache-dc59fb0ef8f36bc78b7ef3a4825730c4:timer', 'i:1762223288;', 1762223288),
('laravel-cache-dd65c0bfccb33eb2c672ff3eabeb1551', 'i:1;', 1762061556),
('laravel-cache-dd65c0bfccb33eb2c672ff3eabeb1551:timer', 'i:1762061556;', 1762061556),
('laravel-cache-dd876bdf54b2fddc108841d27c65de17', 'i:1;', 1762142925),
('laravel-cache-dd876bdf54b2fddc108841d27c65de17:timer', 'i:1762142925;', 1762142925),
('laravel-cache-dd8a409fbdb077979baa433eae1650e2', 'i:1;', 1762064681),
('laravel-cache-dd8a409fbdb077979baa433eae1650e2:timer', 'i:1762064681;', 1762064681),
('laravel-cache-ddcd4a4bca020cba0dbfeb0f6252ed5b', 'i:1;', 1762133312),
('laravel-cache-ddcd4a4bca020cba0dbfeb0f6252ed5b:timer', 'i:1762133311;', 1762133311),
('laravel-cache-ddd0b840ad0432393583158cf31e55a2', 'i:1;', 1762229185),
('laravel-cache-ddd0b840ad0432393583158cf31e55a2:timer', 'i:1762229185;', 1762229185),
('laravel-cache-de12f11d6124093010e193d3c9dcd0e9', 'i:2;', 1762158256),
('laravel-cache-de12f11d6124093010e193d3c9dcd0e9:timer', 'i:1762158256;', 1762158256),
('laravel-cache-de60598194611d0e761cbb90e14879df', 'i:1;', 1761919629),
('laravel-cache-de60598194611d0e761cbb90e14879df:timer', 'i:1761919629;', 1761919629),
('laravel-cache-de7da510c65da3ee9864ec6d3c9f25ed', 'i:2;', 1762243112),
('laravel-cache-de7da510c65da3ee9864ec6d3c9f25ed:timer', 'i:1762243112;', 1762243112),
('laravel-cache-de8b68b1f24415932d62d590bd916533', 'i:1;', 1762100350),
('laravel-cache-de8b68b1f24415932d62d590bd916533:timer', 'i:1762100350;', 1762100350),
('laravel-cache-dfd769c9c82caae95e8d19cd5d0fcc10', 'i:2;', 1762211410),
('laravel-cache-dfd769c9c82caae95e8d19cd5d0fcc10:timer', 'i:1762211410;', 1762211410),
('laravel-cache-e0b36b9d6a1f3ee4ce9c907a6a8fa782', 'i:1;', 1762243103),
('laravel-cache-e0b36b9d6a1f3ee4ce9c907a6a8fa782:timer', 'i:1762243103;', 1762243103),
('laravel-cache-e0d1ff8fbdbfff353cc6c033ef8ad30b', 'i:1;', 1762067728),
('laravel-cache-e0d1ff8fbdbfff353cc6c033ef8ad30b:timer', 'i:1762067728;', 1762067728),
('laravel-cache-e25eabadf7f4e7eb6aba24368e700c55', 'i:1;', 1762081705),
('laravel-cache-e25eabadf7f4e7eb6aba24368e700c55:timer', 'i:1762081705;', 1762081705),
('laravel-cache-e3825d143af8f3228833cef7dcfe9d57', 'i:1;', 1762223970),
('laravel-cache-e3825d143af8f3228833cef7dcfe9d57:timer', 'i:1762223970;', 1762223970),
('laravel-cache-e4ed787b2d50ccf0cbd5236f7fc6e652', 'i:1;', 1762082803),
('laravel-cache-e4ed787b2d50ccf0cbd5236f7fc6e652:timer', 'i:1762082803;', 1762082803),
('laravel-cache-e5212b6ea2e9a98d0ee4bc8937471790', 'i:1;', 1762228908),
('laravel-cache-e5212b6ea2e9a98d0ee4bc8937471790:timer', 'i:1762228908;', 1762228908),
('laravel-cache-e5c2e78f5effceb45c6dc05983f0f9e0', 'i:1;', 1761992339),
('laravel-cache-e5c2e78f5effceb45c6dc05983f0f9e0:timer', 'i:1761992339;', 1761992339),
('laravel-cache-e617eb21278fca14d1a85370c185319b', 'i:1;', 1762177720),
('laravel-cache-e617eb21278fca14d1a85370c185319b:timer', 'i:1762177720;', 1762177720),
('laravel-cache-e69706ce597524de6de42606be4a9877', 'i:1;', 1762212815),
('laravel-cache-e69706ce597524de6de42606be4a9877:timer', 'i:1762212814;', 1762212814),
('laravel-cache-e7005636cc18de86dfd18074ab0f936d', 'i:1;', 1762183235),
('laravel-cache-e7005636cc18de86dfd18074ab0f936d:timer', 'i:1762183235;', 1762183235),
('laravel-cache-e7634d973432e5bc4974b13ee1831f0c', 'i:2;', 1762219883),
('laravel-cache-e7634d973432e5bc4974b13ee1831f0c:timer', 'i:1762219883;', 1762219883),
('laravel-cache-e7b030b7aedb9dabc35a2189e7e0bc19', 'i:1;', 1761982416),
('laravel-cache-e7b030b7aedb9dabc35a2189e7e0bc19:timer', 'i:1761982416;', 1761982416),
('laravel-cache-eac4658b652c956e6ff9afadaa7757fc', 'i:1;', 1762180556),
('laravel-cache-eac4658b652c956e6ff9afadaa7757fc:timer', 'i:1762180556;', 1762180556),
('laravel-cache-eba4b2adb2703002045dc81574efcf0a', 'i:1;', 1762069577),
('laravel-cache-eba4b2adb2703002045dc81574efcf0a:timer', 'i:1762069577;', 1762069577),
('laravel-cache-ec5066f22df7978aa77ea307b11eef9c', 'i:1;', 1762059395),
('laravel-cache-ec5066f22df7978aa77ea307b11eef9c:timer', 'i:1762059395;', 1762059395),
('laravel-cache-ec87616625bacc07454f2af01923123f', 'i:1;', 1762221592),
('laravel-cache-ec87616625bacc07454f2af01923123f:timer', 'i:1762221591;', 1762221591),
('laravel-cache-ecc223d530099decf696a7fba0fbd304', 'i:1;', 1762205798),
('laravel-cache-ecc223d530099decf696a7fba0fbd304:timer', 'i:1762205798;', 1762205798),
('laravel-cache-ecfb5bb6296ffae5ce2ad005e7e8bf29', 'i:1;', 1762138763),
('laravel-cache-ecfb5bb6296ffae5ce2ad005e7e8bf29:timer', 'i:1762138763;', 1762138763),
('laravel-cache-ed2eb2a07012073eb1626bde2cf604ff', 'i:1;', 1762066834),
('laravel-cache-ed2eb2a07012073eb1626bde2cf604ff:timer', 'i:1762066834;', 1762066834),
('laravel-cache-ee3cf8115350cb901c10bf045271de05', 'i:1;', 1762228484),
('laravel-cache-ee3cf8115350cb901c10bf045271de05:timer', 'i:1762228484;', 1762228484),
('laravel-cache-ee6b47796519e153fc9f185c9d492224', 'i:1;', 1762042366),
('laravel-cache-ee6b47796519e153fc9f185c9d492224:timer', 'i:1762042366;', 1762042366),
('laravel-cache-ee783fd9cdd272264e5f390f337815cd', 'i:1;', 1761997091),
('laravel-cache-ee783fd9cdd272264e5f390f337815cd:timer', 'i:1761997091;', 1761997091),
('laravel-cache-ef05f310561cf8db3ab31af01d86f855', 'i:1;', 1762228481),
('laravel-cache-ef05f310561cf8db3ab31af01d86f855:timer', 'i:1762228481;', 1762228481),
('laravel-cache-f14493cf2adcfc8c2aad34908b20b123', 'i:1;', 1762211075),
('laravel-cache-f14493cf2adcfc8c2aad34908b20b123:timer', 'i:1762211074;', 1762211074),
('laravel-cache-f1bf0ef40786efe0c690b586736a5271', 'i:1;', 1762016341),
('laravel-cache-f1bf0ef40786efe0c690b586736a5271:timer', 'i:1762016341;', 1762016341),
('laravel-cache-f201c6fae210fbef5a31d50dfd19d9ff', 'i:1;', 1761901353),
('laravel-cache-f201c6fae210fbef5a31d50dfd19d9ff:timer', 'i:1761901353;', 1761901353),
('laravel-cache-f37b7495b3185e3b038c953e53eaf6fd', 'i:2;', 1762045395),
('laravel-cache-f37b7495b3185e3b038c953e53eaf6fd:timer', 'i:1762045395;', 1762045395),
('laravel-cache-f4125616280740a8baf7ec7734e19319', 'i:1;', 1762242155),
('laravel-cache-f4125616280740a8baf7ec7734e19319:timer', 'i:1762242155;', 1762242155),
('laravel-cache-f438225e9b69a6fe0cea1d93e8416a12', 'i:1;', 1762061531),
('laravel-cache-f438225e9b69a6fe0cea1d93e8416a12:timer', 'i:1762061531;', 1762061531),
('laravel-cache-f5125343f10579be28c1b71e19f5b0b1', 'i:2;', 1762069910),
('laravel-cache-f5125343f10579be28c1b71e19f5b0b1:timer', 'i:1762069910;', 1762069910),
('laravel-cache-f54f8f01365ff2dfbfb16b14988e4248', 'i:5;', 1762142279),
('laravel-cache-f54f8f01365ff2dfbfb16b14988e4248:timer', 'i:1762142279;', 1762142279),
('laravel-cache-f60688db607eca9325968f5458da3747', 'i:1;', 1762062658),
('laravel-cache-f60688db607eca9325968f5458da3747:timer', 'i:1762062658;', 1762062658),
('laravel-cache-f6b623ea0622876c72865bada2cbf271', 'i:1;', 1762243666),
('laravel-cache-f6b623ea0622876c72865bada2cbf271:timer', 'i:1762243666;', 1762243666),
('laravel-cache-f7285174344921a7dee1504bd7be328b', 'i:1;', 1762215949),
('laravel-cache-f7285174344921a7dee1504bd7be328b:timer', 'i:1762215949;', 1762215949),
('laravel-cache-f73106a52f910c3e88db63e8852443a1', 'i:1;', 1762178761),
('laravel-cache-f73106a52f910c3e88db63e8852443a1:timer', 'i:1762178761;', 1762178761),
('laravel-cache-f7603fdc63c4131e08c6092842cb4313', 'i:1;', 1761998901),
('laravel-cache-f7603fdc63c4131e08c6092842cb4313:timer', 'i:1761998900;', 1761998900),
('laravel-cache-f76669a7ef783b2e7685b758ff6a1ef9', 'i:1;', 1762229012),
('laravel-cache-f76669a7ef783b2e7685b758ff6a1ef9:timer', 'i:1762229012;', 1762229012),
('laravel-cache-f79d90004c6f9770eeba3283cabc3432', 'i:1;', 1762011092),
('laravel-cache-f79d90004c6f9770eeba3283cabc3432:timer', 'i:1762011092;', 1762011092),
('laravel-cache-f7c18a1cf227cf72f4b3d20873528453', 'i:1;', 1762219906),
('laravel-cache-f7c18a1cf227cf72f4b3d20873528453:timer', 'i:1762219906;', 1762219906),
('laravel-cache-f7e7d683025544d32f9844947e45f2f2', 'i:1;', 1762062011),
('laravel-cache-f7e7d683025544d32f9844947e45f2f2:timer', 'i:1762062011;', 1762062011),
('laravel-cache-f8668c73fa25390bfd86320460b80cbd', 'i:1;', 1762022044),
('laravel-cache-f8668c73fa25390bfd86320460b80cbd:timer', 'i:1762022044;', 1762022044),
('laravel-cache-f883faffbe0fffa816f7c64e695e3b4c', 'i:1;', 1762170142),
('laravel-cache-f883faffbe0fffa816f7c64e695e3b4c:timer', 'i:1762170142;', 1762170142),
('laravel-cache-f953ef749ea13e048646c82c344a0aa6', 'i:1;', 1762082480),
('laravel-cache-f953ef749ea13e048646c82c344a0aa6:timer', 'i:1762082480;', 1762082480),
('laravel-cache-f9d294a2708042addda7f9cb0fabc8eb', 'i:1;', 1761993156),
('laravel-cache-f9d294a2708042addda7f9cb0fabc8eb:timer', 'i:1761993156;', 1761993156),
('laravel-cache-fb53696a846bf100521ef9f6bcb35940', 'i:1;', 1762153068),
('laravel-cache-fb53696a846bf100521ef9f6bcb35940:timer', 'i:1762153068;', 1762153068),
('laravel-cache-fb58c6a658b74784f05bd07693fb4506', 'i:1;', 1762183145),
('laravel-cache-fb58c6a658b74784f05bd07693fb4506:timer', 'i:1762183145;', 1762183145),
('laravel-cache-fb9abc12fc611189700c8a20744cd16b', 'i:1;', 1762229181),
('laravel-cache-fb9abc12fc611189700c8a20744cd16b:timer', 'i:1762229181;', 1762229181),
('laravel-cache-fcca70af5e117eff2c8d4ff6f5b9891a', 'i:1;', 1761994483),
('laravel-cache-fcca70af5e117eff2c8d4ff6f5b9891a:timer', 'i:1761994483;', 1761994483),
('laravel-cache-fddddadedc036c7aa84e6284fb2e99c7', 'i:1;', 1762162567),
('laravel-cache-fddddadedc036c7aa84e6284fb2e99c7:timer', 'i:1762162567;', 1762162567),
('laravel-cache-ff0c0dbe14ca684446a0f7f8179a74a0', 'i:1;', 1762156373),
('laravel-cache-ff0c0dbe14ca684446a0f7f8179a74a0:timer', 'i:1762156373;', 1762156373);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_admin`
--

CREATE TABLE `detail_admin` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `divisi_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detail_admin`
--

INSERT INTO `detail_admin` (`id`, `user_id`, `divisi_id`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(2, 2, 2, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(3, 3, 4, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(4, 4, 6, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(5, 5, 2, '2025-10-31 15:59:05', '2025-10-31 15:59:05');

-- --------------------------------------------------------

--
-- Table structure for table `detail_peserta`
--

CREATE TABLE `detail_peserta` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_karyawan` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detail_peserta`
--

INSERT INTO `detail_peserta` (`id`, `user_id`, `foto`, `status_karyawan`, `created_at`, `updated_at`) VALUES
(1, 6, 'profile_photos/6909625342c81.jpg', 1, '2025-10-31 15:59:01', '2025-11-04 09:17:55'),
(2, 7, NULL, 0, '2025-10-31 15:59:02', '2025-10-31 15:59:02'),
(4, 7, 'https://via.placeholder.com/200x200.png?text=User+7', 0, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(5, 8, 'https://via.placeholder.com/200x200.png?text=User+8', 0, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(6, 9, 'https://via.placeholder.com/200x200.png?text=User+9', 1, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(7, 10, 'https://via.placeholder.com/200x200.png?text=User+10', 1, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(8, 11, 'https://via.placeholder.com/200x200.png?text=User+11', 1, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(9, 12, 'https://via.placeholder.com/200x200.png?text=User+12', 1, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(10, 13, 'https://via.placeholder.com/200x200.png?text=User+13', 1, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(11, 14, 'https://via.placeholder.com/200x200.png?text=User+14', 1, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(12, 15, 'https://via.placeholder.com/200x200.png?text=User+15', 0, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(13, 16, 'https://via.placeholder.com/200x200.png?text=User+16', 1, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(14, 17, 'https://via.placeholder.com/200x200.png?text=User+17', 1, '2025-10-31 15:59:05', '2025-10-31 15:59:05'),
(15, 18, 'profile_photos/6905f14a4d1ed.jpg', 0, '2025-10-31 16:01:45', '2025-11-01 18:38:50'),
(16, 19, NULL, 1, '2025-10-31 17:54:43', '2025-10-31 17:54:43'),
(17, 20, 'profile_photos/6906d72bc9514.jpg', 0, '2025-10-31 20:27:42', '2025-11-02 10:59:39'),
(18, 21, 'profile_photos/6907401eca279.jpg', 1, '2025-10-31 21:27:11', '2025-11-02 18:27:26'),
(19, 22, NULL, 0, '2025-11-01 08:05:09', '2025-11-01 08:05:09'),
(20, 23, NULL, 0, '2025-11-01 11:27:30', '2025-11-01 11:27:30'),
(21, 24, NULL, 0, '2025-11-01 12:18:06', '2025-11-01 12:18:06'),
(22, 25, NULL, 0, '2025-11-01 13:02:23', '2025-11-01 13:02:23'),
(23, 26, NULL, 0, '2025-11-01 13:15:33', '2025-11-01 13:15:33'),
(24, 27, NULL, 0, '2025-11-01 13:16:26', '2025-11-01 13:16:26'),
(25, 28, NULL, 0, '2025-11-01 13:31:35', '2025-11-01 13:31:35'),
(26, 29, 'profile_photos/6906d8c7093a6.jpg', 1, '2025-11-01 18:35:52', '2025-11-02 11:06:31'),
(27, 30, NULL, 0, '2025-11-01 20:48:35', '2025-11-01 20:48:35'),
(28, 31, NULL, 1, '2025-11-01 21:18:23', '2025-11-01 21:18:23'),
(29, 32, NULL, 1, '2025-11-01 22:44:45', '2025-11-01 22:44:45'),
(30, 33, NULL, 1, '2025-11-01 22:49:39', '2025-11-01 22:49:39'),
(31, 34, NULL, 1, '2025-11-02 08:02:22', '2025-11-02 08:02:22'),
(32, 35, NULL, 1, '2025-11-02 08:03:38', '2025-11-02 08:03:38'),
(33, 36, NULL, 1, '2025-11-02 10:12:47', '2025-11-02 10:12:47'),
(34, 37, NULL, 0, '2025-11-02 10:14:05', '2025-11-02 10:14:05'),
(35, 38, NULL, 0, '2025-11-02 11:08:33', '2025-11-02 11:08:33'),
(36, 39, 'profile_photos/69084c39622e2.jpg', 0, '2025-11-02 11:17:45', '2025-11-03 13:31:21'),
(37, 40, NULL, 0, '2025-11-02 11:25:38', '2025-11-02 11:25:38'),
(38, 41, 'profile_photos/6906ea90286d1.jpg', 0, '2025-11-02 11:39:58', '2025-11-02 12:22:24'),
(39, 42, 'profile_photos/6906f5896fe2d.jpg', 0, '2025-11-02 12:49:59', '2025-11-02 13:09:13'),
(40, 43, NULL, 0, '2025-11-02 14:11:17', '2025-11-02 14:11:17'),
(41, 44, NULL, 0, '2025-11-02 14:41:46', '2025-11-02 14:41:46'),
(42, 45, 'profile_photos/6907848faf3a1.jpg', 0, '2025-11-02 23:17:09', '2025-11-02 23:19:28'),
(43, 46, NULL, 0, '2025-11-03 01:46:50', '2025-11-03 01:46:50'),
(44, 47, NULL, 0, '2025-11-03 09:42:58', '2025-11-03 09:42:58'),
(45, 48, 'profile_photos/69081cfd0fc8f.jpg', 0, '2025-11-03 09:57:35', '2025-11-03 10:09:49'),
(46, 49, 'profile_photos/690979a611e5a.jpg', 0, '2025-11-03 10:17:49', '2025-11-04 10:57:26'),
(47, 50, 'profile_photos/69082ac5bc488.jpg', 0, '2025-11-03 11:07:07', '2025-11-03 11:08:37'),
(48, 51, NULL, 0, '2025-11-03 11:30:08', '2025-11-03 11:30:08'),
(49, 52, NULL, 1, '2025-11-03 11:57:58', '2025-11-03 11:57:58'),
(50, 53, 'profile_photos/6908493c4c5fe.jpg', 0, '2025-11-03 13:15:48', '2025-11-03 13:18:36'),
(51, 54, NULL, 0, '2025-11-03 13:52:36', '2025-11-03 13:52:36'),
(52, 55, NULL, 0, '2025-11-03 13:53:52', '2025-11-03 13:53:52'),
(53, 56, NULL, 0, '2025-11-03 13:56:06', '2025-11-03 13:56:06'),
(54, 57, NULL, 0, '2025-11-03 19:35:56', '2025-11-03 19:35:56'),
(55, 58, NULL, 0, '2025-11-03 20:49:39', '2025-11-03 20:49:39'),
(56, 59, 'profile_photos/69095ebe376b0.jpg', 1, '2025-11-03 20:51:32', '2025-11-04 09:02:38'),
(57, 60, NULL, 0, '2025-11-03 21:58:20', '2025-11-03 21:58:20'),
(58, 61, NULL, 0, '2025-11-04 04:52:23', '2025-11-04 04:52:23'),
(59, 62, NULL, 0, '2025-11-04 05:27:32', '2025-11-04 05:27:32'),
(60, 63, NULL, 0, '2025-11-04 05:33:23', '2025-11-04 05:33:23'),
(61, 64, NULL, 1, '2025-11-04 05:44:04', '2025-11-04 05:44:04'),
(62, 65, NULL, 1, '2025-11-04 06:07:15', '2025-11-04 06:07:15'),
(63, 66, 'profile_photos/690987679ca33.jpg', 1, '2025-11-04 06:07:25', '2025-11-04 11:56:07'),
(64, 67, 'profile_photos/69099e31955c0.jpg', 0, '2025-11-04 06:21:38', '2025-11-04 13:33:21'),
(65, 68, 'profile_photos/6909613950ce0.jpg', 0, '2025-11-04 07:12:12', '2025-11-04 09:13:13'),
(66, 69, NULL, 0, '2025-11-04 08:28:04', '2025-11-04 08:28:04'),
(67, 70, 'profile_photos/690959757e43e.jpg', 0, '2025-11-04 08:30:29', '2025-11-04 08:40:05'),
(68, 71, NULL, 0, '2025-11-04 08:58:27', '2025-11-04 08:58:27'),
(69, 72, NULL, 1, '2025-11-04 09:27:08', '2025-11-04 09:27:08'),
(70, 73, NULL, 1, '2025-11-04 09:29:44', '2025-11-04 09:29:44'),
(71, 74, NULL, 0, '2025-11-04 09:37:43', '2025-11-04 09:37:43'),
(72, 75, NULL, 0, '2025-11-04 09:37:57', '2025-11-04 09:37:57'),
(73, 76, NULL, 0, '2025-11-04 09:38:02', '2025-11-04 09:38:02'),
(74, 77, NULL, 0, '2025-11-04 09:45:38', '2025-11-04 09:45:38'),
(75, 78, 'profile_photos/690978ef3dce2.jpg', 0, '2025-11-04 10:38:20', '2025-11-04 10:54:23'),
(76, 79, NULL, 1, '2025-11-04 10:52:50', '2025-11-04 10:52:50'),
(77, 80, 'profile_photos/6909798cd3383.jpg', 0, '2025-11-04 10:52:59', '2025-11-04 10:57:01'),
(78, 81, NULL, 0, '2025-11-04 10:53:01', '2025-11-04 10:53:01'),
(79, 82, NULL, 0, '2025-11-04 10:55:27', '2025-11-04 10:55:27'),
(80, 83, NULL, 0, '2025-11-04 10:56:30', '2025-11-04 10:56:30'),
(81, 84, NULL, 0, '2025-11-04 10:56:39', '2025-11-04 10:56:39'),
(82, 85, NULL, 0, '2025-11-04 10:59:50', '2025-11-04 10:59:50'),
(83, 86, NULL, 0, '2025-11-04 10:59:51', '2025-11-04 10:59:51'),
(84, 87, NULL, 1, '2025-11-04 11:00:33', '2025-11-04 11:00:33'),
(85, 88, NULL, 0, '2025-11-04 11:02:07', '2025-11-04 11:02:07'),
(86, 89, 'profile_photos/69097d4d81d44.jpg', 0, '2025-11-04 11:02:33', '2025-11-04 11:13:01'),
(87, 90, NULL, 0, '2025-11-04 11:03:41', '2025-11-04 11:03:41'),
(88, 91, NULL, 0, '2025-11-04 11:26:51', '2025-11-04 11:26:51'),
(89, 92, 'profile_photos/69099a67c0f30.jpg', 0, '2025-11-04 12:57:53', '2025-11-04 13:17:12'),
(90, 93, NULL, 0, '2025-11-04 13:54:27', '2025-11-04 13:54:27'),
(91, 94, 'profile_photos/6909b1d207a0a.jpg', 1, '2025-11-04 14:01:17', '2025-11-04 14:57:06'),
(92, 95, NULL, 1, '2025-11-04 14:01:23', '2025-11-04 14:01:23'),
(93, 96, NULL, 1, '2025-11-04 14:09:43', '2025-11-04 14:09:43'),
(94, 97, NULL, 0, '2025-11-04 14:41:18', '2025-11-04 14:41:18'),
(95, 98, NULL, 1, '2025-11-04 14:53:02', '2025-11-04 14:53:02'),
(96, 99, NULL, 0, '2025-11-04 14:56:28', '2025-11-04 14:56:28'),
(97, 100, NULL, 1, '2025-11-04 15:06:46', '2025-11-04 15:06:46');

-- --------------------------------------------------------

--
-- Table structure for table `divisi`
--

CREATE TABLE `divisi` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `desc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `divisi`
--

INSERT INTO `divisi` (`id`, `nama`, `desc`, `created_at`, `updated_at`) VALUES
(1, 'Teknologi Informasi', 'Bertanggung jawab atas pengembangan dan pemeliharaan sistem teknologi informasi', '2025-10-31 15:59:00', '2025-10-31 15:59:00'),
(2, 'Sumber Daya Manusia', 'Mengelola semua aspek yang berkaitan dengan kepegawaian dan pengembangan SDM', '2025-10-31 15:59:00', '2025-10-31 15:59:00'),
(3, 'Keuangan', 'Mengelola perencanaan, pengendalian, dan pelaporan keuangan perusahaan', '2025-10-31 15:59:00', '2025-10-31 15:59:00'),
(4, 'Pemasaran', 'Bertanggung jawab atas strategi pemasaran dan promosi produk/layanan', '2025-10-31 15:59:00', '2025-10-31 15:59:00'),
(5, 'Operasional', 'Mengelola kegiatan operasional harian dan proses bisnis perusahaan', '2025-10-31 15:59:00', '2025-10-31 15:59:00'),
(6, 'Hubungan Masyarakat', 'Mengelola komunikasi dan hubungan dengan stakeholder eksternal', '2025-10-31 15:59:00', '2025-10-31 15:59:00');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_10_28_081439_create_detail_peserta_table', 1),
(5, '2025_10_28_081525_create_divisi_table', 1),
(6, '2025_10_28_081526_create_detail_admin_table', 1),
(7, '2025_10_28_082707_create_personal_access_tokens_table', 1),
(8, '2025_10_28_135045_create_otps_table', 1),
(9, '2025_10_29_073256_create_modul_acara_table', 1),
(10, '2025_10_29_074351_create_password_resets_table', 1),
(11, '2025_10_30_041507_add_failed_login_tracking_to_users_table', 1),
(12, '2025_10_30_042357_add_is_public_to_modul_acara_table', 1),
(13, '2025_10_30_143720_create_pendaftaran_acara_table', 1),
(14, '2025_10_30_144045_create_presensi_acara_table', 1),
(15, '2025_11_01_150423_add_pendaftaran_fk_to_presensi', 2),
(16, '2025_11_01_171754_add_mdl_link_wa_to_modul_acara_table', 2),
(18, '2025_11_01_223330_create_table_sertif', 3),
(19, '2025_11_01_230709_create_table_sertif', 4);

-- --------------------------------------------------------

--
-- Table structure for table `modul_acara`
--

CREATE TABLE `modul_acara` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `mdl_kode` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdl_slug` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdl_nama` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdl_deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdl_tipe` enum('online','offline','hybrid') COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdl_kategori` enum('public','private','invite-only') COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdl_lokasi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdl_latitude` decimal(10,7) DEFAULT NULL,
  `mdl_longitude` decimal(10,7) DEFAULT NULL,
  `mdl_radius` int UNSIGNED DEFAULT NULL,
  `mdl_pendaftaran_mulai` datetime NOT NULL,
  `mdl_pendaftaran_selesai` datetime NOT NULL,
  `mdl_maks_peserta_eksternal` int UNSIGNED DEFAULT NULL,
  `mdl_acara_mulai` datetime NOT NULL,
  `mdl_acara_selesai` datetime DEFAULT NULL,
  `mdl_status` enum('draft','active','closed','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `mdl_presensi_aktif` tinyint(1) NOT NULL DEFAULT '0',
  `mdl_kode_qr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdl_link_wa` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdl_file_acara` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdl_file_rundown` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdl_template_sertifikat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdl_sertifikat_aktif` tinyint(1) NOT NULL DEFAULT '0',
  `mdl_doorprize_aktif` tinyint(1) NOT NULL DEFAULT '0',
  `mdl_banner_acara` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mdl_catatan` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `modul_acara`
--

INSERT INTO `modul_acara` (`id`, `user_id`, `mdl_kode`, `mdl_slug`, `mdl_nama`, `mdl_deskripsi`, `mdl_tipe`, `mdl_kategori`, `mdl_lokasi`, `mdl_latitude`, `mdl_longitude`, `mdl_radius`, `mdl_pendaftaran_mulai`, `mdl_pendaftaran_selesai`, `mdl_maks_peserta_eksternal`, `mdl_acara_mulai`, `mdl_acara_selesai`, `mdl_status`, `is_public`, `mdl_presensi_aktif`, `mdl_kode_qr`, `mdl_link_wa`, `mdl_file_acara`, `mdl_file_rundown`, `mdl_template_sertifikat`, `mdl_sertifikat_aktif`, `mdl_doorprize_aktif`, `mdl_banner_acara`, `mdl_catatan`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(42, 5, 'EVT9158', 'pelatihan-keselamatan-penerbangan-nasional-2025', 'Pelatihan Keselamatan Penerbangan Nasional 2025', 'Pelatihan Keselamatan Penerbangan Nasional 2025 merupakan program strategis tahunan yang diselenggarakan oleh AirNav Indonesia sebagai bagian dari komitmen perusahaan dalam menjaga dan meningkatkan standar keselamatan penerbangan sipil di Indonesia. Acara ini dirancang khusus bagi seluruh karyawan yang berperan langsung dalam pengelolaan lalu lintas udara, mulai dari petugas Air Traffic Controller, teknisi komunikasi, hingga staf pendukung operasional. Melalui pelatihan ini, peserta akan memperoleh pemahaman yang lebih mendalam mengenai prosedur keselamatan, mitigasi risiko, serta penanganan situasi darurat sesuai dengan standar internasional yang berlaku. Selama pelaksanaan pelatihan, peserta akan mengikuti serangkaian kegiatan pembelajaran yang meliputi sesi teori, studi kasus, dan simulasi lapangan. Dalam sesi teori, narasumber dari Direktorat Jenderal Perhubungan Udara serta perwakilan ICAO akan memberikan paparan tentang kebijakan terbaru dalam keselamatan penerbangan, termasuk implementasi Safety Management System (SMS) di lingkungan kerja. Sementara itu, sesi praktik akan melibatkan simulasi kondisi darurat di ruang kontrol lalu lintas udara untuk meningkatkan kemampuan respon cepat dan koordinasi antarunit. Kegiatan ini juga menjadi wadah bagi peserta untuk saling bertukar pengalaman dan memperkuat kolaborasi lintas divisi. Melalui forum diskusi kelompok, karyawan diharapkan dapat berbagi inovasi maupun solusi terhadap tantangan keselamatan yang dihadapi dalam kegiatan operasional sehari-hari. Selain itu, pelatihan ini turut menekankan pentingnya aspek komunikasi dan mental preparedness, mengingat pekerjaan dalam dunia navigasi udara menuntut ketelitian tinggi dan pengambilan keputusan dalam waktu singkat. Dengan terselenggaranya pelatihan ini, AirNav Indonesia berharap dapat terus menumbuhkan budaya keselamatan (safety culture) yang kuat di seluruh lapisan organisasi. Pelatihan ini bukan sekadar kegiatan rutin, tetapi juga bentuk nyata komitmen perusahaan dalam mewujudkan visi menjadi penyedia layanan navigasi penerbangan yang unggul, andal, dan berstandar global.', 'offline', 'public', 'Gedung AirNav Pusat, Tangerang', NULL, NULL, NULL, '2025-10-30 00:00:00', '2025-11-04 00:00:00', NULL, '2025-11-04 04:00:00', '2025-11-04 05:50:00', 'active', 1, 1, 'EVTQR-X0YTKXTX-1762100638', 'https://chat.whatsapp.com/staff-training', 'modul-acara/files/YtYV6IPQlzUbkcWNcc5H8snkoEuKMCGmHLwlpCj1.pdf', 'modul-acara/rundown/63hEOramZe5N334gHYcZBNZGD0WtFUapDbEIDKfH.pdf', NULL, 0, 0, 'modul-acara/banner/ZjzrOgXsIfaZlbjT7axCF9OEgRbLymsmd8gAPgoz.jpg', NULL, 5, 5, '2025-11-02 23:23:57', '2025-11-04 04:55:53', NULL),
(45, 5, 'EVT1308', 'seminar-edukasi-keselamatan-udara-untuk-masyarakat-2025', 'Seminar Edukasi Keselamatan Udara untuk Masyarakat 2025', 'Seminar Edukasi Keselamatan Udara 2025 diselenggarakan sebagai upaya AirNav Indonesia dalam memberikan edukasi kepada masyarakat mengenai pentingnya keselamatan penerbangan dan peran lembaga navigasi dalam menjaga keamanan ruang udara nasional. Acara ini terbuka untuk pelajar, mahasiswa, komunitas pecinta aviasi, serta masyarakat umum yang ingin memahami lebih dalam mengenai sistem pengelolaan lalu lintas udara di Indonesia.\\n\\nDalam seminar ini, narasumber dari AirNav Indonesia, Kementerian Perhubungan, serta praktisi industri penerbangan akan memberikan paparan menarik seputar pengawasan ruang udara, komunikasi penerbangan, serta teknologi pendukung keselamatan. Peserta akan diajak memahami proses komunikasi antara pilot dan petugas ATC, bagaimana radar bekerja dalam mendeteksi pergerakan pesawat, serta pentingnya koordinasi antarinstansi dalam mencegah insiden penerbangan.\\n\\nSelain sesi utama, acara juga akan diisi dengan diskusi interaktif, kuis edukatif, serta pemutaran video dokumenter tentang operasi Air Traffic Control di berbagai bandara besar Indonesia. Peserta yang aktif mengikuti kegiatan akan memperoleh e-sertifikat resmi dari AirNav Indonesia. Melalui kegiatan ini, diharapkan masyarakat semakin memahami bahwa keselamatan penerbangan bukan hanya tanggung jawab petugas, tetapi juga memerlukan dukungan dan kesadaran publik.\\n\\nAirNav Indonesia berkomitmen untuk terus melakukan sosialisasi dan edukasi publik secara berkelanjutan sebagai bagian dari tanggung jawab sosial perusahaan. Seminar ini menjadi wujud nyata kolaborasi antara dunia profesional dan masyarakat untuk menciptakan penerbangan yang aman, tertib, dan efisien bagi seluruh pengguna jasa transportasi udara di Indonesia.', 'online', 'invite-only', 'Zoom Webinar', NULL, NULL, NULL, '2025-10-26 00:00:00', '2025-11-03 00:00:00', NULL, '2025-11-03 01:00:00', '2025-11-04 12:00:00', 'active', 1, 1, 'EVTQR-8LUVGIGZ-1762102033', 'https://chat.whatsapp.com/seminarairnav', 'modul-acara/files/yLXlcyDBk6uKDXIzHiMoNGbeRoXHOgCXyV3sRgRG.pdf', NULL, NULL, 0, 0, 'modul-acara/banner/2VZzmN9uqX1IwtDze0H8554uihQQxgi62qUUuGxl.jpg', 'Link Zoom akan dikirim melalui email peserta yang terdaftar.', 5, 5, '2025-11-02 23:47:13', '2025-11-03 21:35:09', NULL),
(46, 5, 'EVT6328', 'family-gathering-airnav-indonesia-2025', 'Family Gathering AirNav Indonesia 2025', 'Family Gathering AirNav Indonesia 2025 merupakan kegiatan tahunan yang bertujuan mempererat kebersamaan antarpegawai dan keluarga besar AirNav. Dalam suasana yang penuh keakraban, acara ini menjadi momen penting untuk memperkuat semangat persaudaraan, kerja sama, serta rasa memiliki terhadap perusahaan. Kegiatan ini juga menjadi ajang penghargaan bagi karyawan berprestasi yang telah memberikan kontribusi terbaik selama tahun berjalan.\\n\\nRangkaian kegiatan mencakup berbagai perlombaan antardivisi, pertunjukan seni dan musik, bazar makanan khas daerah, serta sesi motivasi dari pimpinan perusahaan. Selain itu, disediakan pula area bermain anak dan kegiatan interaktif keluarga yang menumbuhkan kebersamaan lintas generasi. Seluruh peserta diharapkan dapat berpartisipasi aktif dalam setiap agenda yang telah disusun oleh panitia dengan tetap menjunjung tinggi nilai-nilai integritas dan sportivitas.\\n\\nAcara ini tidak hanya menjadi ajang rekreasi, tetapi juga refleksi atas pencapaian AirNav selama satu tahun terakhir. Dalam sambutannya, manajemen akan menyampaikan capaian strategis perusahaan serta rencana pengembangan untuk tahun mendatang. Dengan demikian, setiap karyawan dapat memahami arah dan visi jangka panjang perusahaan sembari menikmati waktu bersama keluarga.\\n\\nMelalui Family Gathering ini, AirNav Indonesia berharap dapat menciptakan lingkungan kerja yang harmonis dan berorientasi pada kesejahteraan keluarga. Kegiatan semacam ini diyakini mampu meningkatkan loyalitas dan motivasi kerja karyawan sehingga berdampak positif pada produktivitas dan kinerja perusahaan secara keseluruhan.', 'offline', 'public', 'Taman Mini Indonesia Indah, Jakarta', NULL, NULL, NULL, '2025-10-31 00:00:00', '2025-11-06 08:50:00', NULL, '2025-11-07 08:00:00', '2025-12-07 09:00:00', 'active', 1, 1, 'EVTQR-TBUVWRWR-1762102766', 'https://chat.whatsapp.com/familygathering', 'modul-acara/files/RKj3mtLcVyF741bv1UAGLEHS5118jIL4tTfZpaaW.pdf', 'modul-acara/rundown/36bVBKEBfObg2N0660HTOYUvAvAtioga5UVSTV0N.pdf', 'modul-acara/sertifikat/9vgsYK04LauT24Kevc2zteHGXaqPzUTOSIxXTcUN.jpg', 0, 1, 'modul-acara/banner/AdowwZCkA5bAupr72PYzta62jW2K3Z84JguxrrLy.png', 'Peserta wajib membawa tanda pengenal keluarga dan menggunakan kaos seragam event.', 5, 5, '2025-11-02 23:59:26', '2025-11-04 04:17:50', NULL),
(47, 5, 'EVT9213', 'airnav-aviation-expo-2025', 'AirNav Aviation Expos 2025', 'AirNav Aviation Expo 2025 merupakan acara tahunan yang diselenggarakan oleh AirNav Indonesia sebagai bentuk komitmen perusahaan dalam memperkenalkan dunia navigasi penerbangan kepada masyarakat luas. Acara ini menghadirkan pameran interaktif tentang sistem pengendalian lalu lintas udara, simulasi radar, serta teknologi komunikasi penerbangan terkini yang digunakan di berbagai bandara di Indonesia. Melalui kegiatan ini, AirNav berupaya untuk meningkatkan literasi masyarakat terhadap pentingnya keselamatan dan efisiensi dalam pengaturan lalu lintas udara nasional. Selain pameran, terdapat pula sesi seminar yang diisi oleh pakar penerbangan nasional dan internasional yang akan membahas inovasi teknologi, pengelolaan ruang udara, dan masa depan industri penerbangan di era digital. Peserta juga berkesempatan untuk mengunjungi booth edukatif dari berbagai unit AirNav yang menampilkan peran serta kontribusi mereka dalam menjaga keselamatan penerbangan di Indonesia. Tidak hanya bersifat edukatif, acara ini juga menghadirkan berbagai kegiatan menarik seperti lomba pengetahuan penerbangan, mini workshop untuk pelajar, dan area kuliner yang menghadirkan cita rasa khas nusantara. Melalui kegiatan ini, AirNav Indonesia berharap dapat membangun hubungan yang lebih dekat dengan masyarakat, sekaligus memperkuat citra sebagai lembaga yang berperan penting dalam menjaga keamanan dan keteraturan lalu lintas udara Indonesia. Dengan semangat “Navigating the Future Together”, AirNav mengajak semua pihak untuk bersama-sama membangun masa depan penerbangan yang aman, modern, dan berkelanjutan.', 'offline', 'public', 'Bandara Soekarno-Hatta', NULL, NULL, NULL, '2025-10-26 00:00:00', '2025-11-03 00:00:00', NULL, '2025-11-03 01:30:00', '2025-11-03 12:00:00', 'active', 1, 1, 'EVTQR-5RDWQ7KB-1762103081', 'https://chat.whatsapp.com/airnavexpo2025', 'modul-acara/files/u1yT3byq0d61lZxee1QQDxopRaPQIgM9iUQvSxVR.pdf', 'modul-acara/rundown/E37IUTtO3SNNE7A6D8V3YGOvTqBEFWFjYm4YeS7h.pdf', 'modul-acara/sertifikat/mst5Ce40SLaml9xCtsMwOisDTiNjct9J1P02qzNu.pdf', 0, 1, 'modul-acara/banner/chYaiJTl2JKZ6m4qjqfJxA4SU2CB8tSOvx5FD4Vr.jpg', 'https://chat.whatsapp.com/grup-airnav\r\nPeserta wajib membawa identitas resmi untuk verifikasi di lokasi acara.', 5, 5, '2025-11-03 00:04:41', '2025-11-03 22:24:01', NULL),
(56, 5, 'EVT9198', 'seminar-nasional-teknologi-2025', 'Seminar Nasional Teknologi 2025', 'Seminar ini membahas perkembangan teknologi terkini, termasuk AI, IoT, dan cybersecurity, dengan pembicara dari berbagai perusahaan dan universitas ternama.', 'offline', 'public', 'Airnav Pusaat', NULL, NULL, NULL, '2025-11-01 00:00:00', '2025-11-04 03:00:00', NULL, '2025-11-04 04:00:00', '2025-11-04 12:00:00', 'active', 1, 1, 'EVTQR-BWN0A6VI-1762134731', 'https://chat.whatsapp.com/Leadership2025', 'modul-acara/files/lp7eYnkxMG6wHjMUrr6iqTPU3sZhgt8xRL1twriD.pdf', 'modul-acara/rundown/UHxQuAfNTILyeRQWDwzfMXm5oxCrVR4nwM9fBFt5.pdf', 'modul-acara/sertifikat/V0FpwELXNwNZCZ6uwT5BBpXSdcI0HedyIxfCchiD.png', 0, 1, 'modul-acara/banner/vucMN1Slffy3OscGTPi3GEBJPHSePs9e2t7PYCWS.jpg', NULL, 5, 5, '2025-11-03 08:52:11', '2025-11-04 09:35:53', NULL),
(83, 5, 'EVT4055', 'airnav-innovation-fair-2025', 'AirNav Innovation Fair 2025', 'AirNav Innovation Fair 2025 merupakan ajang pameran dan kolaborasi terbuka antara AirNav Indonesia dengan masyarakat umum, perguruan tinggi, serta pelaku industri kreatif di bidang teknologi penerbangan. Kegiatan ini dirancang sebagai wadah untuk menampilkan inovasi terbaru dalam sistem navigasi udara, teknologi kontrol lalu lintas penerbangan, serta solusi digital yang mendukung peningkatan keselamatan dan efisiensi penerbangan di Indonesia. Dalam era transformasi digital yang semakin pesat, AirNav memahami pentingnya sinergi antara lembaga pemerintah, akademisi, dan pelaku industri dalam mendorong inovasi yang berkelanjutan. Melalui kegiatan ini, AirNav ingin memperkenalkan berbagai riset, proyek, dan teknologi yang telah dan sedang dikembangkan oleh para insinyur, teknisi, dan pegawai muda di lingkungan AirNav Indonesia. Peserta pameran juga mencakup startup dan mahasiswa yang memiliki ide-ide kreatif dalam bidang teknologi penerbangan, sistem monitoring, hingga pemanfaatan kecerdasan buatan untuk meningkatkan efisiensi layanan penerbangan.\\n\\nSelain pameran, acara ini juga menghadirkan sesi seminar dan talkshow yang menghadirkan narasumber dari berbagai institusi, termasuk Kementerian Perhubungan, Badan Riset dan Inovasi Nasional (BRIN), serta perwakilan industri aviasi global. Topik yang dibahas mencakup perkembangan teknologi komunikasi dan navigasi udara (CNS), keamanan siber dalam sistem penerbangan, serta tantangan pengelolaan ruang udara di masa depan. AirNav Innovation Fair 2025 diharapkan menjadi ruang inspiratif yang tidak hanya memamerkan kemajuan teknologi, tetapi juga menumbuhkan semangat kolaborasi dan kreativitas bagi generasi muda untuk ikut serta dalam membangun masa depan penerbangan Indonesia yang lebih maju dan berkelanjutan.\\n\\nMelalui kegiatan ini, AirNav menegaskan komitmennya untuk terus berinovasi dan memberikan layanan terbaik bagi masyarakat. Dengan tema \'Navigating the Future with Innovation\', AirNav berharap kegiatan ini dapat memperluas wawasan publik terhadap peran penting navigasi udara dalam mendukung konektivitas nasional. Selain itu, acara ini juga menjadi bukti nyata bahwa AirNav tidak hanya berfokus pada pengelolaan ruang udara, tetapi juga aktif berperan dalam membangun ekosistem inovasi teknologi di Indonesia. Diharapkan, dari ajang ini akan lahir gagasan-gagasan baru yang dapat meningkatkan kualitas layanan navigasi udara serta memperkuat posisi Indonesia sebagai salah satu negara dengan sistem penerbangan teraman dan paling inovatif di kawasan Asia Tenggara.', 'offline', 'public', 'Jakarta Convention Center, Jakarta', NULL, NULL, NULL, '2025-11-01 00:00:00', '2025-11-01 00:00:00', NULL, '2025-11-02 09:00:00', '2025-11-03 17:00:00', 'active', 1, 0, 'EVTQR-LT8WSWWQ-1762174547', 'https://api.airnav.id/banner/innovationfair2025.png', NULL, NULL, NULL, 0, 0, 'modul-acara/banner/FvMad0ZnroxovS0NAceWJbFJwdZnkYORtCxCaUlx.jpg', 'Peserta umum diharapkan melakukan registrasi online terlebih dahulu. Sertifikat akan diberikan kepada peserta seminar.', 5, 5, '2025-11-03 19:55:47', '2025-11-04 11:04:48', NULL),
(97, 5, 'EVT6292', 'presentasi-navevent', 'Presentasi Skripsi Navevent', 'Ini Deskripsi', 'offline', 'public', 'DI sana', NULL, NULL, NULL, '2025-11-04 00:00:00', '2025-11-05 00:00:00', NULL, '2025-11-04 00:00:00', '2025-11-04 07:00:00', 'active', 1, 1, 'EVTQR-BCHZMK5G-1762210456', 'https://chat/whatsapp.com/acara', NULL, NULL, NULL, 0, 1, 'modul-acara/banner/lv7kdyEDRxcATQt6h3ebNoYkdKQI4RiBYIMNmCSn.jpg', NULL, 5, 5, '2025-11-04 05:54:16', '2025-11-04 09:37:19', NULL),
(98, 5, 'EVT2804', 'navevent-lauching', 'Peresmian Aplikasi dan Website NavEvent', 'Acara peluncuran resmi Aplikasi dan Website NavEvent yang dikembangkan oleh AirNav Indonesia sebagai platform manajemen dan publikasi acara internal serta eksternal. Kegiatan ini bertujuan memperkenalkan fitur dan manfaat NavEvent kepada seluruh unit kerja dan mitra strategis.', 'offline', 'public', 'Gedung Kantor AirNav Pusat, Tangerang, Banten', NULL, NULL, NULL, '2025-10-26 00:00:00', '2025-11-05 09:54:00', NULL, '2025-11-04 11:00:00', '2025-11-04 20:28:00', 'active', 1, 1, 'EVTQR-EJM8ECJF-1762213043', 'https://chat.whatsapp.com/HImx7Z2Fx3CC05BzOdCn2h?mode=wwt', NULL, 'modul-acara/rundown/tU7HHesuOY0kcNUbGkn1ILhggWMB7xSiTQ2H9LdU.doc', 'modul-acara/sertifikat/SxmcDh1Af7SCdmKyWhPXyPoBrN9oWtjcBlTWhhlW.png', 0, 1, 'modul-acara/banner/QVG7Fpgz3yGsFrtA5kN6Quem3UIH0jMApEgAJBVe.png', 'Peserta diharapkan hadir 30 menit sebelum acara dimulai.\r\nDress code : Formal.\r\nAcara akan disiarkan langsung melalui kanal internal AirNav Indonesia.', 5, 5, '2025-11-04 06:37:23', '2025-11-04 10:42:20', NULL),
(100, 5, 'EVT4999', 'airnav-digital-transformation-summit-2025', 'AirNav Digital Transformation Summit 2025', 'AirNav Digital Transformation Summit 2025 merupakan forum nasional yang diselenggarakan untuk mempertemukan para pemangku kepentingan di sektor penerbangan, teknologi, dan komunikasi dalam membahas arah transformasi digital di dunia navigasi udara Indonesia. Dengan mengusung tema \'Connecting Skies Through Innovation\', kegiatan ini menjadi wadah bagi AirNav Indonesia untuk menunjukkan komitmennya terhadap modernisasi sistem pengelolaan ruang udara dan digitalisasi proses operasional di seluruh jaringan pelayanan navigasi udara nasional.\\n\\nKegiatan ini menghadirkan kombinasi format hybrid, di mana peserta dapat mengikuti acara secara langsung di Jakarta maupun melalui platform daring yang telah disediakan. Dalam acara ini, AirNav menampilkan berbagai inovasi digital yang telah diimplementasikan, seperti sistem e-Flight Plan, integrasi data meteorologi real-time, serta pemanfaatan kecerdasan buatan dalam analisis lalu lintas udara. Selain pameran teknologi, summit ini juga menghadirkan sesi panel diskusi yang diisi oleh pakar dari dalam dan luar negeri, membahas isu-isu strategis seperti keamanan siber dalam industri penerbangan, digital twin untuk infrastruktur navigasi udara, serta penerapan big data analytics dalam mendukung pengambilan keputusan operasional.\\n\\nAirNav berharap kegiatan ini dapat menjadi katalis bagi peningkatan kolaborasi lintas sektor, mendorong pertukaran gagasan, serta memperkuat kesiapan Indonesia dalam menghadapi tantangan global di bidang transportasi udara. Melalui pelaksanaan acara ini, AirNav menegaskan posisinya sebagai lembaga penyelenggara navigasi udara yang adaptif terhadap perkembangan zaman dan berkomitmen untuk memberikan pelayanan terbaik berbasis teknologi mutakhir. Dengan semangat kolaborasi dan inovasi, AirNav Indonesia bertekad menjadikan Digital Transformation Summit sebagai agenda tahunan yang terus mendorong kemajuan industri penerbangan nasional menuju era digital yang berkelanjutan.', 'hybrid', 'public', 'Menara AirNav Indonesia, Tangerang', NULL, NULL, NULL, '2025-11-01 00:00:00', '2025-11-04 11:00:00', NULL, '2025-11-04 12:00:00', '2025-11-04 19:00:00', 'active', 1, 0, 'EVTQR-R1Y9IG92-1762221638', 'https://chat.whatsapp.com/airnavdigisummit2025', 'modul-acara/files/Q9kqXEfi9lOzfFSLgKrMRxBcNouLYHOx505GLqqm.pdf', 'modul-acara/rundown/xzcRXPnX8gQgQO2shvQq7aLzBRonm12cbEZM4HHA.pdf', 'modul-acara/sertifikat/qmNnGBrFjZg6wOjLxrJPRAd1siPT6Qmo698jzSen.jpg', 0, 1, 'modul-acara/banner/PVfYUsYTMRg2whygup1X23FDQhVfi18Re1VF0ieb.jpg', 'Peserta daring akan menerima tautan Zoom satu hari sebelum acara dimulai.', 5, 5, '2025-11-04 09:00:38', '2025-11-04 10:21:45', NULL),
(102, 5, 'EVT9483', 'workshop-peningkatan-keselamatan-dan-efisiensi-navigasi-penerbangan', 'Peluncuran Aplikasi NavEvent', 'Acara Peluncuran Aplikasi NavEvent diselenggarakan oleh AirNav Indonesia sebagai bentuk inovasi dalam pengelolaan dan penyelenggaraan kegiatan internal perusahaan. Aplikasi NavEvent dirancang untuk mempermudah proses pendaftaran, manajemen peserta, serta publikasi informasi acara secara terpusat dan efisien.\r\n\r\nMelalui acara ini, peserta akan diperkenalkan pada fitur-fitur utama NavEvent, seperti sistem registrasi digital, pengelolaan jadwal acara, serta pelaporan otomatis. Peluncuran ini juga menjadi langkah strategis AirNav dalam mendukung transformasi digital dan meningkatkan efisiensi operasional di lingkungan kerja.', 'offline', 'public', 'Gedung Pusat AirNav Indonesia, Tangerang', NULL, NULL, NULL, '2025-11-03 00:00:00', '2025-11-04 15:00:00', NULL, '2025-11-04 10:00:00', '2025-11-04 15:10:00', 'active', 1, 1, 'EVTQR-WHNYCQRM-1762228654', 'https://chat.whatsapp.com/AIRNAV-WORKSHOP2025', NULL, NULL, 'modul-acara/sertifikat/envfLEqKe0N4rkbugQaGYf1eIODBT5SbuMAnIueG.jpg', 0, 1, 'modul-acara/banner/JyQKNW0BJwEFbnD5UVCtQLAMHzsMOQ3ygTKFLuXW.png', 'Peserta diwajibkan mengenakan pakaian formal dan membawa ID card AirNav. Disediakan makan siang dan coffee break selama acara berlangsung.', 5, 5, '2025-11-04 10:57:34', '2025-11-04 15:03:19', NULL),
(103, 5, 'EVT8829', 'workshop-kreatif', 'workshop kreatif', 'acara ini bertujuan', 'offline', 'public', 'airnav', NULL, NULL, NULL, '2025-11-03 00:00:00', '2025-11-04 00:00:00', NULL, '2025-11-04 13:00:00', '2025-11-04 17:00:00', 'active', 1, 0, 'EVTQR-OCCJZEBA-1762243157', 'https://test', NULL, NULL, NULL, 0, 0, NULL, 'baju putih', 5, NULL, '2025-11-04 14:59:17', '2025-11-04 14:59:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `otps`
--

CREATE TABLE `otps` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `otps`
--

INSERT INTO `otps` (`id`, `user_id`, `code`, `expires_at`, `verified_at`, `created_at`, `updated_at`) VALUES
(1, 18, '429137', '2025-10-31 16:11:45', '2025-10-31 16:02:12', '2025-10-31 16:01:45', '2025-10-31 16:02:12'),
(2, 19, '010302', '2025-10-31 18:04:43', '2025-10-31 17:55:30', '2025-10-31 17:54:43', '2025-10-31 17:55:30'),
(3, 20, '951456', '2025-10-31 20:37:42', '2025-10-31 20:28:40', '2025-10-31 20:27:42', '2025-10-31 20:28:40'),
(4, 21, '512455', '2025-10-31 21:37:11', '2025-10-31 21:28:05', '2025-10-31 21:27:11', '2025-10-31 21:28:05'),
(5, 22, '554889', '2025-11-01 08:15:09', NULL, '2025-11-01 08:05:09', '2025-11-01 08:05:09'),
(6, 23, '844515', '2025-11-01 11:37:30', NULL, '2025-11-01 11:27:30', '2025-11-01 11:27:30'),
(7, 24, '328645', '2025-11-01 12:28:06', '2025-11-01 12:18:31', '2025-11-01 12:18:06', '2025-11-01 12:18:31'),
(8, 25, '006598', '2025-11-01 13:12:23', NULL, '2025-11-01 13:02:23', '2025-11-01 13:02:23'),
(9, 26, '660452', '2025-11-01 13:25:33', NULL, '2025-11-01 13:15:33', '2025-11-01 13:15:33'),
(10, 27, '538042', '2025-11-01 13:26:26', '2025-11-01 13:16:54', '2025-11-01 13:16:26', '2025-11-01 13:16:54'),
(11, 26, '437285', '2025-11-01 13:28:44', '2025-11-01 13:19:16', '2025-11-01 13:18:44', '2025-11-01 13:19:16'),
(12, 28, '183866', '2025-11-01 13:41:35', NULL, '2025-11-01 13:31:35', '2025-11-01 13:31:35'),
(13, 29, '455998', '2025-11-01 18:45:52', '2025-11-01 18:36:48', '2025-11-01 18:35:52', '2025-11-01 18:36:48'),
(14, 30, '619975', '2025-11-01 20:58:35', '2025-11-01 20:49:47', '2025-11-01 20:48:35', '2025-11-01 20:49:47'),
(15, 31, '897877', '2025-11-01 21:28:23', NULL, '2025-11-01 21:18:23', '2025-11-01 21:18:23'),
(16, 32, '962197', '2025-11-01 22:54:45', NULL, '2025-11-01 22:44:45', '2025-11-01 22:44:45'),
(17, 33, '645318', '2025-11-01 22:59:39', NULL, '2025-11-01 22:49:39', '2025-11-01 22:49:39'),
(18, 34, '216854', '2025-11-02 08:12:22', NULL, '2025-11-02 08:02:22', '2025-11-02 08:02:22'),
(19, 35, '290919', '2025-11-02 08:13:38', NULL, '2025-11-02 08:03:38', '2025-11-02 08:03:38'),
(20, 36, '497120', '2025-11-02 10:22:47', NULL, '2025-11-02 10:12:47', '2025-11-02 10:12:47'),
(21, 37, '055419', '2025-11-02 10:24:05', '2025-11-02 10:14:49', '2025-11-02 10:14:05', '2025-11-02 10:14:49'),
(22, 38, '001359', '2025-11-02 11:18:33', '2025-11-02 11:09:05', '2025-11-02 11:08:33', '2025-11-02 11:09:05'),
(23, 39, '804826', '2025-11-02 11:27:45', '2025-11-02 11:18:09', '2025-11-02 11:17:45', '2025-11-02 11:18:09'),
(24, 40, '502934', '2025-11-02 11:35:38', NULL, '2025-11-02 11:25:38', '2025-11-02 11:25:38'),
(25, 41, '437325', '2025-11-02 11:49:58', NULL, '2025-11-02 11:39:58', '2025-11-02 11:39:58'),
(26, 41, '135163', '2025-11-02 11:51:59', '2025-11-02 11:42:26', '2025-11-02 11:41:59', '2025-11-02 11:42:26'),
(27, 42, '038646', '2025-11-02 12:59:59', '2025-11-02 12:51:08', '2025-11-02 12:49:59', '2025-11-02 12:51:08'),
(28, 43, '808762', '2025-11-02 14:21:17', '2025-11-02 14:12:43', '2025-11-02 14:11:17', '2025-11-02 14:12:43'),
(29, 44, '154259', '2025-11-02 14:51:47', NULL, '2025-11-02 14:41:47', '2025-11-02 14:41:47'),
(30, 45, '047547', '2025-11-02 23:27:09', '2025-11-02 23:18:10', '2025-11-02 23:17:09', '2025-11-02 23:18:10'),
(31, 46, '368890', '2025-11-03 01:56:50', '2025-11-03 01:47:17', '2025-11-03 01:46:50', '2025-11-03 01:47:17'),
(32, 47, '304039', '2025-11-03 09:52:58', '2025-11-03 09:43:27', '2025-11-03 09:42:58', '2025-11-03 09:43:27'),
(33, 48, '905445', '2025-11-03 10:07:35', '2025-11-03 09:58:15', '2025-11-03 09:57:35', '2025-11-03 09:58:15'),
(34, 49, '504124', '2025-11-03 10:27:49', '2025-11-03 10:18:30', '2025-11-03 10:17:49', '2025-11-03 10:18:30'),
(35, 50, '140812', '2025-11-03 11:17:07', '2025-11-03 11:07:36', '2025-11-03 11:07:07', '2025-11-03 11:07:36'),
(36, 51, '221295', '2025-11-03 11:40:08', '2025-11-03 11:30:36', '2025-11-03 11:30:08', '2025-11-03 11:30:36'),
(37, 52, '817683', '2025-11-03 12:07:58', NULL, '2025-11-03 11:57:58', '2025-11-03 11:57:58'),
(38, 53, '067477', '2025-11-03 13:25:48', '2025-11-03 13:16:43', '2025-11-03 13:15:48', '2025-11-03 13:16:43'),
(39, 54, '605665', '2025-11-03 14:02:36', NULL, '2025-11-03 13:52:36', '2025-11-03 13:52:36'),
(40, 55, '002104', '2025-11-03 14:03:52', '2025-11-03 13:55:42', '2025-11-03 13:53:52', '2025-11-03 13:55:42'),
(41, 56, '415599', '2025-11-03 14:06:06', '2025-11-03 13:56:49', '2025-11-03 13:56:06', '2025-11-03 13:56:49'),
(42, 57, '049613', '2025-11-03 19:45:56', NULL, '2025-11-03 19:35:56', '2025-11-03 19:35:56'),
(43, 58, '766202', '2025-11-03 20:59:39', '2025-11-03 20:51:03', '2025-11-03 20:49:39', '2025-11-03 20:51:03'),
(44, 59, '536128', '2025-11-03 21:01:32', '2025-11-03 20:51:58', '2025-11-03 20:51:32', '2025-11-03 20:51:58'),
(45, 60, '914480', '2025-11-03 22:08:20', '2025-11-03 21:58:59', '2025-11-03 21:58:20', '2025-11-03 21:58:59'),
(46, 61, '075549', '2025-11-04 05:02:23', NULL, '2025-11-04 04:52:23', '2025-11-04 04:52:23'),
(47, 62, '665229', '2025-11-04 05:37:32', NULL, '2025-11-04 05:27:32', '2025-11-04 05:27:32'),
(48, 63, '089022', '2025-11-04 05:43:23', NULL, '2025-11-04 05:33:23', '2025-11-04 05:33:23'),
(49, 64, '891164', '2025-11-04 05:54:04', NULL, '2025-11-04 05:44:04', '2025-11-04 05:44:04'),
(50, 65, '656524', '2025-11-04 06:17:15', NULL, '2025-11-04 06:07:15', '2025-11-04 06:07:15'),
(51, 66, '900388', '2025-11-04 06:17:25', '2025-11-04 06:08:08', '2025-11-04 06:07:25', '2025-11-04 06:08:08'),
(52, 67, '627949', '2025-11-04 06:31:38', '2025-11-04 06:22:36', '2025-11-04 06:21:38', '2025-11-04 06:22:36'),
(53, 68, '108987', '2025-11-04 07:22:12', '2025-11-04 07:12:49', '2025-11-04 07:12:12', '2025-11-04 07:12:49'),
(54, 69, '656183', '2025-11-04 08:38:04', NULL, '2025-11-04 08:28:04', '2025-11-04 08:28:04'),
(55, 70, '381834', '2025-11-04 08:40:29', '2025-11-04 08:30:47', '2025-11-04 08:30:29', '2025-11-04 08:30:47'),
(56, 71, '966717', '2025-11-04 09:08:27', '2025-11-04 08:58:52', '2025-11-04 08:58:27', '2025-11-04 08:58:52'),
(57, 72, '649382', '2025-11-04 09:37:08', NULL, '2025-11-04 09:27:08', '2025-11-04 09:27:08'),
(58, 73, '659033', '2025-11-04 09:39:44', '2025-11-04 09:29:58', '2025-11-04 09:29:44', '2025-11-04 09:29:58'),
(59, 74, '702772', '2025-11-04 09:47:43', '2025-11-04 09:38:26', '2025-11-04 09:37:43', '2025-11-04 09:38:26'),
(60, 75, '819707', '2025-11-04 09:47:57', NULL, '2025-11-04 09:37:57', '2025-11-04 09:37:57'),
(61, 76, '010756', '2025-11-04 09:48:02', '2025-11-04 09:38:30', '2025-11-04 09:38:02', '2025-11-04 09:38:30'),
(62, 77, '175212', '2025-11-04 09:55:38', '2025-11-04 09:46:08', '2025-11-04 09:45:38', '2025-11-04 09:46:08'),
(63, 78, '236769', '2025-11-04 10:48:20', '2025-11-04 10:38:37', '2025-11-04 10:38:20', '2025-11-04 10:38:37'),
(64, 79, '268814', '2025-11-04 11:02:50', '2025-11-04 10:53:19', '2025-11-04 10:52:50', '2025-11-04 10:53:19'),
(65, 80, '019347', '2025-11-04 11:02:59', '2025-11-04 10:53:41', '2025-11-04 10:52:59', '2025-11-04 10:53:41'),
(66, 81, '314115', '2025-11-04 11:03:01', '2025-11-04 10:53:44', '2025-11-04 10:53:01', '2025-11-04 10:53:44'),
(67, 82, '118659', '2025-11-04 11:05:27', '2025-11-04 10:55:53', '2025-11-04 10:55:27', '2025-11-04 10:55:53'),
(68, 83, '267590', '2025-11-04 11:06:30', '2025-11-04 10:57:01', '2025-11-04 10:56:30', '2025-11-04 10:57:01'),
(69, 84, '732081', '2025-11-04 11:06:39', '2025-11-04 10:57:08', '2025-11-04 10:56:39', '2025-11-04 10:57:08'),
(70, 85, '327339', '2025-11-04 11:09:50', '2025-11-04 11:00:20', '2025-11-04 10:59:50', '2025-11-04 11:00:20'),
(71, 86, '219825', '2025-11-04 11:09:52', NULL, '2025-11-04 10:59:52', '2025-11-04 10:59:52'),
(72, 87, '218514', '2025-11-04 11:10:33', NULL, '2025-11-04 11:00:33', '2025-11-04 11:00:33'),
(73, 88, '928169', '2025-11-04 11:12:07', '2025-11-04 11:02:32', '2025-11-04 11:02:07', '2025-11-04 11:02:32'),
(74, 89, '485811', '2025-11-04 11:12:33', '2025-11-04 11:03:00', '2025-11-04 11:02:33', '2025-11-04 11:03:00'),
(75, 90, '503863', '2025-11-04 11:13:41', '2025-11-04 11:05:21', '2025-11-04 11:03:41', '2025-11-04 11:05:21'),
(76, 91, '995150', '2025-11-04 11:36:51', '2025-11-04 11:27:10', '2025-11-04 11:26:51', '2025-11-04 11:27:10'),
(77, 92, '525351', '2025-11-04 13:07:53', '2025-11-04 12:58:16', '2025-11-04 12:57:53', '2025-11-04 12:58:16'),
(78, 93, '663600', '2025-11-04 14:04:27', '2025-11-04 13:55:07', '2025-11-04 13:54:27', '2025-11-04 13:55:07'),
(79, 94, '653767', '2025-11-04 14:11:17', '2025-11-04 14:01:57', '2025-11-04 14:01:17', '2025-11-04 14:01:57'),
(80, 95, '656587', '2025-11-04 14:11:23', '2025-11-04 14:02:24', '2025-11-04 14:01:23', '2025-11-04 14:02:24'),
(81, 96, '177729', '2025-11-04 14:19:43', '2025-11-04 14:10:14', '2025-11-04 14:09:43', '2025-11-04 14:10:14'),
(82, 97, '414829', '2025-11-04 14:51:18', '2025-11-04 14:41:35', '2025-11-04 14:41:18', '2025-11-04 14:41:35'),
(83, 98, '396881', '2025-11-04 15:03:02', '2025-11-04 14:54:12', '2025-11-04 14:53:02', '2025-11-04 14:54:12'),
(84, 99, '306686', '2025-11-04 15:06:28', '2025-11-04 14:57:23', '2025-11-04 14:56:28', '2025-11-04 14:57:23'),
(85, 100, '719509', '2025-11-04 15:16:46', '2025-11-04 15:07:29', '2025-11-04 15:06:46', '2025-11-04 15:07:29');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('sinteh21@gmail.com', '$2y$12$YqaW9wbgntAHkIA87LCq4O.qr5z47VeDx0DDVb4uF9A6k8IGwaLei', '2025-11-01 13:45:59'),
('sealskyccc@gmail.com', '$2y$12$YBJM/nsku9qtuSYH.JMsCuxAdLQbPrXDJthiica797bov9UP5zeqW', '2025-11-03 01:04:42'),
('mfatihbagaskara11@gmail.com', '$2y$12$tAauUTSKwuumnrwJ0.vOIe2nAYnjMi.MUE8hCfQChU64hVJy.70nq', '2025-11-04 09:42:50');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran_acara`
--

CREATE TABLE `pendaftaran_acara` (
  `id` bigint UNSIGNED NOT NULL,
  `modul_acara_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `metode_daftar` enum('self','invite') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'self',
  `waktu_daftar` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `has_doorprize` tinyint(1) NOT NULL DEFAULT '0',
  `no_sertifikat` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pendaftaran_acara`
--

INSERT INTO `pendaftaran_acara` (`id`, `modul_acara_id`, `user_id`, `metode_daftar`, `waktu_daftar`, `has_doorprize`, `no_sertifikat`, `created_at`, `updated_at`) VALUES
(173, 47, 18, 'self', '2025-11-02 18:27:15', 1, 'EVT9213/2025/001', '2025-11-03 01:27:15', '2025-11-03 01:40:36'),
(175, 45, 46, 'self', '2025-11-02 18:48:48', 1, 'EVT1308/2025/001', '2025-11-03 01:48:48', '2025-11-03 01:54:38'),
(176, 47, 46, 'self', '2025-11-02 18:50:21', 1, 'EVT9213/2025/002', '2025-11-03 01:50:21', '2025-11-03 01:51:19'),
(179, 42, 29, 'self', '2025-11-02 21:05:26', 0, NULL, '2025-11-03 04:05:26', '2025-11-03 04:05:26'),
(180, 46, 29, 'self', '2025-11-02 22:24:54', 1, 'EVT6328/2025/001', '2025-11-03 05:24:54', '2025-11-03 08:58:22'),
(193, 42, 48, 'self', '2025-11-03 07:53:05', 0, NULL, '2025-11-03 14:53:05', '2025-11-03 14:53:05'),
(194, 47, 49, 'self', '2025-11-03 12:53:30', 0, NULL, NULL, NULL),
(201, 42, 49, 'self', '2025-11-03 20:41:12', 0, NULL, '2025-11-04 03:41:11', '2025-11-04 03:41:11'),
(204, 56, 6, 'self', '2025-11-03 21:22:09', 0, NULL, '2025-11-04 04:22:09', '2025-11-04 04:22:09'),
(205, 42, 59, 'self', '2025-11-03 21:50:41', 0, 'EVT9158/2025/001', '2025-11-04 04:50:41', '2025-11-04 04:53:57'),
(206, 46, 59, 'self', '2025-11-03 21:51:25', 0, NULL, '2025-11-04 04:51:25', '2025-11-04 04:51:25'),
(209, 97, 49, 'self', '2025-11-03 22:57:08', 1, 'EVT6292/2025/001', '2025-11-04 05:57:08', '2025-11-04 05:57:17'),
(210, 46, 42, 'self', '2025-11-03 23:00:52', 0, NULL, '2025-11-04 06:00:52', '2025-11-04 06:00:52'),
(219, 98, 66, 'self', '2025-11-04 00:21:26', 0, 'EVT2804/2025/004', '2025-11-04 07:21:26', '2025-11-04 11:42:21'),
(220, 97, 66, 'self', '2025-11-04 00:57:29', 0, NULL, '2025-11-04 07:57:29', '2025-11-04 07:57:29'),
(222, 98, 70, 'self', '2025-11-04 01:44:47', 1, 'EVT2804/2025/001', '2025-11-04 08:44:47', '2025-11-04 08:50:33'),
(223, 46, 68, 'self', '2025-11-04 01:53:10', 0, NULL, '2025-11-04 08:53:10', '2025-11-04 08:53:10'),
(224, 98, 68, 'self', '2025-11-04 01:53:17', 0, NULL, '2025-11-04 08:53:17', '2025-11-04 08:53:17'),
(225, 97, 68, 'self', '2025-11-04 01:53:36', 0, NULL, '2025-11-04 08:53:36', '2025-11-04 08:53:36'),
(228, 46, 71, 'self', '2025-11-04 02:02:20', 0, NULL, '2025-11-04 09:02:20', '2025-11-04 09:02:20'),
(229, 98, 71, 'self', '2025-11-04 02:02:31', 0, NULL, '2025-11-04 09:02:31', '2025-11-04 09:02:31'),
(230, 97, 71, 'self', '2025-11-04 02:04:27', 0, NULL, '2025-11-04 09:04:27', '2025-11-04 09:04:27'),
(232, 46, 37, 'self', '2025-11-04 02:16:50', 0, NULL, '2025-11-04 09:16:50', '2025-11-04 09:16:50'),
(233, 97, 37, 'self', '2025-11-04 02:17:31', 0, NULL, '2025-11-04 09:17:31', '2025-11-04 09:17:31'),
(235, 98, 73, 'self', '2025-11-04 02:35:55', 0, NULL, '2025-11-04 09:35:55', '2025-11-04 09:35:55'),
(238, 100, 74, 'self', '2025-11-04 02:40:04', 1, 'EVT4999/2025/001', '2025-11-04 09:40:04', '2025-11-04 09:48:43'),
(239, 100, 76, 'self', '2025-11-04 02:40:30', 1, 'EVT4999/2025/003', '2025-11-04 09:40:30', '2025-11-04 09:49:29'),
(240, 100, 73, 'self', '2025-11-04 02:42:16', 0, 'EVT4999/2025/004', '2025-11-04 09:42:16', '2025-11-04 09:50:43'),
(241, 100, 37, 'self', '2025-11-04 02:42:38', 0, NULL, '2025-11-04 09:42:38', '2025-11-04 09:42:38'),
(242, 100, 77, 'self', '2025-11-04 02:47:30', 0, 'EVT4999/2025/002', '2025-11-04 09:47:30', '2025-11-04 09:49:10'),
(243, 46, 67, 'self', '2025-11-04 03:22:23', 0, NULL, '2025-11-04 10:22:23', '2025-11-04 10:22:23'),
(244, 98, 6, 'self', '2025-11-04 03:23:12', 0, 'EVT2804/2025/002', '2025-11-04 10:23:12', '2025-11-04 10:23:52'),
(245, 98, 78, 'self', '2025-11-04 03:44:52', 0, NULL, '2025-11-04 10:44:52', '2025-11-04 10:44:52'),
(246, 97, 83, 'self', '2025-11-04 03:58:53', 0, NULL, '2025-11-04 10:58:53', '2025-11-04 10:58:53'),
(247, 98, 67, 'self', '2025-11-04 04:02:28', 0, NULL, '2025-11-04 11:02:28', '2025-11-04 11:02:28'),
(248, 46, 88, 'self', '2025-11-04 04:04:32', 0, NULL, '2025-11-04 11:04:32', '2025-11-04 11:04:32'),
(249, 98, 89, 'self', '2025-11-04 04:14:15', 1, 'EVT2804/2025/003', '2025-11-04 11:14:15', '2025-11-04 11:16:00'),
(250, 102, 89, 'self', '2025-11-04 04:20:05', 1, 'EVT9483/2025/001', '2025-11-04 11:20:05', '2025-11-04 11:20:35'),
(251, 98, 20, 'self', '2025-11-04 04:58:25', 0, NULL, '2025-11-04 11:58:25', '2025-11-04 11:58:25'),
(252, 46, 20, 'self', '2025-11-04 05:00:34', 0, NULL, '2025-11-04 12:00:34', '2025-11-04 12:00:34'),
(253, 98, 92, 'self', '2025-11-04 06:06:56', 0, 'EVT2804/2025/005', '2025-11-04 13:06:56', '2025-11-04 13:14:07'),
(254, 102, 30, 'self', '2025-11-04 06:43:00', 0, 'EVT9483/2025/002', '2025-11-04 13:43:00', '2025-11-04 14:55:09'),
(255, 46, 95, 'self', '2025-11-04 07:02:42', 0, NULL, '2025-11-04 14:02:42', '2025-11-04 14:02:42'),
(256, 102, 51, 'self', '2025-11-04 07:13:41', 0, NULL, '2025-11-04 14:13:41', '2025-11-04 14:13:41'),
(257, 102, 73, 'self', '2025-11-04 07:53:17', 0, NULL, '2025-11-04 14:53:16', '2025-11-04 14:53:16'),
(258, 102, 94, 'self', '2025-11-04 07:53:44', 0, NULL, '2025-11-04 14:53:44', '2025-11-04 14:53:44'),
(259, 46, 30, 'self', '2025-11-04 07:53:48', 0, NULL, '2025-11-04 14:53:48', '2025-11-04 14:53:48'),
(260, 46, 99, 'self', '2025-11-04 07:58:01', 0, NULL, '2025-11-04 14:58:01', '2025-11-04 14:58:01');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 7, 'auth_token', 'fa49cf629e2d5b626649f9c9fec2cdc982ee6bef9ba0cfecb8e5b3562e9d3270', '[\"*\"]', '2025-10-31 16:02:10', NULL, '2025-10-31 16:00:15', '2025-10-31 16:02:10'),
(2, 'App\\Models\\User', 5, 'auth_token', 'e2fee0620dfedf5d17bd7cab21ee49a6829fcf9aadfee6a587e048e1a99ab286', '[\"*\"]', '2025-10-31 16:02:07', NULL, '2025-10-31 16:01:45', '2025-10-31 16:02:07'),
(3, 'App\\Models\\User', 18, 'auth_token', '2f8c660953788d89952bf5b689a38ae476c239e90cb3f598edc64b506efd4e83', '[\"*\"]', NULL, NULL, '2025-10-31 16:02:18', '2025-10-31 16:02:18'),
(4, 'App\\Models\\User', 18, 'auth_token', '5c1a6b5263cdb9bdc0b55fb377612b48bc2128250e48ae7f159a92778728d098', '[\"*\"]', '2025-10-31 16:27:10', NULL, '2025-10-31 16:02:25', '2025-10-31 16:27:10'),
(5, 'App\\Models\\User', 7, 'auth_token', '4c9bc40e6c678610bd4c14ae24ae3ce56c96dab9d675d0ac6b3ab310ccfc6cef', '[\"*\"]', NULL, NULL, '2025-10-31 16:03:44', '2025-10-31 16:03:44'),
(6, 'App\\Models\\User', 5, 'auth_token', 'aa11cce39314570b9f8b7fb262932114133c2d0317b3fb91b621be14d7f24fcd', '[\"*\"]', '2025-10-31 16:16:04', NULL, '2025-10-31 16:12:28', '2025-10-31 16:16:04'),
(7, 'App\\Models\\User', 18, 'auth_token', '3b00221d63f7640ee87ba59dd7c9d270013a145781bc099892370f58825c04e4', '[\"*\"]', '2025-10-31 16:17:48', NULL, '2025-10-31 16:17:25', '2025-10-31 16:17:48'),
(8, 'App\\Models\\User', 5, 'auth_token', 'b4bd52aa75de9a9956bca3cb147e46eacbdc1b7ee5b3cdfef88ebc3839005a10', '[\"*\"]', '2025-10-31 16:19:09', NULL, '2025-10-31 16:18:53', '2025-10-31 16:19:09'),
(9, 'App\\Models\\User', 18, 'auth_token', '57ec67782c4039c24effebd190fad28bd5f0d74e34abfc6b0472fb1587470324', '[\"*\"]', '2025-10-31 16:45:18', NULL, '2025-10-31 16:20:11', '2025-10-31 16:45:18'),
(10, 'App\\Models\\User', 5, 'auth_token', 'c48e83783dc8f9ea4f4e2e44eae616911c8dddde5173fc8fa07d223ec19425f0', '[\"*\"]', NULL, NULL, '2025-10-31 16:20:24', '2025-10-31 16:20:24'),
(11, 'App\\Models\\User', 5, 'auth_token', 'fc8590d3eb98564f8e38e3dee268c88d578eb7d407cd27678b24e8789c87a1e0', '[\"*\"]', '2025-10-31 16:24:39', NULL, '2025-10-31 16:22:34', '2025-10-31 16:24:39'),
(12, 'App\\Models\\User', 5, 'auth_token', 'b2ebc5a5ee91949b17c8524aa6d61c5313b0e30d4e27bbd5c7325b6cae57442a', '[\"*\"]', '2025-10-31 16:29:26', NULL, '2025-10-31 16:23:25', '2025-10-31 16:29:26'),
(13, 'App\\Models\\User', 18, 'auth_token', 'a0922068c84d7685462405d07cc45512b8c0858035f3edda27812aa20b496c4e', '[\"*\"]', '2025-10-31 16:26:14', NULL, '2025-10-31 16:25:45', '2025-10-31 16:26:14'),
(14, 'App\\Models\\User', 5, 'auth_token', '680721d2eceaa55577c326dd47bbd4bf667dd83540ffbd1ae5011ee934dea2bf', '[\"*\"]', '2025-10-31 16:41:46', NULL, '2025-10-31 16:30:15', '2025-10-31 16:41:46'),
(15, 'App\\Models\\User', 5, 'auth_token', 'b643866fd5cacb9f4fc2cffd013336e026db0601cebe21868a3c899f5514b458', '[\"*\"]', '2025-10-31 16:51:11', NULL, '2025-10-31 16:31:23', '2025-10-31 16:51:11'),
(16, 'App\\Models\\User', 5, 'auth_token', 'd8fe293ba4cdcaa33e183274a7c55059b1334308acb9388805df241d76ee8f2d', '[\"*\"]', '2025-11-01 18:13:57', NULL, '2025-10-31 16:35:16', '2025-11-01 18:13:57'),
(17, 'App\\Models\\User', 5, 'auth_token', 'b47d714ce1ddf97e9a0473550608be6d27b2fc894582b2c05679d9a6cf443fb7', '[\"*\"]', '2025-10-31 16:44:53', NULL, '2025-10-31 16:41:54', '2025-10-31 16:44:53'),
(18, 'App\\Models\\User', 18, 'auth_token', '5404eaf15af057385112f1d5a0dffb404f14922d188ae12fa19d8e69bd4fe08a', '[\"*\"]', '2025-10-31 16:47:16', NULL, '2025-10-31 16:46:17', '2025-10-31 16:47:16'),
(19, 'App\\Models\\User', 5, 'auth_token', '93e06499eb3768b15dbb4cd4b37aec9146d7256b364c03a18e27e83e9094e379', '[\"*\"]', '2025-10-31 16:56:34', NULL, '2025-10-31 16:49:03', '2025-10-31 16:56:34'),
(20, 'App\\Models\\User', 6, 'auth_token', '90a33ca1b7ff4368ed9b13aa080824b71a0ec2963f1201b20e53a2b3d9104832', '[\"*\"]', NULL, NULL, '2025-10-31 16:49:13', '2025-10-31 16:49:13'),
(21, 'App\\Models\\User', 18, 'auth_token', '1681a0a3a70e9befefac37188c4f92d848c59f65b24c7a69d787b0fd4d8cc172', '[\"*\"]', '2025-10-31 17:51:00', NULL, '2025-10-31 17:25:31', '2025-10-31 17:51:00'),
(22, 'App\\Models\\User', 19, 'auth_token', '61a92523cbbdff681e042db5bdb84f6fb033dd19631c8118db6bd7bc97a0dc83', '[\"*\"]', NULL, NULL, '2025-10-31 17:55:42', '2025-10-31 17:55:42'),
(23, 'App\\Models\\User', 5, 'auth_token', '29dc2f09e41ebadba027fd920020edd1e4b4fe93ce90db02e2e1732fcba8b097', '[\"*\"]', NULL, NULL, '2025-10-31 17:56:13', '2025-10-31 17:56:13'),
(24, 'App\\Models\\User', 5, 'auth_token', 'd022d16d57cbb877d8b448a519c42c207da0a0ea2bcf3db06878a363f05bfc0b', '[\"*\"]', NULL, NULL, '2025-10-31 17:57:05', '2025-10-31 17:57:05'),
(25, 'App\\Models\\User', 5, 'auth_token', 'f74cebef4b0d5111a06f9cc3f8c444100a3f25ff003b3502b0be1f5cefe25c5f', '[\"*\"]', '2025-11-02 05:50:56', NULL, '2025-10-31 17:58:23', '2025-11-02 05:50:56'),
(26, 'App\\Models\\User', 5, 'auth_token', 'ddcb9ee0fbe4f0f72c95a09e23344437e7cfcb65728f02315e65313ea623d14c', '[\"*\"]', NULL, NULL, '2025-10-31 18:00:19', '2025-10-31 18:00:19'),
(27, 'App\\Models\\User', 5, 'auth_token', 'e33a807ab3871f04dfda12128eb36c0f4eebf1b48522f21e28dd6f6d319d915e', '[\"*\"]', NULL, NULL, '2025-10-31 18:00:38', '2025-10-31 18:00:38'),
(28, 'App\\Models\\User', 5, 'auth_token', 'e1fd876d9e28b9a242f266b934f1fe5cd668421c08d304afb32cad987c4c65c7', '[\"*\"]', NULL, NULL, '2025-10-31 18:01:27', '2025-10-31 18:01:27'),
(29, 'App\\Models\\User', 5, 'auth_token', '3160cc1f12af5b6675c8e1a245d1ff8f35aca50a7a34fa3a6021a1a8ab985c30', '[\"*\"]', NULL, NULL, '2025-10-31 18:06:10', '2025-10-31 18:06:10'),
(30, 'App\\Models\\User', 5, 'auth_token', '808b9523c0a181a2ae6e72359896e84005f6b55c8ccf609b56348cd61047efd9', '[\"*\"]', NULL, NULL, '2025-10-31 18:09:56', '2025-10-31 18:09:56'),
(31, 'App\\Models\\User', 5, 'auth_token', '875057b2b42f10e4a0f1f1bcaf9e61b8885840eb075c60e2461c81f5540cb0b9', '[\"*\"]', NULL, NULL, '2025-10-31 18:10:42', '2025-10-31 18:10:42'),
(32, 'App\\Models\\User', 5, 'auth_token', '6671b6fc7632ffbb4014fcb2bbf23dc7cc9991e68e71e42310d5c93b51ef6486', '[\"*\"]', NULL, NULL, '2025-10-31 18:11:20', '2025-10-31 18:11:20'),
(33, 'App\\Models\\User', 6, 'auth_token', 'f91040c482f3dc4d0fe9b5afef99af9b9b48593b733ddb4b2dea5a58a6bb4db6', '[\"*\"]', '2025-10-31 18:44:17', NULL, '2025-10-31 18:11:40', '2025-10-31 18:44:17'),
(34, 'App\\Models\\User', 5, 'auth_token', '0c3a81453de09e12a676bffaba37af6cfe064263414310dabceca59b9afcd464', '[\"*\"]', NULL, NULL, '2025-10-31 18:12:10', '2025-10-31 18:12:10'),
(35, 'App\\Models\\User', 5, 'auth_token', 'c9e6080a969ed3f326e62275f3e8a3a670960a822f382cda7754117834e9aa13', '[\"*\"]', NULL, NULL, '2025-10-31 18:27:23', '2025-10-31 18:27:23'),
(36, 'App\\Models\\User', 5, 'auth_token', '4f8fdb5a8fd645803553719361de85b591caaac0f8df17b05e41df392aeb9112', '[\"*\"]', '2025-10-31 18:31:26', NULL, '2025-10-31 18:30:18', '2025-10-31 18:31:26'),
(37, 'App\\Models\\User', 5, 'auth_token', 'ce8139ab81e861abe7e79b9a396be46c83eea8ff729dc99d76b3d53dd1ef7833', '[\"*\"]', NULL, NULL, '2025-10-31 18:39:15', '2025-10-31 18:39:15'),
(38, 'App\\Models\\User', 18, 'auth_token', '907ce15bfa91c39b0896867805b691b39cc074681f62eba13d1608c2acf1ccfc', '[\"*\"]', NULL, NULL, '2025-10-31 18:44:18', '2025-10-31 18:44:18'),
(39, 'App\\Models\\User', 20, 'auth_token', 'bc73e1df685784ddb5f06fc23610668475d53708f178bf169f37736e96da8a36', '[\"*\"]', '2025-11-03 00:04:41', NULL, '2025-10-31 20:36:19', '2025-11-03 00:04:41'),
(42, 'App\\Models\\User', 18, 'auth_token', 'e911baaeae9b0819762f4699f265c02154e8dc2537560f528682b5c9515db483', '[\"*\"]', '2025-10-31 21:39:15', NULL, '2025-10-31 20:43:09', '2025-10-31 21:39:15'),
(43, 'App\\Models\\User', 18, 'auth_token', '121ef3556ade3e27110d97b061b7618d60496fcbdbaaef20fa8e69a03f3d892b', '[\"*\"]', '2025-10-31 20:45:17', NULL, '2025-10-31 20:44:59', '2025-10-31 20:45:17'),
(44, 'App\\Models\\User', 5, 'auth_token', 'f33f9988f8eb8f039e753ed8617c120d3733b0424680a5869c8c023439e1f0a1', '[\"*\"]', NULL, NULL, '2025-10-31 21:04:01', '2025-10-31 21:04:01'),
(45, 'App\\Models\\User', 18, 'auth_token', '5ff0644be9256ffede25caa558b9ab4f4e070712012cbee12ac42f74f14d3466', '[\"*\"]', NULL, NULL, '2025-10-31 21:05:45', '2025-10-31 21:05:45'),
(46, 'App\\Models\\User', 5, 'auth_token', 'f8fe50242522eeba35ece511442b4d49064f14a2cf87f3b5faba81729ee6c9c8', '[\"*\"]', NULL, NULL, '2025-10-31 21:06:10', '2025-10-31 21:06:10'),
(49, 'App\\Models\\User', 5, 'auth_token', 'a4be1bbb4c6c14c7f220bae7753446949cc1bc005458f7cd8c23cb523b86e9a2', '[\"*\"]', '2025-11-01 18:49:50', NULL, '2025-10-31 21:29:03', '2025-11-01 18:49:50'),
(50, 'App\\Models\\User', 5, 'auth_token', 'b19ca4a926f46c06c828a6276f0e31256df5a163b672602b6db1d121f438ea0f', '[\"*\"]', NULL, NULL, '2025-10-31 21:31:35', '2025-10-31 21:31:35'),
(51, 'App\\Models\\User', 5, 'auth_token', '60921d9e1ea39d6415c60e1d408e695f369e5a0be2ff8716ea3553a5bcdb60f9', '[\"*\"]', '2025-11-01 13:24:52', NULL, '2025-10-31 21:34:46', '2025-11-01 13:24:52'),
(53, 'App\\Models\\User', 5, 'auth_token', 'b482c9b78732fb45c42541eed683d00cf6a564ffcb12f37d1c7467430b3a3f22', '[\"*\"]', '2025-10-31 21:46:31', NULL, '2025-10-31 21:40:59', '2025-10-31 21:46:31'),
(54, 'App\\Models\\User', 5, 'auth_token', '06d41f837013147382878a533106f245782cc3836694935e5a78e9ca5b398373', '[\"*\"]', '2025-11-02 01:39:05', NULL, '2025-10-31 21:41:20', '2025-11-02 01:39:05'),
(55, 'App\\Models\\User', 5, 'auth_token', '26dd040c71b878cb2da2f507add65cd37cd9121dba2d2fc985a805a092dd7a9e', '[\"*\"]', '2025-11-01 00:55:45', NULL, '2025-10-31 21:55:02', '2025-11-01 00:55:45'),
(57, 'App\\Models\\User', 18, 'auth_token', '582d0980842abe49c086707dc5980d5bafdf90506d7ce53ebfd916df88cc8dc1', '[\"*\"]', '2025-10-31 22:09:05', NULL, '2025-10-31 22:09:05', '2025-10-31 22:09:05'),
(58, 'App\\Models\\User', 18, 'auth_token', '785010130712a024cc7eca97f889fdc50da9cdea2cc24dae72b3eae9644f9a20', '[\"*\"]', '2025-10-31 22:12:55', NULL, '2025-10-31 22:11:47', '2025-10-31 22:12:55'),
(59, 'App\\Models\\User', 18, 'auth_token', '179044201f3b34d5df3700cb131b7b519b594575e2fbc9a12d9c161d1193234d', '[\"*\"]', NULL, NULL, '2025-10-31 22:16:35', '2025-10-31 22:16:35'),
(60, 'App\\Models\\User', 18, 'auth_token', '116057d3be3fb012a9ff904278ed48e1dd42ac54f2b385313bfd81772441eb3a', '[\"*\"]', '2025-11-01 04:52:27', NULL, '2025-10-31 22:16:35', '2025-11-01 04:52:27'),
(61, 'App\\Models\\User', 5, 'auth_token', '815947f0feff41a4ff7a78c2ef386714ce77d444ca6bb25e0cc210100572c5f0', '[\"*\"]', '2025-11-01 01:51:18', NULL, '2025-10-31 22:56:17', '2025-11-01 01:51:18'),
(62, 'App\\Models\\User', 5, 'auth_token', 'ec67dd11c1c78251720571a57b24322b85f2669072293bc46c98fd265d40ba3c', '[\"*\"]', '2025-11-01 05:51:56', NULL, '2025-10-31 23:39:29', '2025-11-01 05:51:56'),
(63, 'App\\Models\\User', 18, 'auth_token', 'b2e1f80513ea62c5f8cb5717d54c9e6cf9e2ab9a0b45ca6124b7216537798341', '[\"*\"]', '2025-11-01 01:51:57', NULL, '2025-11-01 01:04:20', '2025-11-01 01:51:57'),
(64, 'App\\Models\\User', 5, 'auth_token', 'c0a3aaf2ae17c685f1f06c9f20518216c9a992916615b8e0a919d00c5e3d142d', '[\"*\"]', '2025-11-01 01:50:45', NULL, '2025-11-01 01:36:09', '2025-11-01 01:50:45'),
(65, 'App\\Models\\User', 18, 'auth_token', 'd59e868eccd06f2cf06fa84a0883150618e86812c0c840944b8162152c73551a', '[\"*\"]', '2025-11-01 06:13:26', NULL, '2025-11-01 04:52:41', '2025-11-01 06:13:26'),
(66, 'App\\Models\\User', 18, 'auth_token', '8efdc68b0aba847a34973227be4057f976de86409b0ffbae3b33f4571b9a5f8b', '[\"*\"]', '2025-11-01 05:35:37', NULL, '2025-11-01 04:56:34', '2025-11-01 05:35:37'),
(67, 'App\\Models\\User', 5, 'auth_token', '8aafb00e31faf761e8405749aae8d18be9d1d396deba702a7eaaaf3d75507fe2', '[\"*\"]', '2025-11-01 06:02:54', NULL, '2025-11-01 05:07:09', '2025-11-01 06:02:54'),
(69, 'App\\Models\\User', 18, 'auth_token', '5bec20a9f25f47d0cbfb7983dd13d2fa324d5bea4a47711f3dcf25004e187ea1', '[\"*\"]', '2025-11-01 06:26:32', NULL, '2025-11-01 06:25:36', '2025-11-01 06:26:32'),
(70, 'App\\Models\\User', 5, 'auth_token', '4f967cb96572c880c247954be357459b799105ae2f4e1dbcb773925fd87c5294', '[\"*\"]', NULL, NULL, '2025-11-01 06:27:37', '2025-11-01 06:27:37'),
(72, 'App\\Models\\User', 6, 'auth_token', 'b5ef5c5e51e503904f06be17e1b359986ade60bdb33fba41c69b3e25bf8b850f', '[\"*\"]', NULL, NULL, '2025-11-01 06:40:30', '2025-11-01 06:40:30'),
(74, 'App\\Models\\User', 6, 'auth_token', '475d17b6ce5922fc9a59a8179c74d2b2d86703ef8d44e0f498909007fd40f900', '[\"*\"]', NULL, NULL, '2025-11-01 06:58:35', '2025-11-01 06:58:35'),
(77, 'App\\Models\\User', 18, 'auth_token', 'a9f6f9d567b4ad7028dcec1ad2eef19dada9f21bfa6c88b8453b136f93f7428c', '[\"*\"]', '2025-11-01 07:51:27', NULL, '2025-11-01 07:44:51', '2025-11-01 07:51:27'),
(78, 'App\\Models\\User', 18, 'auth_token', '6645dc441436bd6b2e16245261aa4a46907af6001a9c697db0a4f79a3727bc71', '[\"*\"]', NULL, NULL, '2025-11-01 08:04:41', '2025-11-01 08:04:41'),
(80, 'App\\Models\\User', 20, 'auth_token', 'cc9cd8834ac1375d9d11d96a5084f08cfd1f014bdf3129ab9b040c33bfd053ec', '[\"*\"]', '2025-11-03 00:04:21', NULL, '2025-11-01 08:08:52', '2025-11-03 00:04:21'),
(82, 'App\\Models\\User', 20, 'auth_token', 'c7261f0bf8d6c86c037614608a502dbd551d647c0a698122b1771437c49e59f6', '[\"*\"]', NULL, NULL, '2025-11-01 08:14:04', '2025-11-01 08:14:04'),
(83, 'App\\Models\\User', 20, 'auth_token', '139867701b9b04980f7cf56c55a6f73c30e2badec904ecf778d522cedea06bd5', '[\"*\"]', NULL, NULL, '2025-11-01 08:15:05', '2025-11-01 08:15:05'),
(84, 'App\\Models\\User', 5, 'auth_token', '728eeaa8beca63372edde3b8954d8f2565b2faf4aefce9be6bc66871687a5318', '[\"*\"]', '2025-11-01 13:21:42', NULL, '2025-11-01 08:23:20', '2025-11-01 13:21:42'),
(86, 'App\\Models\\User', 5, 'auth_token', 'a04fb22674df413eeba1854870a6b87ccaade760552fa8e0dfd8036b296fce2c', '[\"*\"]', '2025-11-02 01:00:11', NULL, '2025-11-01 08:46:10', '2025-11-02 01:00:11'),
(87, 'App\\Models\\User', 6, 'auth_token', 'ee51196b599e293422b3a305198f5b26052d3b1b3b14367c04a077e8004a07e9', '[\"*\"]', '2025-11-01 08:54:50', NULL, '2025-11-01 08:54:19', '2025-11-01 08:54:50'),
(89, 'App\\Models\\User', 6, 'auth_token', '1846cf7610c6a6fa33f3a3b2cc20df971a8fe5a3993a3c047fd4b39fd1813b0c', '[\"*\"]', '2025-11-01 10:26:00', NULL, '2025-11-01 10:07:21', '2025-11-01 10:26:00'),
(90, 'App\\Models\\User', 5, 'auth_token', '1732595a423ed83395113f26eedb908bfb61f2942ec307b1e974be5aaa9d137d', '[\"*\"]', '2025-11-01 11:50:01', NULL, '2025-11-01 10:11:40', '2025-11-01 11:50:01'),
(91, 'App\\Models\\User', 6, 'auth_token', '440cca34820e917182d0272bfc798353efa10c77bb2b5a7abbd41ed1934a1936', '[\"*\"]', NULL, NULL, '2025-11-01 10:33:00', '2025-11-01 10:33:00'),
(92, 'App\\Models\\User', 6, 'auth_token', '10ae73bb2f67a647678ceeb5352fe32c859f4fa5f3a121836053cd432f2f6679', '[\"*\"]', '2025-11-03 17:20:11', NULL, '2025-11-01 10:34:56', '2025-11-03 17:20:11'),
(93, 'App\\Models\\User', 6, 'auth_token', 'a12b615186a03ce16ab826e4a73e89ef01632e47fe5d959194575bdeb09e7177', '[\"*\"]', NULL, NULL, '2025-11-01 10:46:55', '2025-11-01 10:46:55'),
(94, 'App\\Models\\User', 20, 'auth_token', '35e9542a7bba024ec1766dcd70851b876ec496f9c6cd85dd45850c304739052a', '[\"*\"]', '2025-11-03 00:04:10', NULL, '2025-11-01 11:46:23', '2025-11-03 00:04:10'),
(95, 'App\\Models\\User', 20, 'auth_token', '56f836e16b47d100becd0eceb151e4a825779afc33e1ffe7c28ab74429f04b60', '[\"*\"]', NULL, NULL, '2025-11-01 12:25:28', '2025-11-01 12:25:28'),
(97, 'App\\Models\\User', 5, 'auth_token', '40321be5ffd7edca29a2488addf6a0a03946f0d666567d9abc9e5c10aa63be00', '[\"*\"]', '2025-11-01 16:47:24', NULL, '2025-11-01 12:53:26', '2025-11-01 16:47:24'),
(98, 'App\\Models\\User', 20, 'auth_token', 'f8586287f577056cb3e2cb00a678286e066e97f382cb3028b11c3504054a49c3', '[\"*\"]', NULL, NULL, '2025-11-01 12:59:30', '2025-11-01 12:59:30'),
(99, 'App\\Models\\User', 20, 'auth_token', '5f7ce4a4ec3720428b340459772d2a96d4baecaa43dee73f00c74bb0777459d3', '[\"*\"]', NULL, NULL, '2025-11-01 13:02:39', '2025-11-01 13:02:39'),
(100, 'App\\Models\\User', 20, 'auth_token', '7463752e1b5bac2df13b5ba9e53a851c001cc0dda11d04e8b21039f3dae50496', '[\"*\"]', '2025-11-01 13:03:26', NULL, '2025-11-01 13:03:15', '2025-11-01 13:03:26'),
(101, 'App\\Models\\User', 18, 'auth_token', '0d9e964c79ce4a2a71d8358b569be84f6f498f2ede655700b06788bc0bb61d1d', '[\"*\"]', '2025-11-01 13:11:43', NULL, '2025-11-01 13:11:34', '2025-11-01 13:11:43'),
(104, 'App\\Models\\User', 20, 'auth_token', '6b927c16905f991efb7ac0b186485277c56dd95a82e5f239873e4e7a178c075c', '[\"*\"]', NULL, NULL, '2025-11-01 13:33:37', '2025-11-01 13:33:37'),
(105, 'App\\Models\\User', 26, 'auth_token', '9dcce736eef24129cf0a57cfd6af52eea78034d872fb7caf3b297d0e77ab7500', '[\"*\"]', NULL, NULL, '2025-11-01 13:35:58', '2025-11-01 13:35:58'),
(106, 'App\\Models\\User', 18, 'auth_token', 'b19b1458e64e271ced092bfdbcb89503bb295f957ea2d7a3a6249fc2c1d0401d', '[\"*\"]', '2025-11-01 17:16:20', NULL, '2025-11-01 13:45:19', '2025-11-01 17:16:20'),
(107, 'App\\Models\\User', 18, 'auth_token', '399a22ce06dcee65b2675cc695369ed3001aa4b8cea78dcae8b8b9103ecd2a4a', '[\"*\"]', '2025-11-01 13:46:41', NULL, '2025-11-01 13:46:37', '2025-11-01 13:46:41'),
(108, 'App\\Models\\User', 5, 'auth_token', 'd7d210cc10368eedddbc1812fa211b079f3dc47b785c0f4a693ffe31e94ececb', '[\"*\"]', '2025-11-01 14:28:44', NULL, '2025-11-01 13:51:00', '2025-11-01 14:28:44'),
(109, 'App\\Models\\User', 24, 'auth_token', 'f3f6958a9c773737dac8cf340640eac02a542c0cdf9d99c48dffebf0b4e02493', '[\"*\"]', '2025-11-01 15:20:42', NULL, '2025-11-01 13:55:30', '2025-11-01 15:20:42'),
(110, 'App\\Models\\User', 5, 'auth_token', '68c9dc2558bbacf872f7e2aa4baf909fbea1588cbb063e567d47f74f7e330896', '[\"*\"]', NULL, NULL, '2025-11-01 14:32:37', '2025-11-01 14:32:37'),
(111, 'App\\Models\\User', 5, 'auth_token', 'e10f9a621563328b644bc077cab4ee701eb42623bfcbdf59e0722555cd44ad57', '[\"*\"]', '2025-11-01 21:01:49', NULL, '2025-11-01 14:32:49', '2025-11-01 21:01:49'),
(112, 'App\\Models\\User', 5, 'auth_token', '142d90f175507e411d2c9c68184c24309c8fc794471ae55634a9aa7040feaf1d', '[\"*\"]', '2025-11-01 18:19:44', NULL, '2025-11-01 14:33:53', '2025-11-01 18:19:44'),
(113, 'App\\Models\\User', 6, 'auth_token', 'a12eac2802cfffb0d8f25ca67bf63d7f43a20252cd6705559e99110c679ec81c', '[\"*\"]', '2025-11-01 17:09:47', NULL, '2025-11-01 14:47:11', '2025-11-01 17:09:47'),
(114, 'App\\Models\\User', 20, 'auth_token', 'af600de3d1c37193d7d6236c50c5137c936704ba8720dc6cae38187d3f0494b6', '[\"*\"]', '2025-11-01 15:13:19', NULL, '2025-11-01 15:09:06', '2025-11-01 15:13:19'),
(115, 'App\\Models\\User', 5, 'auth_token', '73f23da8aa5461d7e1e417cdc71172031f07fed75c22daf996f7f6a59a4ec33a', '[\"*\"]', '2025-11-01 17:29:23', NULL, '2025-11-01 16:50:54', '2025-11-01 17:29:23'),
(116, 'App\\Models\\User', 5, 'auth_token', 'e5fd040405dc6e5da455c758275689c380953de2cf2931042629cc05eb32cd3b', '[\"*\"]', '2025-11-01 17:25:26', NULL, '2025-11-01 17:14:52', '2025-11-01 17:25:26'),
(117, 'App\\Models\\User', 18, 'auth_token', 'f43e69d7fa55049af57643f18f8533a0171a57152d7fb2cf1dfb442fd306f1cc', '[\"*\"]', '2025-11-02 16:09:01', NULL, '2025-11-01 17:17:59', '2025-11-02 16:09:01'),
(118, 'App\\Models\\User', 20, 'auth_token', 'b24b51c6b5106bbd47ef7147e3234cdf14e730ece7d939200bffffffe4e933bc', '[\"*\"]', '2025-11-01 17:47:26', NULL, '2025-11-01 17:29:07', '2025-11-01 17:47:26'),
(119, 'App\\Models\\User', 5, 'auth_token', 'a0e28d7b2b4a3c0f508696ca304322c4803f0a13182eb35bcfad1220786b76f9', '[\"*\"]', NULL, NULL, '2025-11-01 17:35:49', '2025-11-01 17:35:49'),
(120, 'App\\Models\\User', 5, 'auth_token', 'aa862a42f87ecc241e56f7a51259ad0220741a840c768057452354a3a3954582', '[\"*\"]', '2025-11-01 19:26:11', NULL, '2025-11-01 17:37:36', '2025-11-01 19:26:11'),
(122, 'App\\Models\\User', 20, 'auth_token', 'bc5118eb1ab1ac4270315e50202be3be464c82d84788a195e5c78215d9b621b7', '[\"*\"]', '2025-11-01 17:56:58', NULL, '2025-11-01 17:54:12', '2025-11-01 17:56:58'),
(123, 'App\\Models\\User', 20, 'auth_token', '0741d945a112df8989ec3ba4dc58291ff8e55fd63b84e80c086cd211028fd985', '[\"*\"]', '2025-11-01 18:08:19', NULL, '2025-11-01 18:00:46', '2025-11-01 18:08:19'),
(124, 'App\\Models\\User', 5, 'auth_token', 'ca913221917e8bb070097d40cf3fde8c68b97fddf1190c08f95853489ae8d5ea', '[\"*\"]', '2025-11-01 21:48:21', NULL, '2025-11-01 18:21:15', '2025-11-01 21:48:21'),
(125, 'App\\Models\\User', 29, 'auth_token', 'c8d3b83983ed42c181b970c2c325f6a0db6f4a8616f62fbfe86e9e8728e43fb3', '[\"*\"]', '2025-11-01 18:38:44', NULL, '2025-11-01 18:37:12', '2025-11-01 18:38:44'),
(127, 'App\\Models\\User', 5, 'auth_token', '26b316478550777f6c2ae1727fe1ad561a4a0502e228ea8db7156c2781d3bfb2', '[\"*\"]', '2025-11-01 21:47:50', NULL, '2025-11-01 18:45:05', '2025-11-01 21:47:50'),
(128, 'App\\Models\\User', 5, 'auth_token', '41fd960a72e874e907a2dcd8b6a836531c000175796bba01b958fdf93ba9bdba', '[\"*\"]', NULL, NULL, '2025-11-01 19:01:57', '2025-11-01 19:01:57'),
(129, 'App\\Models\\User', 20, 'auth_token', '72a6d9851f85886ec36f4dfe4522b5273e3ce2ae275d794875c47d66fa5e4a8b', '[\"*\"]', '2025-11-01 19:13:57', NULL, '2025-11-01 19:06:11', '2025-11-01 19:13:57'),
(130, 'App\\Models\\User', 5, 'auth_token', '9d16a0ebd6ff550936a0a66210dc36cfed3dcdf4bc9914b7224143e807c7d75f', '[\"*\"]', '2025-11-01 19:07:45', NULL, '2025-11-01 19:07:21', '2025-11-01 19:07:45'),
(131, 'App\\Models\\User', 20, 'auth_token', '5d9b85671c063652134c543ea925b0d8a032cab4e4f95c29525491a755e0c5bd', '[\"*\"]', '2025-11-01 19:09:01', NULL, '2025-11-01 19:09:01', '2025-11-01 19:09:01'),
(132, 'App\\Models\\User', 29, 'auth_token', '69c27a14de1d9833afbbf32bcae8f180161c9646ed576db460c993a49cd292db', '[\"*\"]', '2025-11-01 19:14:05', NULL, '2025-11-01 19:12:53', '2025-11-01 19:14:05'),
(133, 'App\\Models\\User', 20, 'auth_token', '993b80ee83c1c9e42ad9338adbe850cf9a5d88348e499510bb1bbd7b40731035', '[\"*\"]', '2025-11-01 19:15:48', NULL, '2025-11-01 19:14:08', '2025-11-01 19:15:48'),
(136, 'App\\Models\\User', 20, 'auth_token', '2e2be91b4c07048b9fa6874d95d1886f49535c951fc94b1ada378c9bc575b065', '[\"*\"]', '2025-11-01 19:32:29', NULL, '2025-11-01 19:22:00', '2025-11-01 19:32:29'),
(137, 'App\\Models\\User', 5, 'auth_token', 'cfa1d3c465ade8e8d98472bc1ace08183f615a0142329a9fcbd4eafcb2dbfa5a', '[\"*\"]', '2025-11-01 19:35:44', NULL, '2025-11-01 19:26:23', '2025-11-01 19:35:44'),
(139, 'App\\Models\\User', 6, 'auth_token', '848a873b64b5cdb6ca61b7b7ab4ddb0f81736d2b08cfcc2be0da75cfb8a1bfad', '[\"*\"]', NULL, NULL, '2025-11-01 19:35:32', '2025-11-01 19:35:32'),
(140, 'App\\Models\\User', 20, 'auth_token', 'cb25703096beb9fca1bd7ff44fa467ea980f064f290ed15c5aae8b7847d19cc5', '[\"*\"]', '2025-11-01 20:29:30', NULL, '2025-11-01 20:06:24', '2025-11-01 20:29:30'),
(145, 'App\\Models\\User', 18, 'auth_token', 'd13e47879af7bb33a53b92b728498f1f06bffeefa3f58043093f22907a271573', '[\"*\"]', '2025-11-01 20:44:04', NULL, '2025-11-01 20:43:12', '2025-11-01 20:44:04'),
(146, 'App\\Models\\User', 5, 'auth_token', 'b72e98d9a5f83872384b63c285e66fed5a1ab5d8b28d366a996fae4def4a5a60', '[\"*\"]', NULL, NULL, '2025-11-01 20:49:07', '2025-11-01 20:49:07'),
(147, 'App\\Models\\User', 5, 'auth_token', '4d010bf1d86d86ccf3b739b2b4337a01b7346ed2c1b60595958f7bc1bda6488d', '[\"*\"]', '2025-11-01 21:04:50', NULL, '2025-11-01 20:50:19', '2025-11-01 21:04:50'),
(148, 'App\\Models\\User', 5, 'auth_token', 'f5af173aa10a86406fbcda3d8224ca847cc1e1cc11a53432199300ba1482c863', '[\"*\"]', NULL, NULL, '2025-11-01 20:53:27', '2025-11-01 20:53:27'),
(151, 'App\\Models\\User', 5, 'auth_token', 'f8e7168c09bb0692bd89a3a4978bb8249445ade846e5b396e8ce8978d5dac92a', '[\"*\"]', '2025-11-02 00:23:09', NULL, '2025-11-01 21:09:25', '2025-11-02 00:23:09'),
(152, 'App\\Models\\User', 6, 'auth_token', '34d8cd42f2e8bda14422b6472e22e3c0c1b65af86d46e27ee0520166f56f4917', '[\"*\"]', NULL, NULL, '2025-11-01 21:30:42', '2025-11-01 21:30:42'),
(155, 'App\\Models\\User', 6, 'auth_token', '933c4e8f396059f87cc02ce0bf4ce57da400cb6dac13dd394049b06e9922a7f8', '[\"*\"]', '2025-11-03 20:33:30', NULL, '2025-11-01 21:39:05', '2025-11-03 20:33:30'),
(156, 'App\\Models\\User', 5, 'auth_token', 'f27211da0b0a90c8f93a87bb528fdc96f8fe11fda1b60fcca235077d3d3f2636', '[\"*\"]', '2025-11-01 23:45:23', NULL, '2025-11-01 21:49:54', '2025-11-01 23:45:23'),
(158, 'App\\Models\\User', 20, 'auth_token', '85e1a3e82a57221593c7b66de47e5f1d59759acab98891dc466001b6c02ad8df', '[\"*\"]', '2025-11-01 22:00:41', NULL, '2025-11-01 22:00:09', '2025-11-01 22:00:41'),
(159, 'App\\Models\\User', 18, 'auth_token', '73ead729631e7c47d9f6018ea54fed90a79fb9f9f9c071360a59221e14a764a6', '[\"*\"]', '2025-11-01 22:10:50', NULL, '2025-11-01 22:10:26', '2025-11-01 22:10:50'),
(165, 'App\\Models\\User', 6, 'auth_token', 'dd7f24ed1b184885095949624da47965e3914f44ca657962524994bbbd3b1b84', '[\"*\"]', NULL, NULL, '2025-11-01 22:42:54', '2025-11-01 22:42:54'),
(175, 'App\\Models\\User', 5, 'auth_token', '88216aa6e4e557644fecceb36675a799e2c4ee23b0dad20c4657ee2030a08c12', '[\"*\"]', '2025-11-01 23:53:16', NULL, '2025-11-01 23:41:16', '2025-11-01 23:53:16'),
(176, 'App\\Models\\User', 5, 'auth_token', 'b40815dbe2881c080cbdbd3fe8c60b1fbe73682973e61002abf5a434bd967a56', '[\"*\"]', NULL, NULL, '2025-11-01 23:48:37', '2025-11-01 23:48:37'),
(177, 'App\\Models\\User', 5, 'auth_token', '4c07bc82d4b1287b3a88e09e7f1172728cf8efcedb6e860b19da692621f588bd', '[\"*\"]', '2025-11-01 23:57:04', NULL, '2025-11-01 23:49:07', '2025-11-01 23:57:04'),
(178, 'App\\Models\\User', 18, 'auth_token', '8bc2c2e3153b5894d453324001f5b13750964f9e4bd93fad6b43551a84390e09', '[\"*\"]', '2025-11-01 23:53:45', NULL, '2025-11-01 23:53:44', '2025-11-01 23:53:45'),
(181, 'App\\Models\\User', 5, 'auth_token', 'c6b75a3b45433946c8494cc7ec2f76b457044aa725c5e5f1d7c1cc00b8a6c65f', '[\"*\"]', '2025-11-02 01:48:23', NULL, '2025-11-01 23:58:02', '2025-11-02 01:48:23'),
(183, 'App\\Models\\User', 5, 'auth_token', 'd78b974387cf9b5581db7c61e90cc9072817e4e45ce100c119ac98b3287c44ff', '[\"*\"]', NULL, NULL, '2025-11-02 00:23:36', '2025-11-02 00:23:36'),
(184, 'App\\Models\\User', 5, 'auth_token', '10728cedfc2c7e7cf0f48721ecb81fbc23bef6f68419f84eeee32d51da2b9cce', '[\"*\"]', '2025-11-02 00:27:39', NULL, '2025-11-02 00:23:40', '2025-11-02 00:27:39'),
(185, 'App\\Models\\User', 5, 'auth_token', 'b59703e39c8450302e580be3c8cce0cb2407122efa83d1855e5bd5a6aa161d60', '[\"*\"]', '2025-11-02 00:38:54', NULL, '2025-11-02 00:33:00', '2025-11-02 00:38:54'),
(189, 'App\\Models\\User', 18, 'auth_token', '6d1280b9bdb0f891f6973ed081ddc21215e483bf7904e8c0bb8004d4fd678496', '[\"*\"]', '2025-11-02 01:05:34', NULL, '2025-11-02 01:05:15', '2025-11-02 01:05:34'),
(191, 'App\\Models\\User', 5, 'auth_token', '358cfec77cbd7090df8edb6ce57579a003c62e926f0694491cb346f78574a1f5', '[\"*\"]', '2025-11-02 01:14:53', NULL, '2025-11-02 01:11:43', '2025-11-02 01:14:53'),
(192, 'App\\Models\\User', 5, 'auth_token', '12094f304c7e40c2ebf7a3887b553c6d9cfafd7ab640f92dd4d6be893e81a39a', '[\"*\"]', '2025-11-02 01:14:29', NULL, '2025-11-02 01:14:09', '2025-11-02 01:14:29'),
(193, 'App\\Models\\User', 18, 'auth_token', '92ba5e447ac64a9e040d63797190439094ec19fdc6c5828f623acb51f5ffd2c2', '[\"*\"]', '2025-11-02 01:15:08', NULL, '2025-11-02 01:15:00', '2025-11-02 01:15:08'),
(194, 'App\\Models\\User', 3, 'auth_token', '62c0431199f196478af70883066f6c3e1f640da966605938a3434cdad5b43b6b', '[\"*\"]', NULL, NULL, '2025-11-02 01:31:47', '2025-11-02 01:31:47'),
(195, 'App\\Models\\User', 5, 'auth_token', '8ca3feee39072a3a5d0dfa17f7af295c9559922a75b2c78852448ba2ef57dca5', '[\"*\"]', '2025-11-02 14:38:28', NULL, '2025-11-02 01:33:04', '2025-11-02 14:38:28'),
(198, 'App\\Models\\User', 5, 'auth_token', '33aed5c152c03f109a19a6a47837da12cfbf5f61c7ed3c7fe8561a137a1ab5ef', '[\"*\"]', '2025-11-02 01:57:29', NULL, '2025-11-02 01:55:27', '2025-11-02 01:57:29'),
(199, 'App\\Models\\User', 5, 'auth_token', 'f6a0a480f4b9ab4024d4530c53d97b26dac4e1afc471a0379a54cb97abedff8e', '[\"*\"]', '2025-11-02 01:56:27', NULL, '2025-11-02 01:56:17', '2025-11-02 01:56:27'),
(200, 'App\\Models\\User', 3, 'auth_token', 'c6842a5dc9a52cd53be395b25ceada741c9a26adbc0245962643f9743441bc7a', '[\"*\"]', NULL, NULL, '2025-11-02 01:59:31', '2025-11-02 01:59:31'),
(204, 'App\\Models\\User', 18, 'auth_token', 'f1d42e839062369db9b5199413f99ff37bdd0201054729ade993184f61cdf4b6', '[\"*\"]', '2025-11-02 05:53:04', NULL, '2025-11-02 05:52:06', '2025-11-02 05:53:04'),
(205, 'App\\Models\\User', 5, 'auth_token', '688816310b639e0fab2804da6bd36b684877bc01babdff0b964fcda7cf9580a9', '[\"*\"]', '2025-11-02 06:01:12', NULL, '2025-11-02 06:00:47', '2025-11-02 06:01:12'),
(206, 'App\\Models\\User', 18, 'auth_token', 'e306b5296ba0e4bfc599e22a4ee1f4aca0572ca203686042ec4b9bfc0ff1bb0e', '[\"*\"]', '2025-11-02 06:01:54', NULL, '2025-11-02 06:01:42', '2025-11-02 06:01:54'),
(207, 'App\\Models\\User', 5, 'auth_token', '10e7076fcc5cff89733305a6a99ad5a684028eb87f2dc89e0451614de67954e4', '[\"*\"]', '2025-11-02 06:04:07', NULL, '2025-11-02 06:03:51', '2025-11-02 06:04:07'),
(208, 'App\\Models\\User', 18, 'auth_token', 'dcdf87c5020459840d549c6848d826e358bb79a1dea7946cd4854e7c4d745c36', '[\"*\"]', '2025-11-02 06:12:51', NULL, '2025-11-02 06:06:36', '2025-11-02 06:12:51'),
(209, 'App\\Models\\User', 5, 'auth_token', '83e4210c7b2f1d2a9bc755b2fb28eadbceb63b605747222006d458bc68122dec', '[\"*\"]', '2025-11-02 06:53:27', NULL, '2025-11-02 06:17:59', '2025-11-02 06:53:27'),
(210, 'App\\Models\\User', 18, 'auth_token', 'eac51aeea94e21c17d206975f736cf1201af803c33674635b36637a0425dde16', '[\"*\"]', '2025-11-02 06:21:57', NULL, '2025-11-02 06:18:27', '2025-11-02 06:21:57'),
(212, 'App\\Models\\User', 5, 'auth_token', 'a6c1819d6324e5517e90e56c8b013e1e555a6f4249ceacdf733edabedc199146', '[\"*\"]', '2025-11-02 07:41:38', NULL, '2025-11-02 07:39:09', '2025-11-02 07:41:38'),
(213, 'App\\Models\\User', 6, 'auth_token', '5410651972bc681da2de76d8fac29b36857af740863fcd5c77fc56acb5a67da0', '[\"*\"]', '2025-11-02 08:29:28', NULL, '2025-11-02 08:25:11', '2025-11-02 08:29:28'),
(214, 'App\\Models\\User', 5, 'auth_token', '2309a5e7db7e9c3389d47bd43ac90735b205f1e02cadae518ae56c49b4bcdc71', '[\"*\"]', '2025-11-02 09:04:38', NULL, '2025-11-02 09:03:22', '2025-11-02 09:04:38'),
(215, 'App\\Models\\User', 6, 'auth_token', 'cd858c71e49bf8cdc42f8bb4b3e9944f63813f4041c2d8538d7c567a6244010a', '[\"*\"]', '2025-11-02 11:50:28', NULL, '2025-11-02 09:12:42', '2025-11-02 11:50:28'),
(216, 'App\\Models\\User', 5, 'auth_token', '919701a2184f4563b4aea279121bbc63c73395070f7772b86187533f3f978343', '[\"*\"]', '2025-11-02 09:20:50', NULL, '2025-11-02 09:17:58', '2025-11-02 09:20:50'),
(218, 'App\\Models\\User', 5, 'auth_token', '6ce24833c225e701399816e18c3fcd242681c9132e002ef7af693abe80540596', '[\"*\"]', '2025-11-02 10:21:34', NULL, '2025-11-02 09:36:59', '2025-11-02 10:21:34'),
(219, 'App\\Models\\User', 5, 'auth_token', 'e29aa4ce6a8054cfd8da59649705dd06c1c82ceb2464ced0f519f14fc111f9a0', '[\"*\"]', '2025-11-02 14:31:30', NULL, '2025-11-02 10:09:35', '2025-11-02 14:31:30'),
(236, 'App\\Models\\User', 18, 'auth_token', '7ba4fc07f322b2c3cc14c562715f100128005cb004b7c558aa1dcb508a4e4e0c', '[\"*\"]', '2025-11-02 11:46:13', NULL, '2025-11-02 11:03:16', '2025-11-02 11:46:13'),
(242, 'App\\Models\\User', 29, 'auth_token', '0cd9dc995ff3e1b94f7c05b4ae53be192336fab9c7fdc4687e5aa848efe293d0', '[\"*\"]', '2025-11-04 06:19:49', NULL, '2025-11-02 11:25:59', '2025-11-04 06:19:49'),
(244, 'App\\Models\\User', 5, 'auth_token', '0991df7ad23c64ab29d214f1c32998cbaa7772f8ebd60f188e6fdf7cb202a116', '[\"*\"]', '2025-11-02 13:19:57', NULL, '2025-11-02 11:36:34', '2025-11-02 13:19:57'),
(247, 'App\\Models\\User', 39, 'auth_token', '662c716327baf1ed004001f2f3cae8eade41d6d5110311936654fc25d1493cc4', '[\"*\"]', '2025-11-02 11:45:09', NULL, '2025-11-02 11:45:09', '2025-11-02 11:45:09'),
(254, 'App\\Models\\User', 6, 'auth_token', '33e695eea9141ac3828f342a57ab216ad5ec6548f94eb11f1319b00342e0d2a0', '[\"*\"]', NULL, NULL, '2025-11-02 11:52:14', '2025-11-02 11:52:14'),
(256, 'App\\Models\\User', 18, 'auth_token', 'a9ec65c91ee5d1697e71d7599f6c28db38324947b3e55cee57b9512d0125d946', '[\"*\"]', '2025-11-03 15:22:54', NULL, '2025-11-02 11:54:06', '2025-11-03 15:22:54'),
(258, 'App\\Models\\User', 5, 'auth_token', 'a9a990ee7bb50448d8e0c38d51d80191fed580f851678624113a3b189280442b', '[\"*\"]', '2025-11-02 12:13:27', NULL, '2025-11-02 11:55:41', '2025-11-02 12:13:27'),
(279, 'App\\Models\\User', 6, 'auth_token', '84954b64cfab0f7b0350368c463e48b9d4a3df3a703e8efe7f231dbf961d4a96', '[\"*\"]', NULL, NULL, '2025-11-02 13:05:59', '2025-11-02 13:05:59'),
(280, 'App\\Models\\User', 20, 'auth_token', '646b7f80477e8a4a2ce981133c2b96e84e95af111a01f74cc2303ea1bd5f1e3a', '[\"*\"]', '2025-11-04 07:04:08', NULL, '2025-11-02 13:18:52', '2025-11-04 07:04:08'),
(281, 'App\\Models\\User', 5, 'auth_token', 'feb2f2e3c09b83d1f73a9b8f5b7b8fee87a77aee3fa6bf67462299ee7622ab12', '[\"*\"]', '2025-11-02 13:21:42', NULL, '2025-11-02 13:21:31', '2025-11-02 13:21:42'),
(282, 'App\\Models\\User', 5, 'auth_token', 'b30c051fa01634c53a6768a2d557efc2b2589adfbae7ec069be3d31f4040c42d', '[\"*\"]', '2025-11-02 15:27:01', NULL, '2025-11-02 13:22:27', '2025-11-02 15:27:01'),
(283, 'App\\Models\\User', 6, 'auth_token', 'f5d2fa6a34b0a5d42149ab32e6c99fc2c3502d86f19dd8ff387db27a7afeeefa', '[\"*\"]', '2025-11-04 12:21:10', NULL, '2025-11-02 13:23:41', '2025-11-04 12:21:10'),
(292, 'App\\Models\\User', 42, 'auth_token', 'c6485b0b8885da220f1847db95bd81fb05f63e92bf7c4c97c260e9ad248082d8', '[\"*\"]', '2025-11-02 13:52:09', NULL, '2025-11-02 13:51:50', '2025-11-02 13:52:09'),
(298, 'App\\Models\\User', 5, 'auth_token', '5cf1ccb4fc26854b4dd1013d72c5b1827aae8dc9c584680bdbe1d19b4e78ffaf', '[\"*\"]', '2025-11-02 14:05:20', NULL, '2025-11-02 13:59:35', '2025-11-02 14:05:20'),
(300, 'App\\Models\\User', 18, 'auth_token', '5f8210417185930645555d07743f4002fab19367786147f0811a249ddaedec90', '[\"*\"]', '2025-11-02 14:11:43', NULL, '2025-11-02 14:08:18', '2025-11-02 14:11:43'),
(301, 'App\\Models\\User', 43, 'auth_token', 'f924b0f183640614a6de430c20bf494273077cddc10fbff52471005680a24854', '[\"*\"]', '2025-11-04 13:47:05', NULL, '2025-11-02 14:14:28', '2025-11-04 13:47:05'),
(302, 'App\\Models\\User', 5, 'auth_token', '4ef66e5aecc74ffb86b419a27a1bd2b0fd98256013a8b3f75f35a72bbcbca641', '[\"*\"]', '2025-11-02 14:17:23', NULL, '2025-11-02 14:17:16', '2025-11-02 14:17:23'),
(307, 'App\\Models\\User', 18, 'auth_token', '06dd0b5e039533effd6afb9911e3b57c9d784ec1ea2e8f1e7b5d4bcf37824dea', '[\"*\"]', '2025-11-02 14:59:42', NULL, '2025-11-02 14:28:03', '2025-11-02 14:59:42'),
(311, 'App\\Models\\User', 5, 'auth_token', '1e0a3f75ce19863c7dd55a9a6fbef9133cde221de1fc57f79e0945d1bc46a715', '[\"*\"]', '2025-11-02 14:32:03', NULL, '2025-11-02 14:31:59', '2025-11-02 14:32:03'),
(312, 'App\\Models\\User', 6, 'auth_token', 'ad261245bbc92c3cb2f0da742a595d88769bb9be0079b732cb2f2b405c72b91a', '[\"*\"]', '2025-11-02 14:35:18', NULL, '2025-11-02 14:33:17', '2025-11-02 14:35:18'),
(313, 'App\\Models\\User', 6, 'auth_token', '27b3b9a021bd65e01c371c2c44965668f375d4f33ed19177ebe0dbf68fe1ce92', '[\"*\"]', '2025-11-02 14:39:07', NULL, '2025-11-02 14:38:31', '2025-11-02 14:39:07'),
(314, 'App\\Models\\User', 5, 'auth_token', 'e431ecc71fe12ab92fc264b19f35cd48529782be3bea82560c467dd9c3162d79', '[\"*\"]', '2025-11-02 14:44:58', NULL, '2025-11-02 14:39:25', '2025-11-02 14:44:58'),
(316, 'App\\Models\\User', 6, 'auth_token', 'c30f96562ce1ac10c9999c61bd480c1d55cbe48c73d71250e733b65fb0d045a9', '[\"*\"]', '2025-11-02 14:49:47', NULL, '2025-11-02 14:48:04', '2025-11-02 14:49:47'),
(320, 'App\\Models\\User', 18, 'auth_token', 'fddfc13cd33e052a6e5048ca6b11d1be1a8145014376e83b176817cbe46604f5', '[\"*\"]', '2025-11-02 15:31:41', NULL, '2025-11-02 15:31:31', '2025-11-02 15:31:41'),
(321, 'App\\Models\\User', 18, 'auth_token', '4121f5af2aab73cb5f2612cbba2c89ab141d092c608f09c22f110f6cd0cf0f59', '[\"*\"]', '2025-11-02 15:32:08', NULL, '2025-11-02 15:32:06', '2025-11-02 15:32:08'),
(323, 'App\\Models\\User', 18, 'auth_token', 'c80f993410ba07b03b4cb419fc69eeb76b150ca9ac4fc52834a14314b661ea9c', '[\"*\"]', '2025-11-02 15:33:13', NULL, '2025-11-02 15:33:01', '2025-11-02 15:33:13'),
(327, 'App\\Models\\User', 6, 'auth_token', '49ff1fe63848e83fe522d37781e11c247fa95997e63d8e53cb670defaa0fa2a9', '[\"*\"]', '2025-11-04 06:32:52', NULL, '2025-11-02 15:39:06', '2025-11-04 06:32:52'),
(329, 'App\\Models\\User', 18, 'auth_token', '70411c1981db857bbe81ee332fbeeee7f53b8c4b306da49146fd6da7a7ac6723', '[\"*\"]', '2025-11-02 16:09:45', NULL, '2025-11-02 16:09:44', '2025-11-02 16:09:45'),
(331, 'App\\Models\\User', 5, 'auth_token', 'ba25654ec299fc7ae756cab2d75783a5abad5aa36d9605054f9f7fe637b819c6', '[\"*\"]', '2025-11-03 10:05:22', NULL, '2025-11-02 16:17:27', '2025-11-03 10:05:22'),
(339, 'App\\Models\\User', 21, 'auth_token', '1abb5d1c68c5f0e2d266e68f93ac5e0ce5f8fc540989d27bfb2f602042b909b6', '[\"*\"]', '2025-11-02 17:01:52', NULL, '2025-11-02 17:01:30', '2025-11-02 17:01:52'),
(340, 'App\\Models\\User', 20, 'auth_token', '5cc1ec12f57703ae16893dfac1881acb5e251baea96912112eb7b3179f752295', '[\"*\"]', '2025-11-02 17:33:06', NULL, '2025-11-02 17:32:58', '2025-11-02 17:33:06'),
(349, 'App\\Models\\User', 5, 'auth_token', '204cf5e2c40c11e106157784722c544a7c71ca6c7c3a9afbd0e9e53dd3a8f998', '[\"*\"]', NULL, NULL, '2025-11-02 18:21:11', '2025-11-02 18:21:11'),
(350, 'App\\Models\\User', 21, 'auth_token', 'b9b523ccb0785d5aed021262dee5fc6f900fe08547c3ed36c5dd481d3e659272', '[\"*\"]', '2025-11-02 18:28:11', NULL, '2025-11-02 18:25:44', '2025-11-02 18:28:11'),
(351, 'App\\Models\\User', 5, 'auth_token', '7dca6614274787b58dfb84f22c032d4265453e4127f19cae404ef6260d73206e', '[\"*\"]', '2025-11-03 07:27:52', NULL, '2025-11-02 18:35:52', '2025-11-03 07:27:52'),
(354, 'App\\Models\\User', 5, 'auth_token', '092c8c3ca42f3d87b9f3beeaa762305a3266cbcb503a33ae2230362b1667b0fd', '[\"*\"]', '2025-11-02 20:52:30', NULL, '2025-11-02 20:45:47', '2025-11-02 20:52:30'),
(358, 'App\\Models\\User', 5, 'auth_token', 'd4c3536677635f372333724e97cf106604fda1dc32b1305ec7dfa8b12bf6806a', '[\"*\"]', '2025-11-02 21:07:36', NULL, '2025-11-02 20:56:03', '2025-11-02 21:07:36'),
(362, 'App\\Models\\User', 5, 'auth_token', 'f8e6b38d8d9fc8b11c27e1da8e63b61de16dd78ddb423e16b998c1cfcff2f6a5', '[\"*\"]', '2025-11-03 03:33:41', NULL, '2025-11-02 23:09:58', '2025-11-03 03:33:41'),
(363, 'App\\Models\\User', 5, 'auth_token', '72c42f3af823bbd383342bf26d86eeaaa87c6f4891b236ff8390c9a46c9d5568', '[\"*\"]', '2025-11-03 19:43:50', NULL, '2025-11-02 23:12:56', '2025-11-03 19:43:50'),
(366, 'App\\Models\\User', 20, 'auth_token', '6020177da6e3d5361ab878e946f56f83ca9ad5659d74bc17bd553ce09f0c23f4', '[\"*\"]', '2025-11-03 01:46:45', NULL, '2025-11-03 00:04:53', '2025-11-03 01:46:45'),
(367, 'App\\Models\\User', 1, 'auth_token', '2f930cd58cda86b051895121736a0afd0995e2b2390c1e3ce1508918fe1403cf', '[\"*\"]', NULL, NULL, '2025-11-03 00:08:46', '2025-11-03 00:08:46'),
(368, 'App\\Models\\User', 1, 'auth_token', '3a8ce81ef51ca9ba062e4b874b54c668a4a9456b5cae3ef80a2b53cfe63e65e7', '[\"*\"]', '2025-11-03 00:18:30', NULL, '2025-11-03 00:15:44', '2025-11-03 00:18:30'),
(371, 'App\\Models\\User', 18, 'auth_token', 'c3d7da7eafc3d121acdad367147099b538b1503c9d0a0ca38bb94165b9683d24', '[\"*\"]', '2025-11-03 01:13:33', NULL, '2025-11-03 01:11:08', '2025-11-03 01:13:33'),
(372, 'App\\Models\\User', 18, 'auth_token', '095b34e0ce5a1c78585fb565b50ea2e3c2f281b0b7d892afc6b8c7ef6290cf83', '[\"*\"]', '2025-11-03 01:13:56', NULL, '2025-11-03 01:13:51', '2025-11-03 01:13:56'),
(373, 'App\\Models\\User', 18, 'auth_token', 'd129f67b28d8b76f135643577429506a28bdd10336fd1589c3cf5c67be35f278', '[\"*\"]', '2025-11-03 01:16:35', NULL, '2025-11-03 01:14:12', '2025-11-03 01:16:35'),
(377, 'App\\Models\\User', 5, 'auth_token', '5f428431a03da19d1ea27782354a6bf41b5c7f8e12fda234ff099af5eef3bdd1', '[\"*\"]', '2025-11-03 01:39:08', NULL, '2025-11-03 01:38:06', '2025-11-03 01:39:08'),
(378, 'App\\Models\\User', 5, 'auth_token', 'e6e5e658b922ea1b31e14e58e6223827697bdc8137fe7b943a560a6645bfc9cd', '[\"*\"]', '2025-11-03 09:13:55', NULL, '2025-11-03 01:41:20', '2025-11-03 09:13:55'),
(379, 'App\\Models\\User', 46, 'auth_token', '5a5591e55714750dc9c0844df28e90526a75c80dc13bf0c2830ba17500bd50ec', '[\"*\"]', '2025-11-03 01:48:23', NULL, '2025-11-03 01:47:33', '2025-11-03 01:48:23'),
(383, 'App\\Models\\User', 29, 'auth_token', 'c11a54b01f69984c778ec9881545c94bc21f052d912ecae52d4515a4dbcb1922', '[\"*\"]', '2025-11-03 02:54:39', NULL, '2025-11-03 02:19:34', '2025-11-03 02:54:39'),
(389, 'App\\Models\\User', 5, 'auth_token', 'f00fbde1e3027c583e16bb0cb96c96a8ee60fddddabf69ff6fea0d624735afc8', '[\"*\"]', '2025-11-03 03:52:00', NULL, '2025-11-03 03:04:36', '2025-11-03 03:52:00'),
(390, 'App\\Models\\User', 20, 'auth_token', '6bc2c57621a4621da8771eecc29205c911d906c5e85aae949da134d9e876642d', '[\"*\"]', '2025-11-03 03:21:43', NULL, '2025-11-03 03:16:33', '2025-11-03 03:21:43'),
(392, 'App\\Models\\User', 5, 'auth_token', 'ba0df5b37aef24e20a78b6e714f5c60aade6c7af75708fd79c12d861edcec279', '[\"*\"]', '2025-11-03 03:39:14', NULL, '2025-11-03 03:32:18', '2025-11-03 03:39:14'),
(396, 'App\\Models\\User', 6, 'auth_token', 'fff63f3f0f0d07f496ef690385a26985252388a9729a13913cb5ce6831f6d96e', '[\"*\"]', '2025-11-03 04:00:18', NULL, '2025-11-03 03:58:21', '2025-11-03 04:00:18'),
(398, 'App\\Models\\User', 29, 'auth_token', '4e9640f072120c50f5afcae0f2a014106e4558ccdb3bb16426c32ed640d0f0fb', '[\"*\"]', '2025-11-03 04:04:31', NULL, '2025-11-03 04:04:13', '2025-11-03 04:04:31'),
(399, 'App\\Models\\User', 29, 'auth_token', 'd3b48c10b507646e95aa0a4e9d05ebc8b265d21441081b7745e74f089459e63b', '[\"*\"]', '2025-11-03 04:12:02', NULL, '2025-11-03 04:11:37', '2025-11-03 04:12:02'),
(400, 'App\\Models\\User', 29, 'auth_token', 'cd07f9aa6227a487740429d432fc3ad0a77379ff5448933431d5d17534c615df', '[\"*\"]', '2025-11-03 07:51:33', NULL, '2025-11-03 04:26:02', '2025-11-03 07:51:33'),
(401, 'App\\Models\\User', 29, 'auth_token', '9995a95e68d8225c9779326b17b01329f26c4f2056919dc60bfb2fe3ab04c516', '[\"*\"]', '2025-11-03 04:46:26', NULL, '2025-11-03 04:46:10', '2025-11-03 04:46:26'),
(403, 'App\\Models\\User', 29, 'auth_token', 'f96d21556721a310be21762975d29a403348f9614cce49ac8654255fe105d1c9', '[\"*\"]', '2025-11-03 05:17:38', NULL, '2025-11-03 05:17:26', '2025-11-03 05:17:38'),
(404, 'App\\Models\\User', 29, 'auth_token', '087f709732cee1ae9ce9a1c32033576bb1142d5270ebc536bb235d960b10ca4b', '[\"*\"]', '2025-11-03 05:23:47', NULL, '2025-11-03 05:20:03', '2025-11-03 05:23:47'),
(405, 'App\\Models\\User', 29, 'auth_token', '785faa7b4e07eced9d50d9774ba73cbff175a41a1639586f2bcb08f8db019772', '[\"*\"]', '2025-11-03 06:51:53', NULL, '2025-11-03 05:57:38', '2025-11-03 06:51:53'),
(406, 'App\\Models\\User', 42, 'auth_token', 'dbee8b9c0a1ba1b15fff8fbc3b601b6ede111654cde8beff222f9424021b592a', '[\"*\"]', '2025-11-03 08:32:34', NULL, '2025-11-03 06:03:44', '2025-11-03 08:32:34'),
(412, 'App\\Models\\User', 29, 'auth_token', 'b26016293be8be71335e36a33a461277fae0ff460570fda81eeced81149cfa77', '[\"*\"]', '2025-11-03 08:03:15', NULL, '2025-11-03 07:57:24', '2025-11-03 08:03:15'),
(414, 'App\\Models\\User', 18, 'auth_token', 'bdb67789f3ddd6f499fb3aed57bc480ea2b492c0a9c7ff6e701606780d3c8e21', '[\"*\"]', '2025-11-03 08:24:20', NULL, '2025-11-03 08:15:54', '2025-11-03 08:24:20'),
(417, 'App\\Models\\User', 18, 'auth_token', '93b3147d6bf0a1f904a9f0363b8ab38dd49455a3f5e0f0b82e2a1bfb2043b44d', '[\"*\"]', '2025-11-03 08:26:34', NULL, '2025-11-03 08:24:27', '2025-11-03 08:26:34'),
(418, 'App\\Models\\User', 18, 'auth_token', '092b8402333825c03d2adda55bdf21deccaf67e32eded53dd5fa8eeffb3ab1d6', '[\"*\"]', '2025-11-03 08:28:21', NULL, '2025-11-03 08:26:40', '2025-11-03 08:28:21'),
(420, 'App\\Models\\User', 18, 'auth_token', '3dcc0b82da7c21c8534c8a7df90663993814e64a38614e727e3614a6caa576d1', '[\"*\"]', '2025-11-04 09:00:24', NULL, '2025-11-03 08:28:39', '2025-11-04 09:00:24'),
(423, 'App\\Models\\User', 42, 'auth_token', '50069e6671705b56d408821caf872ba1645f8fa5dc379156a6cc2550bdc89231', '[\"*\"]', '2025-11-03 08:33:49', NULL, '2025-11-03 08:33:45', '2025-11-03 08:33:49'),
(424, 'App\\Models\\User', 42, 'auth_token', '2c9a6ca6f7387b2b7056f5112ec2c844ab1a83294c523caf03009139fe29c4bf', '[\"*\"]', '2025-11-03 08:34:09', NULL, '2025-11-03 08:33:56', '2025-11-03 08:34:09'),
(427, 'App\\Models\\User', 5, 'auth_token', 'e8476f5bff7bdb550c92a988aad9f190d17f194e990cc6abdcfd9cfd72832cd6', '[\"*\"]', '2025-11-03 15:42:09', NULL, '2025-11-03 08:37:19', '2025-11-03 15:42:09'),
(430, 'App\\Models\\User', 29, 'auth_token', '25f859996c637188d3b9dd3cd5e43e18599f8539e2960000c7bc421fc150e230', '[\"*\"]', '2025-11-03 08:42:26', NULL, '2025-11-03 08:42:21', '2025-11-03 08:42:26'),
(432, 'App\\Models\\User', 29, 'auth_token', '1e27d716347d1e40c790b27c79c3784adffeb5def39f7ba83f15d0383a430e08', '[\"*\"]', '2025-11-03 14:20:21', NULL, '2025-11-03 08:52:31', '2025-11-03 14:20:21'),
(438, 'App\\Models\\User', 5, 'auth_token', '7e76d42a7431913f327abb75988646b5ad5ca6913b68651d08080e525ac56dfb', '[\"*\"]', '2025-11-03 09:48:00', NULL, '2025-11-03 09:08:28', '2025-11-03 09:48:00'),
(443, 'App\\Models\\User', 5, 'auth_token', 'ed8e16f8d5a27a0ae4cb0c3516e36c59285e2291d5cc34d4c9d76d0dcfa41884', '[\"*\"]', '2025-11-04 09:13:59', NULL, '2025-11-03 09:11:39', '2025-11-04 09:13:59'),
(446, 'App\\Models\\User', 5, 'auth_token', 'ed611d6b49bbeede3453df88a241b07651fbdb6f41e3d72e93a006c51cdb90c0', '[\"*\"]', '2025-11-03 09:15:07', NULL, '2025-11-03 09:14:23', '2025-11-03 09:15:07'),
(448, 'App\\Models\\User', 5, 'auth_token', '8bd4ae03e63b1cc5614c1c1c7a127f90743ff564f60520e626bde4d4c3103b3f', '[\"*\"]', '2025-11-03 09:19:29', NULL, '2025-11-03 09:18:54', '2025-11-03 09:19:29'),
(449, 'App\\Models\\User', 5, 'auth_token', '70c45799995e39bf68e6dcc68f56587671f2ee14a0e3b37eb6202d00caaa48db', '[\"*\"]', '2025-11-03 09:19:34', NULL, '2025-11-03 09:19:03', '2025-11-03 09:19:34'),
(451, 'App\\Models\\User', 29, 'auth_token', '8ef2293d3502234c209a47193af490f1d65d1da00c8e20681ed7600745aff544', '[\"*\"]', '2025-11-03 13:38:15', NULL, '2025-11-03 09:22:34', '2025-11-03 13:38:15'),
(455, 'App\\Models\\User', 5, 'auth_token', '4821e0f6f77975e9b9d9b8e2a0e9755c61d2a1a523ec45857f7ec10f03b1b3ba', '[\"*\"]', '2025-11-03 09:31:45', NULL, '2025-11-03 09:30:59', '2025-11-03 09:31:45'),
(457, 'App\\Models\\User', 5, 'auth_token', '947320e5bf9dc89492dc496cb81787fda52b6094e4a77a546927276239dcd210', '[\"*\"]', '2025-11-03 10:58:48', NULL, '2025-11-03 09:34:44', '2025-11-03 10:58:48'),
(462, 'App\\Models\\User', 29, 'auth_token', 'aa53f0fc668fd5c6ee06c9c5c8ff380dde17e22c0836aa1f59c46e1096bc98ec', '[\"*\"]', '2025-11-03 09:46:00', NULL, '2025-11-03 09:45:36', '2025-11-03 09:46:00'),
(466, 'App\\Models\\User', 6, 'auth_token', '662239a2b4f1e0bb6ab4b2f1e81ee19229f4387a7c5253142e93560191f42bec', '[\"*\"]', NULL, NULL, '2025-11-03 09:48:58', '2025-11-03 09:48:58'),
(469, 'App\\Models\\User', 5, 'auth_token', 'd925df69585b5376ab21d395872fd290fc3249ae311e50d1f234149434558872', '[\"*\"]', '2025-11-03 09:51:32', NULL, '2025-11-03 09:51:17', '2025-11-03 09:51:32'),
(471, 'App\\Models\\User', 6, 'auth_token', '36ecf44868f3e8cfee258220aca91c1ceb3648937b10757570ad5ac9d64e22d2', '[\"*\"]', '2025-11-03 09:54:48', NULL, '2025-11-03 09:53:47', '2025-11-03 09:54:48'),
(475, 'App\\Models\\User', 48, 'auth_token', '0101c45bab253dc75a2f91bbf055e08f7f6e01bcd53ed095f93dace362c2459b', '[\"*\"]', '2025-11-03 10:00:19', NULL, '2025-11-03 09:58:27', '2025-11-03 10:00:19'),
(478, 'App\\Models\\User', 48, 'auth_token', '2674c64de3f264cc0b31abfbbd13b0303d89774d1677930d16d75162825d5409', '[\"*\"]', '2025-11-03 10:03:24', NULL, '2025-11-03 10:03:14', '2025-11-03 10:03:24'),
(479, 'App\\Models\\User', 48, 'auth_token', 'db3b815c54cb8f171f41bdbe613c119b0b4572b57a05dd0262de37c095d054be', '[\"*\"]', '2025-11-03 10:04:18', NULL, '2025-11-03 10:04:08', '2025-11-03 10:04:18'),
(480, 'App\\Models\\User', 6, 'auth_token', '59d3bc2f4a227933f6953f2be7a3d71cc76e414e1567e4dfbc4462346b09df77', '[\"*\"]', '2025-11-03 10:07:27', NULL, '2025-11-03 10:05:07', '2025-11-03 10:07:27'),
(483, 'App\\Models\\User', 48, 'auth_token', 'b213c2ce4cd1e0634e1ee91415075d4126787af2981b0e7bf4ef767f3579a815', '[\"*\"]', '2025-11-03 10:11:25', NULL, '2025-11-03 10:08:45', '2025-11-03 10:11:25'),
(485, 'App\\Models\\User', 6, 'auth_token', '78593f763e2edb4b8eae237727bbd47b52853842ea62ebe60e07832a69eaaa64', '[\"*\"]', NULL, NULL, '2025-11-03 10:09:09', '2025-11-03 10:09:09'),
(486, 'App\\Models\\User', 6, 'auth_token', 'dfea9c2cce067991095d05af4f7e7328a45ef1eb5744fb0a5f3d0b0b6ec29ac0', '[\"*\"]', '2025-11-03 20:02:47', NULL, '2025-11-03 10:09:20', '2025-11-03 20:02:47'),
(488, 'App\\Models\\User', 48, 'auth_token', '405368fdf4cd8c2e3eabe8b86d7338331148f40f3fcbb774b83a4eb023cc48e4', '[\"*\"]', '2025-11-03 10:13:58', NULL, '2025-11-03 10:11:52', '2025-11-03 10:13:58'),
(490, 'App\\Models\\User', 6, 'auth_token', '6128a890199215dd194915c8be844c58ec6cc9ef48e0b5116860e67d0e059437', '[\"*\"]', '2025-11-03 10:17:27', NULL, '2025-11-03 10:15:05', '2025-11-03 10:17:27'),
(491, 'App\\Models\\User', 5, 'auth_token', '5612c2f6ed0cbe364d1d9dbc52825536ca88df9469a9bcc5ed937282922c6b03', '[\"*\"]', NULL, NULL, '2025-11-03 10:15:32', '2025-11-03 10:15:32'),
(493, 'App\\Models\\User', 5, 'auth_token', '875fe975f132109ccf8a2f4a5edb9059faa1c229757c37c3c50da04990e011d9', '[\"*\"]', '2025-11-03 10:18:12', NULL, '2025-11-03 10:17:51', '2025-11-03 10:18:12'),
(494, 'App\\Models\\User', 6, 'auth_token', '345ee66a97284eeed4b30cd75c3e5e2742250c2695dca01463d70fcba21b9220', '[\"*\"]', '2025-11-03 10:57:49', NULL, '2025-11-03 10:18:05', '2025-11-03 10:57:49'),
(499, 'App\\Models\\User', 49, 'auth_token', '2772d5625b6058e92dcab4d755c29074f62dd5be209724af1f327ba23f2aeffc', '[\"*\"]', '2025-11-03 10:43:55', NULL, '2025-11-03 10:23:15', '2025-11-03 10:43:55'),
(500, 'App\\Models\\User', 5, 'auth_token', 'c0efe32654c8d3a3460eb885ac7c95d1083333fdc794f4bb67611d747a7f711e', '[\"*\"]', '2025-11-03 10:43:36', NULL, '2025-11-03 10:26:36', '2025-11-03 10:43:36'),
(510, 'App\\Models\\User', 6, 'auth_token', '8e34858fead92ffce46a7c536e5ca1aaca6dc940d1df1a0f992cbb19c471e673', '[\"*\"]', '2025-11-03 13:37:55', NULL, '2025-11-03 10:56:40', '2025-11-03 13:37:55'),
(512, 'App\\Models\\User', 5, 'auth_token', 'a4898173e154e6a21050de30cd1d287e0b2fd91d1feb4fc66683edf09454dda9', '[\"*\"]', '2025-11-03 11:43:42', NULL, '2025-11-03 11:01:02', '2025-11-03 11:43:42');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(515, 'App\\Models\\User', 20, 'auth_token', '656076ef24b4be738db4241ab81386e9012c475dcefcfc8b27ca91438784cd29', '[\"*\"]', '2025-11-03 11:12:59', NULL, '2025-11-03 11:12:32', '2025-11-03 11:12:59'),
(520, 'App\\Models\\User', 1, 'auth_token', 'e987397466f64ae4547736452b0a5cd440d552b5affc81121c36b806a4be3903', '[\"*\"]', '2025-11-03 11:44:25', NULL, '2025-11-03 11:36:32', '2025-11-03 11:44:25'),
(521, 'App\\Models\\User', 5, 'auth_token', 'e2252015d9d199257bec1945f09f8c2a32c1b98d3cbf1e3c54e752b136044bd8', '[\"*\"]', '2025-11-03 11:38:41', NULL, '2025-11-03 11:37:41', '2025-11-03 11:38:41'),
(523, 'App\\Models\\User', 6, 'auth_token', '7f78797d2c08e15b08392f91363b78a16fdb6401e7ce7970aee568deea56e6fb', '[\"*\"]', '2025-11-03 13:28:18', NULL, '2025-11-03 11:45:03', '2025-11-03 13:28:18'),
(524, 'App\\Models\\User', 5, 'auth_token', 'f5c3cd1464895ef0e42f74d437bfa0a3efa36c4ec27dfdb3b830ede143562ed9', '[\"*\"]', '2025-11-03 13:51:21', NULL, '2025-11-03 11:53:32', '2025-11-03 13:51:21'),
(525, 'App\\Models\\User', 6, 'auth_token', 'ef86c3ab9d9e9e5078b387d8f50f515e1f62bad8685d6f4f46dda61bcbc53ca9', '[\"*\"]', NULL, NULL, '2025-11-03 11:55:26', '2025-11-03 11:55:26'),
(530, 'App\\Models\\User', 6, 'auth_token', '39e7c4a95e8f15319e0c49be6ace1f7d3026ab6407ebb9236e4c59612a4b9df8', '[\"*\"]', '2025-11-03 13:29:06', NULL, '2025-11-03 13:28:29', '2025-11-03 13:29:06'),
(531, 'App\\Models\\User', 1, 'auth_token', '9e3576b3b3641f987bf6adfccba626ad92a80ef645e287e6cfead6c31935eb39', '[\"*\"]', '2025-11-03 13:31:35', NULL, '2025-11-03 13:29:25', '2025-11-03 13:31:35'),
(532, 'App\\Models\\User', 6, 'auth_token', 'ea30db48371ea33ce34845d35105315468c0cfeb92626487ff4402a35abcc18b', '[\"*\"]', '2025-11-03 13:35:45', NULL, '2025-11-03 13:31:46', '2025-11-03 13:35:45'),
(533, 'App\\Models\\User', 5, 'auth_token', 'd1b52f9adfdc9f3abbaaa9e80deafc4dcb0b16ebe990a84ff65810613618826b', '[\"*\"]', '2025-11-03 13:41:03', NULL, '2025-11-03 13:32:58', '2025-11-03 13:41:03'),
(534, 'App\\Models\\User', 6, 'auth_token', 'f05c894885f7826d2d398a788cd9f50d49420de8020a80b3d2936fd036ddce99', '[\"*\"]', '2025-11-03 13:38:53', NULL, '2025-11-03 13:34:45', '2025-11-03 13:38:53'),
(538, 'App\\Models\\User', 5, 'auth_token', 'ed7ea284033de79b09036738548402679072d9c0f69a7c66d4f83c912ce8e688', '[\"*\"]', '2025-11-03 13:52:02', NULL, '2025-11-03 13:37:59', '2025-11-03 13:52:02'),
(539, 'App\\Models\\User', 6, 'auth_token', '3e75c045e6b35668ae723e49a995531897e07106c17ece22f1f5728a1ec9619c', '[\"*\"]', '2025-11-03 13:41:06', NULL, '2025-11-03 13:38:45', '2025-11-03 13:41:06'),
(541, 'App\\Models\\User', 37, 'auth_token', '4dbb50a979db8103cd1de169acdcf70e641bdbab31bf4335acee2e8a99510802', '[\"*\"]', '2025-11-03 13:42:55', NULL, '2025-11-03 13:42:52', '2025-11-03 13:42:55'),
(543, 'App\\Models\\User', 5, 'auth_token', 'd05c35a5180c4c472a249887428ca1cc6d2c51b6838c26e30d1c4e6cc6d909d8', '[\"*\"]', '2025-11-03 13:43:34', NULL, '2025-11-03 13:43:19', '2025-11-03 13:43:34'),
(545, 'App\\Models\\User', 5, 'auth_token', 'baeb2c202b097e86b67f9d9ea4e29d5d4dd6d001f45b813728d25c990e957382', '[\"*\"]', NULL, NULL, '2025-11-03 13:43:44', '2025-11-03 13:43:44'),
(548, 'App\\Models\\User', 5, 'auth_token', 'c1cd513638700275b39990f357b54c7dd8fe1a4234be7000805dbaa2eea8cbc5', '[\"*\"]', '2025-11-03 14:06:04', NULL, '2025-11-03 13:44:39', '2025-11-03 14:06:04'),
(549, 'App\\Models\\User', 5, 'auth_token', '699eaf6c96d2b5421d2411f0ab6f9972f23d73ab557eb8e53adb1b6cab7d8557', '[\"*\"]', NULL, NULL, '2025-11-03 13:44:48', '2025-11-03 13:44:48'),
(551, 'App\\Models\\User', 5, 'auth_token', '250f402068af4bf12edcc4707a1c0e046ff9c4b86c19c7718c5ec645ca362841', '[\"*\"]', NULL, NULL, '2025-11-03 13:45:25', '2025-11-03 13:45:25'),
(553, 'App\\Models\\User', 4, 'auth_token', '9233921b99325e40e329c610af7b8b6fef4e781a3abc764d98727d609229c6aa', '[\"*\"]', '2025-11-03 13:47:43', NULL, '2025-11-03 13:47:21', '2025-11-03 13:47:43'),
(561, 'App\\Models\\User', 5, 'auth_token', '549d52676425cbc728008f21147db711294d9994b8dc38a9ef5106b08a1d9996', '[\"*\"]', '2025-11-03 13:56:14', NULL, '2025-11-03 13:55:54', '2025-11-03 13:56:14'),
(565, 'App\\Models\\User', 55, 'auth_token', '96797e1495d9bd49fceecd7955159b986a7777d0fb16e7e82be3e661b43903e2', '[\"*\"]', '2025-11-03 23:57:53', NULL, '2025-11-03 13:59:20', '2025-11-03 23:57:53'),
(569, 'App\\Models\\User', 5, 'auth_token', 'd3d42049daf5a9a50411c739b5d3c5ffea491cd6dbfc31f2f41ccfb516c6771c', '[\"*\"]', '2025-11-03 17:00:34', NULL, '2025-11-03 14:09:50', '2025-11-03 17:00:34'),
(570, 'App\\Models\\User', 5, 'auth_token', 'd010f22f3ce56811e282516fba6c35e7b57d99d2bc6ce8ecc0c34a22c2fa6c35', '[\"*\"]', '2025-11-03 14:17:06', NULL, '2025-11-03 14:16:50', '2025-11-03 14:17:06'),
(571, 'App\\Models\\User', 5, 'auth_token', '940e42372a126f892273ad033f35077524f0ef7c042a44e55a2edd2420be519c', '[\"*\"]', NULL, NULL, '2025-11-03 14:28:48', '2025-11-03 14:28:48'),
(572, 'App\\Models\\User', 5, 'auth_token', '0626f0da0d232b5e553c36687792a617f1d40c4f23ce8cb1bdfeaf176ad4c905', '[\"*\"]', '2025-11-03 15:32:24', NULL, '2025-11-03 14:40:05', '2025-11-03 15:32:24'),
(573, 'App\\Models\\User', 6, 'auth_token', '1e98ffd1e801a6ce298037f0ed9ae5345ac0137ec740257e31604907d26e0ae8', '[\"*\"]', '2025-11-03 15:32:36', NULL, '2025-11-03 14:43:28', '2025-11-03 15:32:36'),
(574, 'App\\Models\\User', 48, 'auth_token', 'cb565cd2bfbbb9f2988602d44ada827f02eebb607131d9b1bc5a639e3e3c1cd8', '[\"*\"]', '2025-11-03 14:50:41', NULL, '2025-11-03 14:50:33', '2025-11-03 14:50:41'),
(575, 'App\\Models\\User', 48, 'auth_token', 'd8829bbf28ed568a16522f5b7e6a060603a192de7e1d7b47a182a0e85801a72a', '[\"*\"]', '2025-11-03 14:53:12', NULL, '2025-11-03 14:51:54', '2025-11-03 14:53:12'),
(577, 'App\\Models\\User', 20, 'auth_token', '82624d9d1e38b8a3581c496dfe5f8e0f1dd763ad9ae072fa9cdabad49e20636f', '[\"*\"]', NULL, NULL, '2025-11-03 16:19:58', '2025-11-03 16:19:58'),
(578, 'App\\Models\\User', 20, 'auth_token', 'f68687acb7a79a2f070f6d171bb2f71049e389f85d752e6121887d1638c07095', '[\"*\"]', NULL, NULL, '2025-11-03 16:21:09', '2025-11-03 16:21:09'),
(579, 'App\\Models\\User', 20, 'auth_token', 'a23642f7ef579510a40f3406fb212cee5d607df0a6373cf2b90920af2f355bc2', '[\"*\"]', NULL, NULL, '2025-11-03 16:22:23', '2025-11-03 16:22:23'),
(581, 'App\\Models\\User', 5, 'auth_token', 'cfc003258eb7dbf897ad72f0e51715582fe5962b2218e9be1aac306eb1cec343', '[\"*\"]', '2025-11-03 17:20:13', NULL, '2025-11-03 16:25:06', '2025-11-03 17:20:13'),
(582, 'App\\Models\\User', 49, 'auth_token', '6ee449c7cc2da175969713b1033afb21ec3ed1edb681c39d5b2883328bb2f9fe', '[\"*\"]', '2025-11-03 17:18:03', NULL, '2025-11-03 16:35:08', '2025-11-03 17:18:03'),
(586, 'App\\Models\\User', 4, 'auth_token', 'c965dc7b2b93f18a97e4c3e260a868c3e2d8a8a9770397d73ba50f23bc6533b3', '[\"*\"]', '2025-11-03 17:23:27', NULL, '2025-11-03 17:06:06', '2025-11-03 17:23:27'),
(587, 'App\\Models\\User', 5, 'auth_token', '298c80dc79ebe82353bfede3b7def217846f5763273800e29bda52063f24026d', '[\"*\"]', '2025-11-04 09:05:17', NULL, '2025-11-03 17:07:23', '2025-11-04 09:05:17'),
(588, 'App\\Models\\User', 5, 'auth_token', 'c8f539320212b15f4d6ab10657c565247f9dc89fc543700c9d8bdd887148b458', '[\"*\"]', '2025-11-03 17:13:35', NULL, '2025-11-03 17:12:26', '2025-11-03 17:13:35'),
(589, 'App\\Models\\User', 6, 'auth_token', 'df1e725b03702ad9f0ea6690ed4be9b605c377c673a8e2bdd969a714706a269c', '[\"*\"]', '2025-11-03 17:49:17', NULL, '2025-11-03 17:16:00', '2025-11-03 17:49:17'),
(590, 'App\\Models\\User', 3, 'auth_token', '7b286f9987d0b554259775531214ff4dbe181e01eab38e4dcccb0de478511a08', '[\"*\"]', NULL, NULL, '2025-11-03 17:18:06', '2025-11-03 17:18:06'),
(592, 'App\\Models\\User', 49, 'auth_token', '4de5c879d47cc09111201d3a53d218acd2fd96e5cd81e114887c88e51095bb1d', '[\"*\"]', '2025-11-03 18:44:40', NULL, '2025-11-03 17:23:29', '2025-11-03 18:44:40'),
(594, 'App\\Models\\User', 4, 'auth_token', '8de7051910b9ac5ecb1c387ab83e1b2e70b658b1a96da57c6398fc75bb564419', '[\"*\"]', '2025-11-03 18:01:35', NULL, '2025-11-03 17:36:23', '2025-11-03 18:01:35'),
(595, 'App\\Models\\User', 5, 'auth_token', '2f96d16bf2b85013103446c78230d0df6245a749d2f8dc179a4b15ed692724b1', '[\"*\"]', '2025-11-03 17:40:41', NULL, '2025-11-03 17:40:06', '2025-11-03 17:40:41'),
(596, 'App\\Models\\User', 5, 'auth_token', 'db6e5b9f6ac7a01294b5cf17f7ad8761074aa02c165dddba9ced3dca34d439fd', '[\"*\"]', '2025-11-03 17:47:17', NULL, '2025-11-03 17:46:08', '2025-11-03 17:47:17'),
(598, 'App\\Models\\User', 3, 'auth_token', 'f650b968285c94a31ac4457f99c804d781406d0b43d64f005906650074e4897a', '[\"*\"]', NULL, NULL, '2025-11-03 18:00:10', '2025-11-03 18:00:10'),
(600, 'App\\Models\\User', 5, 'auth_token', '27e43b76266f3e11c1a046ad5d3f3bc90a4006d4a9eff3d40ce85cda5d2bb8e7', '[\"*\"]', '2025-11-03 21:35:18', NULL, '2025-11-03 18:24:50', '2025-11-03 21:35:18'),
(601, 'App\\Models\\User', 5, 'auth_token', '6cfadb21c5aeb7ea488d64250f2bb7abbbf6f93ce92cecbe3f079b5b1bcda5c2', '[\"*\"]', '2025-11-03 18:38:25', NULL, '2025-11-03 18:38:11', '2025-11-03 18:38:25'),
(603, 'App\\Models\\User', 20, 'auth_token', '4e34c41242e29bad3dd77c0f28b139f81ccdd750e3a41534f3f94faf97c7315c', '[\"*\"]', NULL, NULL, '2025-11-03 18:50:32', '2025-11-03 18:50:32'),
(604, 'App\\Models\\User', 49, 'auth_token', '43d3c68546cec8a0a05abd3f8bcca54efd7a18db99d00889483b83145b4e3e4f', '[\"*\"]', NULL, NULL, '2025-11-03 18:52:27', '2025-11-03 18:52:27'),
(605, 'App\\Models\\User', 49, 'auth_token', '0ed983fecd3d34337528ed5dfe7799e26b31f98b9ef0200ba501e6990c264876', '[\"*\"]', NULL, NULL, '2025-11-03 18:53:09', '2025-11-03 18:53:09'),
(608, 'App\\Models\\User', 5, 'auth_token', 'f26428839ddfe19aca3793b4a7e27258591fad8a25cb6cc3d01387385956d769', '[\"*\"]', '2025-11-03 20:44:11', NULL, '2025-11-03 19:28:08', '2025-11-03 20:44:11'),
(609, 'App\\Models\\User', 4, 'auth_token', '47cd6c2ded2e658398cc6143e745635d31352966f47eb62ccdb5e2ea3887fd11', '[\"*\"]', '2025-11-03 19:30:19', NULL, '2025-11-03 19:30:00', '2025-11-03 19:30:19'),
(610, 'App\\Models\\User', 4, 'auth_token', '788c4e61b7f613b13e77980175956070a1acffd368bb35ab16d810126fa00df1', '[\"*\"]', '2025-11-03 19:55:36', NULL, '2025-11-03 19:32:04', '2025-11-03 19:55:36'),
(611, 'App\\Models\\User', 6, 'auth_token', '4be1cefdc164718e212fe4b2c5a98dac2a548ae35f68ff950a7069f7ac0c9ad7', '[\"*\"]', NULL, NULL, '2025-11-03 20:00:24', '2025-11-03 20:00:24'),
(613, 'App\\Models\\User', 4, 'auth_token', 'd32f4a21203920bb45aa4008f0a9498b22e69e8b79454192ccf8202bec5291fd', '[\"*\"]', '2025-11-03 20:05:17', NULL, '2025-11-03 20:02:02', '2025-11-03 20:05:17'),
(614, 'App\\Models\\User', 5, 'auth_token', '6ebc4f4b073340e51258ba34ed8e4ea39cc9f2e55bf9ec9fda1b65d6e3ca51d3', '[\"*\"]', '2025-11-03 20:06:48', NULL, '2025-11-03 20:06:07', '2025-11-03 20:06:48'),
(616, 'App\\Models\\User', 49, 'auth_token', 'a5448ed2bb65fdbcc8bad057cb3d71653c5569b22b1c18f14a1326008d599062', '[\"*\"]', NULL, NULL, '2025-11-03 20:31:08', '2025-11-03 20:31:08'),
(617, 'App\\Models\\User', 5, 'auth_token', 'cc13513bfc4e64599b384e43b0ba70e6ec649a07d41e4339ee8892ac2d9f5968', '[\"*\"]', NULL, NULL, '2025-11-03 20:36:06', '2025-11-03 20:36:06'),
(620, 'App\\Models\\User', 5, 'auth_token', '7bddbcb007b10c3a449e9505d028ccc50bf003bfbd3372237ae96fa8870f23d8', '[\"*\"]', NULL, NULL, '2025-11-03 20:39:30', '2025-11-03 20:39:30'),
(623, 'App\\Models\\User', 5, 'auth_token', 'ece11a5cda9e676844df54b5a89c2138ffe41f629db8726ade9dd7eabb102bdc', '[\"*\"]', NULL, NULL, '2025-11-03 20:43:23', '2025-11-03 20:43:23'),
(626, 'App\\Models\\User', 49, 'auth_token', 'bf9ff579d8be21281473a459edc65cf0fed9b67b88ccdfa260ea354951e2f258', '[\"*\"]', NULL, NULL, '2025-11-03 20:46:56', '2025-11-03 20:46:56'),
(628, 'App\\Models\\User', 5, 'auth_token', '68960757b24fd6d8d87d33fb48dd8f0da452e20c556def7fa0de22626539d696', '[\"*\"]', '2025-11-03 21:23:40', NULL, '2025-11-03 20:47:41', '2025-11-03 21:23:40'),
(633, 'App\\Models\\User', 5, 'auth_token', '319256295640167e02d244e18bef088480353d510b032ba54a65dfa5c3946ca5', '[\"*\"]', '2025-11-03 20:58:24', NULL, '2025-11-03 20:54:10', '2025-11-03 20:58:24'),
(635, 'App\\Models\\User', 5, 'auth_token', '1d8951989ad1326fbc944b06f006d92f0af274f204272c3b2538acf1eaef69fb', '[\"*\"]', '2025-11-03 22:04:47', NULL, '2025-11-03 20:54:35', '2025-11-03 22:04:47'),
(638, 'App\\Models\\User', 5, 'auth_token', '1bbfc4b18ac97f6cf587feff291ccf344c0f20dda5d84f8572960d6d74e54cc0', '[\"*\"]', '2025-11-03 20:57:47', NULL, '2025-11-03 20:56:31', '2025-11-03 20:57:47'),
(642, 'App\\Models\\User', 5, 'auth_token', '66853ab361249f7579ec0118dca710460f04cee3bda3ba83fd64b36e1d7bb0a0', '[\"*\"]', '2025-11-03 23:39:28', NULL, '2025-11-03 21:05:02', '2025-11-03 23:39:28'),
(646, 'App\\Models\\User', 5, 'auth_token', '8c9110ac543d8f80470e0f13455e8f610ee77176a0fdc3d748e5bbf4335a1e33', '[\"*\"]', '2025-11-03 21:23:20', NULL, '2025-11-03 21:23:05', '2025-11-03 21:23:20'),
(648, 'App\\Models\\User', 5, 'auth_token', 'daec94aa1889d2a59ba1684cc7f9406e9a34418d3325663068d1defa1ee60402', '[\"*\"]', '2025-11-03 21:35:16', NULL, '2025-11-03 21:34:56', '2025-11-03 21:35:16'),
(651, 'App\\Models\\User', 60, 'auth_token', '95eedad818fd19b1c22107d1c0127a532f0cf87d508309a5e4090531074a3e33', '[\"*\"]', '2025-11-03 22:49:07', NULL, '2025-11-03 21:59:17', '2025-11-03 22:49:07'),
(652, 'App\\Models\\User', 5, 'auth_token', 'a6ab9879c66e7ad98128d7169f84142936f242cf4b2f602cfd8fd4c900688bfd', '[\"*\"]', '2025-11-03 22:16:31', NULL, '2025-11-03 22:12:24', '2025-11-03 22:16:31'),
(654, 'App\\Models\\User', 49, 'auth_token', '4bd619669c391db4c8eb0d1e60bcab2f9deacf01da47910c1b39fb0d79051090', '[\"*\"]', '2025-11-03 23:17:06', NULL, '2025-11-03 22:17:12', '2025-11-03 23:17:06'),
(656, 'App\\Models\\User', 5, 'auth_token', 'c646efe0d645d3f58da71ab8a8d90c514f6e5268caa74bb67e11389e8e4a2d00', '[\"*\"]', '2025-11-03 22:19:40', NULL, '2025-11-03 22:19:36', '2025-11-03 22:19:40'),
(658, 'App\\Models\\User', 5, 'auth_token', 'ef0880131ca793272821103df0aac594a0eb81049123ad7c7d2aa84a516ef32d', '[\"*\"]', '2025-11-04 08:47:04', NULL, '2025-11-03 22:27:18', '2025-11-04 08:47:04'),
(659, 'App\\Models\\User', 49, 'auth_token', '5ee5f5017fbf861bb5db5b0221dfe3b1104435fa4eabd9a997326123fa19ed82', '[\"*\"]', '2025-11-03 22:36:53', NULL, '2025-11-03 22:29:33', '2025-11-03 22:36:53'),
(664, 'App\\Models\\User', 5, 'auth_token', '7b89910f56edd68fd76adde1ccdc13eb12b8547c4c8ec47a0a6ed14ed9ceebc5', '[\"*\"]', NULL, NULL, '2025-11-04 02:58:03', '2025-11-04 02:58:03'),
(665, 'App\\Models\\User', 5, 'auth_token', '1612f7114874c7b4f581c58a3e8362780271d74956c9b773eaeec9fbf9fa9883', '[\"*\"]', '2025-11-04 03:15:25', NULL, '2025-11-04 03:00:37', '2025-11-04 03:15:25'),
(668, 'App\\Models\\User', 6, 'auth_token', '7f20155e95db7aac3b44a322a55e7bf630fbb47ff14eddb3876ed395f2bc95d0', '[\"*\"]', '2025-11-04 03:31:27', NULL, '2025-11-04 03:15:43', '2025-11-04 03:31:27'),
(669, 'App\\Models\\User', 6, 'auth_token', '5afb55d40d314c43d26437ad754b3d7359ca0fdf87ccbe0ea79e671ba57a2e2e', '[\"*\"]', '2025-11-04 03:31:09', NULL, '2025-11-04 03:23:15', '2025-11-04 03:31:09'),
(671, 'App\\Models\\User', 59, 'auth_token', '8bbc4fc2962516908d2dc1a122df0a0880109f23845537c221f9566864b8eecf', '[\"*\"]', NULL, NULL, '2025-11-04 03:40:54', '2025-11-04 03:40:54'),
(672, 'App\\Models\\User', 6, 'auth_token', 'd2306d059b59b999c3d8bbbc7cae2e4345fe42a9de9570f4cef23e5395699f0b', '[\"*\"]', NULL, NULL, '2025-11-04 03:41:09', '2025-11-04 03:41:09'),
(676, 'App\\Models\\User', 59, 'auth_token', '47c50a15f71fc6fab4846db4e0860615da4db337ecdffb69e5aef3f328782ad0', '[\"*\"]', NULL, NULL, '2025-11-04 04:30:33', '2025-11-04 04:30:33'),
(677, 'App\\Models\\User', 5, 'auth_token', '1dae943e004971ca913ba83bb81ed245daa7a66e36e88d7ef64e37757ffcd8e1', '[\"*\"]', '2025-11-04 04:35:50', NULL, '2025-11-04 04:30:57', '2025-11-04 04:35:50'),
(678, 'App\\Models\\User', 49, 'auth_token', 'e49591bc0acbd0911d9b05d128d7a4438455b877cf266bc9b1a715f880946ef0', '[\"*\"]', '2025-11-04 04:37:13', NULL, '2025-11-04 04:35:38', '2025-11-04 04:37:13'),
(680, 'App\\Models\\User', 49, 'auth_token', '2999fae785b281aa3c640aa4b0a81285aca2dc70e4f1e6671177c858d9e1a5a6', '[\"*\"]', '2025-11-04 13:54:05', NULL, '2025-11-04 05:41:05', '2025-11-04 13:54:05'),
(681, 'App\\Models\\User', 5, 'auth_token', '78d1cd26ef8bd1334198f0f074c08841c2cc5ba6f4862f84d24c5bc9d9b39887', '[\"*\"]', '2025-11-04 09:51:31', NULL, '2025-11-04 05:50:11', '2025-11-04 09:51:31'),
(682, 'App\\Models\\User', 5, 'auth_token', 'c43a9b92f1632f888fda759684212ed0f3669815d8c8f7bc4df6963195d296e1', '[\"*\"]', '2025-11-04 05:56:42', NULL, '2025-11-04 05:56:32', '2025-11-04 05:56:42'),
(686, 'App\\Models\\User', 5, 'auth_token', 'aacae1a4675100564f7d466b32752c83d45f906c523ef4d297b008e699c833b6', '[\"*\"]', '2025-11-04 06:04:29', NULL, '2025-11-04 06:03:35', '2025-11-04 06:04:29'),
(688, 'App\\Models\\User', 66, 'auth_token', 'e28b0c2e497e1d0332b01ca3238156c29dc122644112617c4a2114a25e5f2e36', '[\"*\"]', '2025-11-04 06:13:27', NULL, '2025-11-04 06:13:02', '2025-11-04 06:13:27'),
(692, 'App\\Models\\User', 67, 'auth_token', 'b015eaebe7b805504ed8e67f0351911c9aeeef3be82616966f0153e7549baf6f', '[\"*\"]', '2025-11-04 06:40:40', NULL, '2025-11-04 06:26:40', '2025-11-04 06:40:40'),
(693, 'App\\Models\\User', 5, 'auth_token', 'd36572d1a7676bef6bb7cc2390e89a66fbfcc04b55f2d1287d8b899d5b1c3953', '[\"*\"]', '2025-11-04 14:57:38', NULL, '2025-11-04 06:26:59', '2025-11-04 14:57:38'),
(694, 'App\\Models\\User', 5, 'auth_token', '5cd62569680b87bb8b2947e6cfc7955624cfe1b23772b7f2ea673b87e8dccfe0', '[\"*\"]', '2025-11-04 06:30:47', NULL, '2025-11-04 06:30:39', '2025-11-04 06:30:47'),
(695, 'App\\Models\\User', 5, 'auth_token', '162643fcc0e1f1896a73902ed2c79bd7351c7e912915d6937648ba8b9ac47952', '[\"*\"]', '2025-11-04 07:55:06', NULL, '2025-11-04 06:32:35', '2025-11-04 07:55:06'),
(698, 'App\\Models\\User', 5, 'auth_token', 'b1483d35527bc04d3f7495474d045b527678dea5e34320d26713ca59a7c7975a', '[\"*\"]', '2025-11-04 06:36:07', NULL, '2025-11-04 06:36:03', '2025-11-04 06:36:07'),
(699, 'App\\Models\\User', 5, 'auth_token', 'd59b824a005af5d2b87b33bc1424ccddfd413d89969f941a7c0c677f6c501db3', '[\"*\"]', '2025-11-04 06:36:39', NULL, '2025-11-04 06:36:38', '2025-11-04 06:36:39'),
(701, 'App\\Models\\User', 67, 'auth_token', '4388234267fec3cdc5f8aff2d33c7401d6426bd531f803679a9f0612307ddea1', '[\"*\"]', '2025-11-04 07:22:25', NULL, '2025-11-04 06:55:22', '2025-11-04 07:22:25'),
(703, 'App\\Models\\User', 68, 'auth_token', '9f6a58e592219ee51254bde0fda9792e23d88165783d283a73cb9b20d4705a7f', '[\"*\"]', '2025-11-04 07:25:09', NULL, '2025-11-04 07:13:35', '2025-11-04 07:25:09'),
(705, 'App\\Models\\User', 66, 'auth_token', '47997249174b1410f39278fbbb4e38ed9516e193b4e5dc9817a03684dc4b34f1', '[\"*\"]', '2025-11-04 07:55:30', NULL, '2025-11-04 07:20:58', '2025-11-04 07:55:30'),
(706, 'App\\Models\\User', 66, 'auth_token', '8c6d82e659aced4f14ce8e1b0642bd16eac4be9d7e39f24d2570a5bf994ee22e', '[\"*\"]', '2025-11-04 07:28:59', NULL, '2025-11-04 07:25:07', '2025-11-04 07:28:59'),
(715, 'App\\Models\\User', 5, 'auth_token', '84373de9363e74b94d7953d9fe71442bc20de689984c24f62a529df64a180e9c', '[\"*\"]', '2025-11-04 13:26:41', NULL, '2025-11-04 08:56:36', '2025-11-04 13:26:41'),
(717, 'App\\Models\\User', 5, 'auth_token', 'd0b03155a341bbe41f166725697dbe8ffbc235552b2c5ae20b15517713aeb1f9', '[\"*\"]', '2025-11-04 09:50:41', NULL, '2025-11-04 09:01:53', '2025-11-04 09:50:41'),
(718, 'App\\Models\\User', 59, 'auth_token', '5ee11fbca43994be8d7da1f6422dcb78a6e21f2b5d4fa5242648b5874d0508e3', '[\"*\"]', '2025-11-04 09:04:26', NULL, '2025-11-04 09:01:58', '2025-11-04 09:04:26'),
(719, 'App\\Models\\User', 5, 'auth_token', 'da76d4e19b88334e955c277d3f3e7e4044934be0dff798563086eba61950241c', '[\"*\"]', '2025-11-04 13:11:01', NULL, '2025-11-04 09:03:25', '2025-11-04 13:11:01'),
(722, 'App\\Models\\User', 5, 'auth_token', '49d9cb466daee7591118c8edea4503b8a332c05515f10a11d2806887740ee8a1', '[\"*\"]', '2025-11-04 10:26:45', NULL, '2025-11-04 09:07:43', '2025-11-04 10:26:45'),
(724, 'App\\Models\\User', 68, 'auth_token', 'f9914cfa8c866f6279c2a7bc368d54bac6a4bbac214e3a8b5ace362d6dfe952c', '[\"*\"]', '2025-11-04 09:13:39', NULL, '2025-11-04 09:12:39', '2025-11-04 09:13:39'),
(725, 'App\\Models\\User', 4, 'auth_token', 'f4b6728386236fcb2f4dc73faa94d7af08adda9f7b6a3e1ed46bcbd19cd76adc', '[\"*\"]', '2025-11-04 09:40:06', NULL, '2025-11-04 09:13:32', '2025-11-04 09:40:06'),
(728, 'App\\Models\\User', 3, 'auth_token', 'dcd0018035e11c03ec8cb0d8cd409991570f41e556ae1fa4e6fca32f09154cd3', '[\"*\"]', NULL, NULL, '2025-11-04 09:19:24', '2025-11-04 09:19:24'),
(732, 'App\\Models\\User', 3, 'auth_token', '1ba69dbd4be843992f3c7c600ec8049786ad58c416c7bf6abbc738eea2286672', '[\"*\"]', '2025-11-04 09:30:55', NULL, '2025-11-04 09:29:22', '2025-11-04 09:30:55'),
(735, 'App\\Models\\User', 74, 'auth_token', '30ee42560f5f60e79f601a125a2c5128cdc47307d31771cef65b96713ee8fc47', '[\"*\"]', '2025-11-04 09:50:40', NULL, '2025-11-04 09:38:41', '2025-11-04 09:50:40'),
(739, 'App\\Models\\User', 37, 'auth_token', '4727fc3b8495b5026eb4ef20a0dc69cb297bc7f43513668af9e7d0899c0bb2e0', '[\"*\"]', '2025-11-04 09:48:09', NULL, '2025-11-04 09:42:26', '2025-11-04 09:48:09'),
(740, 'App\\Models\\User', 77, 'auth_token', '0a046423809353fbdea30a0ed84c1183f9204a8d8c2f0a59f787cc261aa531aa', '[\"*\"]', '2025-11-04 09:50:20', NULL, '2025-11-04 09:46:24', '2025-11-04 09:50:20'),
(745, 'App\\Models\\User', 73, 'auth_token', 'fa1d54a0993f87310cefa7ce3f3c7436374f0caa0dd5d457c21403eaaa4e5832', '[\"*\"]', '2025-11-04 10:11:44', NULL, '2025-11-04 10:11:43', '2025-11-04 10:11:44'),
(746, 'App\\Models\\User', 73, 'auth_token', 'b6da30838aee29c75b41635267b2c57270ac43d6fb96dbd38c5ad0ecf2411051', '[\"*\"]', '2025-11-04 10:11:53', NULL, '2025-11-04 10:11:44', '2025-11-04 10:11:53'),
(747, 'App\\Models\\User', 5, 'auth_token', '99aacd4d28fc7f62de1f666a6124f8bf9f74bffd7c0d77b7f4ebb0b9ad915bfb', '[\"*\"]', '2025-11-04 15:07:59', NULL, '2025-11-04 10:11:58', '2025-11-04 15:07:59'),
(752, 'App\\Models\\User', 5, 'auth_token', 'f09e98b736cf6a62dfc2eb8ea41015e3745b59fc0c014ee6b659bef727deb8b5', '[\"*\"]', '2025-11-04 11:47:53', NULL, '2025-11-04 10:23:00', '2025-11-04 11:47:53'),
(756, 'App\\Models\\User', 6, 'auth_token', '5344c0dbc9688f291e84457fa41a82fc9cb6464cc92e1efbeecc90d1d491faf6', '[\"*\"]', '2025-11-04 10:41:10', NULL, '2025-11-04 10:40:44', '2025-11-04 10:41:10'),
(757, 'App\\Models\\User', 79, 'auth_token', 'b170835fa87b0cd02095c2538ecc1591a3a0cb5c67a48d7302bef3689cba6310', '[\"*\"]', '2025-11-04 15:03:14', NULL, '2025-11-04 10:53:37', '2025-11-04 15:03:14'),
(758, 'App\\Models\\User', 81, 'auth_token', 'dfa74369fbd61dbf1d3802b4c64925148065ea2a9bfcd3acf2a87ddccdf4910f', '[\"*\"]', '2025-11-04 10:54:23', NULL, '2025-11-04 10:53:55', '2025-11-04 10:54:23'),
(759, 'App\\Models\\User', 80, 'auth_token', '2f034b9ca217ebe0a66c6fe8a9e72f4f4ef9d306f107d97fd3c6d2db86966276', '[\"*\"]', '2025-11-04 13:00:42', NULL, '2025-11-04 10:54:32', '2025-11-04 13:00:42'),
(760, 'App\\Models\\User', 76, 'auth_token', 'b3cc8ffb8cde3fde555d80d757e20f427a8bc9077ca96c06994cbc0550d85640', '[\"*\"]', '2025-11-04 10:54:55', NULL, '2025-11-04 10:54:55', '2025-11-04 10:54:55'),
(761, 'App\\Models\\User', 82, 'auth_token', '5e939bdf938dc3d2e36608e5cb8b116b555f024a386c518903bd44a901061481', '[\"*\"]', '2025-11-04 10:56:21', NULL, '2025-11-04 10:55:58', '2025-11-04 10:56:21'),
(763, 'App\\Models\\User', 84, 'auth_token', '84823c9120a128a5f92de5d3096b7f65a79142a9cdd351879eacca699fcc9263', '[\"*\"]', '2025-11-04 13:44:03', NULL, '2025-11-04 10:57:20', '2025-11-04 13:44:03'),
(765, 'App\\Models\\User', 85, 'auth_token', '0f844635718a8bd0022c0760ddda9f30602d2c3f7d8459d5b5664a3187a73dc5', '[\"*\"]', '2025-11-04 11:00:56', NULL, '2025-11-04 11:00:48', '2025-11-04 11:00:56'),
(767, 'App\\Models\\User', 88, 'auth_token', 'c2fb96a0a7cea1f10f2091fdd6392dbb51ad0106f255369235ae3a05854b3254', '[\"*\"]', '2025-11-04 14:40:50', NULL, '2025-11-04 11:03:00', '2025-11-04 14:40:50'),
(769, 'App\\Models\\User', 90, 'auth_token', 'cdf1b6c2d36c972571f9fbaa62ebdf0b0545d3c7b9c3acd642c5091672ac01e9', '[\"*\"]', '2025-11-04 11:06:19', NULL, '2025-11-04 11:05:25', '2025-11-04 11:06:19'),
(776, 'App\\Models\\User', 5, 'auth_token', '1d3df8b9e74d224978d45953e5e90653b54a06b413dc87d5ebdc8432a5b0b5f0', '[\"*\"]', '2025-11-04 13:43:15', NULL, '2025-11-04 11:22:45', '2025-11-04 13:43:15'),
(777, 'App\\Models\\User', 91, 'auth_token', 'f9ae45c60dc17616a2e0728b6901a86d259cac45b2354ff946d50d2bdca1de3c', '[\"*\"]', '2025-11-04 13:37:56', NULL, '2025-11-04 11:27:26', '2025-11-04 13:37:56'),
(778, 'App\\Models\\User', 5, 'auth_token', '09d5bbc34da556247124121367dc3c41cf9858dcb1a875788f1b49c2cdb4f372', '[\"*\"]', '2025-11-04 13:17:10', NULL, '2025-11-04 11:32:20', '2025-11-04 13:17:10'),
(779, 'App\\Models\\User', 5, 'auth_token', 'cc34fd18b67bafcc066cd4f573c5b210290ddecb7a35aa63b1680b3114ac35d7', '[\"*\"]', '2025-11-04 11:46:07', NULL, '2025-11-04 11:33:01', '2025-11-04 11:46:07'),
(782, 'App\\Models\\User', 5, 'auth_token', 'fd3a08ea301658ba8d69ddae0e3fa707dbcdfa96bf235b04cac621b9c1189922', '[\"*\"]', '2025-11-04 11:48:57', NULL, '2025-11-04 11:44:59', '2025-11-04 11:48:57'),
(784, 'App\\Models\\User', 20, 'auth_token', 'c9cd650f5a0a9cdeafdbdaccc4818cc36b4da4c9982db748e106722ccf9febee', '[\"*\"]', '2025-11-04 15:03:12', NULL, '2025-11-04 11:58:04', '2025-11-04 15:03:12'),
(785, 'App\\Models\\User', 55, 'auth_token', '5e07461a56e6bfb197e77a90c8f3ae719c9c668218a599f3e236ea0120e87643', '[\"*\"]', '2025-11-04 15:07:16', NULL, '2025-11-04 11:59:38', '2025-11-04 15:07:16'),
(789, 'App\\Models\\User', 6, 'auth_token', 'c9eb8b7b382900b4c047688d5de49bdada7d6e6533b0da29dc7e767230db4d34', '[\"*\"]', '2025-11-04 13:12:56', NULL, '2025-11-04 13:12:52', '2025-11-04 13:12:56'),
(791, 'App\\Models\\User', 5, 'auth_token', 'e8cb1ff6b112d1fd50b74811fe07b26e954056c842e3ab038e3e15b3f1d7bdd1', '[\"*\"]', '2025-11-04 14:52:49', NULL, '2025-11-04 13:17:42', '2025-11-04 14:52:49'),
(796, 'App\\Models\\User', 30, 'auth_token', '50ca11f9a56cc1ffd48ac21e443fed55182930a8be3519572f3ddbd63c62a534', '[\"*\"]', '2025-11-04 13:43:05', NULL, '2025-11-04 13:40:48', '2025-11-04 13:43:05'),
(797, 'App\\Models\\User', 85, 'auth_token', 'ae35e4a3d25044f00882a89ec8f40ada1c8ea9c2e1b06c797f415c3239fb60e5', '[\"*\"]', '2025-11-04 14:11:47', NULL, '2025-11-04 13:44:41', '2025-11-04 14:11:47'),
(801, 'App\\Models\\User', 4, 'auth_token', 'bd57874040e119503daa4ba216468ec282b629f1def7d98048556c2165bd6660', '[\"*\"]', '2025-11-04 13:53:18', NULL, '2025-11-04 13:53:01', '2025-11-04 13:53:18'),
(803, 'App\\Models\\User', 93, 'auth_token', '66c52e4cda7f5e0dbc61fe7b4defef935e6835cb2288f4b0e4f9f3ec84a761ea', '[\"*\"]', '2025-11-04 14:35:47', NULL, '2025-11-04 13:55:26', '2025-11-04 14:35:47'),
(804, 'App\\Models\\User', 73, 'auth_token', '1ddac70f92e4d967f987a2fe0823912c2ae366832a2aa4ac6570a6c206501307', '[\"*\"]', '2025-11-04 14:10:18', NULL, '2025-11-04 13:55:28', '2025-11-04 14:10:18'),
(805, 'App\\Models\\User', 37, 'auth_token', '96374b7d60251aadb2fd318b7268a6abdac50363e98b93c306460eed0754b7a7', '[\"*\"]', '2025-11-04 13:56:10', NULL, '2025-11-04 13:56:02', '2025-11-04 13:56:10'),
(806, 'App\\Models\\User', 94, 'auth_token', '11c341b8bb4be9a99c4ec9e9ebc0a0a24c5c01f3f386956a44f18e38caaba712', '[\"*\"]', '2025-11-04 14:39:29', NULL, '2025-11-04 14:02:29', '2025-11-04 14:39:29'),
(808, 'App\\Models\\User', 96, 'auth_token', '337180050eb67008e6972a91654f304036f8ee16d540c323ca06a1e098edf3e3', '[\"*\"]', '2025-11-04 14:12:03', NULL, '2025-11-04 14:10:32', '2025-11-04 14:12:03'),
(811, 'App\\Models\\User', 77, 'auth_token', 'dc89261b8ed407c5c48c6935ed22c4600cd742b89c0c0d31541a25415aec66cf', '[\"*\"]', '2025-11-04 14:21:11', NULL, '2025-11-04 14:14:15', '2025-11-04 14:21:11'),
(812, 'App\\Models\\User', 95, 'auth_token', '72efe49804d34608bf64f1d5392e9e15b02defe23b99a05b0126e0ed248b3f54', '[\"*\"]', '2025-11-04 14:29:26', NULL, '2025-11-04 14:28:49', '2025-11-04 14:29:26'),
(814, 'App\\Models\\User', 5, 'auth_token', 'd8d887c3181c999a9eefb392beeddfa51c6b7863435dfc43cfed2c62d1d17cad', '[\"*\"]', '2025-11-04 14:40:08', NULL, '2025-11-04 14:37:16', '2025-11-04 14:40:08'),
(817, 'App\\Models\\User', 94, 'auth_token', 'cdc6ae713740a034aa44651590d6bac0827e3f0a5ca5716d946f7cb5a812b444', '[\"*\"]', '2025-11-04 15:01:42', NULL, '2025-11-04 14:52:39', '2025-11-04 15:01:42'),
(819, 'App\\Models\\User', 98, 'auth_token', '52b76efa2c322822eb09e174f34f54c93d78807d4128f5f421fb63a7de152341', '[\"*\"]', '2025-11-04 14:57:15', NULL, '2025-11-04 14:54:26', '2025-11-04 14:57:15'),
(824, 'App\\Models\\User', 99, 'auth_token', 'e6f1840f59aab385ef8d30417e177b27345a6f7f48bde8708876b6ad14f88a51', '[\"*\"]', '2025-11-04 15:05:31', NULL, '2025-11-04 14:57:33', '2025-11-04 15:05:31'),
(825, 'App\\Models\\User', 80, 'auth_token', 'd39d3ffbc6de761497b76d03bf2d4c812361225029f62cc40d9798bc09d7962d', '[\"*\"]', '2025-11-04 15:05:30', NULL, '2025-11-04 14:57:40', '2025-11-04 15:05:30'),
(826, 'App\\Models\\User', 58, 'auth_token', '1d74d416c7e406beb8944fea54856ddcd5b1df2fc9fc19a89dae1c1ddb7b7e5f', '[\"*\"]', '2025-11-04 14:58:33', NULL, '2025-11-04 14:58:32', '2025-11-04 14:58:33'),
(827, 'App\\Models\\User', 73, 'auth_token', '44c6fce794eb03b69dd19ebd5dc3ae81c8fa240b898bc61f4fd7588607e7787b', '[\"*\"]', '2025-11-04 15:03:25', NULL, '2025-11-04 15:00:04', '2025-11-04 15:03:25'),
(829, 'App\\Models\\User', 83, 'auth_token', 'ffdeab66cf7fdd88845efcb2ccd23c120500e1963ea4adc02d1dbda5cd918e22', '[\"*\"]', '2025-11-04 15:06:56', NULL, '2025-11-04 15:06:55', '2025-11-04 15:06:56'),
(830, 'App\\Models\\User', 100, 'auth_token', 'c6e52fe93745e9a61f75a32a5279802e4a5631b1805832d4b28c2d8144bf190e', '[\"*\"]', '2025-11-04 15:07:54', NULL, '2025-11-04 15:07:48', '2025-11-04 15:07:54'),
(831, 'App\\Models\\User', 51, 'auth_token', '4344cfe71c514a1638aa946ddd3db04b6d5b1f21ab7153412e47aa47a4cceca9', '[\"*\"]', '2025-11-04 15:07:56', NULL, '2025-11-04 15:07:51', '2025-11-04 15:07:56');

-- --------------------------------------------------------

--
-- Table structure for table `presensi_acara`
--

CREATE TABLE `presensi_acara` (
  `id` bigint UNSIGNED NOT NULL,
  `pendaftaran_acara_id` bigint UNSIGNED NOT NULL,
  `modul_acara_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `waktu_absen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Hadir','Belum Hadir') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Belum Hadir',
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `presensi_acara`
--

INSERT INTO `presensi_acara` (`id`, `pendaftaran_acara_id`, `modul_acara_id`, `user_id`, `waktu_absen`, `status`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(82, 173, 47, 18, '2025-11-03 01:40:36', 'Hadir', NULL, NULL, '2025-11-03 01:40:36', '2025-11-03 01:40:36'),
(83, 176, 47, 46, '2025-11-03 01:51:19', 'Hadir', NULL, NULL, '2025-11-03 01:51:19', '2025-11-03 01:51:19'),
(84, 175, 45, 46, '2025-11-03 01:54:38', 'Hadir', NULL, NULL, '2025-11-03 01:54:38', '2025-11-03 01:54:38'),
(86, 180, 46, 29, '2025-11-03 08:58:22', 'Hadir', NULL, NULL, '2025-11-03 08:58:22', '2025-11-03 08:58:22'),
(89, 205, 42, 59, '2025-11-04 04:53:57', 'Hadir', NULL, NULL, '2025-11-04 04:53:57', '2025-11-04 04:53:57'),
(92, 209, 97, 49, '2025-11-04 05:57:17', 'Hadir', NULL, NULL, '2025-11-04 05:57:17', '2025-11-04 05:57:17'),
(94, 222, 98, 70, '2025-11-04 08:50:33', 'Hadir', NULL, NULL, '2025-11-04 08:50:33', '2025-11-04 08:50:33'),
(95, 238, 100, 74, '2025-11-04 09:48:43', 'Hadir', NULL, NULL, '2025-11-04 09:48:43', '2025-11-04 09:48:43'),
(96, 242, 100, 77, '2025-11-04 09:49:10', 'Hadir', NULL, NULL, '2025-11-04 09:49:10', '2025-11-04 09:49:10'),
(97, 239, 100, 76, '2025-11-04 09:49:29', 'Hadir', NULL, NULL, '2025-11-04 09:49:29', '2025-11-04 09:49:29'),
(98, 240, 100, 73, '2025-11-04 09:50:43', 'Hadir', NULL, NULL, '2025-11-04 09:50:43', '2025-11-04 09:50:43'),
(99, 244, 98, 6, '2025-11-04 10:23:52', 'Hadir', NULL, NULL, '2025-11-04 10:23:52', '2025-11-04 10:23:52'),
(100, 249, 98, 89, '2025-11-04 11:16:00', 'Hadir', NULL, NULL, '2025-11-04 11:16:00', '2025-11-04 11:16:00'),
(101, 250, 102, 89, '2025-11-04 11:20:35', 'Hadir', NULL, NULL, '2025-11-04 11:20:35', '2025-11-04 11:20:35'),
(102, 219, 98, 66, '2025-11-04 11:42:21', 'Hadir', NULL, NULL, '2025-11-04 11:42:21', '2025-11-04 11:42:21'),
(103, 253, 98, 92, '2025-11-04 13:14:07', 'Hadir', NULL, NULL, '2025-11-04 13:14:07', '2025-11-04 13:14:07'),
(104, 254, 102, 30, '2025-11-04 14:55:09', 'Hadir', NULL, NULL, '2025-11-04 14:55:09', '2025-11-04 14:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `sertifikats`
--

CREATE TABLE `sertifikats` (
  `id` bigint UNSIGNED NOT NULL,
  `name_peserta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_sertif` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_sertif` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sertifikats`
--

INSERT INTO `sertifikats` (`id`, `name_peserta`, `kode_sertif`, `tanggal_sertif`) VALUES
(1, 'Sukmawan Azis Abdul', 'aaaaaa', '2025-11-30 20:40:18'),
(2, 'Sukmawan Azis Abdul', 'aaaaaa', '2025-11-30 20:40:18');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('superadmin','peserta') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_login_attempts` int NOT NULL DEFAULT '0',
  `locked_until` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `telp`, `role`, `email`, `email_verified_at`, `password`, `remember_token`, `failed_login_attempts`, `locked_until`, `created_at`, `updated_at`) VALUES
(1, 'Abdul Azis Sukmawan', 'azis', '081234567890', 'superadmin', 'superadmin1@gmail.com', '2025-10-31 15:59:00', '$2y$12$S8UA54QjG6wk1pSgkO/GruAFNr6FyQJuH9bQfCPvOjazUu.3g/cLu', NULL, 0, NULL, '2025-10-31 15:59:00', '2025-11-03 10:02:57'),
(2, 'Yohanes Tedy', 'tedy', '081234567890', 'superadmin', 'superadmin2@example.com', '2025-10-31 15:59:00', '$2y$12$hWOV4ONt1l4p1RSO8SqtLeNQ7CPew0u94Mtm7scti8tSBUceGg.UC', NULL, 0, NULL, '2025-10-31 15:59:00', '2025-10-31 15:59:00'),
(3, 'Fakhri', 'fakhri', '081234567890', 'superadmin', 'superadmin3@example.com', '2025-10-31 15:59:00', '$2y$12$3jsFxjCYiJ2FWWkJh2WgguXzunGiFBCvTGvrdwUV2Ht4qXG5.gUBi', NULL, 0, NULL, '2025-10-31 15:59:01', '2025-11-04 09:29:22'),
(4, 'Rizan', 'rizan', '081234567890', 'superadmin', 'superadmin4@example.com', '2025-10-31 15:59:01', '$2y$12$R0iy4jmI65CgthcZ6/KeWOFu6efNvsCxeoDYsu3SA/5gbh.faIYMK', NULL, 0, NULL, '2025-10-31 15:59:01', '2025-11-03 09:55:44'),
(5, 'Asep Kangkung', 'asep', '081234567890', 'superadmin', 'superadmin5@example.com', '2025-10-31 15:59:01', '$2y$12$d065YzF0PZ9eK8eI2v4cEe3u3nBxMj4Y8lU3nfhUzwi9EOD/6BRwq', NULL, 0, NULL, '2025-10-31 15:59:01', '2025-11-04 13:17:42'),
(6, 'Najib Ahoy', 'pesertainternal', '0851263723', 'peserta', 'peserta1@example.com', '2025-10-31 15:59:01', '$2y$12$9H4Yi4TnL5FiGjZIgUJrc.qPY.gqfeel/SAuIp5TBvkVpZvg2/2za', NULL, 0, NULL, '2025-10-31 15:59:01', '2025-11-04 10:40:44'),
(7, 'Andi Peserta Eksternal', 'pesertaeksternal', '081234567890', 'peserta', 'peserta2@example.com', '2025-10-31 15:59:01', '$2y$12$58gsoJd/50k7Gl6MixbUhuQ/uc/Cq/bSDMnQlucXo9GyUQJeO1dhO', NULL, 0, NULL, '2025-10-31 15:59:02', '2025-10-31 15:59:02'),
(8, 'Jess Schmeler IV', 'marco.mclaughlin', '+1.404.766.9167', 'peserta', 'vheller@example.net', '2025-10-31 15:59:02', '$2y$12$95FcuQFJPfM7qRZy8P99uOQ.IWarjp1VpDfu94QvuQ7Eel1z.hiZ2', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(9, 'Mr. Cyril Armstrong', 'barrows.dewitt', '405.720.9720', 'peserta', 'duane.medhurst@example.org', '2025-10-31 15:59:02', '$2y$12$5FZG.R4CllaFm8yYht/Zauof/MQ2fcCZTBeRUMIGLL6f9IY1lXVXS', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(10, 'Freeda Collier', 'deontae48', '630.487.9461', 'peserta', 'bednar.harvey@example.com', '2025-10-31 15:59:02', '$2y$12$uWyyMalO6IpKLCu.8measOKNVSTityRY7VkwjCTUwrC.VHLJEy4La', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(11, 'Magali Kub DVM', 'russel.oliver', '1-906-452-5882', 'peserta', 'vohara@example.org', '2025-10-31 15:59:02', '$2y$12$NBQnB6TQuBdFR598qNfWYuOlx9SHjji4r7OfaRf77Jjwo0bBnE7ky', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(12, 'Darlene Ryan', 'xbreitenberg', '845.505.6789', 'peserta', 'schuster.dell@example.com', '2025-10-31 15:59:03', '$2y$12$x6F/QAOxzClIUTpQZJ6py.vCXluuWZxFMCw3Pxhu4UyVVwbUf/LQu', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(13, 'Elmore Towne', 'xgutkowski', '1-785-418-7421', 'peserta', 'cjones@example.org', '2025-10-31 15:59:03', '$2y$12$HxEdr6lVP48HRokU9S8rsu0gXPV.ZCyII9lAty6HGekcGhVfau2TW', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(14, 'Lilly Treutel II', 'wdavis', '669.865.6470', 'peserta', 'mclaughlin.dianna@example.net', '2025-10-31 15:59:03', '$2y$12$A8pmqQj0EsT18SLgGHPgMelq.PycTF73thfWrvsixmds5w7kjyKai', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(15, 'Jaycee Jaskolski', 'briana88', '+1-830-659-4697', 'peserta', 'garnet68@example.net', '2025-10-31 15:59:03', '$2y$12$fepUnltOowvk9WYs5Cp6jOKnBWw1Cwl/CiqoMYFnubTRGcDNG2JMS', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(16, 'Stephanie Stehr', 'hickle.katrine', '+18458433305', 'peserta', 'royce.hermann@example.org', '2025-10-31 15:59:03', '$2y$12$N153FOfxc7TnY4KKls002uE8zIvPiKsn1o48.NqEA86YYKv.y.KW2', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(17, 'Lela Halvorson', 'annabell.zulauf', '+1.803.260.1863', 'peserta', 'gmertz@example.net', '2025-10-31 15:59:04', '$2y$12$/34TSWbzeQhIoR06WSGWR.YIHARKb/tM.fCBYcKbSDh9e3iQqeq46', NULL, 0, NULL, '2025-10-31 15:59:04', '2025-10-31 15:59:04'),
(18, 'Melanie Refmannnnn', 'mel123', '081371173356', 'peserta', 'melanierefman84@gmail.com', '2025-10-31 16:02:12', '$2y$12$WOsSndmHCElqDOAwc54ctueHF/nBwJ.mJiJUDAmEy.vA2HyUd/hVa', NULL, 14, '2025-11-04 06:25:02', '2025-10-31 16:01:45', '2025-11-04 06:10:02'),
(19, 'mfatih', 'mfatih', '081510040349', 'peserta', 'mfatihbagaskara11@gmail.com', '2025-10-31 17:55:30', '$2y$12$WFGxWoJnxYT8nJu.UQmDLepm3ug36GP.bIe/XiWeQtD8ddbpSToIW', NULL, 0, NULL, '2025-10-31 17:54:43', '2025-10-31 17:55:30'),
(20, 'John', 'johnjohn', '0813251329960', 'peserta', 'doanda.dev@gmail.com', '2025-10-31 20:28:40', '$2y$12$eFqNPn87c0PfWPQaRkV7Tubl4EzqHyAH86qffXZUjUjl884ajuswW', NULL, 0, NULL, '2025-10-31 20:27:42', '2025-11-02 13:18:52'),
(21, 'Bahlil lahadalia', 'azissukmawan', '08123456999', 'peserta', 'sukmawanabdul@gmail.com', '2025-10-31 21:28:05', '$2y$12$0vzz9ziUWco2KU2PJNdbO.rWSMiAvcklLHXrNx.l9jbrpO6BsvvvS', NULL, 0, NULL, '2025-10-31 21:27:11', '2025-11-03 09:18:07'),
(22, 'admin', 'admin', '0888888888', 'peserta', 'admin@gmail.com', NULL, '$2y$12$Q52l6Rk9DFyMB9fFPfRoeuyFUsh/H4TQThpM4WGz.GpAEgfNFbBx.', NULL, 2, NULL, '2025-11-01 08:05:09', '2025-11-04 14:17:19'),
(23, 'Doanda', 'ddpanda', '081325132996', 'peserta', 'drdoanda@gmail.com', NULL, '$2y$12$cKMdQjrCsmAlU5cTQlYdG.yFonNMXYRYvSNdIvd9YqEW.4baDLRE6', NULL, 0, NULL, '2025-11-01 11:27:30', '2025-11-01 11:27:30'),
(24, 'Yonda', 'yondayonda', '081231231231', 'peserta', 'ddoanda37@gmail.com', '2025-11-01 12:18:31', '$2y$12$8BzmLSHqawfAvRhMAt26v.0n7P/Sy7zotSxT.MvqonSRlziUMlQOe', NULL, 1, NULL, '2025-11-01 12:18:06', '2025-11-01 22:43:44'),
(25, 'udaonan d', 'audannn', '1019191919191', 'peserta', 'fauzimanz23@gmail.com', NULL, '$2y$12$N/REVL261AjVhoWBbTK9fuMFgOmwcW1Aa4DK55yiU74N7RDgOU/c.', NULL, 0, NULL, '2025-11-01 13:02:23', '2025-11-01 13:02:23'),
(26, 'Sinteh Young', 'Sinteh', '08123121212', 'peserta', 'sinteh21@gmail.com', '2025-11-01 13:19:16', '$2y$12$4YoDdBUgyRMB5MbJZKiGbOiWHjeyA4nFXwpy8ZlzRDQ5l.3ifDTxC', NULL, 0, NULL, '2025-11-01 13:15:33', '2025-11-01 13:35:30'),
(27, 'Fauzi', 'Fauzim', '10101010019', 'peserta', 'fauziman52078@gmail.com', '2025-11-01 13:16:54', '$2y$12$mtv81MXAxCLlBTeqcIMAmO1XB8HHHyDCnF0ZdyP2xbySd7CSJKjzS', NULL, 0, NULL, '2025-11-01 13:16:26', '2025-11-01 13:16:54'),
(28, 'Titik S', 'titiks', '081231972708', 'peserta', 'mamahtitiksugiyarni@gmail.com', NULL, '$2y$12$p5DtPuOEvZEx2QYj2MqvQ.FlRyexRpdH23l6G4RjLHnMIyfOKUqkS', NULL, 0, NULL, '2025-11-01 13:31:35', '2025-11-01 13:31:35'),
(29, 'Bahlil Alexander Felixandro', 'lilnasxbahlil', '085964327811', 'peserta', 'amawannn9@gmail.com', '2025-11-01 18:36:48', '$2y$12$./PUMr/h9tWHcGF.nFQjh.WBvRDNMydb/9dB5L6Zp7cjoop8ncl8m', NULL, 6, '2025-11-03 16:23:23', '2025-11-01 18:35:52', '2025-11-03 16:08:23'),
(30, 'Nunikkkk', 'nunik', '085780903720', 'peserta', 'nunik.suroya@gmail.com', '2025-11-01 20:49:47', '$2y$12$n4hVoAaweFeQYiSlUQB/uev92vwQA6sOq7kEK3O.Gi5uhrAVXb0JC', NULL, 0, NULL, '2025-11-01 20:48:34', '2025-11-04 14:56:39'),
(31, 'testuser', 'testuser1', '0812382388281', 'peserta', 'testuser1@gmail.com', NULL, '$2y$12$RKOEaboIHiTrYEuq3G7SouXLl/R0iZFw.MpOgfOUvlT98QogFpDl.', NULL, 0, NULL, '2025-11-01 21:18:23', '2025-11-01 21:18:23'),
(32, 'Asep', 'asepajahh', '081234567893', 'peserta', 'asepajahh@example.com', NULL, '$2y$12$xCxvJHp0ef4qEoaYeZMPN.EqFOf7w3Az/hXdXZPOuUqN5tGik2uXS', NULL, 0, NULL, '2025-11-01 22:44:45', '2025-11-01 22:44:45'),
(33, 'Asep', 'asepajah', '081234567893', 'peserta', 'asepajahh@gmail.com', NULL, '$2y$12$jw3vhE2KdoxxGvlYF4RG8O.IHIYCdVubYABquPWzlXDuKa1uURrsO', NULL, 0, NULL, '2025-11-01 22:49:39', '2025-11-01 22:49:39'),
(34, 'Asep', 'asepajah1h', '081234567893', 'peserta', 'asepajahhh@gmail.com', NULL, '$2y$12$NaN9VEMvGVlRKaEVJ9EeIOE77XpeJ9OiYcbpN030YIXGXI2uWG2AO', NULL, 0, NULL, '2025-11-02 08:02:22', '2025-11-02 08:02:22'),
(35, 'tes tes', 'testtest', '081234567894', 'peserta', 'tesh@example.com', NULL, '$2y$12$589rxPrHR79cfv7sv7A1beOhZlEhY8qc86jVZiZwe7Dy8sR.J/A32', NULL, 0, NULL, '2025-11-02 08:03:38', '2025-11-02 08:03:38'),
(36, 'lixiano', 'lixianosup', '088808014419', 'peserta', 'sealixie@airnavindonesia.co.id', NULL, '$2y$12$AWf/riExoIvKsRG3W/3ggeKg6njENkrX7/bnKOB0SRGAHtgjQluTC', NULL, 0, NULL, '2025-11-02 10:12:47', '2025-11-02 10:12:47'),
(37, 'lixiannoo', 'lixiannosup', '088228757719', 'peserta', 'sealskyccc@gmail.com', '2025-11-02 10:14:49', '$2y$12$CA1ioxNuGnZdTG5TT3uFz.cJC2l58NrhINiAGsifvzQPp4VTFhlyS', NULL, 0, NULL, '2025-11-02 10:14:05', '2025-11-03 01:16:53'),
(38, 'Jajang Miharja', 'Jajang Gamtenk', '089516049048', 'peserta', 'mutiarab711@gmail.com', '2025-11-02 11:09:05', '$2y$12$QN/7dg7eDqYoeWk7a46N5uDsN0u6CO/zBmaLSU0TXu7DBLygBST7a', NULL, 0, NULL, '2025-11-02 11:08:33', '2025-11-02 11:09:05'),
(39, 'Juanda', 'Mang Juanda', '081267893653', 'peserta', 'putrigultom627@gmail.com', '2025-11-02 11:18:10', '$2y$12$G8IzLLAukmegWnxz3GXYOODQ9vo6CXxyhfhTlHaY4bGB.Dsc4uQ5O', NULL, 0, NULL, '2025-11-02 11:17:45', '2025-11-03 13:31:29'),
(40, 'Kaylie', 'Kaylie Jenner', '08973766628', 'peserta', 'alfatassidiqi@gmail.com', NULL, '$2y$12$yqbqQ3TKTMU4ktX3e7edgO6XCSzNG0vOzlT6Yo0FxaB.EcCTocXhK', NULL, 0, NULL, '2025-11-02 11:25:38', '2025-11-02 11:25:38'),
(41, 'Haris L', 'Haris Jaenab', '089516049043', 'peserta', 'alfatasidiqqi@gmail.com', '2025-11-02 11:42:26', '$2y$12$S31RuRH9Q.JqcabjKMvKFen.bo/aLpgu96wtRCcK/9lKqv3nfExeu', NULL, 0, NULL, '2025-11-02 11:39:58', '2025-11-02 12:33:45'),
(42, 'Justin Kere', 'justin asep', '089767894569', 'peserta', 'asidiqqialfat@gmail.com', '2025-11-02 12:51:08', '$2y$12$VVZAg7xXdTSEf4Ugs9mR0ujqJqbHtxTZPxfD6KL8rH57LkNzQQ9m.', NULL, 0, NULL, '2025-11-02 12:49:59', '2025-11-02 13:48:56'),
(43, 'Sebuah Kisah', 'kesalahanberpikir', '0895350630611', 'peserta', 'lanzzers123@gmail.com', '2025-11-02 14:12:43', '$2y$12$ZY8Yr93URJuvtiWrh3DCw.9NLTQraKYFRG0kysxhhlTNW.jXLnqt2', NULL, 0, NULL, '2025-11-02 14:11:17', '2025-11-02 14:14:10'),
(44, 'lifa', 'lifa', '0882003667531', 'peserta', 'lifa123@gmail.com', NULL, '$2y$12$hDCBZE89771XEDHaCM/MX.cgpJr/APBd4ls5Bw8uypeGVazAM.XbK', NULL, 0, NULL, '2025-11-02 14:41:46', '2025-11-02 14:41:46'),
(45, 'Aditya Yufnanda', 'Adith', '081234567764', 'peserta', 'adithmedan@gmail.com', '2025-11-02 23:18:10', '$2y$12$MOktpvPZKVFdInvO0ujXWuqKeA.KNbMvQSCC308EeAm74qw6TZINq', NULL, 2, NULL, '2025-11-02 23:17:09', '2025-11-04 06:09:23'),
(46, 'User Non Karyawan', 'usernon123', '081371222222', 'peserta', 'melanierefman44@gmail.com', '2025-11-03 01:47:17', '$2y$12$ZCsZhei0Wr/CIaAYBrCbrO0rkqoTjozkrH0dE/5Y1anG/jfc76drq', NULL, 0, NULL, '2025-11-03 01:46:50', '2025-11-03 01:47:17'),
(47, 'fakhriii', 'mfakhria', '0857234323', 'peserta', 'abdulazissukmawan@gmail.com', '2025-11-03 09:43:27', '$2y$12$sil4dYuCD9TKe/v.crdFVOGtEnhv7Q7SDxcY6U9tJPF4rfKnWuJ4.', NULL, 0, NULL, '2025-11-03 09:42:58', '2025-11-03 10:16:05'),
(48, 'Farhan Rizki Fauzi', 'farhan', '089662060909', 'peserta', 'farhanrizki475@gmail.com', '2025-11-03 09:58:15', '$2y$12$ySj3kye6.PyUEUh7NOoF0OLGZqJmgFCUvEaiFvipohxvI7iSPLmaC', NULL, 0, NULL, '2025-11-03 09:57:35', '2025-11-03 09:58:15'),
(49, 'aaa1', 'aaa1', '123456789102', 'peserta', 'cq53rf5obs@wnbaldwy.com', '2025-11-03 10:18:30', '$2y$12$1rcE9Xv.esAslKJ/xUgHA./glwfqW3SSEqrUNTjq3FibtBYXuVUTa', NULL, 2, NULL, '2025-11-03 10:17:49', '2025-11-04 11:08:23'),
(50, 'Talitha Aurora', 'nadenggansrgr', '085868529716', 'peserta', 'talithaansiregar@gmail.com', '2025-11-03 11:07:36', '$2y$12$nfaM5hW4mqL7ZvXQWirnhuPlW/WuGnI/XT4xWAE1lmUacbF.gb4sa', NULL, 0, NULL, '2025-11-03 11:07:07', '2025-11-03 11:09:51'),
(51, 'M Fakhri A', 'fakhriuser', '085723847291', 'peserta', 'fakhrizon607@gmail.com', '2025-11-03 11:30:36', '$2y$12$GQ03Qd9Uy31JHdjMT3ctcOYMm0Ix3kMox7Bw3yApyfPgmRB.V820G', NULL, 0, NULL, '2025-11-03 11:30:08', '2025-11-04 13:39:11'),
(52, 'Asepkjbk', 'asepajah1hh', '081234567893', 'peserta', 'asepajahhhhh@gmail.com', NULL, '$2y$12$XkbUY8Jc9t28WcqfcyPZ3ej/8WWofdycRJtwZf3CeiMMHuQshuEWu', NULL, 0, NULL, '2025-11-03 11:57:58', '2025-11-03 11:57:58'),
(53, 'ahmad showi samrotul fuadi', 'ahmadshowi', '087654321987', 'peserta', 'ahmadshowi15@gmail.com', '2025-11-03 13:16:43', '$2y$12$B98VkvRMSC8IGWN5DOT1a.1c9hff2nAux6J/Ooj9wVjjdgrS/UM86', NULL, 2, NULL, '2025-11-03 13:15:48', '2025-11-04 13:49:18'),
(54, 'Keonho', 'User AirNav', '081548213834', 'peserta', 'keonho@gmail.com', NULL, '$2y$12$18uTPCzZRHexTIpIrooBHOAXVE28oJoeeL5GehPIYrMte8hPgqIFu', NULL, 0, NULL, '2025-11-03 13:52:36', '2025-11-03 13:52:36'),
(55, 'sallys', 'sallz', '089501030283', 'peserta', 'ashleyclaristine@gmail.com', '2025-11-03 13:55:42', '$2y$12$8Cl1SIoBXdWK7bGo1RAiSOxT4c7wDMvtPdX/eWyZU0//7cPE2.UMq', NULL, 0, NULL, '2025-11-03 13:53:52', '2025-11-03 14:08:29'),
(56, 'Siska Khoirunnisa', 'Siska Khoirunnisa', '081548213834', 'peserta', 'siskakhnnisa@gmail.com', '2025-11-03 13:56:49', '$2y$12$sFoBuELhjVdLwOmtcYhLM.EGDMMRvRM/JFQQ2vSu0cxErFxY9xlgm', NULL, 0, NULL, '2025-11-03 13:56:06', '2025-11-03 21:57:09'),
(57, 'Doanda DR', 'ddoanda', '081325132996', 'peserta', 'ddoanda@gmail.com', NULL, '$2y$12$Zj7a5M106S42IvnGAzoWbeZK.Tjmv7im7YLvPr1sO3TW1vKmEr3Tq', NULL, 0, NULL, '2025-11-03 19:35:56', '2025-11-03 19:35:56'),
(58, 'Siska Khoirunnisa', 'siskakhnnisa', '08219218298030', 'peserta', 'siskakhoirunnisa00@gmail.com', '2025-11-03 20:51:03', '$2y$12$DPyHqFGff.aipy5TSfM3Y.rcBTj6k6ckYFmQfsMZRIRC/kmjMDsA2', NULL, 0, NULL, '2025-11-03 20:49:39', '2025-11-04 14:58:32'),
(59, 'User Karyawann', 'user karyawan', '081371222224', 'peserta', 'krpaleobrinweb@gmail.com', '2025-11-03 20:51:58', '$2y$12$QfP1HvuUjOX8.3fCrDYgGOH2Cig2vgck6Cy376gnSNgbrV1zRuxcm', NULL, 0, NULL, '2025-11-03 20:51:32', '2025-11-04 09:02:38'),
(60, 'Siska Khoirunnisa', 'siskannisa', '081298980829', 'peserta', 'siskaakhoirunnisaa1.1@gmail.com', '2025-11-03 21:58:59', '$2y$12$vHnmsEH7fBRk9EdNLN4qGuLCmbiVe6V5e7wdBNJZ.6lbKiLM1b34C', NULL, 0, NULL, '2025-11-03 21:58:20', '2025-11-03 21:58:59'),
(61, 'Test User', 'testkaryawan', '081234567891', 'peserta', 'vwqzs@2200freefonts.com', NULL, '$2y$12$4jTvcbgdkFZ8cHxQRxUOC.ripDDxHGh9rjqbmizeYU7/EkIspRv4C', NULL, 0, NULL, '2025-11-04 04:52:23', '2025-11-04 04:52:23'),
(62, 'James Doe', 'james22', '12345678910', 'peserta', 'siroy69349@fandoe.com', NULL, '$2y$12$ZtIXVO5Mu0rjVFUSCDt0F.sDygpd5KbqjMQ6M63fQ6eI.eih5zL8.', NULL, 0, NULL, '2025-11-04 05:27:32', '2025-11-04 05:27:32'),
(63, 'shjsnsns', 'james77', '1717272717', 'peserta', 'jhkno@2200freefonts.com', NULL, '$2y$12$ydHOj7GIKIbN3LRMYJINNua4kZ2GPzriMNZMVQtiN.Bt4m8VnK4ZK', NULL, 0, NULL, '2025-11-04 05:33:23', '2025-11-04 05:33:23'),
(64, 'Asep kasep', 'asepajahh123', '081234567893', 'peserta', 't0u5q@2200freefonts.com', NULL, '$2y$12$OtXi9NiACfQSkXLp6r.ahuRZeR7G4bkGJKIM4tbntfMhsvmr.bx8W', NULL, 0, NULL, '2025-11-04 05:44:04', '2025-11-04 05:44:04'),
(65, 'Muhammad Aditya Yufnanda', 'Aditya', '081939267649', 'peserta', 'adithmedan@airnavindonesia.co.id', NULL, '$2y$12$zpE4/Qv3v4VQzdCahkvRtupotejny76csbwEd.ZBLkm5AmPmyTjuK', NULL, 0, NULL, '2025-11-04 06:07:15', '2025-11-04 06:07:15'),
(66, 'Aira Navalia Indrawastika', 'karyawankaryawan1432', '081264567890', 'peserta', 'aexak@2200freefonts.com', '2025-11-04 06:08:08', '$2y$12$Tw.hP5gF6UPVAgwntWT5UuHCovjdsR6hg.n1aOTiRvSm69RSmQBF2', NULL, 0, NULL, '2025-11-04 06:07:25', '2025-11-04 11:56:26'),
(67, 'Adithyuyuyu', 'Alexandria', '998877665522', 'peserta', 'adityayufnanda25@gmail.com', '2025-11-04 06:22:36', '$2y$12$XLhTnO2bMUvj1zCzpb1eCeIuwSfro12wa08LMkv5buGZb/lXOhbNW', NULL, 0, NULL, '2025-11-04 06:21:38', '2025-11-04 13:33:15'),
(68, 'Fauziman', 'fajx', '2929292828282', 'peserta', 'yunansetiadi6@gmail.com', '2025-11-04 07:12:49', '$2y$12$cGzJQHAX7Kh0MUkngdn6j.bHb.1SFygB.0oa57Kou6uvtOCivvUGu', NULL, 0, NULL, '2025-11-04 07:12:12', '2025-11-04 08:16:39'),
(69, 'Farhan Rizki Fauzi', 'Farhanrizki', '089662060909', 'peserta', 'frhnrizki24@gmail.com', NULL, '$2y$12$O/AxLdmHaZ9zXu47Y6pZ9OvRIcNVFuMSYdw.xrC43VCCPc3n9v8Jy', NULL, 0, NULL, '2025-11-04 08:28:04', '2025-11-04 08:28:04'),
(70, 'Michael Farhan', 'farhanrizkif', '089662060908', 'peserta', 'frhanrizki24@gmail.com', '2025-11-04 08:30:47', '$2y$12$6c2UW63oYgVk14KypqPFgOtUH23E.vP6jPapzvdPQ.HMU5KpglQpC', NULL, 0, NULL, '2025-11-04 08:30:29', '2025-11-04 08:41:22'),
(71, 'Nama Peserta', 'namapeserta37', '081234567890', 'peserta', '5z4y6@2200freefonts.com', '2025-11-04 08:58:52', '$2y$12$H4snLt.lmOkITCFAvL6tj.5/phVGOf/8mDJklLa2RB86jghBKM5uq', NULL, 0, NULL, '2025-11-04 08:58:27', '2025-11-04 08:58:52'),
(72, 'Putri', 'Put', '08962828674', 'peserta', 'putrigultom01014@gmail.com', NULL, '$2y$12$eR302v/fMIpgEdZ.c3d4U.BCU5rpJCae/2u7n8EA1KyBKljNwGb2.', NULL, 0, NULL, '2025-11-04 09:27:08', '2025-11-04 09:27:08'),
(73, 'putri gulton', 'putri', '08763627723', 'peserta', 'putrigultom010104@gmail.com', '2025-11-04 09:29:58', '$2y$12$wMg5UJ3/MelmYCxepNBDLOP5bK7MpHcNpqKXFugNw4Un.ZMdokpD2', NULL, 0, NULL, '2025-11-04 09:29:44', '2025-11-04 10:14:47'),
(74, 'Azzah Husna', 'Azzah', '0812731829121', 'peserta', 'azzhhsna08@gmail.com', '2025-11-04 09:38:26', '$2y$12$39h6gEvLdp8Ykm0EdSGp1.NHqq2YfXbPVzxEEnD.LM9HV7Yc94M0q', NULL, 0, NULL, '2025-11-04 09:37:43', '2025-11-04 09:41:36'),
(75, 'fatih', 'mfatihbagaskara', '081510040349', 'peserta', 'mfatihbagaskara@gmail.com', NULL, '$2y$12$1QpEgWD08hjlhgeeRSxN6OaPfdL5fIIiBKbpx1KfIANQ8lTLfk29K', NULL, 1, NULL, '2025-11-04 09:37:57', '2025-11-04 09:41:08'),
(76, 'Rizki Novian', 'Rizki Novian', '06282110737645', 'peserta', 'rizkinovian236@gmail.com', '2025-11-04 09:38:30', '$2y$12$dlExWKtZWuP44MJ1221R5edq80guBwb9iwgCo4WyjzolEAAnc89tO', NULL, 0, NULL, '2025-11-04 09:38:02', '2025-11-04 09:38:30'),
(77, 'fatih', 'mfatihb', '081510040349', 'peserta', 'mfatihbagaskara@apps.ipb.ac.id', '2025-11-04 09:46:08', '$2y$12$AQQsg/J9xcVWbHTOtHyUouAdVbxhJklPH.8Xr9w266zOq2NolO49K', NULL, 0, NULL, '2025-11-04 09:45:38', '2025-11-04 14:14:15'),
(78, 'Peserta baru 1', 'User', '0987654321', 'peserta', '0pa99@2200freefonts.com', '2025-11-04 10:38:37', '$2y$12$bqOiiTQCJe07E2JORK05pOrMxfrqfXQv4DaVwqDRe3G1CWFypyyGy', NULL, 0, NULL, '2025-11-04 10:38:20', '2025-11-04 10:54:34'),
(79, 'Raihan Fathan', 'rhn', '081828362722', 'peserta', 'bemainan123@gmail.com', '2025-11-04 10:53:19', '$2y$12$8ZBo.grMAd5Xl5SllZIFZ.ursiY0k/TkhHFXOmSr7oB6FT6bldd0G', NULL, 0, NULL, '2025-11-04 10:52:50', '2025-11-04 10:53:19'),
(80, 'Yohanes Tedy Kurniawan', 'yohanestedy', '087741802584', 'peserta', 'yohanestedy52b@gmail.com', '2025-11-04 10:53:41', '$2y$12$5iheHeFg.exkG7mC9eInTemvjR6Mw4pOWITRuVM0v8HIgdwgIiiEO', NULL, 0, NULL, '2025-11-04 10:52:59', '2025-11-04 14:57:40'),
(81, 'Gavrila', 'gavrilahana', '0895703057807', 'peserta', 'gav.hana1@gmail.com', '2025-11-04 10:53:44', '$2y$12$l2OEZ.tzj9MIrCsXAxvS1OU/Ucon6pZdz.USIXUTvZLG5wEdK996i', NULL, 0, NULL, '2025-11-04 10:53:01', '2025-11-04 10:53:44'),
(82, 'ayuna', 'ayuna', '081290060072', 'peserta', 'ayuurahma11@gmail.com', '2025-11-04 10:55:53', '$2y$12$B558ptfMkWXJOrflfNW99utTg/Ls0basVn.F8y8ArH1jW5As8xKai', NULL, 0, NULL, '2025-11-04 10:55:27', '2025-11-04 10:55:53'),
(83, 'Syah Rizan Nazri Muhammad', 'syahrizan', '08979415320', 'peserta', 'snazrimuh@gmail.com', '2025-11-04 10:57:01', '$2y$12$buRsXa70If15bpOoxBXheux/z5Xh4BlTrbGX/axNBrglxUEYoBTLS', NULL, 0, NULL, '2025-11-04 10:56:30', '2025-11-04 10:57:01'),
(84, 'Annisa Nur Iksan', 'anisa.nurii', '083895482262', 'peserta', 'annisanur.iksan02@gmail.com', '2025-11-04 10:57:08', '$2y$12$gbgyrLuLbBryko93GLWVj.mCtnpjF.LgCiUi2pzunolyTegpXQAx2', NULL, 0, NULL, '2025-11-04 10:56:39', '2025-11-04 10:57:08'),
(85, 'Pratama Aldiansah', 'pratamaaldi', '085726495825', 'peserta', 'ilhampa17@gmail.com', '2025-11-04 11:00:20', '$2y$12$QL6pVAvwXSKnUR5o7.6GLuuff4aCtz34xji9sEwdF5YF2BJi26392', NULL, 0, NULL, '2025-11-04 10:59:50', '2025-11-04 11:00:20'),
(86, 'Peserta12', 'User12', '08987654321', 'peserta', 'l4k49@freefonts.com', NULL, '$2y$12$TEe19ZLHM4SYvZjeiSMxP.3STJMwNEiTEixCzYjahXnzjzbQlFa1y', NULL, 0, NULL, '2025-11-04 10:59:51', '2025-11-04 10:59:51'),
(87, 'siapaya', 'siapaya', '082232397147', 'peserta', 'siapaya@airnavindonesia.co.id', NULL, '$2y$12$eBxJtGPha0Ta7kdlavDu9.qtUpzc7dOeHEhDjNS.JTJWVvOBrgZUO', NULL, 0, NULL, '2025-11-04 11:00:33', '2025-11-04 11:00:33'),
(88, 'Marylda Salma', 'maryldasalma', '082232397147', 'peserta', 'maryldasalmaa@gmail.com', '2025-11-04 11:02:33', '$2y$12$ozoNbztONH6sL6w7tMrB5.oXjbVBcSi6LqnciMCpVFn2ySCWmvHei', NULL, 0, NULL, '2025-11-04 11:02:07', '2025-11-04 11:02:33'),
(89, 'Fauzi bowo', 'fauzi', '123456789013', 'peserta', 'budisupratna59@gmail.com', '2025-11-04 11:03:00', '$2y$12$7fQmG1WAYocIbHczVGhTPe2Nks/RrhKz8Uv3Sx5w60MbD.SNim.cC', NULL, 0, NULL, '2025-11-04 11:02:33', '2025-11-04 11:14:06'),
(90, 'Fairuz Salma Zahfirah', 'sallyy', '0895621913048', 'peserta', 'fairuzsalmazahfira30@gmail.com', '2025-11-04 11:05:21', '$2y$12$fVDW5jjWscmlntRVQel2a.LAixpY..Btaeh4vxNYhHjipsu5M91zG', NULL, 0, NULL, '2025-11-04 11:03:41', '2025-11-04 11:05:21'),
(91, 'Rawiansyah', 'Wiwi', '85157706249', 'peserta', 'rawiansyah123@gmail.com', '2025-11-04 11:27:10', '$2y$12$MY1fgJ5YqZAykCkYHYO53.aypKsSQPI9RVvLi6x8srWFKQu7AI1Zq', NULL, 0, NULL, '2025-11-04 11:26:51', '2025-11-04 11:27:10'),
(92, 'contoh user', 'poniee', '0899009988', 'peserta', '2q2wy@2200freefonts.com', '2025-11-04 12:58:16', '$2y$12$YrtLwbemc5OKptlJIGx2t.F50i5K6noOi1YfvngksQ.yYefsXBHiO', NULL, 0, NULL, '2025-11-04 12:57:53', '2025-11-04 13:17:09'),
(93, 'Ahmad showi sf', 'ahmadshowisf', '082299417885', 'peserta', 'ahmadshowi123@gmail.com', '2025-11-04 13:55:07', '$2y$12$HDYqUZMvz4vh3o4h0Bj6juWhiYkP2EqEfl/aWYk7Fegg6SqF/KpEu', NULL, 0, NULL, '2025-11-04 13:54:27', '2025-11-04 13:55:07'),
(94, 'Rahmat Rahimi', 'rahmat.rahimi', '081394396418', 'peserta', 'rahmat.rahimi@airnavindonesia.co.id', '2025-11-04 14:01:57', '$2y$12$HSAKhSskIX0cvrW0x8L.YOCFq7reLiwJgR4..JOZOOevS2OzvDiZC', NULL, 0, NULL, '2025-11-04 14:01:17', '2025-11-04 14:02:29'),
(95, 'Taslimuddin', 'taslim', '085110398667', 'peserta', 'taslimuddin@airnavindonesia.co.id', '2025-11-04 14:02:24', '$2y$12$C0ilxbvhWC1kkxVUO3eUjegsnYLSExZtXK/w5X/lX9efkLCuv0f8S', NULL, 0, NULL, '2025-11-04 14:01:22', '2025-11-04 14:28:49'),
(96, 'ADE ANDRE RIZKY S.', 'ade.andre', '08111861092', 'peserta', 'ade.andre@airnavindonesia.co.id', '2025-11-04 14:10:14', '$2y$12$awb/fyqS1pabVkwIjer7W.OZeQTmyI26JBLs3qX2pPt/xpoWxJpgG', NULL, 0, NULL, '2025-11-04 14:09:43', '2025-11-04 14:10:14'),
(97, 'Nuniq', 'nnunik', '0812181971213', 'peserta', 'nuni19007ti@student.nurulfikri.ac.id', '2025-11-04 14:41:36', '$2y$12$Giw4o0d3j.VZPQ0ynUFd/uvfBfoAjryauIx3E0R6ToK7Lgqnrblw6', NULL, 0, NULL, '2025-11-04 14:41:18', '2025-11-04 14:41:36'),
(98, 'Arya Bima Setyantoro', 'arya.bima', '085228034875', 'peserta', 'arya.bima@airnavindonesia.co.id', '2025-11-04 14:54:12', '$2y$12$gY4h.PgSwmvLRD4A49KC1OFIt2A98StzQjwANV45H7N.jiJfAuPXm', NULL, 0, NULL, '2025-11-04 14:53:02', '2025-11-04 14:54:12'),
(99, 'Trisinus Gulo', 'Trisgl03', '081235487842', 'peserta', 'trisinusgulo6@gmail.com', '2025-11-04 14:57:24', '$2y$12$lstWxTfckmGK2oKQ1ACwQuJuqWvZJXdv1nQ2ZDXpcE.TTJYE436Ea', NULL, 0, NULL, '2025-11-04 14:56:28', '2025-11-04 14:57:24'),
(100, 'Fani Hidayat Kurniawan', 'testing', '6281314465786', 'peserta', 'fani.hidayat@airnavindonesia.co.id', '2025-11-04 15:07:29', '$2y$12$vFNgTKBVL.GtRurpJlkquePgZwj2qxNBcNSdLB6EgZKsm18urG0RW', NULL, 0, NULL, '2025-11-04 15:06:46', '2025-11-04 15:07:48');

--
-- Indexes for dumped tables
--

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
-- Indexes for table `detail_admin`
--
ALTER TABLE `detail_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detail_admin_user_id_foreign` (`user_id`),
  ADD KEY `detail_admin_divisi_id_foreign` (`divisi_id`);

--
-- Indexes for table `detail_peserta`
--
ALTER TABLE `detail_peserta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detail_peserta_user_id_foreign` (`user_id`);

--
-- Indexes for table `divisi`
--
ALTER TABLE `divisi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

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
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `modul_acara`
--
ALTER TABLE `modul_acara`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `modul_acara_mdl_kode_unique` (`mdl_kode`),
  ADD UNIQUE KEY `modul_acara_mdl_slug_unique` (`mdl_slug`),
  ADD KEY `modul_acara_user_id_foreign` (`user_id`),
  ADD KEY `modul_acara_created_by_foreign` (`created_by`),
  ADD KEY `modul_acara_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `otps`
--
ALTER TABLE `otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `otps_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pendaftaran_acara`
--
ALTER TABLE `pendaftaran_acara`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pendaftaran_acara_modul_acara_id_user_id_unique` (`modul_acara_id`,`user_id`),
  ADD KEY `pendaftaran_acara_user_id_foreign` (`user_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `presensi_acara`
--
ALTER TABLE `presensi_acara`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `presensi_acara_modul_acara_id_user_id_unique` (`modul_acara_id`,`user_id`),
  ADD UNIQUE KEY `presensi_pendaftaran_unique` (`pendaftaran_acara_id`),
  ADD KEY `presensi_acara_user_id_foreign` (`user_id`);

--
-- Indexes for table `sertifikats`
--
ALTER TABLE `sertifikats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

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
-- AUTO_INCREMENT for table `detail_admin`
--
ALTER TABLE `detail_admin`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `detail_peserta`
--
ALTER TABLE `detail_peserta`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `divisi`
--
ALTER TABLE `divisi`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `modul_acara`
--
ALTER TABLE `modul_acara`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `otps`
--
ALTER TABLE `otps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `pendaftaran_acara`
--
ALTER TABLE `pendaftaran_acara`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=832;

--
-- AUTO_INCREMENT for table `presensi_acara`
--
ALTER TABLE `presensi_acara`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `sertifikats`
--
ALTER TABLE `sertifikats`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_admin`
--
ALTER TABLE `detail_admin`
  ADD CONSTRAINT `detail_admin_divisi_id_foreign` FOREIGN KEY (`divisi_id`) REFERENCES `divisi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detail_admin_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `detail_peserta`
--
ALTER TABLE `detail_peserta`
  ADD CONSTRAINT `detail_peserta_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `modul_acara`
--
ALTER TABLE `modul_acara`
  ADD CONSTRAINT `modul_acara_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `modul_acara_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `modul_acara_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `otps`
--
ALTER TABLE `otps`
  ADD CONSTRAINT `otps_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pendaftaran_acara`
--
ALTER TABLE `pendaftaran_acara`
  ADD CONSTRAINT `pendaftaran_acara_modul_acara_id_foreign` FOREIGN KEY (`modul_acara_id`) REFERENCES `modul_acara` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pendaftaran_acara_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `presensi_acara`
--
ALTER TABLE `presensi_acara`
  ADD CONSTRAINT `presensi_acara_modul_acara_id_foreign` FOREIGN KEY (`modul_acara_id`) REFERENCES `modul_acara` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `presensi_acara_pendaftaran_acara_id_foreign` FOREIGN KEY (`pendaftaran_acara_id`) REFERENCES `pendaftaran_acara` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `presensi_acara_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
