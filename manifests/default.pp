# Update to the latest software
exec { "apt-get update":
  path => "/usr/bin",
}

# Install RabbitMQ
package { 'rabbitmq-server': ensure  => 'latest' }
package { 'git': ensure  => 'latest' }

# Start the RabbitMQ service
#service { "rabbitmq-server":
#  ensure  => "running",
#  require => Package["rabbitmq-server"],
#}


file { 'cookie':
path => '/var/lib/rabbitmq/.erlang.cookie',
mode => 0400,
owner => rabbitmq,
group => rabbitmq,
source => '/vagrant/cookie',
require => Package[rabbitmq-server]
}

file { 'profile':
path => '/home/vagrant/.bash_profile'
mode => 0400,
owner => vagrant,
group => vagrant,
source => '/vagrant/bash_profile',
require => Package[rabbitmq-server]
}



# Cluster Support
#
# Set up /etc/hosts so that all servers can communicate
#
host { 'rabbit1':
    ip => '192.168.33.11',
}
host { 'rabbit2':
    ip => '192.168.33.12',
}
host { 'rabbit3':
    ip => '192.168.33.13',
}

