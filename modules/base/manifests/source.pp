# Class: base::source
#
# Cloudera debian repo and Java7 PPA
#
# Parameters:
#
# Actions:
#     /etc/apt/sources.list.d/softfactory.list with cloudera & Java7 Key
# Requires:
#     base::update
# Sample Usage:
#     include base::source
# TODO :
#     Installing packages with names that vary per distro
#    case $operatingsystem {
#      centos: { $apache = "httpd" }
#      # Note that these matches are case-insensitive.
#      redhat: { $apache = "httpd" }
#      debian: { $apache = "apache2" }
#      ubuntu: { $apache = "apache2" }
#      default: { fail("Unrecognized operating system for webserver") }
#    }

    # determine the apache-server package based on the operatingsystem fact
#    $sourcelist = $operatingsystem ? {
#        centos  => "httpd",
#        default => "/etc/apt/sources.list.d/softfactory.list",
#    }
#    $sourcefile= $operatingsystem ? {
#        centos  => "base/softfactory.list.erb",
#        default => "base/softfactory.list.erb",
#    }
#    file { "$sourcelist":
#      owner   => 'root',
#      group   => 'root',
#      mode    => 644,
#      content => template($sourcefile)
#      alias  => "sourcelist",
#    }
#
#    exec {'add-cdh4-key':
#        command => "",
#        require => File["sourcelist"],
#    }

class base::source{
  file { "sourcelist":
    path    => "/etc/apt/sources.list.d/softfactory.list",
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template("base/softfactory.list.erb")
  }

  $os_downcase = downcase($::operatingsystem)

  exec {'add-cdh4-key':
    unless => 'ls /root/cdh4.key.lock',
    command => "curl -s http://archive.cloudera.com/cdh4/${os_downcase}/${::lsbdistcodename}/${::architecture}/cdh/archive.key | sudo apt-key add -",
    path => $path,
    creates => '/root/cdh4.key.lock',
    require => [File['sourcelist'], Package['curl']]
  }

  exec {'add-java-key':
    unless => 'ls /root/java.key.lock',
    command => "apt-key adv --recv-keys --keyserver keyserver.ubuntu.com EEA14886",
    path => $path,
    creates => '/root/java.key.lock',
    require => File['sourcelist']
  }

  exec {'add-mariadb-key':
    unless => 'ls /root/mariadb.key.lock',
    command => "apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db",
    path => $path,
    creates => '/root/mariadb.key.lock',
    require => File['sourcelist']
  }

  exec {'add-R-key':
    unless => 'ls /root/r.key.lock',
    command => "/usr/bin/apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80  E084DAB9",
    path => $path,
    creates => '/root/r.key.lock',
    require => File['sourcelist']
  }

}
