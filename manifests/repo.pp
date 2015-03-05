#
# == Class gluster::repo
#
# enables an upstream GlusterFS repository
#
# Note that this module is a wrapper for sub-classes that implement
# the specific repository type, ie:  gluster::repo::yum
#
# === Parameters
#
# version: the version of the upstream repo to enable
#
# === Examples
#
# class { ::gluster::repo
#   version => '3.5.2',
# }
#
# === Authors
#
# Scott Merrill <smerrill@covermymeds.com>
#
# === Copyright
#
# Copyright 2014 CoverMyMeds, unless otherwise noted
#
class gluster::repo (
  $version = $::gluster::params::version,
) inherits ::gluster::params {
  case $::osfamily {
    'RedHat': {
      class { '::gluster::repo::yum':
        version => $version
      }
    }

    'Debian': {
      case $::operatingsystem {

	'Debian': {
	  class { '::gluster::repo::apt':
	    version => $version,
	  }
	}

	'Ubuntu': {
	  class { '::gluster::repo::ppa':
	    repo_ppa	      => $repo_ppa,
	    repo_ppa_version  => $repo_ppa_version,
	  }
	}
      }
    }

    default: { fail("${::osfamily} not yet supported!") }
  }
}
