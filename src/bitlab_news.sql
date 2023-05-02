-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 02, 2023 at 12:53 PM
-- Server version: 5.7.39
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bitlab_news`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Economics'),
(2, 'Politics'),
(3, 'Sports');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `postDate` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `comment`, `postDate`, `user_id`, `news_id`) VALUES
(3, 'cool', '2023-04-29', 7, 30),
(4, 'ye', '2023-04-29', 10, 30),
(5, 'sultan', '2023-04-29', 10, 30),
(6, 'today\r\n', '2023-04-29', 10, 30),
(7, 'today aswell\r\n', '2023-04-29', 10, 30),
(8, 'cool', '2023-05-02', 10, 48),
(9, 'wow', '2023-05-02', 10, 50);

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `news_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`news_id`, `user_id`) VALUES
(30, 7),
(30, 10),
(39, 10),
(48, 10),
(50, 10);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `postDate` date NOT NULL,
  `categoryId` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `content` longtext NOT NULL,
  `views` int(11) DEFAULT NULL,
  `imageUrl` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `postDate`, `categoryId`, `title`, `content`, `views`, `imageUrl`) VALUES
(26, '2023-04-26', 1, 'Title of news 1', 'content. content. content. content.', 28, 'https://picsum.photos/300/200'),
(27, '2023-04-26', 1, 'Title of news 2', 'content. content. content. content.', 4, 'https://picsum.photos/300/200'),
(28, '2023-04-26', 1, 'Title of news 3', 'content. content. content. content.', 3, 'https://picsum.photos/300/200'),
(29, '2023-04-26', 1, 'Title of news 4', 'content. content. content. content.', 1, 'https://picsum.photos/300/200'),
(30, '2023-04-26', 1, 'Title of news 5', 'content. content. content. content.', 72, 'https://picsum.photos/300/200'),
(31, '2023-04-26', 1, 'Title of news 6', 'content. content. content. content.', 0, 'https://picsum.photos/300/200'),
(32, '2023-04-26', 1, 'Title of news 7', 'content. content. content. content.', 0, 'https://picsum.photos/300/200'),
(33, '2023-04-26', 1, 'Title of news 8', 'content. content. content. content.', 2, 'https://picsum.photos/300/200'),
(34, '2023-04-26', 1, 'Title of news 9', 'content. content. content. content.', 0, 'https://picsum.photos/300/200'),
(35, '2023-04-26', 1, 'Title of news 10', 'content. content. content. content.', 0, 'https://picsum.photos/300/200'),
(36, '2023-04-26', 1, 'Title of news 11', 'content. content. content. content.', 0, 'https://picsum.photos/300/200'),
(37, '2023-04-26', 1, 'Title of news 12', 'content. content. content. content.', 0, 'https://picsum.photos/300/200'),
(38, '2023-04-26', 1, 'Title of news 13', 'content. content. content. content.', 0, 'https://picsum.photos/300/200'),
(39, '2023-04-26', 1, 'Title of news 13', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus, mauris eu suscipit imperdiet, elit ipsum blandit urna, at venenatis mauris diam quis libero. Nunc lobortis molestie arcu, at mattis lectus placerat vel. Suspendisse et tempor lacus. Mauris consequat porttitor convallis. Aenean est mi, ultricies nec massa at, ultrices sagittis mauris. Sed semper neque ac lectus interdum blandit. Vivamus non orci vel mauris interdum convallis sed non dolor. Curabitur faucibus tempor massa a facilisis. Maecenas dictum velit libero. Maecenas molestie nisl in est hendrerit, in laoreet nunc vestibulum. Nullam ligula purus, facilisis quis sollicitudin quis, porta et turpis. Ut tristique quam nec magna eleifend laoreet. Quisque gravida vulputate augue. Praesent feugiat arcu neque, ut fringilla mi dictum at. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;', 3, 'https://picsum.photos/300/200'),
(40, '2023-04-26', 1, 'Title of news 11', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus, mauris eu suscipit imperdiet, elit ipsum blandit urna, at venenatis mauris diam quis libero. Nunc lobortis molestie arcu, at mattis lectus placerat vel. Suspendisse et tempor lacus. Mauris consequat porttitor convallis. Aenean est mi, ultricies nec massa at, ultrices sagittis mauris. Sed semper neque ac lectus interdum blandit. Vivamus non orci vel mauris interdum convallis sed non dolor. Curabitur faucibus tempor massa a facilisis. Maecenas dictum velit libero. Maecenas molestie nisl in est hendrerit, in laoreet nunc vestibulum. Nullam ligula purus, facilisis quis sollicitudin quis, porta et turpis. Ut tristique quam nec magna eleifend laoreet. Quisque gravida vulputate augue. Praesent feugiat arcu neque, ut fringilla mi dictum at. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;\nPellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc sit amet scelerisque nulla. Pellentesque maximus ac quam eget rutrum. Nullam non libero augue. Phasellus interdum ligula a libero venenatis vehicula. Mauris rhoncus sit amet lectus in aliquam. Mauris metus eros, gravida nec vulputate ut, sollicitudin a leo. Sed ac nibh lorem. Proin suscipit facilisis leo vel ornare.\nAenean vitae justo non erat bibendum feugiat nec in risus. Donec imperdiet dolor vel mi posuere, vitae condimentum mauris tempor. Suspendisse blandit eros massa, vitae faucibus arcu vehicula in. Nullam nec pulvinar massa, quis rhoncus leo. Aenean nec dolor augue. Vestibulum vitae magna id lorem commodo gravida. In hac habitasse platea dictumst. Aliquam erat volutpat. Aliquam a molestie mi, sed lacinia sapien. Sed tincidunt quis quam id efficitur. Morbi odio velit, congue gravida purus et, consectetur laoreet sapien.\nDonec dolor eros, iaculis et lacus at, tempor ornare nibh. Maecenas rutrum metus eu tempus tristique. Mauris quis accumsan dui, non luctus elit. Ut non nulla vitae est porta dictum vel eu ligula. Phasellus in arcu dolor. Nunc faucibus nunc tortor, in venenatis libero ornare mollis. Curabitur malesuada laoreet mauris nec efficitur. Etiam cursus feugiat urna, a lobortis magna elementum in. Integer et egestas dolor. Quisque dictum ligula lectus, non fermentum diam lacinia id. Aliquam in nibh at risus rutrum ornare. Pellentesque ac ligula ac magna ultricies porttitor quis id arcu. Curabitur vel erat magna. Cras vel mi ut neque tincidunt accumsan. Vestibulum elit metus, porttitor vitae leo in, tempus congue tortor. Proin luctus leo quis felis laoreet pretium.\nVivamus feugiat felis enim. Morbi id ullamcorper eros. Donec mattis rutrum ante et gravida. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus pellentesque feugiat felis, a varius quam ultrices sit amet. Cras ligula arcu, congue eu erat quis, maximus suscipit sapien. Ut interdum urna vitae laoreet semper. Aliquam ut mi eu velit accumsan imperdiet. Vivamus rhoncus urna placerat nisi hendrerit, at ullamcorper nisl pulvinar. Praesent facilisis, lectus non fermentum commodo, purus nisl bibendum mi, sed ultricies metus sem eleifend ligula. Ut egestas cursus est, vitae scelerisque ipsum tincidunt quis. Morbi vel porttitor massa, nec maximus dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Maecenas ut orci vel risus ultricies convallis. Cras laoreet odio mauris, id tincidunt est tempor nec. Quisque ultricies pharetra nulla, imperdiet hendrerit dolor luctus non.', 6, 'https://picsum.photos/300/200'),
(41, '2023-04-28', 1, 'new', 'new', 2, 'https://picsum.photos/300/200'),
(42, '2023-04-28', 1, 'new', 'new', 2, 'https://picsum.photos/300/200'),
(43, '2023-04-28', 1, 'new', 'new', 0, 'https://picsum.photos/300/200'),
(44, '2023-04-28', 1, 'new', ' new', 0, 'https://picsum.photos/300/200'),
(46, '2023-04-29', 1, 'HAHA', 'Intro. a;lskdfjasldfjalsdjfals', 15, 'https://picsum.photos/300/200'),
(47, '2023-04-01', 1, 'old news', 'this is old news. yes.', 1, 'https://picsum.photos/300/200'),
(48, '2023-05-02', 2, 'New politics news', 'Content. New politics news', 103, 'https://picsum.photos/id/1/300/200'),
(49, '2023-05-01', 2, 'New politics news', 'content. content.', 0, 'https://picsum.photos/id/2/300/200'),
(50, '2023-05-02', 3, 'New sports news', 'sports.sports.sports.sports.sports.sports.sports.sports.vsports.sports.sports.sports.sports.sports.sports.', 73, 'https://picsum.photos/id/26/300/200');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `roleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `fullName`, `roleId`) VALUES
(1, 'admin@mail.ru', 'admin', 'admininho', 1),
(2, 'ryzyk.aidyn@gmail.com', 'aidyn007', 'Aidyn Ryzyk', 1),
(3, 'asd@mail.ru', 'asd', 'asd', 2),
(4, 'asdf@mail.ru', 'asdf', 'asdf', 2),
(5, 'asdf', 'asdf', 'asdf', 2),
(6, 'test@mail.ru', 'test', 'test', 2),
(7, 'test@test.ru', 'test', 'test', 1),
(8, 'test@test.ru', 'test', 'test', 1),
(9, 'test@test.ru', 'test', 'tester', 1),
(10, 'user@mail.ru', 'user', 'user', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `news_id` (`news_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD KEY `news_id` (`news_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryId` (`categoryId`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roleId` (`roleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
