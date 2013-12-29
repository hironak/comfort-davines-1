# config/unicorn.rb

# app_path = "/mnt/project/davines_commers/current"

# working_directory app_path

# stderr_path "#{app_path}/log/unicorn.log"
# stdout_path "#{app_path}/log/unicorn.log"

pid "/tmp/davines-unicorn-unicorn.pid"

listen "/tmp/davines_commers.sock"
worker_processes 3
timeout 180
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end