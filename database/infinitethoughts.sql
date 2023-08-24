-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 07, 2023 at 07:42 PM
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
  `content_type` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(50) NOT NULL,
  `overall_rating` decimal(3,1) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `content_type`, `date`, `img_file`, `overall_rating`, `user_id`) VALUES
(32, 'Python ', 'All about Python', 'python-post', 'Python tutorial provides basic and advanced concepts of Python. Our Python tutorial is designed for beginners and professionals.\r\n\r\nPython is a simple, general purpose, high level, and object-oriented programming language.\r\n\r\nPython is an interpreted scripting language also. Guido Van Rossum is known as the founder of Python programming.\r\n\r\nOur Python tutorial includes all topics of Python Programming such as installation, control statements, Strings, Lists, Tuples, Dictionary, Modules, Exceptions, Date and Time, File I/O, Programs, etc. There are also given Python interview questions to help you better understand Python Programming.', 'educational', '2023-08-03 12:39:28', '5dea584f-b49e-450b-a5fc-505fb9097be5.png', '3.5', 4),
(34, 'Java', 'All you need to know about java', 'java', 'Java is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible. It is a general-purpose programming language intended to let programmers write once, run anywhere (WORA),[17] meaning that compiled Java code can run on all platforms that support Java without the need to recompile.[18] Java applications are typically compiled to bytecode that can run on any Java virtual machine (JVM) regardless of the underlying computer architecture. The syntax of Java is similar to C and C++, but has fewer low-level facilities than either of them. The Java runtime provides dynamic capabilities (such as reflection and runtime code modification) that are typically not available in traditional compiled languages. As of 2019, Java was one of the most popular programming languages in use according to GitHub,[citation not found][19][20] particularly for client–server web applications, with a reported 9 million developers.[21]\r\n\r\nJava was originally developed by James Gosling at Sun Microsystems. It was released in May 1995 as a core component of Sun Microsystems\' Java platform. The original and reference implementation Java compilers, virtual machines, and class libraries were originally released by Sun under proprietary licenses. As of May 2007, in compliance with the specifications of the Java Community Process, Sun had relicensed most of its Java technologies under the GPL-2.0-only license. Oracle offers its own HotSpot Java Virtual Machine, however the official reference implementation is the OpenJDK JVM which is free open-source software and used by most developers and is the default JVM for almost all Linux distributions.\r\n\r\nAs of March 2023, Java 20 is the latest version, while Java 17, 11 and 8 are the current long-term support (LTS) versions.', 'educational', '2023-08-03 15:43:46', '002bef9e-e1a0-4110-92f8-51b3cfc5a207.jpg', '4.0', 7),
(35, 'Ruby on Rails', 'all you need to know about Ruby on Rails', 'ruby-on-rails', 'Ruby on Rails (simplified as Rails) is a server-side web application framework written in Ruby under the MIT License. Rails is a model–view–controller (MVC) framework, providing default structures for a database, a web service, and web pages. It encourages and facilitates the use of web standards such as JSON or XML for data transfer and HTML, CSS and JavaScript for user interfacing. In addition to MVC, Rails emphasizes the use of other well-known software engineering patterns and paradigms, including convention over configuration (CoC), don\'t repeat yourself (DRY), and the active record pattern.[4]\r\n\r\nRuby on Rails\' emergence in 2005 greatly influenced web app development, through innovative features such as seamless database table creations, migrations, and scaffolding of views to enable rapid application development. Ruby on Rails\' influence on other web frameworks remains apparent today, with many frameworks in other languages borrowing its ideas, including Django in Python; Catalyst in Perl; Laravel, CakePHP and Yii in PHP; Grails in Groovy; Phoenix in Elixir; Play in Scala; and Sails.js in Node.js.\r\n\r\nWell-known sites that use Ruby on Rails include Airbnb, Crunchbase, Dribbble,[5] GitHub,[6] Twitch[7] and Shopify.', 'educational', '2023-08-03 15:59:51', '3f429c0a-685c-4921-b3c8-d65fb0cdbd95.png', '0.0', 7),
(36, 'Javascript', 'All you need to know about Javascript', 'javascript', 'JavaScript (/ˈdʒɑːvəskrɪpt/), often abbreviated as JS, is a programming language that is one of the core technologies of the World Wide Web, alongside HTML and CSS. As of 2023, 98.7% of websites use JavaScript on the client side for webpage behavior,[10] often incorporating third-party libraries. All major web browsers have a dedicated JavaScript engine to execute the code on users\' devices.\r\n\r\nJavaScript is a high-level, often just-in-time compiled language that conforms to the ECMAScript standard.[11] It has dynamic typing, prototype-based object-orientation, and first-class functions. It is multi-paradigm, supporting event-driven, functional, and imperative programming styles. It has application programming interfaces (APIs) for working with text, dates, regular expressions, standard data structures, and the Document Object Model (DOM).\r\n\r\nThe ECMAScript standard does not include any input/output (I/O), such as networking, storage, or graphics facilities. In practice, the web browser or other runtime system provides JavaScript APIs for I/O.\r\n\r\nJavaScript engines were originally used only in web browsers, but are now core components of some servers and a variety of applications. The most popular runtime system for this usage is Node.js.\r\n\r\nAlthough Java and JavaScript are similar in name, syntax, and respective standard libraries, the two languages are distinct and differ greatly in design.', 'educational', '2023-08-03 16:31:47', '004f4835-b93c-4e06-8843-18f3189e926c.jpeg', '1.0', 5),
(37, 'Oppenheimer', 'All you need to know about Oppenheimer', 'oppenheimer', 'Oppenheimer (/ˈɒpənˌhaɪmər/ OP-ən-HY-mər) is a 2023 biographical drama film written and directed by Christopher Nolan. Based on the 2005 biography American Prometheus by Kai Bird and Martin J. Sherwin, the film chronicles the career of American theoretical physicist J. Robert Oppenheimer. The story predominantly focuses on Oppenheimer\'s early studies, his direction of the Manhattan Project during World War II, and his eventual fall from grace due to his 1954 security hearing. The film stars Cillian Murphy as Oppenheimer, Emily Blunt as Katherine “Kitty” Oppenheimer, his wife, Matt Damon as Leslie Groves, the director the Los Alamos National Laboratory and Robert Downey Jr. as Lewis Strauss, a senior member of the U.S. Atomic Energy Commission. The ensemble supporting cast includes Florence Pugh, Josh Hartnett, Casey Affleck, Rami Malek and Kenneth Branagh.\r\n\r\nThe film was announced in September 2021 after Universal Pictures won a bidding war for Nolan\'s screenplay, following Nolan\'s conflict with longtime distributor Warner Bros. Pictures. Murphy was the first cast member to sign on the following month, portraying Oppenheimer, with the rest of the cast joining between November 2021 and April 2022. Pre-production was underway by January 2022, with filming taking place from February to May. Oppenheimer was filmed in a combination of IMAX 65 mm and 65 mm large-format film, including, for the first time in history, sections in IMAX black-and-white film photography. It is Nolan\'s first film to receive an R-rating since Insomnia (2002). Like his previous works, Nolan used extensive practical effects and minimal computer-generated imagery.\r\n\r\nOppenheimer premiered at Le Grand Rex in Paris on July 11, 2023, and was theatrically released in the United States and United Kingdom on July 21, 2023, by Universal Pictures. Its simultaneous release with Warner Bros.\' Barbie led to the \"Barbenheimer\" phenomenon on social media, which encouraged audiences to see both films as a double feature. The film has grossed over $434 million worldwide on a $100 million production budget and received critical acclaim, with particular praise for its cast, screenplay, and visuals.', 'entertainment', '2023-08-03 18:28:26', 'c93c8b7c-9cfa-48a9-9d65-48166e59eb5b.jpeg', '5.0', 5),
(38, 'C Sharp', 'All you need to know about C Sharp', 'c-sharp', 'C# (pronounced See sharp)[b] is a general-purpose high-level programming language supporting multiple paradigms. C# encompasses static typing,[16]: 4  strong typing, lexically scoped, imperative, declarative, functional, generic,[16]: 22  object-oriented (class-based), and component-oriented programming disciplines.[17]\r\n\r\nThe C# programming language was designed by Anders Hejlsberg from Microsoft in 2000 and was later approved as an international standard by Ecma (ECMA-334) in 2002 and ISO/IEC (ISO/IEC 23270) in 2003. Microsoft introduced C# along with .NET Framework and Visual Studio, both of which were closed-source. At the time, Microsoft had no open-source products. Four years later, in 2004, a free and open-source project called Mono began, providing a cross-platform compiler and runtime environment for the C# programming language. A decade later, Microsoft released Visual Studio Code (code editor), Roslyn (compiler), and the unified .NET platform (software framework), all of which support C# and are free, open-source, and cross-platform. Mono also joined Microsoft but was not merged into .NET.\r\n\r\nAs of November 2022, the most recent stable version of the language is C# 11.0, which was released in 2022 in .NET 7.0.[18][19]', 'educational', '2023-08-03 20:34:17', '47c4936d-1388-414f-ab25-73207a0d8fad.png', '0.0', 5),
(39, 'Cricket', 'All you need to know about Cricket', 'cricket', 'Cricket is a bat-and-ball game played between two teams of eleven players on a field at the centre of which is a 22-yard (20-metre) pitch with a wicket at each end, each comprising two bails balanced on three stumps. The batting side scores runs by striking the ball bowled at one of the wickets with the bat and then running between the wickets, while the bowling and fielding side tries to prevent this (by preventing the ball from leaving the field, and getting the ball to either wicket) and dismiss each batter (so they are \"out\"). Means of dismissal include being bowled, when the ball hits the stumps and dislodges the bails, and by the fielding side either catching the ball after it is hit by the bat, but before it hits the ground, or hitting a wicket with the ball before a batter can cross the crease in front of the wicket. When ten batters have been dismissed, the innings ends and the teams swap roles. The game is adjudicated by two umpires, aided by a third umpire and match referee in international matches. They communicate with two off-field scorers who record the match\'s statistical information.\r\n\r\nForms of cricket range from Twenty20, with each team batting for a single innings of 20 overs (each \"over\" being a set of 6 fair opportunities for the batting team to score) and the game generally lasting three hours, to Test matches played over five days. Traditionally cricketers play in all-white kit, but in limited overs cricket they wear club or team colours. In addition to the basic kit, some players wear protective gear to prevent injury caused by the ball, which is a hard, solid spheroid made of compressed leather with a slightly raised sewn seam enclosing a cork core layered with tightly wound string.\r\n\r\nThe earliest reference to cricket is in South East England in the mid-16th century. It spread globally with the expansion of the British Empire, with the first international matches in the second half of the 19th century. The game\'s governing body is the International Cricket Council (ICC), which has over 100 members, twelve of which are full members who play Test matches. The game\'s rules, the Laws of Cricket, are maintained by Marylebone Cricket Club (MCC) in London. The sport is followed primarily in South Asia, Australia, New Zealand, the United Kingdom, Southern Africa and the West Indies.[1]\r\n\r\nWomen\'s cricket, which is organised and played separately, has also achieved international standard. The most successful side playing international cricket is Australia, which has won seven One Day International trophies, including five World Cups, more than any other country and has been the top-rated Test side more than any other country.', 'sports', '2023-08-04 13:21:15', '887abbeb-507e-41d3-a0e9-9cc9b6d90499.jpg', '0.0', 4),
(40, 'Barbie', 'All you need to know about Barbie', 'barbie', 'Barbie[a] is a 2023 American fantasy comedy film directed by Greta Gerwig, who wrote the screenplay with Noah Baumbach.[8] Based on the Barbie fashion dolls by Mattel, it is the first live-action Barbie film after numerous computer-animated direct-to-video and streaming television films. The film follows Barbie (Margot Robbie) and Ken (Ryan Gosling) on a journey of self-discovery following an existential crisis. It features an ensemble supporting cast, including America Ferrera, Kate McKinnon, Issa Rae, Rhea Perlman, and Will Ferrell.\r\n\r\nA live-action Barbie film was announced in September 2009 by Universal Pictures with Laurence Mark producing. Development began in April 2014, when Sony Pictures acquired the film rights. Following multiple writer and director changes and the casting of Amy Schumer and later Anne Hathaway as Barbie, the rights were transferred to Warner Bros. Pictures in October 2018. Robbie was cast in 2019, and Gerwig was announced as director and co-writer with Baumbach in 2021. The rest of the cast were announced in early 2022. Filming took place primarily at Warner Bros. Studios, Leavesden, in England and on the Venice Beach Skatepark in Los Angeles from March to July 2022.\r\n\r\nBarbie premiered at the Shrine Auditorium in Los Angeles on July 9, 2023, and was theatrically released in the United States on July 21, by Warner Bros. Pictures. Its simultaneous release with Universal\'s Oppenheimer led to the \"Barbenheimer\" phenomenon on social media, which encouraged audiences to see both films as a double feature. The film received positive reviews from critics and has grossed over $823 million worldwide, becoming the third-highest grossing film of 2023.', 'entertainment', '2023-08-04 13:41:02', '5c3d07c4-7268-49a4-a980-627e120d2f48.jpeg', '0.0', 4),
(41, 'Football', 'All you need to know about Football', 'football', 'Football is a family of team sports that involve, to varying degrees, kicking a ball to score a goal. Unqualified, the word football normally means the form of football that is the most popular where the word is used. Sports commonly called football include association football (known as soccer in North America, Ireland and Australia); gridiron football (specifically American football or Canadian football); Australian rules football; rugby union and rugby league; and Gaelic football.[1] These various forms of football share to varying extents common origins and are known as \"football codes\".\r\n\r\nThere are a number of references to traditional, ancient, or prehistoric ball games played in many different parts of the world.[2][3][4] Contemporary codes of football can be traced back to the codification of these games at English public schools during the 19th century.[5][6] The expansion and cultural influence of the British Empire allowed these rules of football to spread to areas of British influence outside the directly controlled Empire.[7] By the end of the 19th century, distinct regional codes were already developing: Gaelic football, for example, deliberately incorporated the rules of local traditional football games in order to maintain their heritage.[8] In 1888, The Football League was founded in England, becoming the first of many professional football associations. During the 20th century, several of the various kinds of football grew to become some of the most popular team sports in the world.[9]', 'sports', '2023-08-04 14:08:44', '5fc58a1b-acec-40dc-82d9-b710a84fbff0.jpeg', '5.0', 4);

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

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `post_id`, `user_id`, `rating`, `comment`) VALUES
(5, 32, 4, 3, 'it is satisfactory'),
(6, 32, 7, 4, 'it is very helpful'),
(7, 34, 5, 4, 'This was helpful'),
(8, 36, 5, 1, 'this was not helpful'),
(9, 37, 4, 5, 'this film is excellent.'),
(10, 41, 4, 5, 'very good');

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
(4, 'Biraj', 'biraj@gmail.com', '9876543210', 'pbkdf2:sha256:600000$VxRjCyt7P92ZIwSp$f983cad5f5c9b864164834619ee3bc02cabfeb6bf2fe45a7be49c7e93e6541b8'),
(5, 'Sabal', 'sabal@gmail.com', '9876543210', 'pbkdf2:sha256:600000$jvb9SSS2NlkPY2MO$c223743bff2d0db96910c5fa9c4e73549a60e1131a4851f71f677692c2c57821'),
(6, 'Anush ', 'anush@gmail.com', '987642245', 'pbkdf2:sha256:600000$auCN8SSEc3DtekN4$e9db1f3f67ee971327aa06ee4cdbeb11412941d828080ea7c2ac95e71613be54'),
(7, 'Shyam', 'shyam@gmail.com', '1234567890', 'pbkdf2:sha256:600000$arUiLTw1MNFyPsds$bdd04cecd65e0c6ce51837d503a3254f874e950387140c87575d772cf7b9fc29'),
(21, 'Ram', 'ram25@gmail.com', '7894561230', 'pbkdf2:sha256:600000$n8SguJ0UYPg2ALrH$0e6f54020e35e52198a76b752cdb1b3bf59366bfea3f5848cad860891416eacc');

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
  `content_type` varchar(50) NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`),
  ADD KEY `fk_user_id` (`user_id`);

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
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_posts`
--
ALTER TABLE `user_posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
