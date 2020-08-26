# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
  set :ssh_options, {
  	user: "ludake",
    keys: %w(/home/ludake/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(publickey)
 }
#
# The server-based syntax can be used to override options:
# ------------------------------------
 


set :deploy_to, "/myraid10/var/www/pylontqi/public/events"
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.
# set :bundle_gemfile,  "ajax/Gemfile"


set :branch, 'staging'

set :rails_env, "production"

set :nginx_server_name, "pylontqi.mynetgear.com"

#set :rvm_ruby_version, '2.5.8'
# set :rvm_type, :oss
#set :monit_role, :all

set :html_branch, 'staging'