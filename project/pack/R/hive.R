library(RHive)
rhive.init(hiveHome="/etc/hive", hiveLib="/usr/lib/hive/lib", hadoopHome="/etc/hadoop", hadoopConf="/etc/hadoop/conf",
           hadoopLib="/usr/lib/hadoop", verbose=FALSE)
 
rhive.connect()



rhive.query("select * from mr001")


rhive.big.query
rhive.query
rhive.execute 
rhive.list.databases()
rhive.use.database
rhive.list.tables() 
rhive.desc.table 
rhive.load.table
rhive.load.table2
rhive.exist.table
rhive.size.table('users')
rhive.drop.table

rhive.aggregate
rhive.mapapply
rhive.reduceapply 
rhive.mrapply 
 

rhive.list.jobs()

 