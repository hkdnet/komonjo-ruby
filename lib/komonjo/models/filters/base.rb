module Komonjo
  module Model
    module Filter
      module Base
        def match(text)
          return false unless text
          text.match(pattern)
        end

        def parse(text)
          return split_two(text) if start_with_matched?(text)
          split_three(text)
        end

        def pattern
          //
        end

        private

        def start_with_matched?(text)
          text.index(pattern).zero?
        end

        def split_two(text)
          m = text.match(pattern)
          _, b = text.split(pattern, 2)
          messages = [
            { text: m[0], matched: true },
            { text: b, matched: false },
          ]
          compact_absent(messages)
        end

        def split_three(text)
          m = text.match(pattern)
          a, c = text.split(pattern, 2)
          messages = [
            { text: a, matched: false },
            { text: m[0], matched: true },
            { text: c, matched: false },
          ]
          compact_absent(messages)
        end

        def compact_absent(arr)
          arr.delete_if { |e| e[:text].nil? || e[:text] == "" }
        end
      end
    end
  end
end
