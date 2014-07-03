require 'securerandom'

module Elf
  module API
    class Token < Grape::API
      format :json

      resource :token do
        desc 'Create token'
        params do
          requires :user, type: Hash do
            requires :username
            requires :password
          end
        end
        post do
          user = Elf::Model::User.new(username: params[:user][:username])
          present user, with: Elf::API::Entities::User
        end

        desc 'Destroys token'
        delete '/' do
        end
      end
    end
  end
end