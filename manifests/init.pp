# == Public Class: grafana
#
# Installs and configure grafana.
#
# === Parameters
#
# [* config_admin_password *]
# The purpose of this password is not security, but to stop some users from
# accidentally changing dashboards.
#
# [* config_datasources *]
# The datasources property defines your metric, annotation and dashboard storage
# backends. See [grafana documentation](http://grafana.org/docs#configuration).
#
# [* config_default_route *]
# The default start dashboard.
#
# [* config_playlist_timespan *]
# Set the default timespan for the playlist feature. Example: "1m", "1h"
#
# [* config_plugins_dependencies *]
# requirejs modules in plugins folder that should be loaded; for example custom
# datasources.
#
# [* config_plugins_panels *]
# List of plugin panels.
#
# [* config_search_max_results *]
# Specify the limit for dashboard search results.
#
# [* config_template *]
# The erb template to build config.js.
#
# [* config_unsaved_changes_warning *]
# Set to false to disable unsaved changes warning.
#
# [* config_window_title_prefix *]
# Change window title prefix from 'Grafana - <dashboard title>'.
#
# [* graf_clone_url *]
# URL for the grafana git repo.
#
# [* graf_folder_owner *]
# The owner of the grafana install located at graf_install_folder. If
# graf_folder_owner remains 'undef' it defaults to one of two cases:
#  * if manage_ws => false then graf_folder_owner => 'root'
#  * if manage_ws => true then graf_folder_owner => $::apache::params::user
#
# [* graf_install_folder *]
# The folder to install grafana into.
#
# [* graf_release *]
# A tag or branch from the [grafana](https://github.com/grafana/grafana) repo.
#
# [* manage_git *]
# Should the module manage git.
#
# [* manage_git_repository *]
# Should the module manage grafana git repository.
#
# [* manage_ws *]
# Should the module manage the webserver.
#
# [* ws_default_vhost *]
# Attempt to make the grafana vhost the default. Only taken into account if
# manage_ws => true.
#
# [* ws_port *]
# Change the default port for the webserver to a custom value. Only taken into
# account if `manage_ws => true`.
#
# [* ws_servername *]
# Change the default servername for the apache vhost. Only taken into account if
# manage_ws => true.
#
class grafana (
  $config_admin_password          = $::grafana::params::config_admin_password,
  $config_datasources,
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
  $manage_git_repository          = $::grafana::params::manage_git_repository,
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
  $manage_git_repository,
  $manage_ws,
  $ws_default_vhost)

  validate_hash($config_datasources)

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
