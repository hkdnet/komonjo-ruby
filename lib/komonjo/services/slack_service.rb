module Komonjo
  module Service
    # A base class for Service of Slack
    class SlackService
      def initialize(api_token)
        @api_token = api_token
      end

      def connection
        @connection ||= Komonjo::Connection::SlackConnection.new(api_token)
      end

      # Use mock
      # @return [Komonjo::Service::SlackService] self
      def mockify(connection: Komonjo::Mock::SlackMock)
        @connection = connection if connection
        self
      end

      private

      attr_reader :api_token
    end
  end
end
