module Elf
  module Updater
    module API
      class Base
        include Celluloid
        include Celluloid::Notifications
        include Celluloid::Logger
        include Celluloid::IO

        def initialize(socket)
          @socket = socket
          subscribe 'cmd', :handle_cmd

          async.run
        end

        def run
          while message = JSON.parse(@socket.read)
            dispatch message
          end
        rescue EOFError
          info 'left'
          terminate
        end

        def dispatch(message)
          info "Received: #{message.inspect}"

          case message['cmd']
            when 'get'
              index
          end
        end

        def index
          hash = {
              version: Elf::API::VERSION
          }

          send_message('api', hash.to_json.to_s)
        end

        def send_message(event, body)
          @socket << {
              event: event,
              body: body
          }.to_json
        end
      end
    end
  end
end