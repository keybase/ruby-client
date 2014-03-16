require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new("unit") do |t|
  t.libs << 'test'
  t.pattern = "#{File.dirname(__FILE__)}/test/all.rb"
end

desc "Run tests"
task :default => :unit