require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'
require 'rspec'
require 'rspec/core/rake_task'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/*_spec.rb', 'lib/cachet.rb']
  t.verbose = true
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/*_spec.rb')
end

YARD::Rake::YardocTask.new do |t|
  t.options = ['--markup-provider=redcarpet', '--markup=markdown']
end

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -I lib -r cachet.rb'
end

desc 'Common task'
task all: [:test, :spec]

task :default => :test
