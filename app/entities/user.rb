module Elf
  module API
    module Entities
      # Responses for API output
      class User < Grape::Entity
        root 'users', 'user'

        expose :username, :documentation => { :type => 'string', :desc => 'Name of user' }
        expose :token, :documentation => { :type => 'string', :desc => 'Token of user' }
        expose :role, :documentation => { :type => 'hash', :desc => 'Role of user' }

        private

        # partial options[:fields]
        # for example:
        # present :server, server, with: API::Entities::Server, fields: [:end_time]
        def has_field(key)
          !options.has_key?(:fields) || options[:fields].include?(key)
        end
      end
    end
  end
end