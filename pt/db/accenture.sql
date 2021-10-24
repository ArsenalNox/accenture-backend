-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 24, 2021 at 06:01 AM
-- Server version: 10.6.4-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `accenture`
--

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `fid` varchar(4000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(4000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shopfk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `fid`, `name`, `shopfk`) VALUES
(1, 'G_UNRO1', 'Конвертерный цех 1 УНРС 2,3,4,6', 1),
(2, 'G_UNRO4', 'Конвертерный цех 4 УНРС 8,9,10,11', 2);

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `amount_required` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `date_start`, `date_end`, `amount_required`) VALUES
(1, '2021-10-12', '2021-12-24', 10000);

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `id` int(11) NOT NULL,
  `fid` varchar(4000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `groupfk` int(11) NOT NULL,
  `name` varchar(4000) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resources`
--

INSERT INTO `resources` (`id`, `fid`, `groupfk`, `name`) VALUES
(1, 'S_UNR4O1\n', 1, 'УНРС-4'),
(2, 'S_UNR3O1', 1, 'УНРС-3'),
(3, 'S_UNR6O1', 1, 'УНРС-6'),
(4, 'S_UNR2O1', 1, 'УНРС-2'),
(5, 'Q123', 2, 'УФЗ1'),
(6, 'Q223', 2, 'УФЗ2'),
(7, 'Q323', 2, 'УФЗ3'),
(8, 'Q423', 2, 'УФЗ4'),
(9, 'Q523', 2, 'УФЗ5'),
(10, 'Q623', 2, 'УФЗ6'),
(11, 'Q723', 2, 'УФЗ7'),
(12, 'Q823', 2, 'УФЗ8'),
(13, 'Q923', 2, 'УФЗ9'),
(14, 'Q023', 2, 'УФЗ10');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `name` varchar(4000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fid` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `name`, `fid`) VALUES
(1, 'КЦ-2', 'G_ATO2'),
(2, 'КЦ-4', 'QR-123');

-- --------------------------------------------------------

--
-- Table structure for table `work`
--

CREATE TABLE `work` (
  `id` int(11) NOT NULL,
  `resourcefk` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `amout_produced` float NOT NULL,
  `occupiedPercent` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `work`
--

INSERT INTO `work` (`id`, `resourcefk`, `day`, `amout_produced`, `occupiedPercent`) VALUES
(1, 1, 1, 5, 0.2),
(2, 1, 2, 5, 0.2),
(3, 1, 3, 5, 0.2),
(4, 1, 4, 5, 0.2),
(5, 1, 5, 5, 0.2),
(6, 1, 6, 5, 0.2),
(7, 1, 7, 5, 0.2),
(8, 2, 1, 5, 0.6),
(9, 2, 2, 5, 0.6),
(10, 2, 3, 5, 0.6),
(11, 2, 4, 5, 0.6),
(12, 2, 5, 5, 0.6),
(13, 2, 6, 5, 0.6),
(14, 2, 7, 5, 0.6),
(15, 3, 1, 5, 0.6),
(16, 3, 2, 5, 0.6),
(17, 3, 3, 5, 0.6),
(18, 3, 4, 5, 0.6),
(19, 3, 5, 5, 0.6),
(20, 3, 6, 5, 0.6),
(21, 3, 7, 5, 0.6),
(22, 4, 1, 5, 0.6),
(23, 4, 2, 5, 0.6),
(24, 4, 3, 5, 0.6),
(25, 4, 4, 5, 0.6),
(26, 4, 5, 5, 0.6),
(27, 4, 6, 5, 0.6),
(28, 4, 7, 5, 0.6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shopfk` (`shopfk`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groupfk` (`groupfk`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work`
--
ALTER TABLE `work`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resourcefk` (`resourcefk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `work`
--
ALTER TABLE `work`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`shopfk`) REFERENCES `shops` (`id`);

--
-- Constraints for table `resources`
--
ALTER TABLE `resources`
  ADD CONSTRAINT `resources_ibfk_1` FOREIGN KEY (`groupfk`) REFERENCES `groups` (`id`);

--
-- Constraints for table `work`
--
ALTER TABLE `work`
  ADD CONSTRAINT `work_ibfk_1` FOREIGN KEY (`resourcefk`) REFERENCES `resources` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
