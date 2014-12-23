require 'reel'
require 'celluloid/autostart'
require 'celluloid/io'
require 'celluloid/redis'
require 'json'
require 'yaml'

require File.join(File.dirname(__FILE__), 'lib', 'messenger', 'notifier.rb')

rails_env = ENV['RAILS_ENV'] || 'development'
config_file = File.join(File.dirname(__FILE__), 'config', 'redis.yml')

if File.exist?(config_file)
  config = YAML.load_file(config_file)[rails_env]
  $redis = Redis.new(config.merge(:driver => :celluloid))
end

class MessengerApp < Reel::Server::HTTP
  include Celluloid::Logger

  def initialize(host = '127.0.0.1', port = 9292)
    info "Reel starting on http://#{host}:#{port}"

    super(host, port, &method(:on_connection))
  end

  def on_connection(connection)
    while request = connection.request
      if request.websocket?
        info 'Received WebSocket connection'

        connection.detach

        route request.websocket
        return
      end
    end
  end

  def route(socket)
    Messenger::Notifier.new(socket)
  end
end

MessengerApp.supervise_as :reel

sleep
