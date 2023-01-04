node mineserver.puppet{
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
  include minecraft
}
