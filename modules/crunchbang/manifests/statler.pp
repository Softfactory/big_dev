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
class crunchbang::statler {

   package {'xwindow-base':
      name => ['xorg','slim','alsa-base','volumeicon-alsa','openbox','openbox-themes','openbox-xdgmenu','obmenu','gmrun','suckless-tools','tint2','conky-all','terminator','hal'],
      install_options => '-f  -y',
      ensure  => present
   }

   package { 'crunch-base':
      name => ['geany','nitrogen','lxappearance','gtk2-engines-murrine','thunar','firefox','gksu','python-notify'],
      ensure  => present,
      install_options => '-f  -y',
      require => Package['xwindow-base']
   }

   exec { 'crunch-update' :
      command =>'sudo apt-get -y -f install',
      path =>$path,
      require => Package['crunch-base']
   }

   package { 'crunch-options' :
      name => ['vlc','evince','gpicview','abiword','gnumeric','gigolo','gftp','xchat','synaptic','gparted','gimp','catfish','file-roller','scrot','gcalctool','xscreensaver', 'htop'],
      ensure  => present,
      install_options => '-f -y',
      require => Exec['crunch-update']
   }

   exec {'crunch-install':
      command => 'sudo dpkg -i --force-depends crunchbang-*',
      cwd =>'/etc/puppet/files/modules/crunchbang/files',
      path => $path,
      require => Package['crunch-options']
   }

   exec {'cairo-install':
      command => 'sudo dpkg -i --force-depends cairo-*',
      cwd =>'/etc/puppet/files/modules/crunchbang/files',
      path => $path,
      require => Package['crunch-install']
   }

   exec {'statler-install':
      command => 'sudo dpkg -i --force-depends statler-*',
      cwd =>'/etc/puppet/files/modules/crunchbang/files',
      path => $path,
      require => Exec['cairo-install']
   }

   exec {'statler-copy':
      command => 'cp -R /etc/skel/.[a-zA-Z0-9]* /home/vagrant/',
      cwd =>'/home/vagrant',
      path => $path,
      require => Exec['statler-install']
   }

  file { "openbox_autostart":
    path    => "/home/vagrant/.config/openbox/autostart",
    owner   => 'vagrant',
    group   => 'vagrant',
    mode    => 644,
    source => 'puppet:///modules/crunchbang/openbox/autostart',
    require => Exec['statler-copy']
  }

  file { "openbox_menu":
    path    => "/home/vagrant/.config/openbox/menu.xml",
    owner   => 'vagrant',
    group   => 'vagrant',
    mode    => 644,
    source => 'puppet:///modules/crunchbang/openbox/menu.xml',
    require => File['openbox_autostart']
  }

  file { "openbox_rc":
    path    => "/home/vagrant/.config/openbox/rc.xml",
    owner   => 'vagrant',
    group   => 'vagrant',
    mode    => 644,
    source => 'puppet:///modules/crunchbang/openbox/rc.xml',
    require => File['openbox_menu']
  }

  file { "conky":
    path    => "/home/vagrant/.conkyrc",
    owner   => 'vagrant',
    group   => 'vagrant',
    mode    => 644,
    source => 'puppet:///modules/crunchbang/.conkyrc',
    require => File['openbox_menu']
  }

   exec {'chown-config':
      command => 'chown vagrant:vagrant -R .config',
      cwd =>'/home/vagrant',
      path => $path,
      require => File['conky']
   }
   exec {'vbox_guest':
      command => 'sudo /mnt/VBoxLinuxAdditions.run',
      cwd =>'/home/vagrant',
      path => $path,
      require => Exec['chown-config']
   }
  exec {'install_crunchbang_config':
    unless => 'ls /root/cdh4.key.lock',
    command => "curl -s http://packages.crunchbang.org/statler/pool/main/crunchbang-configs_0.1.1_all.deb | sudo dpkg -i -",
    path => $path,
    creates => '/root/cdh4.key.lock',
    require => [File['sourcelist'], Package['curl']]
  }

  exec {'install_crunchbang_script':
    unless => 'ls /root/cdh4.key.lock',
    command => "curl -s http://packages.crunchbang.org/statler/pool/main/crunchbang-bin-scripts_0.25_all.deb | sudo dpkg -i -",
    path => $path,
    creates => '/root/cdh4.key.lock',
    require => [File['sourcelist'], Package['curl']]
  }

  exec {'install_crunchbang_script':
    unless => 'ls /root/cdh4.key.lock',
    command => "curl -s http://packages.crunchbang.org/statler/pool/main/statler-icon-theme_0.0.1_all.deb | sudo dpkg -i -",
    path => $path,
    creates => '/root/cdh4.key.lock',
    require => [File['sourcelist'], Package['curl']]
  }
  exec {'install_crunchbang_script':
    unless => 'ls /root/cdh4.key.lock',
    command => "curl -s http://packages.crunchbang.org/statler/pool/main/statler-slim-theme_0.03_all.deb | sudo dpkg -i -",
    path => $path,
    creates => '/root/cdh4.key.lock',
    require => [File['sourcelist'], Package['curl']]
  }
  exec {'install_crunchbang_script':
    unless => 'ls /root/cdh4.key.lock',
    command => "curl -s http://packages.crunchbang.org/statler/pool/main/statler-ui-theme_0.02_all.deb | sudo dpkg -i -",
    path => $path,
    creates => '/root/cdh4.key.lock',
    require => [File['sourcelist'], Package['curl']]
  }


# mount /dev/cdrom /mnt              # or any other mountpoint
# cd /mnt
# ./VBoxLinuxAdditions.run
# reboot

  # exec {'install_guest':
  #   unless => 'ls /root/cdh4.key.lock',
  #   command => "apt-get install -f -y virtualbox-guest-additions dkms",
  #   path => $path,
  #   creates => '/root/cdh4.key.lock',
  #   require => [File['sourcelist'], Package['curl']]
  # }

# Add the user for reboot and shutdown in sudoers:
# sudo visudo
# at the bottom of the page, add
#
# Ctrl-o - Enter - Ctrl-x - Enter


  # file_line{'add_locale' :
  #    unless  => 'ls /root/fonts.lock',
  #    path => '/var/lib/locales/supported.d/ko',
  #    line => 'ALL   ALL=NOPASSWD:/sbin/shutdown',
  #         require => File['sudoers']
  # }

   # exec { 'options' :
   #  command => 'apt-get install vlc evince gpicview abiword gnumeric gigolo gftp xchat synaptic gparted gimp catfish file-roller scrot gcalctool xscreensaver',
   #  path => $path
   # }


}


# sudo apt-get install
## optional:
#sudo apt-get install
# wget -c
# wget -c
# sudo dpkg -i crunchbang-*
# wget -c http://packages.crunchbang.org/statler/pool/main/statler-icon-theme_0.0.1_all.deb
# wget -c http://packages.crunchbang.org/statler/pool/main/statler-slim-theme_0.03_all.deb
# wget -c http://packages.crunchbang.org/statler/pool/main/statler-ui-theme_0.02_all.deb
# sudo dpkg -i statler*
# cp -R /etc/skel/.[a-zA-Z0-9]* /home/YOUR-USERNAME/
# # or
# cp -R /etc/skel/.config /home/YOUR-USERNAME/.config

# Whenever you get interrupted, perform a
# sudo apt-get install -f
# After this we copy the #! configs to your user:
# cp -R /etc/skel/.[a-zA-Z0-9]* /home/YOUR-USERNAME/
# # or
# cp -R /etc/skel/.config /home/YOUR-USERNAME/.config
# Now let's copy the menu.xml - I have stripped off the pipe-menus because they won't work here.
# Clicky here: ~/.config/openbox/menu.xml

# Start X:
# sudo /etc/init.d/slim start
# Enter your username and password, and voila. All other things you need you can get with apt-get install.
# Screenshot or it didn't happen?

# As you see, things like the volume icon and the clipboard are not installed (yet). This is absolutely your own problem  Remember that this is just a base that looks like Statler and uses the configs from there, it doesn't cover details like the cb-welcome script, networking, Flash/Java, or any extras like tint2conf or compositing. The packages on the crunchbang server don't play well with the LTS versions, so you should get them from PPAs.

# Edit:
# Q: I want cb-welcome. Now!
# A: Not really, or? All scripts are in /usr/bin/, but for your own sake - don't run cb-welcome. Or run it, and fix the mess you made yourself.
# Q: Why the heck should I format that bloody USB stick?
# A: You usually don't need to if you are creating the LiveUSB stick in Linux with dd. Some users like to use Lili USB Creator, unetbootin or _______ - they will have to format the USB stick before.
# Q: I want to add the statler/waldorf sources so much!
# A: Leave the sources.list as it is - many of the statler packages depend on different file versions than those in Masturbuntu's repos. If the repos don't have your application in stock, hunt for a PPA.
# Q: I hate Statler, gimme Waldorf!
# A: Of course you can get the waldorf files, they are on the same server, in another directory with slightly different file names. As waldorf is not yet an official release, I don't post instructions (yes, that's an excuse for my laziness) but waldorfying the Ubuntu base is as easy as statlerifying it.
# Q: I want to be notified with Statler's beautiful face.
# A: Install libnotify-bin, I think it is.
# Have fun breaking it!
