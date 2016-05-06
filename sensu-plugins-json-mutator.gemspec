lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensu-plugins-json-mutator/version'

Gem::Specification.new do |s|
  s.name                   = 'sensu-plugins-json-mutator'
  s.version                = SensuPluginsJSONMutator::VERSION
  s.authors                = ['Sensu-Plugins and contributors', 'Yuri Artemev']
  s.email                  = 'i@artemeff.com'

  s.summary                = 'Sensu plugin for mutating Graphite and Statsd output'
  s.homepage               = 'https://github.com/artemeff/sensu-plugins-json-mutator'

  s.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md)
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => '@artemeff',
                               'development_status' => 'active',
                               'production_status'  => 'unstable - testing recommended',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false'
                              }

  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 1.9.3'

  s.add_runtime_dependency 'sensu-plugin', '~> 1.2'

  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake',    '~> 10.0'
  s.add_development_dependency 'rspec',   '~> 3.1'
  s.add_development_dependency 'rubocop', '~> 0.37'
end
