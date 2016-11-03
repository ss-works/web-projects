/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

# WW: Should DROP tables in the REVERSE order that they were created in order not to violate the foreign key constraints.
DROP TABLE IF EXISTS CONFIGURATION_BIN;
DROP TABLE IF EXISTS USER_TO_USERROLE;
DROP TABLE IF EXISTS USER_ROLE;
DROP TABLE IF EXISTS TIMESHEET_ENTRY;
DROP TABLE IF EXISTS TIMESHEET_COMMENT;
DROP TABLE IF EXISTS PROJECT_ASSIGNMENT;
DROP TABLE IF EXISTS PROJECT_ASSIGNMENT_TYPE;
DROP TABLE IF EXISTS PROJECT;
DROP TABLE IF EXISTS MAIL_LOG;
DROP TABLE IF EXISTS USER_TO_DEPARTMENT;
DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS USER_DEPARTMENT;
DROP TABLE IF EXISTS TIMESHEET_LOCK;
DROP TABLE IF EXISTS TIMESHEET_LOCK_EXCLUSION;


DROP TABLE IF EXISTS AUDIT;
CREATE TABLE AUDIT (
  AUDIT_ID          INT(11)              NOT NULL AUTO_INCREMENT,
  USER_ID           INT(11)                       DEFAULT NULL,
  USER_FULLNAME     VARCHAR(256),
  AUDIT_DATE        DATETIME,
  PAGE              VARCHAR(256),
  ACTION            VARCHAR(256),
  PARAMETERS        VARCHAR(1024),
  SUCCESS           CHAR(1)
                    CHARACTER SET latin1 NOT NULL,
  AUDIT_ACTION_TYPE VARCHAR(32),
  PRIMARY KEY (AUDIT_ID),
  KEY IDX_AUDIT_DATE (AUDIT_DATE),
  KEY IDX_AUDIT_USER (USER_FULLNAME),
  KEY IDX_AUDIT_ACTION_TYPE (AUDIT_ACTION_TYPE)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;
--
-- Table structure for table CONFIGURATION
--

DROP TABLE IF EXISTS CONFIGURATION;
CREATE TABLE CONFIGURATION (
  CONFIG_KEY   VARCHAR(255) NOT NULL,
  CONFIG_VALUE VARCHAR(4096) DEFAULT NULL,
  PRIMARY KEY (CONFIG_KEY)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

--
-- Dumping data for table CONFIGURATION
--

LOCK TABLES CONFIGURATION WRITE;
/*!40000 ALTER TABLE CONFIGURATION DISABLE KEYS */;
INSERT INTO CONFIGURATION
VALUES ('initialized', 'false'), ('completeDayHours', '8'), ('showTurnOver', 'true'), ('localeLanguage', 'en'),
  ('currency', 'en-US'), ('localeCountry', 'en-US'), ('availableTranslations', 'en,nl,fr,it'),
  ('mailFrom', 'noreply@localhost.net'), ('smtpPort', '25'), ('mailSmtp', '127.0.0.1'), ('demoMode', 'false'),
  ('version', '1.4.2');
INSERT INTO CONFIGURATION (CONFIG_KEY, CONFIG_VALUE) VALUES ('reminderEnabled', 'false');
INSERT INTO CONFIGURATION (CONFIG_KEY, CONFIG_VALUE) VALUES ('reminderBody',
                                                             'Hello $name,\r\n\r\nThis is an automated message.\r\n\r\nOur records show that you have not posted your weekly hours online. Please be sure to post your hours by 5:30PM Friday.\r\n\r\nThank You,\r\n\r\neHour');
INSERT INTO CONFIGURATION (CONFIG_KEY, CONFIG_VALUE) VALUES ('reminderTime', '0 30 17 * * FRI');
INSERT INTO CONFIGURATION (CONFIG_KEY, CONFIG_VALUE) VALUES ('reminderSubject', 'Missing hours');
INSERT INTO CONFIGURATION (CONFIG_KEY, CONFIG_VALUE) VALUES ('reminderMinimalHours', '32');


/*!40000 ALTER TABLE CONFIGURATION ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table CUSTOMER
--

DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
  CUSTOMER_ID INT(11)      NOT NULL AUTO_INCREMENT,
  NAME        VARCHAR(255) NOT NULL,
  DESCRIPTION VARCHAR(1024)         DEFAULT NULL,
  CODE        VARCHAR(32)  NOT NULL,
  ACTIVE      CHAR(1)      NOT NULL DEFAULT 'Y',
  PRIMARY KEY (CUSTOMER_ID),
  UNIQUE KEY NAME (NAME, CODE)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

--
-- Table structure for table USER_DEPARTMENT
--

CREATE TABLE USER_DEPARTMENT (
  DEPARTMENT_ID        INT(11)      NOT NULL AUTO_INCREMENT,
  NAME                 VARCHAR(512) NOT NULL,
  CODE                 VARCHAR(64)  NOT NULL,
  MANAGER_USER_ID      INT(11)               DEFAULT NULL,
  TIMEZONE             VARCHAR(128)          DEFAULT NULL,
  PARENT_DEPARTMENT_ID INT(11)               DEFAULT NULL,
  PRIMARY KEY (DEPARTMENT_ID),
  UNIQUE KEY DEPARTMENT_ID (DEPARTMENT_ID),
  CONSTRAINT FK_PARENT_DEPARTMENT FOREIGN KEY (PARENT_DEPARTMENT_ID) REFERENCES USER_DEPARTMENT (DEPARTMENT_ID),
  CONSTRAINT FK_DEPARTMENT_MANAGER FOREIGN KEY (MANAGER_USER_ID) REFERENCES USERS (USER_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;


--
-- Dumping data for table USER_DEPARTMENT
--

LOCK TABLES USER_DEPARTMENT WRITE;
/*!40000 ALTER TABLE USER_DEPARTMENT DISABLE KEYS */;
INSERT INTO USER_DEPARTMENT (DEPARTMENT_ID, NAME, CODE) VALUES (1, 'Internal', 'INT');
/*!40000 ALTER TABLE USER_DEPARTMENT ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table USERS
--

CREATE TABLE USERS (
  USER_ID    INT(11)      NOT NULL AUTO_INCREMENT,
  USERNAME   VARCHAR(64)  NOT NULL,
  PASSWORD   VARCHAR(128) NOT NULL,
  FIRST_NAME VARCHAR(64)           DEFAULT NULL,
  LAST_NAME  VARCHAR(64)  NOT NULL,
  DEPARTMENT_ID INT(11)      NULL,
  EMAIL      VARCHAR(128)          DEFAULT NULL,
  SALT       INT(11)               DEFAULT NULL,
  ACTIVE     CHAR(1)      NOT NULL DEFAULT 'Y',
  PRIMARY KEY (USER_ID),
  UNIQUE KEY USER_ID (USER_ID),
  UNIQUE KEY USERNAME (USERNAME),
  UNIQUE KEY USERNAME_ACTIVE (USERNAME, ACTIVE),
  KEY IDX_USERNAME_PASSWORD (USERNAME, PASSWORD)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;


--
-- Dumping data for table USERS
--

LOCK TABLES USERS WRITE;
/*!40000 ALTER TABLE USERS DISABLE KEYS */;
INSERT INTO USERS (USER_ID, USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, EMAIL, ACTIVE)
VALUES (1, 'admin', '', 'eHour', 'Admin', '', 'Y');
/*!40000 ALTER TABLE USERS ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE USER_TO_DEPARTMENT (
  DEPARTMENT_ID INT(11) NOT NULL,
  USER_ID       INT(11) NOT NULL,
  PRIMARY KEY (DEPARTMENT_ID, USER_ID),
  KEY ROLE (DEPARTMENT_ID),
  KEY USER_ID (USER_ID),
  CONSTRAINT FK_USER_TO_USER FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
  CONSTRAINT FK_USER_TO_DEPT FOREIGN KEY (DEPARTMENT_ID) REFERENCES USER_DEPARTMENT (DEPARTMENT_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

INSERT INTO USER_TO_DEPARTMENT VALUES (1, 1);

--
-- Table structure for table MAIL_LOG
--

CREATE TABLE MAIL_LOG (
  MAIL_LOG_ID INT(11)  NOT NULL AUTO_INCREMENT,
  TIMESTAMP   DATETIME NOT NULL,
  SUCCESS     CHAR(1)  NOT NULL,
  MAIL_EVENT  VARCHAR(64),
  MAIL_TO     VARCHAR(255),
  PRIMARY KEY (MAIL_LOG_ID),
  UNIQUE KEY MAIL_LOG_ID (MAIL_LOG_ID),
  INDEX IDX_MAIL (MAIL_TO, MAIL_EVENT)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

--
-- Table structure for table PROJECT
--

CREATE TABLE PROJECT (
  PROJECT_ID      INT(11)      NOT NULL AUTO_INCREMENT,
  CUSTOMER_ID     INT(11)               DEFAULT NULL,
  NAME            VARCHAR(255) NOT NULL,
  DESCRIPTION     VARCHAR(1024)         DEFAULT NULL,
  CONTACT         VARCHAR(255)          DEFAULT NULL,
  PROJECT_CODE    VARCHAR(32)  NOT NULL,
  DEFAULT_PROJECT CHAR(1)      NOT NULL DEFAULT 'N',
  ACTIVE          CHAR(1)      NOT NULL DEFAULT 'Y',
  BILLABLE        CHAR(1)               DEFAULT 'Y',
  PROJECT_MANAGER INT(11)               DEFAULT NULL,
  PRIMARY KEY (PROJECT_ID),
  KEY CUSTOMER_ID (CUSTOMER_ID),
  KEY PROJECT_fk1 (PROJECT_MANAGER),
  CONSTRAINT PROJECT_fk FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID),
  CONSTRAINT PROJECT_fk1 FOREIGN KEY (PROJECT_MANAGER) REFERENCES USERS (USER_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

--
-- Table structure for table PROJECT_ASSIGNMENT_TYPE
--

CREATE TABLE PROJECT_ASSIGNMENT_TYPE (
  ASSIGNMENT_TYPE_ID INT(11) NOT NULL,
  ASSIGNMENT_TYPE    VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (ASSIGNMENT_TYPE_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;


--
-- Dumping data for table PROJECT_ASSIGNMENT_TYPE
--

LOCK TABLES PROJECT_ASSIGNMENT_TYPE WRITE;
/*!40000 ALTER TABLE PROJECT_ASSIGNMENT_TYPE DISABLE KEYS */;
INSERT INTO PROJECT_ASSIGNMENT_TYPE VALUES (0, 'DATE_TYPE'), (2, 'TIME_ALLOTTED_FIXED'), (3, 'TIME_ALLOTTED_FLEX');
/*!40000 ALTER TABLE PROJECT_ASSIGNMENT_TYPE ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table PROJECT_ASSIGNMENT
--

CREATE TABLE PROJECT_ASSIGNMENT (
  ASSIGNMENT_ID          INT(11)              NOT NULL AUTO_INCREMENT,
  PROJECT_ID             INT(11)              NOT NULL,
  HOURLY_RATE            FLOAT(9, 3)                   DEFAULT NULL,
  DATE_START             DATE                          DEFAULT NULL,
  DATE_END               DATE                          DEFAULT NULL,
  ROLE                   VARCHAR(255)                  DEFAULT NULL,
  USER_ID                INT(11)              NOT NULL,
  ACTIVE                 CHAR(1)
                         CHARACTER SET latin1 NOT NULL DEFAULT 'Y',
  ASSIGNMENT_TYPE_ID     INT(11)              NOT NULL,
  ALLOTTED_HOURS         FLOAT(9, 3)                   DEFAULT NULL,
  ALLOTTED_HOURS_OVERRUN FLOAT(9, 3)                   DEFAULT NULL,
  NOTIFY_PM_ON_OVERRUN   CHAR(1)              NOT NULL DEFAULT 'N',
  PRIMARY KEY (ASSIGNMENT_ID),
  KEY PROJECT_ID (PROJECT_ID),
  KEY USER_ID (USER_ID),
  KEY ASSIGNMENT_TYPE_ID (ASSIGNMENT_TYPE_ID),
  CONSTRAINT PROJECT_ASSIGNMENT_fk2 FOREIGN KEY (ASSIGNMENT_TYPE_ID) REFERENCES PROJECT_ASSIGNMENT_TYPE (ASSIGNMENT_TYPE_ID),
  CONSTRAINT PROJECT_ASSIGNMENT_fk FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT (PROJECT_ID),
  CONSTRAINT PROJECT_ASSIGNMENT_fk1 FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;


--
-- Table structure for table TIMESHEET_COMMENT
--

CREATE TABLE TIMESHEET_COMMENT (
  USER_ID      INT(11) NOT NULL,
  COMMENT_DATE DATE    NOT NULL,
  COMMENT      VARCHAR(2048) DEFAULT NULL,
  PRIMARY KEY (COMMENT_DATE, USER_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

--
-- Table structure for table TIMESHEET_ENTRY
--

CREATE TABLE TIMESHEET_ENTRY (
  ASSIGNMENT_ID INT(11) NOT NULL,
  ENTRY_DATE    DATE    NOT NULL,
  UPDATE_DATE   TIMESTAMP,
  HOURS         FLOAT(9, 3),
  COMMENT       VARCHAR(2048),
  PRIMARY KEY (ENTRY_DATE, ASSIGNMENT_ID),
  KEY ASSIGNMENT_ID (ASSIGNMENT_ID),
  CONSTRAINT TIMESHEET_ENTRY_fk FOREIGN KEY (ASSIGNMENT_ID) REFERENCES PROJECT_ASSIGNMENT (ASSIGNMENT_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;


--
-- Table structure for table USER_ROLE
--

CREATE TABLE USER_ROLE (
  ROLE VARCHAR(128) NOT NULL,
  NAME VARCHAR(128) NOT NULL,
  PRIMARY KEY (ROLE)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;


--
-- Dumping data for table USER_ROLE
--

LOCK TABLES USER_ROLE WRITE;
/*!40000 ALTER TABLE USER_ROLE DISABLE KEYS */;
INSERT INTO USER_ROLE
VALUES ('ROLE_ADMIN', 'Administrator'), ('ROLE_CONSULTANT', 'Consultant'), ('ROLE_PROJECTMANAGER', 'PM'),
  ('ROLE_REPORT', 'Report role'), ('ROLE_MANAGER', 'Manager');
/*!40000 ALTER TABLE USER_ROLE ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table USER_TO_USERROLE
--

CREATE TABLE USER_TO_USERROLE (
  ROLE    VARCHAR(128) NOT NULL,
  USER_ID INT(11)      NOT NULL,
  PRIMARY KEY (ROLE, USER_ID),
  KEY ROLE (ROLE),
  KEY USER_ID (USER_ID),
  CONSTRAINT USER_TO_USERROLE_fk FOREIGN KEY (ROLE) REFERENCES USER_ROLE (ROLE),
  CONSTRAINT USER_TO_USERROLE_fk1 FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

--
-- Dumping data for table USER_TO_USERROLE
--

LOCK TABLES USER_TO_USERROLE WRITE;
/*!40000 ALTER TABLE USER_TO_USERROLE DISABLE KEYS */;
INSERT INTO USER_TO_USERROLE (ROLE, USER_ID) VALUES ('ROLE_ADMIN', 1), ('ROLE_REPORT', 1);
/*!40000 ALTER TABLE USER_TO_USERROLE ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE CONFIGURATION_BIN (
  CONFIG_KEY   VARCHAR(255) NOT NULL,
  CONFIG_VALUE LONGBLOB,
  METADATA     VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (CONFIG_KEY)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE TIMESHEET_LOCK (
  LOCK_ID    INT          NOT NULL AUTO_INCREMENT,
  DATE_START DATE         NOT NULL,
  DATE_END   DATE         NOT NULL,
  NAME       VARCHAR(255) NULL,
  PRIMARY KEY (LOCK_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

ALTER TABLE TIMESHEET_LOCK
ADD INDEX IDX_LOCK_RANGE (DATE_START ASC, DATE_END ASC);

CREATE TABLE TIMESHEET_LOCK_EXCLUSION (
  LOCK_ID INT(11) NOT NULL,
  USER_ID INT(11) NOT NULL,
  PRIMARY KEY (LOCK_ID, USER_ID),
  INDEX IDX_LOCK_ID (LOCK_ID ASC),
  INDEX fk_TIMESHEET_LOCK_EXCLUSION_1_idx (USER_ID ASC),
  CONSTRAINT FK_EXCLUSION_USER FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
  CONSTRAINT FK_EXCLUSION_LOCK FOREIGN KEY (LOCK_ID) REFERENCES TIMESHEET_LOCK (LOCK_ID)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;