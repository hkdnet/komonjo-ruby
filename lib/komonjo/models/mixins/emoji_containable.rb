module Komonjo
  module Model
    module Mixin
      module EmojiContainable
        def type
          :emoji
        end

        def embed(data)
          name = text[1..-2]
          data[:emojis].any? do |e|
            @markdown = "![emoji:#{e.name}](#{e.url})" if e.name == name
          end
        end
      end
    end
  end
end
