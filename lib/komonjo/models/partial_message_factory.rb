
module Komonjo
  module Model
    module PartialMessageFactory
      def self.build(text)
        Komonjo::Model::PartialMessage.new(text, filters)
      end

      def self.filters
        @filters ||= [
          Komonjo::Model::Filter::URLFilter,
        ]
      end
    end
  end
end
