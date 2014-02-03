#
# Class: rinstall::rhive
#
# Install R
#
# Parameters:
#
# Actions:
#     Manage an RHive installation
#
# Requires:
#
# Sample Usage:
#     include rinstall::rhive
#
#    1. Download source code: <code>git clone https://github.com/nexr/RHive.git</code>
#    2. Change your working directory: <code>cd RHive</code>
#    3. Set the environment variables HIVE_HOME and HADOOP_HOME: <code>export HIVE_HOME=/path/to/your/hive/directory</code> <code>export HADOOP_HOME=/path/#to/your/hadoop/directory</code>#
#    5. Build java files using ant: <code>ant build</code>#
#    4. Build RHive: <code>R CMD build RHive</code>
#    5. Install RHive: <code>R CMD INSTALL RHive_<VERSION>.tar.gz</code>


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
