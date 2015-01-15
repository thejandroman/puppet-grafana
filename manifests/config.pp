# == Private Class grafana::config
#
# This class is called from grafana
#
class grafana::config {
  file { "${::grafana::graf_install_folder}/src/config.js":
    ensure  => present,
    content => template($::grafana::config_template),
    owner   => $::grafana::install::_ws_user,
  }

  if $::grafana::manage_ws {
    File["${::grafana::graf_install_folder}/src/config.js"] ~>
    Class['::apache::service']
  }
}
