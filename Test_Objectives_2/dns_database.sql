CREATE DATABASE dns_database;
USE dns_database;

CREATE TABLE dns_records (
  id INT NOT NULL AUTO_INCREMENT,
  time_epoch TIMESTAMP NOT NULL,
  ip_src VARCHAR(20) NOT NULL,
  udp_srcport INT(11) NOT NULL,
  ip_dst VARCHAR(20) NOT NULL,
  udp_dstport INT(11) NOT NULL,
  dns_qryname VARCHAR(80) NOT NULL,
  PRIMARY KEY (id)
);