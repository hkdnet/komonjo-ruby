module Komonjo
  module Service
    # A service for merge channel log and user information
    class MessagesService < Komonjo::Service::SlackService
      def initialize(api_token)
        @api_token = api_token
      end

      def messages(channel_name)
        connection = connection(@api_token)
        history = connection.channels_history channel_name
        users = connection.users_list
        gateway = Komonjo::Gateway::MessagesGateway.new history, users
        gateway.messages
      end
    end
  end
end
