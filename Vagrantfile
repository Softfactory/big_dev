# -*- mode: ruby -*-
# vi: set ft=ruby nowrap sw=2 sts=2 ts=8 noet:

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
  # see http://puppet-vagrant-boxes.puppetlabs.com/

  config.vm.hostname="big.softfactory.org"
  # https://github.com/mitchellh/vagrant/issues/2309
  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  config.vm.network "forwarded_port", guest: 8021,  host: 8021    #tracker
  config.vm.network "forwarded_port", guest: 8042,  host: 8042    #NodeManager
  config.vm.network "forwarded_port", guest: 8088,  host: 8088    #Resource Manager
  config.vm.network "forwarded_port", guest: 8080,  host: 8080    #Job History?
  config.vm.network "forwarded_port", guest: 8787,  host: 8787    #RStudio
  config.vm.network "forwarded_port", guest: 50070, host:  50070  #NameNode
  config.vm.network "forwarded_port", guest: 50075, host:  50075  #Directory
  config.vm.network "forwarded_port", guest: 19888, host:  19888  #Job History Web
  config.vm.network "forwarded_port", guest: 10020, host:  10020  #Job History
  config.vm.network "forwarded_port", guest: 60010, host:  60010  #HBase Master
  config.vm.network "forwarded_port", guest: 3306, host:  3306    #MariaDB

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  config.vm.synced_folder "shared", "/home/vagrant/shared"
  config.vm.synced_folder "modules", "/etc/puppet/files/modules"
  config.vm.synced_folder "project", "/home/vagrant/project"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "base.pp"
    puppet.module_path = "modules"
    puppet.options = "--verbose --debug" #--verbose --debug
  end
  config.vm.provider "virtualbox" do |v|
    v.name = "Big_Dev"
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    v.memory = 3000
  end

end
