require 'slack'

module Komonjo
  module Connection
    # Connection for slack
    class SlackConnection
      # @param api_token [String] api token
      def initialize(api_token)
        @client = Slack::Client.new(token: api_token)
      end

      # @param channel_id [String]
      # @param channel_name [String]
      # @note Either channel_id or channel_name is required.
      # @example
      #   conn.channels_history(channel_name: '#general')
      #   conn.channels_history(channel_name: 'general')
      #   conn.channels_history(channel_id: 'C1234567')
      # @return [Hash]
      def channels_history(channel_id: nil, channel_name: nil)
        unless channel_id
          channel_name[0] = '' if channel_name[0] == '#'
          channel_id = channel_id(channel_name)
        end
        ret = client.channels_history(channel: channel_id)
        raise 'error' unless ret['ok']
        ret['messages']
      end

      def users_info(user_id)
        ret = client.users_info(user: user_id)
        raise 'error' unless ret['ok']
        ret['user']
      end

      def users_list
        ret = client.users_list
        raise 'error' unless ret['ok']
        ret['members']
      end

      def channels_list
        ret = client.channels_list
        raise 'error' unless ret['ok']
        ret['channels']
      end

      def auth_test
        ret = client.auth_test
        ret['ok']
      end

      def emoji_list
        ret = client.emoji_list
        raise 'error' unless ret['ok']
        ret['emoji']
      end

      private

      attr_reader :client

      # @param channel_name [String] channel name, the first character must not be '#'.
      # @return [String] channel id
      # @raise StandardError on connection error.
      # @raise StandardError if specified channel_name does not exist.
      def channel_id(channel_name)
        channel_list = client.channels_list
        raise 'error' unless channel_list['ok']
        target_channel = channel_list['channels'].select do |e|
          e['name'] == channel_name
        end
        raise "unknown channel name: #{channel_name}" if target_channel.empty?
        target_channel.first['id']
      end
    end
  end
end
