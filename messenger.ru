require 'em-websocket'
require 'em-hiredis'
require 'json'
require 'yaml'

rails_env = ENV['RAILS_ENV'] || 'development'
config_file = File.join(File.dirname(__FILE__), 'config', 'redis.yml')
config = YAML.load_file(config_file)[rails_env]

EM.run do
  @channel = EM::Channel.new

  @redis = EM::Hiredis.connect("redis://#{config['host']}:6379")
  @pubsub = @redis.pubsub
  puts "subscribing to redis (#{config['host']})"
  @pubsub.subscribe('dashboard')
  @pubsub.on(:message){|channel, message|
    if rails_env == 'development'
      puts "redis -> #{channel}: #{message}"
    end
    @channel.push({event: 'sensor', data: message}.to_json)
  }

  EventMachine::WebSocket.start(:host => '127.0.0.1', :port => 9292) do |ws|
    puts 'Establishing websocket'

    ws.onopen do
      puts 'client connected'
      puts 'subscribing to channel'
      sid = @channel.subscribe do |msg|
        puts "sending: #{msg}" if rails_env == 'development'
        ws.send msg
      end

      ws.onmessage { |msg|
        ws.send 'Pong' if msg == 'ping'
      }

      ws.onclose {
        @channel.unsubscribe(sid)
      }
    end
  end
end
