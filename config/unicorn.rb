# http://unicorn.bogomips.org/

listen           ENV['PORT'] || 3000, backlog: Integer(ENV['UNICORN_BACKLOG'] || 16)
worker_processes Integer(ENV['UNICORN_WORKERS'] || 2)
timeout          15
preload_app      true

# Platform check are generally a smell, but I didn't like splitting this file into multiple based on env either.
if RUBY_PLATFORM =~ /linux/
  listen         '/tmp/.unicorn.sock'
  user           'deploy', 'www-data'
  pid            '/run/unicorn.pid'
  stdout_path    '/var/log/unicorn.log'
  stderr_path    '/var/log/unicorn.log'
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end