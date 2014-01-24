# Class: cdh4pseudo::zookeeper
#
# Install Apache Zookeeper
#
# Parameters:
#
# Actions:
#     Install zookeeper for HBase.
# Requires:
#     cdh4pseudo::zookeeper
# Sample Usage:
#     include cdh4pseudo::zookeeper
#
class cdh4pseudo::zookeeper {
  package { 'zookeeper-server':
    ensure => latest
  }

  exec { 'zookeeper-init':
    unless  => 'ls /root/zookeeper.init.lock',
    command => 'service zookeeper-server init ; touch /root/zookeeper.init.lock',
    path => $path,
    require => Package['zookeeper-server']
  }

  service { "zookeeper-server":
    ensure     => running,
    require    => Exec["zookeeper-init"],
    hasrestart => true,
    hasstatus  => true,
  }
}
