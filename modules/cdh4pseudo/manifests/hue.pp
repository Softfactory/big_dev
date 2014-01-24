class cdh4pseudo::hue {
  require cdh4pseudo::hive

  ### install oozie
  package { 'oozie':
    ensure => latest
  }

  ### install oozie
  package { 'oozie-client':
    ensure => latest,
    require => Package['oozie']
  }


  ### install hue
  package { 'hue-server':
    ensure => latest,
    require => Package['oozie-client']
  }

  ### install hue
  package { 'hue-server':
    ensure => latest
  }

}
