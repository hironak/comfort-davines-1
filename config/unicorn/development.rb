# config/unicorn.rb

worker_processes 1
listen "#{ENV['BOXEN_SOCKET_DIR'] || '/tmp'}/comfort-davines", :backlog => 1024
timeout 120

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
