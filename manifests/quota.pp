class tilde::quota {
  package { 'quota':
    ensure => installed,
  }

  exec { 'quotas':
    command => '/usr/sbin/quotacheck -cum /',
    creates => '/aquota.user',
    cwd => '/',
    notify => Exec['quotaon'],
  }

  exec { 'quotaon':
    command => '/sbin/quotaon /',
    refreshonly => true,
  }
}
