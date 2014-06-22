require 'spec_helper'

describe 'grafana' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      let(:facts) {{
          :concat_basedir         => '/dne',
          :osfamily               => osfamily,
          :operatingsystemrelease => '12.04',
        }}
      describe "init class without params on #{osfamily}" do
        let(:params) {{ }}

        it { should compile }

        it { should contain_class('grafana') }
        it { should contain_class('grafana::params') }
        it { should contain_class('grafana::install').that_comes_before('grafana::config') }
        it { should contain_class('grafana::config') }
      end

      describe "init class with custom params on #{osfamily}" do
        let(:params) {{
            :config_datasources             => {},
            :config_default_route           => '/dashboard/file/foo.json',
            :config_ds_url                  => 'http://foo.bar',
            :config_elasticsearch           => 'http://foo.bar',
            :config_grafana_index           => 'grafana-foo',
            :config_panels                  => [ 'foo', 'bar' ],
            :config_playlist_timespan       => '5m',
            #:config_template                => 'grafana/foo.erb',
            :config_timezoneOffset          => '0000',
            :config_unsaved_changes_warning => false,
            :ensure                         => false,
            :graf_folder_owner              => 'thejandroman',
            :graf_install_folder            => '/tmp/grafana',
            :graf_release                   => 'foo',
            :manage_git                     => false,
            :manage_ws                      => false,
            :ws_port                        => '8080',
          }}

        it { should compile }
      end

      describe "bad config_datasources on #{osfamily}" do
        let(:params) {{ :config_datasources => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_default_route on #{osfamily}" do
        let(:params) {{ :config_default_route => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_ds_url on #{osfamily}" do
        let(:params) {{ :config_ds_url => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_elasticsearch on #{osfamily}" do
        let(:params) {{ :config_elasticsearch => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_grafana_index on #{osfamily}" do
        let(:params) {{ :config_grafana_index => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_panels on #{osfamily}" do
        let(:params) {{ :config_panels => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_playlist_timespan on #{osfamily}" do
        let(:params) {{ :config_playlist_timespan => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_template on #{osfamily}" do
        let(:params) {{ :config_template => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_timezoneOffset on #{osfamily}" do
        let(:params) {{ :config_timezoneOffset => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad config_unsaved_changes_warning on #{osfamily}" do
        let(:params) {{ :config_unsaved_changes_warning => 'true' }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad ensure on #{osfamily}" do
        let(:params) {{ :ensure => 'true' }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad graf_folder_owner on #{osfamily}" do
        let(:params) {{ :graf_folder_owner => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad graf_install_folder on #{osfamily}" do
        let(:params) {{ :graf_install_folder => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad graf_release on #{osfamily}" do
        let(:params) {{ :graf_release => true }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad manage_git on #{osfamily}" do
        let(:params) {{ :manage_git => 'true' }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad manage_ws on #{osfamily}" do
        let(:params) {{ :manage_ws => 'true' }}
        it { expect { should compile }.to raise_error }
      end

      describe "bad ws_port on #{osfamily}" do
        let(:params) {{ :ws_port => true }}
        it { expect { should compile }.to raise_error }
      end
    end
  end
end
