#
# Class: rinstall::rhive
#
# Install RHive
#
# Parameters:
#
# Actions:
#     Manage an RHive installation
#
# Requires:

class rinstall::rhive {
   package { ['git','ant'] :
    ensure => present,
   }

   exec {'download_rhive' :
     unless => 'ls /tmp/RHive',
     command => 'git clone https://github.com/nexr/RHive.git /tmp/RHive',
     path => $path,
     require => Package['git']
   }

   #$sourcepath = '/RHive/inst/javasrc/src/com/nexr/rhive/util/DFUtils.java'


  file {'change_src':
    path => '/tmp/RHive/RHive/inst/javasrc/src/com/nexr/rhive/util/DFUtils.java',
    replace => true,
    source => 'puppet:///modules/rinstall/DFUtils.java',
    require => Exec['download_rhive']
  }

   exec {'build_env' :
          command => 'sudo cp -f /etc/puppet/files/modules/rinstall/files/build.xml /tmp/RHive/',
     path => $path,
     require => File['change_src']
   }

   exec {'install_rhive' :
     cwd =>'/tmp/RHive',
     command => 'sudo ant build;sudo R CMD build RHive;sudo R CMD INSTALL RHive_*.tar.gz;',
     path => $path,
     require => [Exec['build_env'], Package['ant']]
   }


}
