# Class: base
#
# Install base
#
# Parameters:
#
# Actions:
#     Base Configuration
#
# Requires:
#     base::update   - Install base packages, curl, python-software-dev, etc
#     base::source   - add apt keys. you can add your keys to this.
#                      Ubuntu source list is defined in softfactory.list.erb
#     base::sudoers  - set sudoers for more convenience.
# Sample Usage:
#     include base
#
class base{

  class {'base::source': require => Class['base::update']}
  class {'base::sudoers': require => Class['base::source']}
  class {'base::korean': require => Class['base::sudoers']}

  include base::update
  include base::source
  include base::sudoers
  include base::korean

  exec {'source-update':
    command => 'apt-get update',
    path => $path,
    require => Class['base::sudoers']
  }

  # sudo apt-get install ubuntu-desktop

}
