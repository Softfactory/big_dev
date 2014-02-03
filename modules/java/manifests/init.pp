# Class: java
#
# Install Java 7 from PPA
#
# Parameters:
#
# Actions:
#     Install oracle Java7 set it as default and modifies /etc/sudoers in order to keep $JAVA_HOME constant through sudo.
#     Don't use OpenJDK on Hadoop or R.
# Requires:
#     base::source
# Sample Usage:
#     include java
#
class java {
  include stdlib
  # seeding taken from https://github.com/abhishektiwari/java7/blob/master/manifests/init.pp
  file { "/tmp/java.accept":
    ensure => present,
    source => 'puppet:///modules/java/java.accept',
    mode   => '0600',
  }

  package { "oracle-java7-installer":
    ensure       => present,
    responsefile => '/tmp/java.accept',
    require => File['/tmp/java.accept'],
  }

  package { 'oracle-java7-set-default':
    ensure => latest,
    require => Package['oracle-java7-installer']
  }

  file_line { 'sudo_rule_java':
          path => '/etc/sudoers',
          line => 'Defaults env_keep = "JAVA_HOME"',
          require => Package['oracle-java7-set-default']
  }

  file { 'default-java' :
    path => '/usr/lib/jvm/default-java' ,
    ensure => link,
    target => '/usr/lib/jvm/java-7-oracle',
    require => File_line['sudo_rule_java']
  }

  file { "/etc/environment":
        content => inline_template("LD_LIBRARY_PATH=/usr/lib/jvm/default-java/jre/lib/amd64:/usr/lib/jvm/default-java/jre/lib/amd64/server"),
        require => File['default-java']
  }
}
