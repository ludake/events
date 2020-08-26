task :server do
  # optional port parameter
  port = ENV['PORT'] ? ENV['PORT'] : '3000'
  puts 'start puma development'
  # execute unicorn command specifically in development
  # port at 3000 if unspecified
  sh "cd #{Rails.root} && RAILS_ENV=development puma -p #{port}"
end
# an alias task
task :s => :server
