# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/trusty64"

    config.vm.hostname = "ubuntu"

    config.vm.synced_folder "./src/", "/src"

    config.vm.network "private_network", ip: "192.168.50.4"
    
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end

  end