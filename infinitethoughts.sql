-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2023 at 11:56 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `infinitethoughts`
--

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `date`, `img_file`) VALUES
(1, 'Stock market', 'all you need to know about stock market', 'first-post', 'A stock market, equity market, or share market is the aggregation of buyers and sellers of stocks (also called shares), which represent ownership claims on businesses; these may include securities listed on a public stock exchange, as well as stock that is only traded privately, such as shares of private companies which are sold to investors through equity crowdfunding platforms. Investment is usually made with an investment strategy in mind. A stock exchange is an exchange (or bourse) where stockbrokers and traders can buy and sell shares (equity stock), bonds, and other securities. Many large companies have their stocks listed on a stock exchange. This makes the stock more liquid and thus more attractive to many investors. The exchange may also act as a guarantor of settlement. These and other stocks may also be traded \"over the counter\" (OTC), that is, through a dealer. Some large companies will have their stock listed on more than one exchange in different countries, so as to attract international investors.[4]\r\n\r\nStock exchanges may also cover other types of securities, such as fixed-interest securities (bonds) or (less frequently) derivatives, which are more likely to be traded OTC.\r\n\r\nTrade in stock markets means the transfer (in exchange for money) of a stock or security from a seller to a buyer. This requires these two parties to agree on a price. Equities (stocks or shares) confer an ownership interest in a particular company.\r\n\r\nParticipants in the stock market range from small individual stock investors to larger investors, who can be based anywhere in the world, and may include banks, insurance companies, pension funds and hedge funds. Their buy or sell orders may be executed on their behalf by a stock exchange trader.\r\n\r\nPPP\r\nSome exchanges are physical locations where transactions are carried out on a trading floor, by a method known as open outcry. This method is used in some stock exchanges and commodities exchanges, and involves traders shouting bid and offer prices. The other type of stock exchange has a network of computers where trades are made electronically. An example of such an exchange is the NASDAQ.\r\n\r\nA potential buyer bids a specific price for a stock, and a potential seller asks a specific price for the same stock. Buying or selling at the Market means you will accept any ask price or bid price for the stock. When the bid and ask prices match, a sale takes place, on a first-come, first-served basis if there are multiple bidders at a given price.\r\n\r\nThe purpose of a stock exchange is to facilitate the exchange of securities between buyers and sellers, thus providing a marketplace. The exchanges provide real-time trading information on the listed securities, facilitating price discovery.\r\n\r\nThe New York Stock Exchange (NYSE) is a physical exchange, with a hybrid market for placing orders electronically from any location as well as on the trading floor. Orders executed on the trading floor enter by way of exchange members and flow down to a floor broker, who submits the order electronically to the floor trading post for the Designated market maker (\"DMM\") for that stock to trade the order. The DMM\'s job is to maintain a two-sided market, making orders to buy and sell the security when there are no other buyers or sellers. If a bid–ask spread exists, no trade immediately takes place – in this case, the DMM may use their own resources (money or stock) to close the difference. Once a trade has been made, the details are reported on the \"tape\" and sent back to the brokerage firm, which then notifies the investor who placed the order. Computers play an important role, especially for program trading.\r\n\r\nThe NASDAQ is an electronic exchange, where all of the trading is done over a computer network. The process is similar to the New York Stock Exchange. One or more NASDAQ market makers will always provide a bid and ask the price at which they will always purchase or sell \'their\' stock.\r\n\r\nThe Paris Bourse, now part of Euronext, is an order-driven, electronic stock exchange. It was automated in the late 1980s. Prior to the 1980s, it consisted of an open outcry exchange. Stockbrokers met on the trading floor of the Palais Brongniart. In 1986, the CATS trading system was introduced, and the order matching system was fully automated.', '2023-07-27 14:27:11', 'stock-market.jpg'),
(2, 'This is my another post', 'it is another post', 'another-post', 'The total market capitalization of all publicly traded securities worldwide rose from US$2.5 trillion in 1980 to US$93.7 trillion at the end of 2020.[1]\r\n\r\nAs of 2016, there are 60 stock exchanges in the world. Of these, there are 16 exchanges with a market capitalization of $1 trillion or more, and they account for 87% of global market capitalization. Apart from the Australian Securities Exchange, these 16 exchanges are all in North America, Europe, or Asia.[2]\r\n\r\nBy country, the largest stock markets as of January 2022 are in the United States of America (about 59.9%), followed by Japan (about 6.2%) and United Kingdom (about 3.9%).[3]', '2023-07-16 13:45:33', 'about-bg.jpg'),
(3, 'share', 'what is share', 'share-post', 'The capital of a company is divided into shares. Each share forms a unit of ownership of a company and is offered for sale so as to raise capital for the company.\r\nShares can be broadly divided into two categories - equity and preference shares. Equity shares give their holders the power to share the earnings/profits in the company as well as a vote in the AGMs of the company. Such a shareholder has to share the profits and also bear the losses incurred by the company.\r\nOn the other hand, preference shares earn their holders only dividends, which are fixed, giving no voting rights. Equity shareholders are regarded as the real owners of the company. When the shares are offered for sale directly by the company for the first time, they are offered in the primary market, whereas the trading of shares takes place in the secondary market.', '2023-07-16 14:20:23', 'about-bg.jpg'),
(4, 'Java', 'let\'s learn Java', 'java-post', 'Java is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible. It is a general-purpose programming language intended to let programmers write once, run anywhere (WORA),[17] meaning that compiled Java code can run on all platforms that support Java without the need to recompile.[18] Java applications are typically compiled to bytecode that can run on any Java virtual machine (JVM) regardless of the underlying computer architecture. The syntax of Java is similar to C and C++, but has fewer low-level facilities than either of them. The Java runtime provides dynamic capabilities (such as reflection and runtime code modification) that are typically not available in traditional compiled languages. As of 2019, Java was one of the most popular programming languages in use according to GitHub,[citation not found][19][20] particularly for client–server web applications, with a reported 9 million developers.[21]', '2023-07-16 14:20:23', 'java.jpg'),
(5, 'JavaScript', 'let\'s learn JavaScript', 'javascript-post', 'JavaScript (/ˈdʒɑːvəskrɪpt/), often abbreviated as JS, is a programming language that is one of the core technologies of the World Wide Web, alongside HTML and CSS. As of 2023, 98.7% of websites use JavaScript on the client side for webpage behavior,[10] often incorporating third-party libraries. All major web browsers have a dedicated JavaScript engine to execute the code on users\' devices.\r\n\r\nJavaScript is a high-level, often just-in-time compiled language that conforms to the ECMAScript standard.[11] It has dynamic typing, prototype-based object-orientation, and first-class functions. It is multi-paradigm, supporting event-driven, functional, and imperative programming styles. It has application programming interfaces (APIs) for working with text, dates, regular expressions, standard data structures, and the Document Object Model (DOM).\r\n\r\nThe ECMAScript standard does not include any input/output (I/O), such as networking, storage, or graphics facilities. In practice, the web browser or other runtime system provides JavaScript APIs for I/O.\r\n\r\nJavaScript engines were originally used only in web browsers, but are now core components of some servers and a variety of applications. The most popular runtime system for this usage is Node.js.\r\n\r\nAlthough Java and JavaScript are similar in name, syntax, and respective standard libraries, the two languages are distinct and differ greatly in design.', '2023-07-16 14:22:13', 'about-bg.jpg'),
(6, 'JavaScript', 'let\'s learn JavaScript', 'javascript-post', 'JavaScript (/ˈdʒɑːvəskrɪpt/), often abbreviated as JS, is a programming language that is one of the core technologies of the World Wide Web, alongside HTML and CSS. As of 2023, 98.7% of websites use JavaScript on the client side for webpage behavior,[10] often incorporating third-party libraries. All major web browsers have a dedicated JavaScript engine to execute the code on users\' devices.\r\n\r\nJavaScript is a high-level, often just-in-time compiled language that conforms to the ECMAScript standard.[11] It has dynamic typing, prototype-based object-orientation, and first-class functions. It is multi-paradigm, supporting event-driven, functional, and imperative programming styles. It has application programming interfaces (APIs) for working with text, dates, regular expressions, standard data structures, and the Document Object Model (DOM).\r\n\r\nThe ECMAScript standard does not include any input/output (I/O), such as networking, storage, or graphics facilities. In practice, the web browser or other runtime system provides JavaScript APIs for I/O.\r\n\r\nJavaScript engines were originally used only in web browsers, but are now core components of some servers and a variety of applications. The most popular runtime system for this usage is Node.js.\r\n\r\nAlthough Java and JavaScript are similar in name, syntax, and respective standard libraries, the two languages are distinct and differ greatly in design.', '2023-07-16 14:25:11', 'about-bg.jpg'),
(10, 'monochrome display', 'all you need to know about monochrome display', 'monochrome-display', 'A display where the picture consists solely of a single color (with variations of shade in some models: see gray-scale). Monochrome displays may have white, amber, or green screens. The choice of screen color depends on users\' preferences, with strong claims being made by the advocates of each color. Monochrome displays are found in terminals and monitors using CRT or LCD technology. In display technology, much higher resolution can be achieved by monochrome than is possible in color displays and for a given performance monochrome displays cost much less than a similar color product.', '2023-07-27 16:11:42', 'monochrome_display.jpg'),
(29, 'Python', 'All about python', 'python', 'Python is a high-level, general-purpose programming language. Its design philosophy emphasizes code readability with the use of significant indentation.[34]\r\n\r\nPython is dynamically typed and garbage-collected. It supports multiple programming paradigms, including structured (particularly procedural), object-oriented and functional programming. It is often described as a \"batteries included\" language due to its comprehensive standard library.[35][36]\r\n\r\nGuido van Rossum began working on Python in the late 1980s as a successor to the ABC programming language and first released it in 1991 as Python 0.9.0.[37] Python 2.0 was released in 2000. Python 3.0, released in 2008, was a major revision not completely backward-compatible with earlier versions. Python 2.7.18, released in 2020, was the last release of Python 2.[38]\r\n\r\nPython consistently ranks as one of the most popular programming languages.', '2023-07-31 23:51:09', '48defa88-3ee9-40a9-ac4e-edbd2aa6dcd3.png');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `phone`, `password`) VALUES
(4, 'biraj', 'biraj@gmail.com', '9876543210', 'pbkdf2:sha256:600000$VxRjCyt7P92ZIwSp$f983cad5f5c9b864164834619ee3bc02cabfeb6bf2fe45a7be49c7e93e6541b8'),
(5, 'sabal', 'sabal@gmail.com', '9876543210', 'pbkdf2:sha256:600000$jvb9SSS2NlkPY2MO$c223743bff2d0db96910c5fa9c4e73549a60e1131a4851f71f677692c2c57821'),
(6, 'anush ', 'anush@gmail.com', '987642245', 'pbkdf2:sha256:600000$auCN8SSEc3DtekN4$e9db1f3f67ee971327aa06ee4cdbeb11412941d828080ea7c2ac95e71613be54');

-- --------------------------------------------------------

--
-- Table structure for table `user_posts`
--

CREATE TABLE `user_posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_posts`
--

INSERT INTO `user_posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`, `user_id`) VALUES
(2, 'bitch post', 'this is another post ', 'bitch-post', 'asldkfjaosdnfo', 'level_0_blog.png', '2023-07-28 00:00:00', 5),
(3, 'asdfa', 'sdmfo', 'shit-post', 'msdaosnd', 'level_0_blog.png', '2023-07-30 00:00:00', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ratings_post_id` (`post_id`),
  ADD KEY `fk_ratings_user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_posts`
--
ALTER TABLE `user_posts`
  ADD PRIMARY KEY (`sno`),
  ADD KEY `FK_postuser` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_posts`
--
ALTER TABLE `user_posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_ratings_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`sno`),
  ADD CONSTRAINT `fk_ratings_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_posts`
--
ALTER TABLE `user_posts`
  ADD CONSTRAINT `FK_postuser` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
