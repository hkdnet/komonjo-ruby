module Komonjo
  module Gateway
    # A gateway for slack response to Komonjo::Model::User
    class UsersGateway
      using HashExtensions
      def initialize(users)
        @users = users.map do |e|
          tmp = Hash[e.symbolize_keys]
          tmp[:profile] = Hash[tmp[:profile].symbolize_keys]
          tmp
        end
      end

      def users
        @users.map { |e| Komonjo::Model::User.create(e) }
      end
    end
  end
end
