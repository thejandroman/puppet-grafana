require 'puppet/version'
require 'puppet/vendor/semantic/lib/semantic' unless Puppet.version.to_f <3.6
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

# These two gems aren't always present, for instance
# on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

exclude_paths = [
  "bundle/**/*",
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.disable_checks = [
    '80chars',
    'autoloader_layout',
    'class_parameter_defaults',
    'class_inherits_from_params_class',
  ]

  config.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
  config.fail_on_warnings = true

  config.ignore_paths = exclude_paths
end

PuppetSyntax.exclude_paths = exclude_paths

desc "Run acceptance tests"
RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

task :metadata do
  sh "metadata-json-lint metadata.json"
end

desc "Run syntax, lint, and spec tests."
task :test => [
  :syntax,
  :lint,
  :spec,
  :metadata,
]
