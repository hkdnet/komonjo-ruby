module Komonjo
  module Service
    # A service for get channels_list as Komonjo::Model::Channel
    class LoginService < Komonjo::Service::SlackService
      def login
        connection = connection(@api_token)
        connection.auth_test
      end
    end
  end
end
