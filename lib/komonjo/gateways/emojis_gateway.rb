require 'cgi'

module Komonjo
  module Gateway
    # Returns an object { name, url }
    class EmojisGateway
      using HashExtensions
      def initialize(emoji)
        @emoji = emoji
      end

      def emoji
        @emoji.map { |k, v| Komonjo::Model::Emoji.create(k, v) }
      end
    end
  end
end
