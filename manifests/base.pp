 # -*- mode: ruby -*-
# vi: set ft=ruby nowrap sw=2 sts=2 ts=8 noet:

#include cdh4pseudo

#include rstudio

class bigdev {

  # class {'java': require => Class['base']}
  # class {'cdh4pseudo': require => Class['java']}
  # class {'rinstall': require => Class['cdh4pseudo']}
  # include base
  # include java
  # include cdh4pseudo
  include rinstall

}

include bigdev

