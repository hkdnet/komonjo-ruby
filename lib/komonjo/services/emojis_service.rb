module Komonjo
  module Service
    # A service for emoji
    class EmojisService < Komonjo::Service::SlackService
      def emoji
        emoji = connection.emoji_list
        gateway = Komonjo::Gateway::EmojisGateway.new(emoji)
        gateway.emoji
      end
    end
  end
end
