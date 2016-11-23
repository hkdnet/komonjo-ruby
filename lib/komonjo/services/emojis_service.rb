module Komonjo
  module Service
    # A service for emoji
    class EmojisService < Komonjo::Service::SlackService
      def emoji(opts = {})
        connection = connection(@api_token)
        emoji = connection.emoji_list(opts)
        gateway = Komonjo::Gateway::EmojisGateway.new(emoji)
        gateway.emoji
      end
    end
  end
end
