module Komonjo
  module Service
    # A base class for Service of Slack
    class SlackService
      def connection(api_token)
        @connection ||= Komonjo::Connection::SlackConnection.new(api_token)
      end
    end
  end
end
