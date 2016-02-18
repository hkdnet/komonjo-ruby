module Komonjo
  class Client
    def initialize(api_token)
      @api_token = api_token
    end

    def token_valid?
      s = Komonjo::Service::LoginService.new(@api_token)
      s.login
    end

    def channels
      s = Komonjo::Service::ChannelsService.new(@api_token)
      s.channels
    end

    def messages(channel_name)
      s = Komonjo::Service::MessagesService.new(@api_token)
      s.messages(channel_name)
    end
  end
end
