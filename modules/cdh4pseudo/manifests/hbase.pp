# Class: cmantix/cdh4pseudo::hbase
#
# Installs Cloudera Hbase pseudo distributed mode
#
# Parameters:
#
# Actions:
#     Installs Hbase and starts Zookeeper instalation, configures it pseudo distributed mode.
# Requires:
#     cdh4pseudo::hadoop
# Sample Usage:
#     include cdh4pseudo::hbase
#
class cdh4pseudo::hbase {

  #require cdh4pseudo::hadoop

  ### install hbase
  package { 'hbase-master':
    ensure => latest,
    install_options => '-y'
  }

  # Add default Hadoop User to Hadoop Super Group - hadoop.
  # You can find it in hdfs-site.xml
  user {'hbase' :
    ensure  => present,
    groups => ['hadoop'],
    require => Package['hbase-master']
  }

  file {'/etc/hbase/conf/hbase-site.xml':
    source  => 'puppet:///modules/cdh4pseudo/hbase-site.xml',
    replace => true,
    owner   => 'root',
    group   => 'root',
    require => Package['hbase-master']
  }

  exec { 'mkdir-hbase':
    unless  => 'ls /root/hbase.mkdir.lock',
    command => 'sudo -u hdfs hadoop fs -mkdir /hbase ; touch /root/hbase.mkdir.lock',
    path => $path,
    require => File['/etc/hbase/conf/hbase-site.xml']
  }

  exec { 'chown-hbase':
    command => 'sudo -u hdfs hadoop fs -chown hbase /hbase',
    path => $path,
    require =>  Exec['mkdir-hbase']
  }

  ## install zookeeper
  class {'cdh4pseudo::zookeeper':
    require => Exec['chown-hbase']
  }

  ## Install region server
  package { 'hbase-regionserver':
    ensure => 'latest',
    require => Class['cdh4pseudo::zookeeper']
  }

  service { 'hbase-regionserver':
    ensure => running,
    require => Package['hbase-regionserver']
  }


  service { 'hbase-master':
    ensure => running,
    require => Service['hbase-regionserver']
  }

  ## install and start HBASE REST Services
  package { 'hbase-rest':
    ensure => 'latest',
    require => Service['hbase-master']
  }

  service { 'hbase-rest':
    ensure => running,
    require => Package['hbase-rest']
  }

  ## install and start HBASE Thrift Services
  package { 'hbase-thrift':
    ensure => 'latest',
    require => Service['hbase-master']
  }

  service { 'hbase-thrift':
    ensure => running,
    require => Package['hbase-thrift']
  }

}
