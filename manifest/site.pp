node mineserver.puppet {
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
  package { 'httpd':
    ensure => installed,
    name   => httpd,
  }  
}
