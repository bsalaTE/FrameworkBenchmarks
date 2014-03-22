# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.box = 'ubuntu1204'
  config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'


  config.vm.synced_folder 'FrameworkBenchmarks/', '/usr/share/FrameworkBenchmarks'


  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.module_path    = 'modules'
  end

end
