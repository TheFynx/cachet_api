require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rspec'
require 'rspec/core/rake_task'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb', 'lib/cachet.rb']
  t.verbose = true
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/*_spec.rb')
end

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'ruby -I lib ./bin/console.rb'
end

desc 'Common task'
task all: [:test, :spec]

task default: :test
