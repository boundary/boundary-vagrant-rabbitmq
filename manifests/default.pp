exec { "apt-get update":
  path => "/usr/bin",
}
package { "rabbitmq-server":
  ensure  => present,
  require => Exec["apt-get update"],
}
service { "rabbitmq-server":
  ensure  => "running",
  require => Package["rabbitmq-server"],
}
package { "openjdk-7-jre-headless":
  ensure  => present,
  require => Exec["apt-get update"],
}
package { "openjdk-7-jdk":
  ensure  => present,
  require => Exec["apt-get update"],
}
package { "maven2":
  ensure => present,
  require => Exec["apt-get update"],
}

#file { "/var/www/sample-webapp":
#  ensure  => "link",
#  target  => "/vagrant/sample-webapp",
#  require => Package["apache2"],
#  notify  => Service["apache2"],
#}
#$ git add manifests/default.pp
#$ git commit -m "Basic Puppet manifest"
