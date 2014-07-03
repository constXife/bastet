module Elf
  module Model
    class User
      attr_accessor :username, :role, :token

      def initialize(args)
        @username = args[:username]
      end

      def role
        {
          bitMask: 3,
          title: 'admin'
        }
      end

      def token
        generate_token
      end

      private

      def generate_token
        self.token = "elf_#{SecureRandom.urlsafe_base64}"
      end
    end
  end
end