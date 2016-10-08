module Komonjo
  module Model
    module Filter
      # URLFilter
      module URLFilter
        FILTER = %r{<https?://\S+>}

        def self.match(text)
          return false unless text
          text.match(FILTER)
        end

        def self.mixin
          Komonjo::Model::Mixin::URLContainable
        end

        def self.parse(text)
          a, c = text.split(FILTER, 2)
          m = text.match(FILTER)
          [a, m[0], c].delete_if { |e| e == "" }
        end
      end
    end
  end
end
