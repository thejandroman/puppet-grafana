# == Private Class grafana::install
#
# This class is called from grafana
#
class grafana::install {
  if $::grafana::manage_git {
    require 'git'
  }

  if $::grafana::manage_ws {
    include ::apache
  }

  if $::grafana::graf_folder_owner {
    $_ws_user = $::grafana::graf_folder_owner
  }
  elsif $::grafana::manage_ws {
    $_ws_user = $::apache::params::user
  }
  else {
    $_ws_user = 'root'
  }

  if $::grafana::manage_git_repository {
    vcsrepo { $::grafana::graf_install_folder:
      ensure   => present,
      provider => git,
      source   => $::grafana::graf_clone_url,
      revision => $::grafana::graf_release,
      owner    => $_ws_user,
    }
  }

  if $::grafana::manage_ws {
    apache::vhost { $::grafana::ws_servername:
      port          => $::grafana::ws_port,
      default_vhost => $::grafana::ws_default_vhost,
      docroot       => "${::grafana::graf_install_folder}/src",
      docroot_owner => $_ws_user,
    }

    if $::grafana::manage_git_repository and $::grafana::manage_ws {
      Vcsrepo[$::grafana::graf_install_folder] ~> Class['::apache::service']
    }
  }
}
