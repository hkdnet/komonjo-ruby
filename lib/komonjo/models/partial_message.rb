module Komonjo
  module Model
    class PartialMessage
      attr_accessor :next
      attr_reader   :text
      attr_reader   :filters

      def initialize(text, filters)
        @text = text
        @filters = filters
        parse
      end

      def parse
        f = filters.find { |e| e.match(text) }
        return unless f
        a, b, c = f.parse(text)
        @text = a
        @next = PartialMessage.new(b, filters).tap do |e|
          e.extend f.mixin
          e.next = PartialMessage.new(c, filters).tap(&:parse) if c && c != ""
        end
        self
      end

      def type
        :text
      end

      def embed(*)
      end
    end
  end
end
