require 'spec_helper'

describe 'grafana::config' do
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
            'include grafana'
          }

          it { should compile }

          it { should contain_class('grafana::config') }

          it { should contain_file('/opt/grafana/src/config.js') \
                       .that_notifies('Class[apache::service]') }
        end

        describe "with custom datasources" do
          let(:pre_condition) {
            'class {\'grafana\':
               config_datasources => {
                 graphite      => {
                   type   => \'graphite\',
                   url    => "http://my.graphite.server.com:8080",
                 },
                 elasticsearch => {
                   type      => \'elasticsearch\',
                   url       => "http://my.elastic.server.com:9200",
                   index     => \'grafana-dash\',
                   grafanaDB => true,
                 }
               }
             }'
          }

          it { should compile }

          it { should contain_file('/opt/grafana/src/config.js') \
                       .with_content(/datasources: {
            elasticsearch: {
                grafanaDB: true,
                index: 'grafana-dash',
                type: 'elasticsearch',
                url: 'http:\/\/my.elastic.server.com:9200',
            },
            graphite: {
                type: 'graphite',
                url: 'http:\/\/my.graphite.server.com:8080',
            },
        },/) }
        end
      end
    end
  end
end
