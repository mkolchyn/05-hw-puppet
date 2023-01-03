node master {
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
  file { '/etc/puppetlabs/puppet/puppet.conf':
    content => "autosign = true\n\n[agent]\nserver = master\nruninterval = 1m",
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
