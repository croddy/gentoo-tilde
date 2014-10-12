define tilde::user (
  $ssh_key,
  $ssh_key_type,
) {
  $user = $title
  $userdir = "${tilde::document_root}/~${user}"

  user { $user:
    ensure     => present,
    groups     => $tilde::sitename,
    managehome => true,
  }

  file { $userdir:
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => '0755',
  }

  file { "/home/${user}/public_html":
    ensure => link,
    target => $userdir,
  }

  file { "/home/${user}/.ssh":
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => '0700',
  }

  ssh_authorized_key { "${user} signup key":
    ensure  => present,
    key     => $ssh_key,
    type    => $ssh_key_type,
    user    => $user,
    require => User[$user],
  }
}
