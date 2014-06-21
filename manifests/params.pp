# == Class grafana::params
#
# This class is meant to be called from grafana
# It sets variables according to platform
#
class grafana::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'grafana'
      $service_name = 'grafana'
    }
    'RedHat', 'Amazon': {
      $package_name = 'grafana'
      $service_name = 'grafana'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
