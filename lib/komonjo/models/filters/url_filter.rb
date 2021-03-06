module Komonjo
  module Model
    module Filter
      # URLFilter
      module URLFilter
        extend Base

        def self.pattern
          @pattern ||= %r{<https?://\S+?>}
        end

        def self.mixin
          Komonjo::Model::Mixin::URLContainable
        end
      end
    end
  end
end
