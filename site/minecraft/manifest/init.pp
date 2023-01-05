class minecraft {
  file { '/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///site/minecraft/minecraft.service',
  }
}
