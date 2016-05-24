# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.hostname = "parse-dev"

  config.vm.box = "bento/centos-7.1"

  config.vm.network "private_network", ip: "192.168.77.10"

  # disable default vagrant mounting
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # It's a small server
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "512"
  end

  # Sync all needed folders
  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  config.vm.synced_folder "server", "/srv/api/"

  ## Use all the defaults:
  config.vm.provision :salt do |config|
      config.minion_config = "salt/minion.yml"
      config.run_highstate = true
      config.verbose = true
      config.install_type = "stable"
      config.temp_config_dir = "/tmp"
      config.colorize = true
      config.log_level = "info"
  end
end

