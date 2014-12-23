module Messenger
  class Notifier
    include Celluloid
    include Celluloid::Notifications
    include Celluloid::Logger
    include Celluloid::IO

    def initialize(socket)
      @socket = socket
      async.run
    end

    def run
      $redis.subscribe('dashboard') do |on|
        on.message do |channel, msg|
          info "##{channel} - #{msg}"
          send_message(msg)
        end
      end
    end

    def send_message(body)
      unless body.empty?
        info "Send: #{body}"
        @socket << body
      end
    rescue Reel::SocketError
      info 'client disconnected'
      terminate
    end
  end
end