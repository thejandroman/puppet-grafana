require 'spec_helper'

describe 'grafana::install' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "#{osfamily}" do
        let(:facts) {{
                       :concat_basedir         => '/dne',
                       :osfamily               => osfamily,
                       :operatingsystemrelease => '12.04',
                     }}
        describe "with default params" do
          let(:pre_condition) {
            'class {\'grafana\': config_datasources => {} }'
          }

          it { should compile }

          it { should contain_class('grafana::install') }
          it { should contain_class('git') }
          it { should contain_class('apache') }

          it { should contain_vcsrepo('/opt/grafana') \
                       .with(
                         'ensure'   => 'present',
                         'provider' => 'git',
                         'source'   => 'https://github.com/grafana/grafana.git',
                         'revision' => 'v1.9.1'
                       ) \
                       .that_notifies('Class[apache::service]') }

          it { should contain_apache__vhost('grafana') \
                       .with(
                         'port'    => '80',
                         'docroot' => '/opt/grafana/src'
                       ) }
        end

        describe "without git or apache" do
          let(:pre_condition) {
            'class {\'grafana\':
               config_datasources => {},
               manage_git         => false,
               manage_ws          => false,
             }'
          }

          it { should compile }

          it { should_not contain_class('git') }
          it { should_not contain_class('apache') }

          it { should contain_vcsrepo('/opt/grafana') \
                       .with_owner('root') }

          it { should_not contain_apache__vhost('grafana') }
        end

        describe "without grafana repo" do
          let(:pre_condition) {
            'class {\'grafana\':
               config_datasources => {},
               manage_git_repository => false,
             }'
          }

          it { should compile }

          it { should_not contain_vcsrepo('/opt/grafana') }
        end

        describe "with custom params" do
          let(:pre_condition) {
            'class {\'grafana\':
               config_datasources  => {},
               graf_folder_owner   => \'foo\',
               graf_install_folder => \'/tmp/grafana\',
               graf_clone_url      => \'git@github.com:grafana/grafana.git\',
               graf_release        => \'foo\',
               ws_default_vhost    => true,
               ws_port             => \'443\',
               ws_servername       => \'foo\',
             }'
          }

          it { should compile }

          it { should contain_vcsrepo('/tmp/grafana') \
                       .with(
                         'source'   => 'git@github.com:grafana/grafana.git',
                         'revision' => 'foo',
                         'owner'    => 'foo'
                       ) }

          it { should contain_apache__vhost('foo') \
                       .with(
                         'port'          => '443',
                         'default_vhost' => true,
                         'docroot'       => '/tmp/grafana/src',
                         'docroot_owner' => 'foo'
                       ) }
        end
      end
    end
  end
end
