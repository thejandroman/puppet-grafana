notification :off

guard 'rake', :task => 'test' do
  watch(%r{^manifests\/(.+)\.pp$})
end

group :specs do
  guard 'rake', :task => 'spec' do
    ignore %r{^spec/classes/\.\#.*}
    watch(%r{^spec/classes/.+_spec\.rb})
  end
end
