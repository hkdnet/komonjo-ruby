module Komonjo
  module Service
    # A service for get channels_list as Komonjo::Model::Channel
    class UsersService < Komonjo::Service::SlackService
      def users
        raw_users = connection.users_list
        gateway = Komonjo::Gateway::UsersGateway.new(raw_users)
        gateway.users
      end
    end
  end
end
