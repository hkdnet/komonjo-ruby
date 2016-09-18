module Komonjo
  module Model
    # slack emoji
    class Emoji
      attr_accessor :name, :url

      def self.create(name, url)
        new.tap do |e|
          e.name = name
          e.url = url
        end
      end
    end
  end
end
