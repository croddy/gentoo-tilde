define tilde::user (
  $ssh_key,
  $ssh_key_type,
) {
  $user = $title
  $userdir = "${thttpd::document_root}/~${user}"

  user { $user:
    ensure     => present,
    groups     => $tilde::site_name,
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

  file { "${userdir}/index.html":
    ensure  => file,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    content => template("${module_name}/index.html.erb"),
    replace => false,
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
