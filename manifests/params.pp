# == Class grafana::params
#
# This class is meant to be called from grafana
# It sets variables according to platform
#
class grafana::params {
  $config_admin_password          = ''
  $config_default_route           = '/dashboard/file/default.json'
  $config_playlist_timespan       = '1m'
  $config_plugins_dependencies    = []
  $config_plugins_panels          = []
  $config_search_max_results      = '100'
  $config_template                = 'grafana/config.js.erb'
  $config_unsaved_changes_warning = true
  $config_window_title_prefix     = 'Grafana - '

  $ensure = true

  # If $graf_folder_owner remains 'undef' it defaults to one of two case
  # if $manage_ws = 'false'; $graf_folder_owner = 'root'
  # if $manage_ws = 'true'; $graf_folder_owner = $::apache::params::user
  $graf_clone_url      = 'https://github.com/grafana/grafana.git'
  $graf_folder_owner   = undef
  $graf_install_folder = '/opt/grafana'
  $graf_release        = 'v1.9.1'

  $manage_git = true
  $manage_git_repository = true

  $manage_ws        = true
  $ws_default_vhost = false
  $ws_port          = '80'
  $ws_servername    = 'grafana'
}
