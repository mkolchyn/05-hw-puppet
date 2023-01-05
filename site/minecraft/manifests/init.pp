class minecraft {


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
