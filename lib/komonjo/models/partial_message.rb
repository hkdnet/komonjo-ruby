module Komonjo
  module Model
    class PartialMessage
      attr_accessor :next
      attr_accessor :markdown
      attr_accessor :text
      attr_accessor :filters

      def initialize(text, filters)
        @text = text
        @markdown = text
        @filters = filters
        parse
      end

      def parse
        f = filters.find { |e| e.match(text) }
        return unless f
        arr = f.parse(text)
        case arr.size
        when 1
          a, = arr
          @text = a[:text]
          extend f.mixin
        when 2
          a, b = arr
          @text = a[:text]
          if a[:matched]
            extend f.mixin
            @next = PartialMessage.new(b[:text], filters)
            @next.parse
          else
            @next = PartialMessage.new(b[:text], filters).tap do |e|
              e.extend f.mixin
            end
          end
        when 3
          a, b, c = arr
          @text = a[:text]
          @next = PartialMessage.new(b[:text], filters).tap do |e|
            e.extend f.mixin
            e.next = PartialMessage.new(c[:text], filters).tap(&:parse)
          end
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
