require 'bundler/gem_tasks'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

desc 'Make all plugins executable'
task :make_bin_executable do
  `chmod -R +x bin/*`
end
