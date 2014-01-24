# Class: cdh4pseudo::hadoop
#
# Install Hadoop in pseudo distributed mode.
# See http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH4/latest/CDH4-Quick-Start/
#
# Parameters:
#
# Actions:
#     Install hadoop in pseudo ditributed mode.
# Requires:
#     Oracle JDK 1.6 over is installed
# Sample Usage:
#     include cdh4pseudo::hadoop

class cdh4pseudo::hadoop {
  package { 'hadoop-conf-pseudo':
    ensure  => present,
  }

  file { "hdfs-site":
    path => "/etc/hadoop/conf/hdfs-site.xml",
    ensure => present,
    source => 'puppet:///modules/cdh4pseudo/hdfs-site.xml',
    mode   => '0644',
    require => Package['hadoop-conf-pseudo']
  }

  # Add default Hadoop User to Hadoop Super Group - hadoop.
  # You can find it in hdfs-site.xml
  user {'vagrant' :
    ensure  => present,
    groups => ['hadoop'],
    require => File['hdfs-site']
  }

  exec { 'format-hdfs-partition':
    unless => 'ls /root/hadooptmp.lock',
    command => 'sudo -u hdfs hdfs namenode -format',
    path => $path,
    require => User['vagrant']
  }

  service {'hadoop-hdfs-datanode': ensure => running, require => Exec['format-hdfs-partition']}
  service {'hadoop-hdfs-namenode': ensure => running, require => Exec['format-hdfs-partition']}
  service {'hadoop-hdfs-secondarynamenode': ensure => running, require => Exec['format-hdfs-partition']}

  exec { 'rm-tmp-hdfs':
    unless => 'ls /root/hadooptmp.lock',
    command => 'sudo -u hdfs hadoop fs -rm -r /tmp ; touch /root/hadooptmp.lock',
    path => $path,
    require => [Service['hadoop-hdfs-datanode'],Service['hadoop-hdfs-namenode'],Service['hadoop-hdfs-secondarynamenode']]
  }

  exec { 'mkdir-tmp-hdfs-tmp':
    unless => 'sudo -u hdfs hadoop fs -ls /tmp',
    command => 'sudo -u hdfs hadoop fs -mkdir /tmp',
    path => $path,
    require => Exec['rm-tmp-hdfs']
  }

  exec { 'mkdir-tmp-hdfs-tmp-hadoop-yarn-staging':
    unless => 'sudo -u hdfs hadoop fs -ls /tmp/hadoop-yarn/staging',
    command => 'sudo -u hdfs hadoop fs -mkdir /tmp/hadoop-yarn/staging',
    path => $path,
    require => Exec['mkdir-tmp-hdfs-tmp']
  }

  exec { 'mkdir-tmp-hdfs-tmp-hadoop-yarn-staging-history-done_intermediate':
    unless => 'sudo -u hdfs hadoop fs -ls /tmp/hadoop-yarn/staging/history/done_intermediate',
    command => 'sudo -u hdfs hadoop fs -mkdir /tmp/hadoop-yarn/staging/history/done_intermediate',
    path => $path,
    require => Exec['mkdir-tmp-hdfs-tmp-hadoop-yarn-staging']
  }

  exec { "chmod-tmp-hdfs-tmp":
    command => 'sudo -u hdfs hadoop fs -chmod -R 1777 /tmp',
    path => $path,
    require => Exec['mkdir-tmp-hdfs-tmp-hadoop-yarn-staging-history-done_intermediate']
  }

  exec { 'chown-tmp-hdfs':
    command => 'sudo -u hdfs hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging',
    path => $path,
    require => Exec['chmod-tmp-hdfs-tmp']
  }

  exec { 'mkdir-tmp-hdfs-log':
    unless => 'sudo -u hdfs hadoop fs -ls /var/log/hadoop-yarn',
    command => 'sudo -u hdfs hadoop fs -mkdir /var/log/hadoop-yarn',
    path => $path,
    require => Exec['chown-tmp-hdfs']
  }

  exec { 'chown-tmp-hdfs-log':
    command => 'sudo -u hdfs hadoop fs -chown yarn:mapred /var/log/hadoop-yarn',
    path => $path,
    require => Exec['mkdir-tmp-hdfs-log']
  }

  service {'hadoop-yarn-resourcemanager':
    ensure => running,
    require => Exec['chown-tmp-hdfs-log']
  }

  service {'hadoop-yarn-nodemanager':
    ensure => running,
    require => Exec['chown-tmp-hdfs-log']
  }

  service {'hadoop-mapreduce-historyserver':
    ensure => running,
    require => Exec['chown-tmp-hdfs-log']
  }

  # create vagrant user directories
  exec { 'vagrant-hdfs-dir':
    unless  => 'sudo -u hdfs hadoop fs -ls /user/vagrant',
    command => 'sudo -u hdfs hadoop fs -mkdir /user/vagrant',
    path => $path,
    require => Service['hadoop-mapreduce-historyserver']
  }

  exec { 'chown-vagrant-hdfs':
    command => 'sudo -u hdfs hadoop fs -chown vagrant:hadoop /user/vagrant',
    path => $path,
    require => Exec['vagrant-hdfs-dir']
  }
}
