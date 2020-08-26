# Load the rails application
require File.expand_path('../application', __FILE__)

#require 'memcache'

#memcache_options = {
#:compression => false,
#:debug => false,
#:namespace => "mem-#Rails.env",
#:readonly => false,
#:urlencode => false
#}
#memcache_servers = [ '0.0.0.0:11211' ]
#CACHE = MemCache.new(memcache_options)
#CACHE.servers = memcache_servers


# Initialize the rails application
Events::Application.initialize!
