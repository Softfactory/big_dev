# Class: mariadb
#
# Install mariaDB
#
# Parameters:
#
# Actions:
#     Manage a MariaDB installation
#
# Requires:
#
# Sample Usage:
#     include mariadb

class mariadb {

  file {
    '/etc/mysql/my.cnf':
      source => 'puppet:///modules/mariadb/my.cnf',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/tmp/mariadb.accept':
      source => 'puppet:///modules/mariadb/mariadb.accept',
      owner  => root,
      group  => root,
      mode   => '0600';

  }

  #Note : Check
  #           apt-cache show mysql-common | grep Version
  #           apt-cache show libmysqlclient18 | grep Version
  package { 'mariadb_dependency':
      name => ['libmysqlclient18=5.5.35+maria-1~precise','mysql-common=5.5.35+maria-1~precise'],
      ensure => present,
      require      => File['/tmp/mariadb.accept'],
  }

  package { 'mariadb-server':
      name => 'mariadb-server-5.5',
      ensure => present,
      responsefile => '/tmp/mariadb.accept',
      require      => Package['mariadb_dependency'],
  }

  package { 'libmysql-java':
      ensure => installed,
      require  => Package['mariadb-server'],
  }

  service {
    'mysql':
      ensure => running,
      enable => true;
  }

  exec {
    'setup-mariadb':
      #cwd     => '/root',
      command => '/etc/puppet/files/modules/mariadb/files/mariadb.setup',
      path => $path,
      creates => '/root/mariadb.done';
  }

  Package['mariadb-server'] ->
    File['/etc/mysql/my.cnf'] ->
    Service['mysql'] ->
    Exec['setup-mariadb']
}
