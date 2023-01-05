class minecraft {
  package {  'java':
    name   => java-17-openjdk,
    ensure => present,
  }
  file { '/opt/minecraft':
    ensure => directory,
  }
  wget::retrieve { "download minecraft server":
    source      => 'https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar',
    destination => '/opt/minecraft/',
    timeout     => 0,
    verbose     => false,
    require => File['/opt/minecraft'],  
  }

  file { '/opt/minecraft/server.properties':
    ensure => file,
    source => 'puppet:///modules/minecraft/server.properties',
  }
  file { '/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraft/minecraft.service',
    require => File['/opt/minecraft/server.properties'],    
  }
  service { 'minecraft.service':
    ensure => running,
    enable => true,
    require => File['/etc/systemd/system/minecraft.service'],
  }
}
