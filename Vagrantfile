# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "rabbitmq" do |v|
    v.vm.box = "hashicorp/precise64"
    v.vm.box_url = "https://vagrantcloud.com/hashicorp/boxes/precise64"
    v.vm.hostname = "rabbitmq"
    v.vm.provision :puppet
    v.vm.network "forwarded_port", guest: 15672, host: 18672
  end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "default.pp"
  end

end
