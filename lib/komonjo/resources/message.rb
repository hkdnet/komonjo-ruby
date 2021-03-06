module Komonjo
  module Resource
    # Resource representation for Komonjo::Model::Message
    class Message < Base
      attr_reader :model

      def initialize(model)
        @model = model
      end

      # rubocop:disable Metrics/AbcSize
      def as_json
        {
          markdown: model.markdown,
          ts: model.ts,
          type: model.type,
          channel: model.channel,
          user: model.user,
          text: model.text,
          edited: model.edited,
          subtype: model.subtype,
        }
      end
      # rubocop:enable Metrics/AbcSize

      def to_json(*args)
        as_json.to_json(*args)
      end
    end
  end
end
