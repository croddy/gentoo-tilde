# == Class: tilde
#
# Full description of class tilde here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'tilde':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class tilde (
  $irc_channel,
  $local_packages,
  $site_name,
  $site_group,
  $users,
  $users_defaults,
) {

  include ::thttpd

  include ::tilde::quota
  include ::tilde::mail

  package { $local_packages:
    ensure => installed,
  }

  # users and groups
  group { $site_group:
    ensure => present,
    gid    => 9001,
  }

  create_resources(tilde::user, $users, $users_defaults)

  # main index assembly
  $tilde_index = "${thttpd::document_root}/index.html"

  concat { $tilde_index:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment { 'tilde index header':
    target  => $tilde_index,
    content => template("${module_name}/index_header.html.erb"),
    order   => '0001',
  }
  concat::fragment { 'tilde index footer':
    target  => $tilde_index,
    content => template("${module_name}/index_footer.html.erb"),
    order   => '9001',
  }

}
