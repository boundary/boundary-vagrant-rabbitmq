# Update to the latest software
exec { "apt-get update":
  path => "/usr/bin",
}

# Install RabbitMQ
package { 'rabbitmq-server': ensure  => 'latest' }
package { 'wget': ensure  => 'latest' }
package { 'curl': ensure  => 'latest' }

# Start the RabbitMQ service
service { "rabbitmq-server":
  ensure  => "running",
  require => Package["rabbitmq-server"],
}

#
exec { "install rabbitmq java client":
  command => "install-rabbitmq-client.sh",
  path => "/vagrant",
}

file { 'profile':
path => '/home/vagrant/.bash_profile',
mode => 0400,
owner => vagrant,
group => vagrant,
source => '/vagrant/bash_profile',
require => Package[rabbitmq-server]
}
