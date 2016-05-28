require 'slack'

module Komonjo
  module Connection
    # Connection for slack
    class SlackConnection
      attr_reader :client
      def initialize(api_token)
        @client = Slack::Client.new(token: api_token)
      end

      def channels_history(opts)
        channel_name = opts.delete(:channel_name)
        unless opts[:channel]
          channel_name[0] = '' if channel_name[0] == '#'
          channel_id = channel_id channel_name
          opts[:channel] = channel_id
        end
        ret = client.channels_history(opts)
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

      private

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
