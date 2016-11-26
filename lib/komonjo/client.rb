module Komonjo
  # Client
  class Client
    using ::HashExtensions
    attr_accessor :api_token

    # @param token [String] slack api token
    # @param debug [TrueClass | FalseClass] set true if debug
    def initialize(token: nil, debug: false)
      @api_token = token
      @debug = debug
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
      if opts.is_a?(String)
        channel_name = opts
        opts = { channel_name: channel_name }
      end
      opts = Hash[opts.symbolize_keys]
      s = Komonjo::Service::MessagesService.new(@api_token)
      s.instance_variable_set('@connection', Komonjo::Mock::SlackMock) if @debug
      s.messages(opts)
    end

    def users(opts = {})
      s = Komonjo::Service::UsersService.new(@api_token)
      s.instance_variable_set('@connection', Komonjo::Mock::SlackMock) if @debug
      s.users(opts)
    end

    def emoji(opts = {})
      s = Komonjo::Service::EmojisService.new(@api_token)
      s.instance_variable_set('@connection', Komonjo::Mock::SlackMock) if @debug
      s.emoji(opts)
    end
  end
end
