# Class: cdh4pseudo
#
# Installs Cloudera CDH4:
#  * Hadoop Pseudo distributed mode
#  * Hbase pseudo distributed mode
#  * Zookeeper.
#  * Hbase thrift
#  * Hbase Rest
#  * Hive
#  * Hive-Server2
#  * Mahout
#  * Hue
#
# Parameters:
#
# Actions:
#   Install base pacakages, validate operating system.
# Requires:
#    java
# Sample Usage:
#     include cdh4pseudo
#
class cdh4pseudo {
  exec {'cdh_update':
    command => 'apt-get update',
    path => $path
  }

  class {'cdh4pseudo::hadoop': require => Exec['cdh_update']}
  class {'cdh4pseudo::hbase': require => Class['cdh4pseudo::hadoop']}
  class {'mariadb': require => Class['cdh4pseudo::hbase']}
  class {'cdh4pseudo::hive': require => Class['mariadb']}
  include cdh4pseudo::hadoop
  include cdh4pseudo::hbase
  include cdh4pseudo::hive
  include mariadb
  #include cdh4pseudo::hue
  #include cdh4pseudo::mahout
  #include cdh4pseudo::zookeeper
}
