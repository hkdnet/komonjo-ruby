module Komonjo
  module Service
    # A service for merge channel log and user information
    class MessagesService < Komonjo::Service::SlackService
      # @param channel_id
      # @param channel_name
      def messages(channel_id: nil, channel_name: nil)
        connection = connection(@api_token)
        history = connection.channels_history(channel_id: channel_id, channel_name: channel_name)
        users = connection.users_list
        emojis = connection.emoji_list
        gateway = Komonjo::Gateway::MessagesGateway.new(history, users, emojis)
        gateway.messages
      end
    end
  end
end
