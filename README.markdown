#grafana [![Build Status](https://travis-ci.org/thejandroman/puppet-grafana.svg?branch=master)](https://travis-ci.org/thejandroman/puppet-grafana)

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Examples](#examples)
4. [Usage](#usage)
    * [Classes](#classes)
      * [grafana](#class-grafana)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [License](#license)

##Overview
The grafana puppet module allows one to setup and configure the [grafana](http://grafana.org) dashboard.

##Module Description
This module should cover all configuration options for grafana v1.9.x.

This module checks out the [grafana source](https://github.com/grafana/grafana) directly from github and requires git to be installed. By default this module will install git via the [puppetlabs/git](https://github.com/puppetlabs/puppetlabs-git) module. This behavior can be disabled.

Grafana requires a webserver to serve its content. By default this module will install apache via the [puppetlabs/apache](https://github.com/puppetlabs/puppetlabs-apache) module. This behavior can be disabled.

##Setup
The grafana module requires that `config_datasources` be specified. For a description of the different granafa configuration options see [grafana's documentation](http://grafana.org/docs#configuration). To disable managing of git or apache see options below.

###Examples
To install grafana accepting all default options:

```puppet
  class { 'grafana':
    config_datasources => {
      graphite      => {
        type => 'graphite',
        url  => 'http://my.graphite.server.com:8080',
      },
      elasticsearch => {
        type      => 'elasticsearch',
        url       => 'http://my.elastic.server.com:9200',
        index     => 'grafana-dash',
        grafanaDB => true,
      }
    }
  }
```

To disable webserver and git management:

```puppet
class { 'grafana':
    config_datasources => { ... },
    manage_ws          => false,
    manage_git         => false,
  }
```

##Usage
###Classes
####Class: `grafana`
#####`config_admin_password`
**Data Type:** _string_
**Default:** _''_
The purpose of this password is not security, but to stop some users from accidentally changing dashboards.

#####`config_datasources`
**Data Type:** _hash_
**Default:** _undef_
The datasources property defines your metric, annotation and dashboard storage backends. See [grafana documentation](http://grafana.org/docs#configuration).

#####`config_default_route`
**Data Type:** _string_
**Default:** _/dashboard/file/default.json_
The default start dashboard.

#####`config_playlist_timespan`
**Data Type:** _string_
**Default:** _1m_
Set the default timespan for the playlist feature. Example: "1m", "1h"

#####`config_plugins_dependencies`
**Data Type:** _array_
**Default:** _[]_
requirejs modules in plugins folder that should be loaded; for example custom datasources.

#####`config_plugins_panels`
**Data Type:** _array_
**Default:** _[]_
List of plugin panels.

#####`config_search_max_results`
**Data Type:** _string_
**Default:** _100_
Specify the limit for dashboard search results.

#####`config_template`
**Data Type:** _string_
**Default:** _grafana/config.js.erb_
The erb template to build config.js.

#####`config_unsaved_changes_warning`
**Data Type:** _bool_
**Default:** _true_
Set to false to disable unsaved changes warning.

#####`config_window_title_prefix`
**Data Type:** _string_
**Default:** _Grafana - _
Change window title prefix from 'Grafana - <dashboard title>'.

##### `graf_clone_url`
**Data Type:** _string_
**Default:** _https://github.com/grafana/grafana.git_
URL for the grafana git repo.

#####`graf_folder_owner`
**Data Type:** _string_
**Default:** _undef_
The owner of the grafana install located at `graf_install_folder`. If `graf_folder_owner` remains 'undef' it defaults to one of two cases:
 * if `manage_ws => false` then `graf_folder_owner => 'root'`
 * if `manage_ws => true` then `graf_folder_owner => $::apache::params::user`

#####`graf_install_folder`
**Data Type:** _string_
**Default:** _/opt/grafana_
The folder to install grafana into.

#####`graf_release`
**Data Type:** _string_
**Default:** _v1.9.1_
A tag or branch from the [grafana](https://github.com/grafana/grafana) repo.

#####`manage_git`
**Data Type:** _bool_
**Default:** _true_
Should the module manage git.

#####`manage_git_repository`
**Data Type:** _bool_
**Default:** _true_
Should the module manage grafana git repository.

#####`manage_ws`
**Data Type:** _bool_
**Default:** _true_
Should the module manage the webserver.

#####`ws_default_vhost`
**Data Type:** _bool_
**Default:** _false_
Attempt to make the grafana vhost the default. Only taken into account if `manage_ws => true`.

#####`ws_port`
**Data Type:** _string_
**Default:** _80_
Change the default port for the webserver to a custom value. Only taken into account if `manage_ws => true`.

#####`ws_servername`
**Data Type:** _string_
**Default:** _grafana_
Change the default servername for the apache vhost. Only taken into account if `manage_ws => true`.

##Limitations
 * Tested and built on Ubuntu 12.04.
 * Tested with grafana v1.9.1.

##Contributing
Pull requests are welcome. Please document and include rspec tests.

##License
See [LICENSE](https://github.com/thejandroman/grafana/blob/master/LICENSE) file.
