if ENV['RACK_ENV'] == 'production'
  deploy_to     = "/var/www/home.constxife.ru"
  sinatra_root  = "#{deploy_to}/current"
  pid_file      = "#{deploy_to}/shared/puma.pid"
  state_file    = "#{deploy_to}/shared/puma.state"
  socket_file   = "unix://#{deploy_to}/shared/puma.sock"
  log_file      = "#{deploy_to}/shared/log/puma.log"
  err_log       = "#{deploy_to}/shared/log/puma_error.log"

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