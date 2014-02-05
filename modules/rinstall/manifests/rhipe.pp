#
# Class: rinstall::rhipe
#
# Install RHipe
#
# Parameters:
#
# Actions:
#     Manage an RHipe installation
#
# Requires:
#


class rinstall::rhipe {

   # exec {'download_rhipe' :
   #   unless => 'ls /tmp/Rhipe',
   #   command => 'git clone https://github.com/saptarshiguha/RHIPE.git /tmp/Rhipe',
   #   path => $path,
   #   require => Package['git']
   # }

  file { "RHipe_ENV":
        path =>'/etc/environment',
        content => inline_template("HADOOP=/usr/lib/hadoop"),
        #require => File['default-java']
  }

   package {'protobuf' :
      name => ['libprotobuf-dev', 'libprotobuf-java','libprotobuf7', 'libprotoc-dev','libprotoc7','protobuf-compiler'],
      ensure => present,
      require => File ['RHipe_ENV']
   }
   exec {'install_rhipe' :
     cwd =>'/home/vagrant/project/RHipe',
     command => 'sudo R CMD build RHipe;sudo R CMD INSTALL Rhipe_*.tar.gz;',
     path => $path,
     require => Package ['protobuf']
     #require => [Exec['build_env'], Package['ant']]
   }

}

