-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2024 at 06:14 AM
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
-- Database: `akar_hijau`
--

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id_posting` int(11) NOT NULL,
  `posting_title` varchar(50) NOT NULL,
  `author` varchar(100) NOT NULL,
  `equipment` varchar(500) NOT NULL,
  `steps` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id_posting`, `posting_title`, `author`, `equipment`, `steps`) VALUES
(17, 'Tanam Padi', 'ceriativitas', '1. Cangkul\n2. Tali\n3. Traktor', '1. Bajak sawah dulu\n2. Rapikan tepian pematangsawah\n3. Tanam benih padi/wineh\n4. Lakukan dengan cara berjalan kebelakang'),
(18, 'Menanam Semangka', 'Dimas', '1. Cangkul\n2. Pupuk\n3. Benih Semangka', '1. Gemburkan tanah terlebih dahulu\n2. Buat lubang kedalaman 2cm\n3. Masukkan benih kedalam lubang lalu tutup lubang\n4. Siram dengan air secukupnya\n5. Tunggu benih kecambah dalam 2 minggu'),
(19, 'pisang cavendis', 'anggara', '1. sekop\n2. sekem\n3. tanah\n4. air\n5. pupuk\n6. pot', '1. Campurkan tanah & sekem kedalam pot\n2. masukkan bibit pisang cavendis\n3. rawatlah & siram tiap hari'),
(20, 'fgh', 'fhh', '1. ghh\n2. vbb', '1. chjj\n2. bhjj'),
(21, 'Tanam Gednag', 'Yulvi', '1. Gedang\n2. Pacul', '1. Nduduk lemah\n2. icir gedang'),
(22, 'Tanam Mawar', 'Niska', '1. Mawar\n2. Pupuk\n3. Sekop', '1. A');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` text NOT NULL,
  `level` enum('user','admin') NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `level`, `email`) VALUES
(1, 'tegar', '12345', 'Tegarganteng', 'admin', 'riotegarganteng@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id_posting`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id_posting` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
