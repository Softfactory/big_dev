# Class: crunchbang
#
# Installs CrunchBang(#!) :
# Seed from http://crunchbang.org/forums/viewtopic.php?id=19736
#
# Parameters:
#
# Actions:
#   Install base pacakages, validate operating system.
# Requires:
#    java
# Sample Usage:
#     include crunchbang

class crunchbang::waldorf {

  exec { 'crunchbang-key' :
    command => 'sudo wget http://packages.crunchbang.org/waldorf-dev/crunchbang.key | sudo apt-key add crunchbang.key',
    cwd => '/home/vagrant',
    path => $path,

  }

}
