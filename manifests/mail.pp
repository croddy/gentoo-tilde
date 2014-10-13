class tilde::mail {
  package { ['postfix', 'alpine']:
    ensure => installed,
  }

  file { '/etc/postfix/main.cf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/main.cf.erb"),
    notify  => Exec['postfix upgrade-configuration'],
  }

  exec { 'postfix upgrade-configration':
    refreshonly => true,
    path        => '/usr/sbin',
    notify      => Service['postfix'],
  }

  service { 'postfix':
    ensure => running,
    enable => true,
  }
}
