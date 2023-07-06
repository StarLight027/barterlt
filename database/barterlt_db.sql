-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2023 at 03:26 PM
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
(13, 3, 'Men Shirt', 'New item', 'Clothing', 30, 1, '3.9743399999999998', '102.43805666666667', 'Pahang', 'Jerantut', '2023-06-13'),
(14, 6, 'Bvlgari Perfume', 'Lightly Used', 'Other', 259, 1, '6.43678', '100.44853833333333', 'Kedah', 'Changlun', '2023-07-05'),
(15, 6, 'Sony XM3', 'Has minor defects', 'Electronics', 550, 1, '3.131918333333333', '101.68405833333334', 'Wilayah Persekutuan ', 'Kuala Lumpur', '2023-07-05'),
(16, 1, 'Duck Lipstick', 'Used once or twice', 'Other', 25, 3, '3.131918333333333', '101.68405833333334', 'Wilayah Persekutuan ', 'Kuala Lumpur', '2023-07-05'),
(17, 1, 'Muslimah Blouse', 'Used with care', 'Clothing', 35, 1, '4.610735', '101.14545833333334', 'Perak', 'Tambun', '2023-07-05'),
(18, 1, 'Nars Eyeshadow', 'Never used 10/10', 'Other', 25, 1, '4.610735', '101.14545833333334', 'Perak', 'Tambun', '2023-07-05'),
(19, 6, 'Uniqlo Tshirt', 'Size L', 'Clothing', 15, 1, '6.230408333333333', '100.24730666666666', 'Kedah', 'Ayer Hitam', '2023-07-05'),
(20, 6, 'Coloring Pen', 'New 10/10', 'Stationery', 2, 10, '2.9432116666666666', '102.27039333333333', 'Negeri Sembilan', 'Simpang Pertang', '2023-07-06');

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
(3, 'aisyah@gmail.com', 'Nur Aisyah', '01309954545', 'a622012aa4ebae001fa6c01f400a1b2d699698b1', '27572', '2023-05-21 17:03:45.204884'),
(6, 'shahul@gmail.com', 'Shahul Mohamad', '0175466604', '68000620e71baab2b53f3c147e807e48e0780210', '84815', '2023-07-05 14:24:57.044660');

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
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD UNIQUE KEY `user_email_2` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
