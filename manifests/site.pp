package { 'wget': ensure  => 'latest' }
package { 'curl': ensure  => 'latest' }

class { 'boundary':
    token => $api_token,
}

# Start the RabbitMQ service
#service { "rabbitmq-server":
#  ensure  => "running",
#  before => Exec[enable-management-plugin],
#  require => Package[rabbitmq-server],
#}

class { 'rabbitmq':
  service_manage    => false,
  port              => '5672',
  require => Exec["update-packages"],
}

# Prequiste for the latest Nodejs
#exec { "enable-management-plugin":
#  command => "/usr/bin/sudo /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management",
#  path => "/vagrant",
#  require => Package[rabbitmq-server]
#}

# Install Pip library for python modules
#exec { "install-pip":
#  command => "/usr/bin/python /vagrant/get-pip.py",
#  path => "/vagrant",
#  require => Package[rabbitmq-server]
#}

file { 'profile':
path => '/home/vagrant/.bash_profile',
mode => 0400,
owner => vagrant,
group => vagrant,
source => '/vagrant/bash_profile',
#require => Package[rabbitmq-server]
}

node /^centos-7.0/ {
  exec { 'update-packages':
    command => '/usr/bin/yum update -y',
  }
}

node /^centos-6.6/ {
  exec { 'update-packages':
    command => '/usr/bin/yum update -y',
  }

}

node /^ubuntu/ {

  exec { 'update-packages':
    command => '/usr/bin/apt-get update -y',
  }

}
