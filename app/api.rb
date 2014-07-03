module Elf
  module API
    class App < Grape::API
      version 'v1', using: :path
      format :json

      helpers do
        def logger
          Grape::API.logger
        end
      end

      before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'

        logger.info "Request Body: #{request.body.read}"
      end

      add_swagger_documentation(
          base_path: 'api',
          api_version: self.version
      )

      mount Elf::API::Token
    end
  end
end