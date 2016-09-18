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
        list = @emoji.map { |k, v| Komonjo::Model::Emoji.create(k, v) }
        list.select(&:alias?).each do |e|
          target = list.find { |i| i.name == e.alias_name }
          e.url = target.url
        end
        list
      end
    end
  end
end
