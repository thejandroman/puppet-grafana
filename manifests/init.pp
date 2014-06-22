# == Public Class: grafana
#
# Full description of class grafana here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class grafana (
  $config_datasources             = $::grafana::params::config_datasources,
  $config_default_route           = $::grafana::params::config_default_route,
  $config_ds_url                  = $::grafana::params::config_ds_url,
  $config_elasticsearch           = $::grafana::params::config_elasticsearch,
  $config_grafana_index           = $::grafana::params::config_grafana_index,
  $config_panels                  = $::grafana::params::config_panels,
  $config_playlist_timespan       = $::grafana::params::config_playlist_timespan,
  $config_template                = $::grafana::params::config_template,
  $config_timezoneOffset          = $::grafana::params::config_timezoneOffset,
  $config_unsaved_changes_warning = $::grafana::params::config_unsaved_changes_warning,
  $ensure                         = $::grafana::params::ensure,
  $graf_folder_owner              = $::grafana::params::graf_folder_owner,
  $graf_install_folder            = $::grafana::params::graf_install_folder,
  $graf_release                   = $::grafana::params::graf_release,
  $manage_git                     = $::grafana::params::manage_git,
  $manage_ws                      = $::grafana::params::manage_ws,
  $ws_port                        = $::grafana::params::ws_port,
) inherits grafana::params {

  validate_array($config_panels)
  validate_bool($config_unsaved_changes_warning)
  validate_bool($ensure)
  validate_bool($manage_git)
  validate_bool($manage_ws)
  validate_string($config_default_route)
  validate_string($config_ds_url)
  validate_string($config_elasticsearch)
  validate_string($config_grafana_index)
  validate_string($config_playlist_timespan)
  validate_string($config_template)
  validate_string($config_timezoneOffset)
  validate_string($graf_install_folder)
  validate_string($graf_release)
  validate_string($ws_port)

  if $config_datasources {
    validate_hash($config_datasources)
    $_datasources = $config_datasources
  }
  else {
    $_datasources = {
      'graphite' => {
        'type'    => 'graphite',
        'url'     => $config_ds_url,
        'default' => true,
      }
    }
  }

  if $::grafana::graf_folder_owner {
    validate_string($graf_folder_owner)
    $_ws_user = $::grafana::graf_folder_owner
  } elsif $::grafana::manage_ws {
    $_ws_user = $::apache::params::user
  } else {
    $_ws_user = 'root'
  }

  class { 'grafana::install': } ->
  class { 'grafana::config': } ->
  Class['grafana']
}
