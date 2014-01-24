class cdh4pseudo::mahout {
  require cdh4pseudo::pseudo

  ### install mahout
  package { 'mahout':
    ensure => latest
  }

