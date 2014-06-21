# == Class: grafana
#
# Full description of class grafana here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class grafana (
  $package_name = $grafana::params::package_name,
  $service_name = $grafana::params::service_name,
) inherits grafana::params {

  # validate parameters here

  class { 'grafana::install': } ->
  class { 'grafana::config': } ~>
  class { 'grafana::service': } ->
  Class['grafana']
}
