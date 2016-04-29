module Komonjo
  class Client
    attr_accessor :api_token
    def initialize(options)
      @api_token = options[:token]
      @debug = options[:debug] || false
    end

    def token_valid?
      s = Komonjo::Service::LoginService.new(@api_token)
      s.instance_variable_set('@connection', Komonjo::Mock::SlackMock) if @debug
      s.login
    end

    def channels
      s = Komonjo::Service::ChannelsService.new(@api_token)
      s.instance_variable_set('@connection', Komonjo::Mock::SlackMock) if @debug
      s.channels
    end

    def messages(opts)
      opts = { channel_name: opts } if opts.is_a?(String)
      s = Komonjo::Service::MessagesService.new(@api_token)
      s.instance_variable_set('@connection', Komonjo::Mock::SlackMock) if @debug
      s.messages(opts)
    end
  end
end
