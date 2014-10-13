class tilde::mail {
  package { 'postfix':
    ensure => installed,
  }
}
