module Komonjo
  module Service
    # A service for merge channel log and user information
    class MessagesService < Komonjo::Service::SlackService
      def initialize(api_token)
        @api_token = api_token
      end

      def messages(opts)
        connection = connection(@api_token)
        history = connection.channels_history(opts)
        users = connection.users_list
        emojis = connection.emoji_list
        gateway = Komonjo::Gateway::MessagesGateway.new(history, users, emojis)
        gateway.messages
      end
    end
  end
end
