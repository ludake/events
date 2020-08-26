# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "events"
set :repo_url, "git@github.com:ludake/events.git"


role :web, domain                         
role :app, domain                         
role :db,  domain


set :default_environment,{
  'PATH' => '$PATH:/usr/local/bin:/usr/bin:/bin',
  'GEM_PATH' => '~/.gem/ruby/2.5.0:/usr/lib64/ruby/gems/2.5.0'

}
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :deploy_to, '/myraid10/var/www/pylontqi/public/events/public/'

# Default value for :scm is :git

set :user,            'ludake'
set :domain,          'pylontqi.mynetgear.com'

# Default value for :format is :pretty
 set :format, :pretty

# Default value for :log_level is :debug
 set :log_level, :debug

# Default value for :pty is false
# set :pty, true


set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.ruby-version', '.ruby-gemset')
# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')


# Default value for keep_releases is 5
set :keep_releases, 5





set :puma_threads,    [4, 16]
set :puma_workers,    4

# Don't change these unless you know what you're doing
set :pty,             true

set :stage,           :staging
set :deploy_via,      :remote_cache
set :deploy_to,       "/myraid10/var/www/pylontqi/public/events"
set :puma_bind,       "unix:///myraid10/var/www/tmp/events.sock"
set :puma_state,      "/myraid10/var/run/events/events.state"
set :puma_pid,        "/myraid10/var/run/events/events.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: false, user: fetch(:user), keys: %w(~/.ssh/authorized_keys) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
set :branch,        :staging
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):

set :linked_files, %w{config/database.yml}

# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}



namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end