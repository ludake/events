#!/usr/bin/env ruby -w
 
#
# config/puma.rb
#
 
rails_env = ENV['RAILS_ENV'] || 'production'
 
threads 4, 4

app_dir = File.expand_path("../..", __FILE__) 
bind 'unix:///myraid10/var/www/tmp/events.sock'
pidfile '/myraid10/var/run/events/events.pid'
state_path '/myraid10/var/run/events/events.state'

#on_worker_boot do
#  require "active_record"
#  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
#  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
#end

 
activate_control_app
