# Update to the latest software
exec { "apt-get update":
  path => "/usr/bin",
}

# Install RabbitMQ
package { 'rabbitmq-server': ensure  => 'latest' }
package { 'wget': ensure  => 'latest' }
package { 'curl': ensure  => 'latest' }
package { 'nodejs': ensure  => 'latest', require => Exec[install-ppa] }

# Start the RabbitMQ service
service { "rabbitmq-server":
  ensure  => "running",
  before => Exec[enable-management-plugin],
  require => Package[rabbitmq-server],
}

# Prequiste for the latest Nodejs
exec { "enable-management-plugin":
  command => "/usr/bin/sudo /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management",
  path => "/vagrant",
  require => Package[rabbitmq-server]
}

# Install Pip library for python modules
exec { "install-pip":
  command => "/usr/bin/python /vagrant/get-pip.py",
  path => "/vagrant",
  require => Package[rabbitmq-server]
}

# Install boto library for AWS ELB Plugin
exec { "install-boto":
  command => "/usr/local/bin/pip install boto",
  path => "/vagrant",
  require => Package[rabbitmq-server]
}

# Install the Rabbit MQ Client library so that we
# generate traffice in Rabbit MQ
#exec { "install-rabbitmq-java-client":
#  command => "install-rabbitmq-client.sh",
#  path => "/vagrant",
#}

# Prequiste for the latest Nodejs
exec { "install-ppa":
  command => "install-ppa.sh",
  path => "/vagrant",
  require => Package[curl]
}

# Install the relay
exec { "install-relay":
  command => "/usr/bin/sudo /usr/bin/npm install graphdat-relay -g",
  path => "/vagrant",
  require => Package[nodejs]
}

#exec { "install-init":
#  command => "/usr/bin/sudo /usr/bin/curl --output /etc/init.d/graphdat-relay https://gist.githubusercontent.com/codemoran/7442551/raw/067109faff11c0d70ced13fd99b75cc175feae58/graphdat-relay-redhat-init",
#  path => "/vagrant",
#  require => Package[curl]
#}

file { "graphdat-initd":
  path => "/etc/init.d/graphdat-relay",
  owner => "root",
  group => "root",
  mode   => 755,
  source => '/vagrant/graphdat-relay',
}

# Create directory for the relay
file { "graphdat-dir":
    path   => "/etc/graphdat-relay",
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 755,
}

file { 'profile':
path => '/home/vagrant/.bash_profile',
mode => 0400,
owner => vagrant,
group => vagrant,
source => '/vagrant/bash_profile',
require => Package[rabbitmq-server]
}
