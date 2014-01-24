#
# Class: rinstall
#
# Install R & RStudio
#
# Parameters:
#
# Actions:
#     Manage an R and RStudio installation
#
# Requires:
#     rinstall::rbase
#     rinstall::rhive
# Sample Usage:
#     include rinstall
#
class rinstall {
  class { 'rinstall::rbase' :
  }

  $url = 'http://download2.rstudio.org'
  $filename = 'rstudio-server-0.98.493-amd64.deb'

  package {
    ['gdebi-core', 'libapparmor1'] :
    ensure => 'present',
    require => Class['rinstall::rbase']
  }

  exec { 'download-rstudio':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      path => $path,
      timeout => 0,
      require => Class['rinstall::rbase']
  }

  exec { 'rstudio_install' :
    command => "sudo gdebi -n /root/${filename}",
    path => $path,
    require => Exec['download-rstudio']
  }

  class { 'rinstall::rhive' :
    require => Exec['rstudio_install']
  }

}
