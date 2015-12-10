# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
  end

  #
  # Centos
  #
  config.vm.define "centos-6.6", autostart: false do |v|
     v.vm.box = "puppetlabs/centos-6.6-64-puppet"
     v.vm.hostname = "centos-6-6"
  end

  config.vm.define "centos-7.0", autostart: false do |v|
     v.vm.box = "puppetlabs/centos-7.0-64-puppet"
     v.vm.hostname = "centos-7-0"
  end

  #
  # Ubuntu
  #
  config.vm.define "ubuntu-12.04", autostart: false do |v|
     v.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"
     v.vm.hostname = "ubuntu-12-04"
  end
  
  config.vm.define "ubuntu-14.04", autostart: false do |v|
      v.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
      v.vm.hostname = "ubuntu-14-04"
  end

  #
  # Add the required puppet modules before provisioning is run by puppet
  #
  config.vm.provision :shell do |shell|
      shell.inline = "puppet module install puppetlabs-stdlib;
                      puppet module install puppetlabs-apt;
                      puppet module install nanliu/staging;
                      puppet module install puppetlabs-rabbitmq;
                      puppet module install boundary-boundary;
                      exit 0"
 end

  #
  # Use Puppet to provision the server
  #
  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "site.pp"
     puppet.facter = {
         "api_token" => ENV["API_TOKEN"]
     }
  end
  #

end
