module Komonjo
  # Client
  class Client
    using ::HashExtensions

    # @param token [String] slack api token
    # @param debug [TrueClass | FalseClass] set true if debug
    def initialize(token: nil, debug: false)
      @api_token = token
      @debug = debug
    end

    def token_valid?
      login_service.login
    end

    # fetch channels
    #
    # @return [Array[Komonjo::Model::Channel]]
    def channels
      channels_service.channels
    end

    # fetch messages
    #
    # @param channel_id [String] channel id
    # @param channel_name [String] channel name
    # @note At least, one of channel_id and channel_name is required.
    #  If both of id and name are set, channel_id will be used.
    # @return [Array[Komonjo::Model::Message]]
    def messages(channel_id: nil, channel_name: nil, channel: nil)
      channel_id = channel if channel
      messages_service.messages(channel_id: channel_id, channel_name: channel_name)
    end

    def users(opts = {})
      users_service.users(opts)
    end

    def emoji(opts = {})
      emojis_service.emoji(opts)
    end

    private

    attr_reader :api_token

    def login_service
      @login_service ||=
        mockify(Komonjo::Service::LoginService.new(api_token))
    end

    def channels_service
      @channels_service ||=
        mockify(Komonjo::Service::ChannelsService.new(api_token))
    end

    def messages_service
      @channels_service ||=
        mockify(Komonjo::Service::MessagesService.new(api_token))
    end

    def users_service
      @users_service ||=
        mockify(Komonjo::Service::UsersService.new(api_token))
    end

    def emojis_service
      @emojis_service ||=
        mockify(Komonjo::Service::EmojisService.new(api_token))
    end

    def mockify(service)
      service.instance_variable_set('@connection', Komonjo::Mock::SlackMock) if @debug
      service
    end
  end
end
