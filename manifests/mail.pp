class tilde::mail {
  package { ['postfix', 'alpine']:
    ensure => installed,
  }
}
