CREATE DATABASE metastore;
USE metastore;
SOURCE /usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-0.10.0.mysql.sql;
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'hive'@'%';
GRANT SELECT,INSERT,UPDATE,DELETE,LOCK TABLES,EXECUTE ON metastore.* TO 'hive'@'%';
FLUSH PRIVILEGES;
