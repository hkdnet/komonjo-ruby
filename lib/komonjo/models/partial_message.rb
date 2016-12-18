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
        @text = arr.first[:text]
        case arr.size
        when 1 then extend f.mixin
        when 2 then setup_with_two(f, arr)
        when 3 then setup_with_three(f, arr)
        end
        self
      end

      def type
        :text
      end

      def embed(*); end

      private

      def setup_with_two(f, arr)
        a, b = arr
        @next = PartialMessage.new(b[:text], filters)
        if a[:matched]
          extend f.mixin
          @next.parse
        else
          @next.extend f.mixin
        end
      end

      def setup_with_three(f, arr)
        _, b, c = arr
        @next = PartialMessage.new(b[:text], filters).tap do |e|
          e.extend f.mixin
          e.next = PartialMessage.new(c[:text], filters).tap(&:parse)
        end
      end
    end
  end
end
