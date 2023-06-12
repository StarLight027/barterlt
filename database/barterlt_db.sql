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

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(5) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_otp` varchar(5) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_password`, `user_otp`, `user_datereg`) VALUES
(1, 'syida2702@gmail.com', 'Nur Syidah', '0184002415', 'f865b53623b121fd34ee5426c792e5c33af8c227', '51303', '2023-05-20 02:37:12.737476'),
(2, 'ali@gmail.com', 'Muhammad Ali', '0194883241', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '13818', '2023-05-21 16:03:33.153761'),
(3, 'aisyah@gmail.com', 'Nur Aisyah', '01309954545', 'a622012aa4ebae001fa6c01f400a1b2d699698b1', '27572', '2023-05-21 17:03:45.204884');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
