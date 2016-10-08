module Komonjo
  module Model
    module Filter
      # URLFilter
      module ReplyFilter
        extend Base

        def self.pattern
          @pattern ||= %r{<@\S+?>}
        end

        def self.mixin
          Komonjo::Model::Mixin::ReplyContainable
        end
      end
    end
  end
end
