#
# Class: rinstall::rbase
#
# Install R
#
# Parameters:
#
# Actions:
#     Manage an R installation
#
# Requires:
#
# Sample Usage:
#     include rinstall::rbase
# TODO remove Exec ['prepare-r-install-env']
class rinstall::rbase {
# Use the relevant Ubuntu box with the cran mirror
# Install latest version of R
    exec {'prepare-r-install-env':
        unless => 'ls /usr/lib/R',
        provider => shell,
        creates => '/usr/lib/R',
        command => 'ls '
    }

    # Get the core environment
    package {['r-base', 'r-base-core', 'r-recommended', 'r-base-html', 'r-base-dev']:
        ensure => 'present',
        require => Exec['prepare-r-install-env'],
    }

    # Install useful packages
    exec {'install-r-packages':
        creates => '/tmp/installed-r-packages',
        command => 'sudo /usr/bin/R CMD javareconf;sudo /usr/bin/R -f /etc/puppet/files/modules/rinstall/files/basicPackages.R;',
        path => $path,
        require => Package['r-base-dev'],
    }

    # Javareconf
    #exec {'javareconf':
    #    creates => '/tmp/javareconf',
    #    command => 'sudo /usr/bin/R CMD javareconf',
    #    path=>$path,
    #    require  => Exec['install-r-packages'],
    #}


    file {'/etc/Rserv.conf' :
        ensure => file,
        content => inline_template("remote enable"),
        require => Exec['install-r-packages'],
    }
}
