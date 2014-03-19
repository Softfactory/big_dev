library(RJDBC)
drv <- JDBC("com.mysql.jdbc.Driver",
            "/usr/share/java/mysql-connector-java.jar", "`")
conn <- dbConnect(drv, "jdbc:mysql://localhost:3306/rmsdb","rms","rms")

dbListTables(conn)
(dbReadTable(conn,'daily_status'))



drv <- JDBC("com.mysql.jdbc.Driver",
            "/usr/share/java/mysql-connector-java.jar", "`")
conn <- dbConnect(drv, "jdbc:mysql://localhost:3306/metastore","hive","hive")
dbListTables(conn)


help(JDBC)
drv <- JDBC("com.mysql.jdbc.Driver",
            "/usr/share/java/mysql-connector-java.jar", "`")
conn <- dbConnect(drv, "jdbc:mysql://localhost:3306/rmsdb","rms","rms")

(dbReadTable(conn,'cluster_20140213112931'))

(dbReadTable(conn,'test'))
tableName=paste('/home/vagrant/project/cluster_',  format(Sys.time(), "%Y%m%d%k%M%S"), '.csv' ,sep = "");
dbGetQuery(con, "set client_encoding to 'UTF-8'")
dbWriteTable(conn, 'test1', c('작업하기'))
 
currentCluster()
?dbConnect
sessionInfo()
Sys.getlocale()
Sys.setlocale('ko_KR.UTF-8')
?Sys.setlocale
Sys.setlocale(category = "LC_ALL", locale ='ko_KR.UTF-8')


dbGetQuery(conn, "SHOW server_encoding");

