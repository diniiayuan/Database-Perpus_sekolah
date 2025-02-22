-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2025 at 07:02 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Delbuku` (IN `id_bukuDel` INT)   BEGIN
	DELETE FROM buku WHERE
    id_buku = id_bukuDel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelPeminjaman` (IN `id_peminjamanDel` INT)   BEGIN
	DELETE FROM peminjaman WHERE
    id_peminjaman = id_peminjamanDel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delsiswa` (IN `id_siswaDel` INT)   BEGIN
	DELETE FROM siswa WHERE
    id_siswa = id_siswaDel;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_buku` ()   BEGIN
    SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_buku` (`pid_buku` INT, `pjudul_buku` VARCHAR(100), `ppenulis` VARCHAR(100), `pkategori` VARCHAR(50), `pstok` INT)   BEGIN
    INSERT INTO buku (id_buku, judul_buku, penulis, kategori, stok) 
    VALUES (pid_buku, pjudul_buku, ppenulis, pkategori, pstok);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_peminjman` (`pid_peminjaman` INT, `pid_siswa` INT, `pid_buku` INT, `ptanggal_pinjam` DATE, `ptanggal_kembali` DATE, `pstatus` VARCHAR(50))   BEGIN
INSERT INTO peminjaman(id_peminjaman, id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) VALUES(pid_peminjaman,pid_siswa,pid_buku,ptanggal_pinjam,ptanggal_kembali, pstatus);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_siswa` (IN `pid_siswa` INT, IN `pnama` VARCHAR(200), IN `pkelas` VARCHAR(200))   BEGIN
  INSERT INTO siswa(id_siswa, nama, kelas)
  VALUES(pid_siswa, pnama, pkelas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kembali_buku` (IN `pid_peminjaman` INT)   BEGIN
    UPDATE peminjaman
    SET tanggal_kembali = CURDATE(), status = 'Dikembalikan'
    WHERE id_peminjaman = pid_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peminjam` ()   BEGIN
    SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semuabuku` ()   BEGIN
    SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semuapeminjaman` ()   BEGIN
    SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semuasiswa` ()   BEGIN
    SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semuasiswaa` ()   BEGIN
    SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semua_buku` ()   BEGIN
    SELECT s.id_buku, s.judul_buku, s.penulis,s.kategori,s.stok, 
           IFNULL(COUNT(p.id_buku), 0) AS jumlah_buku
    FROM buku s
    LEFT JOIN peminjaman p ON s.id_buku = p.id_buku
    GROUP BY s.id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semua_siswa` ()   BEGIN
    SELECT s.id_siswa, s.nama, s.kelas, 
           IFNULL(COUNT(p.id_peminjaman), 0) AS jumlah_peminjaman
    FROM siswa s
    LEFT JOIN peminjaman p ON s.id_siswa = p.id_siswa
    GROUP BY s.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `siswa_peminjam` ()   BEGIN
    SELECT DISTINCT s.id_siswa, s.nama, s.kelas 
    FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Updatebuku` (IN `id_bukuUp` INT, IN `judul_bukuUp` VARCHAR(200), IN `penulisUp` VARCHAR(200), IN `kategoriUp` VARCHAR(200), IN `stokup` INT)   BEGIN
	UPDATE buku set
    judul_buku = judul_bukuUp,
    penulis = penulisUp,
    kategori = kategoriUp,
    stok = stokUp
    WHERE id_buku = id_bukuUp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePeminjaman` (IN `id_peminjamanUp` INT, IN `id_siswaUp` INT, IN `id_bukuUp` INT, IN `tanggal_pinjamUp` DATE, IN `tanggal_kembaliUp` DATE, IN `statusUp` VARCHAR(50))   BEGIN
	UPDATE peminjaman set
    id_siswa = id_siswaUp,
    id_buku = id_bukuUp,
    tanggal_pinjam = tanggal_pinjamUp,
    tanggal_kembali = tanggal_kembaliUp, 
    status = statusUp
    WHERE id_peminjaman = id_peminjamanUp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Updatesiswa` (IN `id_siswaUp` INT, IN `namaUp` VARCHAR(200), IN `kelasUp` VARCHAR(200))   BEGIN
	UPDATE siswa set
    nama = namaUp,
    kelas = kelasUp
    WHERE id_siswa = id_siswaUp;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(100) NOT NULL,
  `judul_buku` varchar(200) DEFAULT NULL,
  `penulis` varchar(200) DEFAULT NULL,
  `kategori` varchar(200) DEFAULT NULL,
  `stok` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_siswa` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `stok_berkurang` BEFORE INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku SET stok = stok - 1 WHERE id_buku = NEW.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `stok_bertambah` BEFORE UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.status = 'Dikembalikan' AND OLD.status = 'Dipinjam' THEN
        UPDATE buku SET stok = stok + 1 WHERE id_buku = NEW.id_buku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `nama` varchar(200) DEFAULT NULL,
  `kelas` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
