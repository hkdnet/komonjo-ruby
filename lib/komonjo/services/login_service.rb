module Komonjo
  module Service
    # A service for get channels_list as Komonjo::Model::Channel
    class LoginService < Komonjo::Service::SlackService
      def login
        connection.auth_test
      end
    end
  end
end
