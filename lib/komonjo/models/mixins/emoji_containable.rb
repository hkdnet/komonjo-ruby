module Komonjo
  module Model
    module Mixin
      module EmojiContainable
        def type
          :emoji
        end

        def embed(data)
          return self.markdown = "" if Komonjo.config.remove_skin_tone && skin_tone?
          name = text[1..-2]
          data[:emojis].any? do |e|
            self.markdown = "![emoji:#{e.name}](#{e.url})" if e.name == name
          end
        end

        def skin_tone?
          text =~ /:skin-tone-\d:/
        end
      end
    end
  end
end
