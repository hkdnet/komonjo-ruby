module Komonjo
  module Service
    # A service for get channels_list as Komonjo::Model::Channel
    class ChannelsService < Komonjo::Service::SlackService
      def channels
        connection = connection(@api_token)
        raw_channels = connection.channels_list
        gateway = Komonjo::Gateway::ChannelsGateway.new raw_channels
        gateway.channels
      end
    end
  end
end
