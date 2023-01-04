node master {
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
 
  include nginx
  
  nginx::resource::server { '192.168.50.25':
    listen_port => 80,
    proxy => 'http://192.168.50.26',
  }
  
  nginx::resource::server { '192.168.50.25:81':
    listen_port => 81,
    proxy => 'http://192.168.50.27',
  }
}

node slave1 {
  package { 'httpd':
    ensure => installed,
    name   => httpd,
  }
  file { '/var/www/html/index.html':
    ensure => present,
    source => "/vagrant/index.html",
  }
  service { 'httpd':
    ensure => running,
    enable => true,
  }
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
}

node slave2 {
  package { 'httpd':
    ensure => installed,
    name   => httpd,
  }
  package { 'php':
    ensure => installed,
    name   => php,
  }
  file { '/var/www/html/index.php':
    ensure => present,
    source => "/vagrant/index.php",
  }
  service { 'php-fpm':
    ensure => running,
    enable => true,
  }
  service { 'httpd':
    ensure => running,
    enable => true,
  }
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
}

node mineserver.puppet {
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
  package {  'java':
    name   => java-17-openjdk,
    ensure => present,
  }
  file { '/opt/minecraft':
    ensure => directory,
  }
  exec { 'download minecraft server':
    cwd     => '/opt/minecraft',
    command => 'wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar',
    path    => "/usr/bin",
    require => File['/opt/minecraft'],  
  }
  exec { 'init start server':
    cwd     => '/opt/minecraft',
    command => 'java -Xmx1024M -Xms1024M -jar server.jar --nogui',
    path    => "/usr/bin",
    require => Exec['download minecraft server'],
  }
  file { '/opt/minecraft/eula.txt':
    content => "eula=true",
  }
  exec { 'download mcrcon':
    cwd     => '/opt/minecraft',
    command => 'git clone https://github.com/Tiiffi/mcrcon.git',
    path    => "/usr/bin",
    require => Exec['download minecraft server'],
  }  
  exec { 'make mcrcon':
    cwd     => '/opt/minecraft/mcrcon',
    command => 'make',
    path    => "/usr/bin",
    require => Exec['download mcrcon'],
  }
  exec { 'install mcrcon':
    cwd     => '/opt/minecraft/mcrcon',
    command => 'make install',
    path    => "/usr/bin",
    require => Exec['make mcrcon'],
  }
}
