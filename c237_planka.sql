-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2024 at 04:24 PM
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
-- Database: `c237_planka`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL,
  `name` varchar(500) NOT NULL,
  `description` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryId`, `name`, `description`) VALUES
(1, 'Manga', 'Relevant content from Japanese comics or graphic books, with distinguish drawing styles originating from Japan.'),
(2, 'Plantation', 'Relevant products to plants and gardening tools.');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `product_name` text NOT NULL,
  `minting_timestamp` datetime NOT NULL,
  `description` text NOT NULL,
  `owner_first_name` text NOT NULL,
  `owner_last_name` text NOT NULL,
  `base_price` int(11) NOT NULL,
  `selling_price` int(11) NOT NULL,
  `image` varchar(500) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `categoryId`, `product_name`, `minting_timestamp`, `description`, `owner_first_name`, `owner_last_name`, `base_price`, `selling_price`, `image`, `quantity`) VALUES
(1, 1, 'Roger\'s laugh', '2024-07-15 10:43:05', 'It contains the moment Roger arrived at Laugh Tale.', 'Oda', 'Eiichiro ', 100, 2500, 'roger\'s laugh.png', 1),
(2, 1, 'Ko\'s turning point', '2024-07-15 11:59:25', 'In this image, the main character transform into a semi-Vampire as he rises up after getting shot in the chest.', 'Kotoyama', '-', 250, 750, 'Vampire_Ko.png', 1),
(3, 1, 'no enemies', '2024-07-15 12:30:27', 'The famous \"I have no enemies\" panel from popular shonen manga, Vinland Saga.', 'Cheng Soon', 'Ong', 500, 1200, 'No Enemies.png', 1),
(4, 2, 'Heal plant', '2024-07-15 15:35:56', 'This plant will heal you!', 'Hajime ', 'Umemiya', 5, 30, 'PlantOne.png', 12),
(5, 2, 'Air-Filter Plant!', '2024-07-15 15:42:13', 'THIS PLANT TAKES IN TOXIC CO2 SO YOU BREATH HEALTHY O2', 'Ash ', 'Ketchum', 10, 30, 'PlantTwo.png', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryId`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `fk_categoryId` (`categoryId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_categoryId` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
