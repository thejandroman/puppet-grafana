require 'spec_helper'

describe 'grafana' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "#{osfamily}" do
        let(:facts) {{
                       :concat_basedir         => '/dne',
                       :osfamily               => osfamily,
                       :operatingsystemrelease => '12.04',
                     }}
        describe "init class without params" do
          let(:params) {{ }}

          it { should compile }

          it { should contain_class('grafana') }
          it { should contain_class('grafana::params') }
          it { should contain_class('grafana::install') \
                       .that_comes_before('grafana::config') }
          it { should contain_class('grafana::config') }
        end

        describe "init class with custom params" do
          let(:params) {{
                          :config_datasources             => {},
                          :config_default_route           => '/dashboard/file/foo.json',
                          :config_plugins_panels          => [ 'foo', 'bar' ],
                          :config_playlist_timespan       => '5m',
                          #:config_template                => 'grafana/foo.erb',
                          :config_unsaved_changes_warning => false,
                          :ensure                         => false,
                          :graf_clone_url                 => 'git@github.com:grafana/grafana.git',
                          :graf_folder_owner              => 'thejandroman',
                          :graf_install_folder            => '/tmp/grafana',
                          :graf_release                   => 'foo',
                          :manage_git                     => false,
                          :manage_ws                      => false,
                          :ws_port                        => '8080',
                          :ws_servername                  => 'foobar',
                        }}

          it { should compile }
        end

        describe "bad config_datasources" do
          let(:params) {{ :config_datasources => true }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad config_default_route" do
          let(:params) {{ :config_default_route => true }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad config_playlist_timespan" do
          let(:params) {{ :config_playlist_timespan => true }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad config_template" do
          let(:params) {{ :config_template => true }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad config_unsaved_changes_warning" do
          let(:params) {{ :config_unsaved_changes_warning => 'true' }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad ensure" do
          let(:params) {{ :ensure => 'true' }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad graf_folder_owner" do
          let(:params) {{ :graf_folder_owner => true }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad graf_install_folder" do
          let(:params) {{ :graf_install_folder => true }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad graf_release" do
          let(:params) {{ :graf_release => true }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad manage_git" do
          let(:params) {{ :manage_git => 'true' }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad manage_ws" do
          let(:params) {{ :manage_ws => 'true' }}
          it { expect { should compile }.to raise_error }
        end

        describe "bad ws_port" do
          let(:params) {{ :ws_port => true }}
          it { expect { should compile }.to raise_error }
        end
      end
    end
  end
end
