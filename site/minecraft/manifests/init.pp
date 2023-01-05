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
#  exec { 'init start server':
#    cwd     => '/opt/minecraft',
#    command => 'java -Xmx1024M -Xms1024M -jar server.jar --nogui',
#    path    => "/usr/bin",
#   require => Wget::retrieve['download minecraft server'],
#  }
#  file { '/opt/minecraft/eula.txt':
#    content => "eula=true",
#  }

  git::repo { 'clone mcrcon':
    path   => '/opt/minecraft/mcrcon',
    source => 'git://github.com/Tiiffi/mcrcon.git'
  }
#  vcsrepo { '/opt/minecraft/mcrcon':
#    ensure   => present,
#    provider => git,
#    source   => 'git://github.com/Tiiffi/mcrcon.git',
#  }
 
#  exec { 'make mcrcon':
#    cwd     => '/opt/minecraft/mcrcon',
#   command => 'make',
#   path    => "/usr/bin",
#   require => Exec['download mcrcon'],
# }
#  exec { 'install mcrcon':
#    cwd     => '/opt/minecraft/mcrcon',
#    path    => "/usr/bin",
#    require => Exec['make mcrcon'],
#  }
  
  
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
