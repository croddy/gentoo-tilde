class tilde::facts {
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/facter/facts.d/recent_emerges.sh':
    source => "puppet:///modules/${module_name}/recent_emerges.sh",
  }

  file { '/etc/facter/facts.d/recent_users.sh':
    source => "puppet:///modules/${module_name}/recent_users.sh",
  }
}
