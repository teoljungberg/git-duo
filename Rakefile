require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end
task :default => :test

desc 'Setup a new dev computer'
task newb: [:install_deps, :install, :test] do
  puts
  puts 'Happy hacking'
end

task :install_deps do
  puts '--- installing dependencies'
  system 'bundle install'
end
