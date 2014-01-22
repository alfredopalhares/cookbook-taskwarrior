require "emeril/rake"

require "kitchen/rake_tasks"
Kitchen::RakeTasks.new


begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
