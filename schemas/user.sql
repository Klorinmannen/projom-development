DROP TABLE IF EXISTS `User`;

CREATE TABLE
	`User` (
		`UserID` INT PRIMARY KEY AUTO_INCREMENT,
		`Username` VARCHAR(255) NOT NULL,
		`PasswordHash` VARCHAR(255) NOT NULL,
		`Firstname` VARCHAR(255) DEFAULT NULL,
		`Lastname` VARCHAR(255) DEFAULT NULL,
		`Active` INT DEFAULT 1,
		`Deleted` INT DEFAULT 0,
		`DeletedAt` TIMESTAMP DEFAULT NULL,
		`CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		`UpdatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		KEY `Username` (`Username`),
		KEY `UsernamePassword` (`Username`, `Password`),
		KEY `UsernameActive` (`Username`, `Active`),
		KEY `Active` (`Active`),
		KEY `Deleted` (`Deleted`),
		KEY `CreatedAt` (`CreatedAt`),
	);