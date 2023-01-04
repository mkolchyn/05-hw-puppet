class minecraft {
  package {  'java':
    name => java-17-openjdk.x86_64
    ensure => present,
  }
  
#  file { '/etc/systemd/system/minecraft.service':
#    ensure => file,
#    source => 'puppet:///modules/minecraft/minecraft.service',
#  }
  
  file { '/opt/minecraft':
    ensure => directory,
  }
  
  
  
}
