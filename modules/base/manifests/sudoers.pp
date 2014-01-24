# Class: base::sudoers
#
# Install sudoers
#
# Parameters:
#
# Actions:
#     Modify sudoers.
# Requires:
#
# Sample Usage:
#     include base::sudoers
#

class base::sudoers {
  include stdlib

  file { 'sudoers':
    path    => '/etc/sudoers',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    replace => true
  }

  file_line { 'sudo_rule_tty1':
          path => '/etc/sudoers',
          line => 'Defaults:vagrant !requiretty',
          require => File['sudoers']
  }

  file_line { 'sudo_rule_tty2':
          path => '/etc/sudoers',
          line => 'Defaults:root !requiretty',
          require => File_line['sudo_rule_tty1']
  }

  file_line { 'sudo_rule_nopass':
          path => '/etc/sudoers',
          line => 'vagrant        ALL=(ALL)       NOPASSWD: ALL',
          require => File_line['sudo_rule_tty2']
  }

  host { $fqdn:
    ip => '127.0.0.1',
    require =>  Host['localhost']
  }

  host { 'localhost':
    ip => '127.0.0.1',
    require =>  File['sudoers']
  }
}
