# -*- mode: ruby -*-
# vi: set ft=ruby  :

Vagrant.configure("2") do |config|

  config.vm.box_check_update = false
  config.vm.boot_timeout = 600
  config.vm.define "inspec" do |machine|
    machine.vm.box = "ubuntu/bionic64"
    machine.vm.hostname = "inspec.caiodelgado.example"
    machine.vm.network "private_network", ip: "10.10.10.11"
    machine.vm.provider "virtualbox" do |vb|
      vb.name = "inspec"
      vb.memory = "1024"
      vb.cpus = "1" 
      vb.customize ["modifyvm", :id, "--groups", "/iac"]
    end
  end
end
