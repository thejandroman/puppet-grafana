# == Private Class grafana::install
#
# This class is called from grafana
#
class grafana::install {
  if $::grafana::manage_git {
    require 'git'
  }

  if $::grafana::manage_ws {
    class { 'apache':
      default_vhost => false,
    }
  }

  vcsrepo { $::grafana::graf_install_folder:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/grafana/grafana.git',
    revision => $::grafana::graf_release,
    owner    => $::grafana::_ws_user,
  }

  if $::grafana::manage_ws {
    apache::vhost { 'grafana':
      port          => $::grafana::ws_port,
      docroot       => "${::grafana::graf_install_folder}/src",
      docroot_owner => $::grafana::_ws_user,
    }

    Vcsrepo[$::grafana::graf_install_folder] ~> Class['::Apache::Service']
  }
}
