module Komonjo
  module Model
    module Mixin
      # URLContainable
      module URLContainable
        def type
          :url
        end

        def embed(_)
          url = text[1..-2]
          @text = "[#{url}](#{url})"
        end
      end
    end
  end
end
