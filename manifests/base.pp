 # -*- mode: ruby -*-
# vi: set ft=ruby nowrap sw=2 sts=2 ts=8 noet:

class bigdev {

  exec {'main-update':
    command => 'apt-get update',
    path => $path,
  }

  Exec['main-update']->Package <| |>

  class {'java': require => Class['base']}
  class {'cdh4pseudo': require => Class['java']}
  class {'rinstall': require => Class['cdh4pseudo']}
  include base
  include java
  include cdh4pseudo
  include rinstall
}

include bigdev

