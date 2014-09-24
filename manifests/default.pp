# Update to the latest software
exec { "apt-get update":
  path => "/usr/bin",
}

# Install RabbitMQ
package { "rabbitmq-server":
  ensure  => present,
  require => Exec["apt-get update"],
}

# Start the RabbitMQ service
service { "rabbitmq-server":
  ensure  => "running",
  require => Package["rabbitmq-server"],
}

# Cluster Support
#
# Set up /etc/hosts so that all servers can communicate
#
host { 'boundary-rabbitmq-01':
    ip => '192.168.33.11',
}
host { 'boundary-rabbitmq-02':
    ip => '192.168.33.11',
}
host { 'boundary-rabbitmq-03':
    ip => '192.168.33.11',
}

