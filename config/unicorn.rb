# http://unicorn.bogomips.org/

listen           ENV['PORT'] || 3000, backlog: Integer(ENV['UNICORN_BACKLOG'] || 16)
listen           '/tmp/.unicorn.sock'
worker_processes Integer(ENV['UNICORN_WORKERS'] || 3)
timeout          15
preload_app      true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
