# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "Debian-jessie-amd64-netboot.box"
  config.vm.box_url= "https://github.com/holms/vagrant-jessie-box/releases/download/Jessie-v0.1/Debian-jessie-amd64-netboot.box"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", 256]
  end

  config.ssh.forward_agent = true

  config.vm.define :main, primary:true do |main|
    main.vm.network :private_network, ip: "192.13.14.100"
    main.vm.synced_folder ".", "/vagrant", type: "nfs", :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']
    main.vm.hostname = "master"
    main.vm.provision "shell",
        inline: "sudo sh /vagrant/provisioning/ansible.sh"

    main.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", 512]
    end
  end

  config.vm.define :production do |production|
    production.vm.hostname = "production"
    production.vm.network :private_network, ip: "192.13.14.101"
  end

  config.vm.define :staging do |staging|
    staging.vm.hostname = "staging"
    staging.vm.network :private_network, ip: "192.13.14.102"
  end

end
