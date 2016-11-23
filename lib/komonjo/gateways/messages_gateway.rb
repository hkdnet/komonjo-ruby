require 'cgi'

module Komonjo
  module Gateway
    # Merge history and users
    class MessagesGateway
      using HashExtensions
      attr_reader :history, :users, :emojis

      def initialize(history, users, emojis)
        @history = history.map { |e| Hash[e.symbolize_keys] }
        @users = users.map do |e|
          h = Hash[e.symbolize_keys]
          h[:profile] = Hash[h[:profile].symbolize_keys]
          Komonjo::Model::User.create(h)
        end
        @emojis = emojis.map do |(name, url)|
          Komonjo::Model::Emoji.create(name, url)
        end
      end

      def messages
        history.map do |e|
          next e unless e[:user]
          Komonjo::Model::Message.create(e).tap do |message|
            message.user = find_user(e[:user])
            message.text = CGI.unescapeHTML(message.text)
            message.partial_messages.each do |partial|
              partial.embed(embed_data)
            end
          end
        end
      end

      private

      def find_user(user_id)
        @users.find { |e| e.id == user_id }.tap do |e|
          raise "unknown user: #{user_id}" unless e
        end
      end

      def embed_data
        @embed_data ||= {
          users: users,
          emojis: emojis,
        }
      end
    end
  end
end
