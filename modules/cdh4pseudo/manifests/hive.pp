# Class: cmantix/cdh4pseudo::hive
#
# Installs Cloudera hive pseudo distributed mode
#
# Parameters:
#
# Actions:
#     Installs hive and starts hive server.
# Requires:
#     mariadb
# Sample Usage:
#     include cdh4pseudo::hive
#
class cdh4pseudo::hive {

  ## install MariaDB as a Metastore
  ##include mariadb

  package { 'hive':
    ensure => latest,
    require => Class['mariadb']
  }

  exec { 'hivedb' :
    unless => 'ls /root/hivedb.done',
    command =>'/etc/puppet/files/modules/cdh4pseudo/files/hivedb.setup',
    path => $path,
    creates => '/root/hivedb.done',
    require => Package['hive']

  }

  file {'mysql-connector-java' :
    path => '/usr/lib/hive/lib/mysql-connector-java.jar' ,
    ensure => link,
    target => '/usr/share/java/mysql-connector-java.jar',
    require => Exec['hivedb']
  }

  package { 'hive-metastore':
    ensure => latest,
    require => File['mysql-connector-java']
  }

  package { 'hive-server2':
    ensure => latest,
    require => Package['hive-metastore']
  }

  exec { 'mkdir-hive':
    unless  => 'ls /root/hive.mkdir.lock',
    command => 'sudo -u hdfs hadoop fs -mkdir /user/hive/warehouse ; touch /root/hive.mkdir.lock',
    path => $path,
    require =>  Package['hive-server2']
  }

  exec { 'chmod-hive':
    command => 'sudo -u hdfs hadoop fs -chmod 1777 /user/hive/warehouse',
    path => $path,
    require =>  Exec['mkdir-hive']
  }

  file {'hive-site':
    path => '/etc/hive/conf/hive-site.xml',
    replace => true,
    source => 'puppet:///modules/cdh4pseudo/hive-site.xml',
    mode   => '0644',
    require => Exec['chmod-hive']
  }

  service { 'hive-metastore':
    ensure => running,
    require => File['hive-site']
  }

  service { 'hive-server2':
    ensure => running,
    require => Service['hive-metastore']
  }

}
