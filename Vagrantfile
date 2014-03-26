# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.box = 'hashicorp/precise32'

  config.vm.synced_folder 'frameworks/', '/usr/share/FrameworkBenchmarks/frameworks'
  config.vm.synced_folder 'toolset/', '/usr/share/FrameworkBenchmarks/toolset'
  config.vm.synced_folder 'config/', '/usr/share/FrameworkBenchmarks/config'



  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.module_path    = 'modules'
  end

end
