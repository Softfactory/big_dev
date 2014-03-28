# Class: base::korean
#
# Install korean Fonts & set Korean Locale
#
# Parameters:
#
# Actions:
#     set korean locales.
# Requires:
#
# Sample Usage:
#     include base::korean
#
class base::korean {
  include stdlib

  package {'language-pack':
    name=>['language-pack-ko', 'language-pack-ko-base'],
    ensure  => present,
    install_options => '-y'
  }

  file_line{'add_locale' :
     path => '/var/lib/locales/supported.d/ko',
     line => 'ko_KR.UTF-8 UTF-8',
     require => Package['language-pack']
  }

  package { 'korean-fonts' :
    name=>['fonts-nanum', 'fonts-nanum-coding'],
    ensure  => present,
    install_options => '-y',
    require => File_line['add_locale']
  }

  exec { 'locale-setting' :
    unless  => 'ls /root/locale.lock',
    command => 'sudo locale-gen --purge; sudo dpkg-reconfigure locales',
    path=>$path,
    creates => '/root/locale.lock',
    require => Package['korean-fonts']
  }

  file_line{'locale-env' :
     path => '/etc/environment',
     line => 'LANG="ko_KR.UTF-8"',
     require => Exec['locale-setting']
  }

  file{'locale-file' :
     path => '/etc/default/locale',
     content => 'LANG="ko_KR.UTF-8"',
     require => File_line['locale-env']
  }
}
