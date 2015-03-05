# == Class gluster::repo::apt
#
# enable the Glusterfs PPA for Ubuntu systems
#
# === Parameters
#
# version: the version to use when building the repo URL
#
# Currently only released versions are supported.  If you want to use
# QA releases or pre-releases, you'll need to edit line 54 below

# === Examples
#
# Enable the Apt repo, and use the public key
# 
# class { gluster::repo::ppa: 
#   repo_ppa	      => 'gluster/glusterfs',
#   repo_ppa_version  => '3.6',
# }
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#
# === Copyright
#
# Copyright 2014 CoverMyMeds, unless otherwise noted
#
class gluster::repo::ppa (
  $repo_ppa	    = $::gluster::params::repo_ppa,
  $repo_ppa_version = $::gluster::params::repo_ppa_version,
) {

  include ::apt

  # Add Glusterfs PPA
  apt::ppa { "ppa:${repo_ppa}-${repo_ppa_version}": }

  Apt::Ppa["ppa:${repo_ppa}-${repo_ppa_version}"] -> Package <| tag == 'gluster-packages' |>
}
