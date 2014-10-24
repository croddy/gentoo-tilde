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
    notify  => Exec['newaliases'],
  }

  file { '/var/spool/mail':
    ensure => directory,
    owner  => 'mail',
    group  => 'root',
    mode   => '1777',
  }
  exec { 'newaliases':
    command     => 'newaliases',
    refreshonly => true,
    path        => '/usr/bin',
    notify      => Exec['upgrade postfix config'],
  }

  exec { 'postfix upgrade config':
    command     => 'postfix upgrade-configuration',
    refreshonly => true,
    path        => '/usr/sbin',
    notify      => Service['postfix'],
  }

  service { 'postfix':
    ensure => running,
    enable => true,
  }

  $users = join(keys(hiera('tilde::users'), ', ')

  file_line { 'all@ alias':
    path   => '/etc/aliases',
    line   => "all: ${users}",
    match  => '^all: ',
    notify => Exec['newaliases'],
  }
}
