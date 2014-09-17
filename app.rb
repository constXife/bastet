module Elf
  class Application < Reel::Server::HTTP
    include Celluloid::Logger

    def initialize(host = '127.0.0.1', port = 3001)
      info "Reel starting on http://#{host}:#{port}"

      super(host, port, &method(:on_connection))
    end

    def on_connection(connection)
      while request = connection.request
        if request.websocket?
          info "Received WebSocket connection"

          connection.detach

          route request.websocket
          return
        else
          request.respond :ok, Elf::API::VERSION
        end
      end
    end

    def route(socket)
      if socket.url == '/api'
        Elf::Updater::API::Base.new(socket)
      else
        info "Invalid socket request for: #{socket.url}"
        socket.close
      end
    end
  end
end
