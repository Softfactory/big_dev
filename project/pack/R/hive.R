Sys.setenv(HADOOP_HOME="/etc/hadoop")
Sys.setenv(HIVE_HOME="/etc/hive")

library(RHive)
rhive.init(hiveHome="/etc/hive", hiveLib="/usr/lib/hive/lib", hadoopHome="/etc/hadoop", hadoopConf="/etc/hadoop/conf",
           hadoopLib="/usr/lib/hadoop/lib", verbose=FALSE)
rhive.connect()

