module Komonjo
  module Model
    module Filter
      module Base
        def match(text)
          return false unless text
          text.match(pattern)
        end

        def parse(text)
          m = text.match(pattern)
          if text.index(pattern).zero?
            _, b = text.split(pattern, 2)
            return [
              { text: m[0], matched: true },
              { text: b, matched: false },
            ].delete_if { |e| e[:text].nil? || e[:text] == "" }
          end
          a, c = text.split(pattern, 2)
          [
            { text: a, matched: false },
            { text: m[0], matched: true },
            { text: c, matched: false },
          ].delete_if { |e| e[:text].nil? || e[:text] == "" }
        end

        def pattern
          //
        end
      end
    end
  end
end
