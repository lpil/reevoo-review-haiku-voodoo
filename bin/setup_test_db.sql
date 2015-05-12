DROP DATABASE IF EXISTS rrhv_test;

CREATE DATABASE IF NOT EXISTS rrhv_test;

USE rrhv_test;

CREATE TABLE reviews (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255),
  good_points MEDIUMTEXT,
  bad_points MEDIUMTEXT,
  general_comments MEDIUMTEXT
  );
