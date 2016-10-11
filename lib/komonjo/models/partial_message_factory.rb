
module Komonjo
  module Model
    module PartialMessageFactory
      def self.build(text)
        Komonjo::Model::PartialMessage.new(text, filters)
      end

      def self.filters
        @filters ||= [
          Komonjo::Model::Filter::ReplyFilter,
          Komonjo::Model::Filter::URLFilter,
          Komonjo::Model::Filter::EmojiFilter,
        ]
      end
    end
  end
end
