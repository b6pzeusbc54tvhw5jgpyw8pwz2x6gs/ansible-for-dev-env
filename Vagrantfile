# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_version = "20180921.0.0"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 2048
  end

  config.vm.provision "file",
    source: "vagrant-key.pub", destination: "/home/vagrant/vagrant-key.pub"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "site.yml"
    ansible.extra_vars = ".extraValue.yml"
    ansible.verbose="-v"
  end

  config.vm.provision "shell", name: "clean", inline: <<-SHELL
    dd if=/dev/zero of=/EMPTY bs=1M
    rm -f /EMPTY
    cat /dev/null > ~/.bash_history && history -c
  SHELL
end
