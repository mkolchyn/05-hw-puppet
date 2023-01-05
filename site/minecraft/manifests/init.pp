class minecraft {
  file { '/opt/asdasdasdasdasdasdasd':
    ensure => directory,
  }
  file { '/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///site/minecraft/minecraft.service',
  }
}
