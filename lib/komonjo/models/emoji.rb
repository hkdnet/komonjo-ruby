module Komonjo
  module Model
    # slack emoji
    class Emoji
      attr_accessor :name, :url, :alias_name
      attr_writer :alias

      def self.create(name, url)
        new.tap do |e|
          e.name = name.to_s
          e.url = url.to_s
          url.match(/^alias:(?<alias_name>\S+)$/) do |m|
            e.alias = true
            e.alias_name = m[:alias_name]
          end
        end
      end

      def alias?
        @alias
      end
    end
  end
end
