# Class: base::update
#
# Install update
#
# Parameters:
#
# Actions:
#     First,  update apt packages. Then install default packages
# Requires:
#
# Sample Usage:
#     include base::update
#
class base::update {
  # exec {'hostname' :
  #   command => 'sudo hostname ${fqdn}',
  #   path => $path
  # }

  exec {'tmp-update':
    command => 'apt-get update',
    path => $path
  }

  # Event Chain for all Package Install
  Exec['tmp-update']->Package <| |>

  package {'curl': ensure => latest }
  package {'libcurl4-openssl-dev': ensure => latest }
  package {'python-software-properties': ensure => latest }
  package {'unzip': ensure => latest }
  package {'screen': ensure => latest }

}
