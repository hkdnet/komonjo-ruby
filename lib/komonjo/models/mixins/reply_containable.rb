module Komonjo
  module Model
    module Mixin
      module ReplyContainable
        def type
          :reply
        end

        def embed(data)
          id = text[2..-2]
          data[:users].any? do |u|
            @text = "@#{u.name}" if u.id == id
          end
        end
      end
    end
  end
end
