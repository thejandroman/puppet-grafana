# == Class grafana::install
#
class grafana::install {

  package { $grafana::package_name:
    ensure => present,
  }
}
