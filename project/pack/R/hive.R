 
Sys.setenv(JAVA_HOME="/usr/lib/jvm/java-7-oracle/jre")

library(RHive)
rhive.init(hiveHome="/etc/hive", hiveLib="/usr/lib/hive/lib", hadoopHome="/etc/hadoop", hadoopConf="/etc/hadoop/conf",
           hadoopLib="/usr/lib/hadoop/lib", verbose=FALSE)
rhive.connect()

