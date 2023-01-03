node master {
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
 
  include nginx
  
  nginx::resource::server { '1kibana.myhost.com':
    listen_port => 80,
    proxy => 'http://192.168.50.26:80',
  }
  
  nginx::resource::server { '2kibana.myhost.com':
    listen_port => 81,
    proxy => 'http://192.168.50.27:80',
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
