# == Class grafana::service
#
# This class is meant to be called from grafana
# It ensure the service is running
#
class grafana::service {

  service { $grafana::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
