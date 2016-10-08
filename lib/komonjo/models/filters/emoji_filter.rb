module Komonjo
  module Model
    module Filter
      module EmojiFilter
        extend Base

        def self.pattern
          @pattern ||= /:\S+?:/
        end

        def self.mixin
          Komonjo::Model::Mixin::EmojiContainable
        end
      end
    end
  end
end
