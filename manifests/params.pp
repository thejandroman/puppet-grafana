# == Class grafana::params
#
# This class is meant to be called from grafana
# It sets variables according to platform
#
class grafana::params {
  $config_template                = 'grafana/config.js.erb'
  $config_datasources             = undef
  $config_default_route           = '/dashboard/file/default.json'
  $config_ds_url                  = ''
  $config_elasticsearch           = 'http://"+window.location.hostname+":9200'
  $config_grafana_index           = 'grafana-dash'
  $config_panels                  = []
  $config_playlist_timespan       = '1m'
  $config_timezoneOffset          = 'null'
  $config_unsaved_changes_warning = true

  $ensure = true

  # If $graf_folder_owner remains 'undef' it defaults to one of two case:
  # if $manage_ws = 'false'; $graf_folder_owner = 'root'
  # if $manage_ws = 'true'; $graf_folder_owner = $::apache::params::user
  $graf_folder_owner   = undef
  $graf_install_folder = '/opt/grafana'
  $graf_release        = '810f46c450'

  $manage_git = true

  $manage_ws = true
  $ws_port   = '80'
}
