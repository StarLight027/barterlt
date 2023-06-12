-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2023 at 01:49 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barterlt_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_items`
--

CREATE TABLE `tbl_items` (
  `item_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_desc` varchar(200) NOT NULL,
  `item_type` varchar(20) NOT NULL,
  `item_price` float NOT NULL,
  `item_qty` float NOT NULL,
  `item_lat` varchar(20) NOT NULL,
  `item_long` varchar(20) NOT NULL,
  `item_state` varchar(20) NOT NULL,
  `item_locality` varchar(20) NOT NULL,
  `item_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_items`
--

INSERT INTO `tbl_items` (`item_id`, `user_id`, `item_name`, `item_desc`, `item_type`, `item_price`, `item_qty`, `item_lat`, `item_long`, `item_state`, `item_locality`, `item_date`) VALUES
(10, 3, 'Office Chair', 'Used 6/10', 'Furniture', 90, 2, '6.46749', '100.50725833333334', 'Kedah', 'Changlun', '2023-06-13'),
(11, 3, 'Gucci Handbag', 'Used 9/10', 'Other', 120, 1, '6.46749', '100.50725833333334', 'Kedah', 'Changlun', '2023-06-13'),
(12, 3, 'Nike Shoes', 'New 10/10', 'Other', 70, 3, '6.429706666666666', '100.26984666666667', 'Perlis', 'Arau', '2023-06-13'),
(13, 3, 'Men Shirt', 'New item', 'Clothing', 30, 1, '3.9743399999999998', '102.43805666666667', 'Pahang', 'Jerantut', '2023-06-13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`item_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
