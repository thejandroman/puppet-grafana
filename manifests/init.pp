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
  $config_admin_password          = $::grafana::params::config_admin_password,
  $config_datasources             = $::grafana::params::config_datasources,
  $config_default_route           = $::grafana::params::config_default_route,
  $config_playlist_timespan       = $::grafana::params::config_playlist_timespan,
  $config_plugins_dependencies    = $::grafana::params::config_plugins_dependencies,
  $config_plugins_panels          = $::grafana::params::config_plugins_panels,
  $config_search_max_results      = $::grafana::params::config_search_max_results,
  $config_template                = $::grafana::params::config_template,
  $config_unsaved_changes_warning = $::grafana::params::config_unsaved_changes_warning,
  $config_window_title_prefix     = $::grafana::params::config_window_title_prefix,
  $ensure                         = $::grafana::params::ensure,
  $graf_clone_url                 = $::grafana::params::graf_clone_url,
  $graf_folder_owner              = $::grafana::params::graf_folder_owner,
  $graf_install_folder            = $::grafana::params::graf_install_folder,
  $graf_release                   = $::grafana::params::graf_release,
  $manage_git                     = $::grafana::params::manage_git,
  $manage_ws                      = $::grafana::params::manage_ws,
  $ws_default_vhost               = $::grafana::params::ws_default_vhost,
  $ws_port                        = $::grafana::params::ws_port,
  $ws_servername                  = $::grafana::params::ws_servername,
  ) inherits grafana::params {

  validate_array($config_plugins_dependencies,
  $config_plugins_panels)

  validate_bool($config_unsaved_changes_warning,
  $ensure,
  $manage_git,
  $manage_ws,
  $ws_default_vhost)

  if ($config_datasources) {
    validate_hash($config_datasources)
  }

  validate_string($config_admin_password,
  $config_default_route,
  $config_playlist_timespan,
  $config_search_max_results,
  $config_template,
  $config_window_title_prefix,
  $graf_clone_url,
  $graf_folder_owner,
  $graf_install_folder,
  $graf_release,
  $ws_port,
  $ws_servername)

  class { 'grafana::install': } ->
  class { 'grafana::config': } ->
  Class['grafana']
}
