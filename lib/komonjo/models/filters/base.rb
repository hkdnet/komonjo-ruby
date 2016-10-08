module Komonjo
  module Model
    module Filter
      module Base
        def match(text)
          return false unless text
          text.match(pattern)
        end

        def parse(text)
          a, c = text.split(pattern, 2)
          m = text.match(pattern)
          [a, m[0], c].delete_if { |e| e == "" }
        end

        def pattern
          //
        end
      end
    end
  end
end
