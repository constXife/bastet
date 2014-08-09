sinatra_root = File.join(File.dirname(__FILE__), '..')

if ENV['RACK_ENV'] == 'production'
  pid_file      = "/tmp/elf.pid"
  state_file    = "/tmp/elf.state"
  socket_file   = "unix:///tmp/elf.sock"
  log_file      = "#{sinatra_root}/log/puma.log"
  err_log       = "#{sinatra_root}/log/puma_error.log"

  environment 'production'
  daemonize
  pidfile pid_file
  state_path state_file
  stdout_redirect log_file, err_log
  bind socket_file
  preload_app!
else
  sinatra_root = '.'
  port 3000
end

rackup "#{sinatra_root}/config.ru"
threads 1,1
workers 1