module Komonjo
  module Model
    # slacke Message
    class Message
      include Komonjo::Extension::ToJson
      attr_accessor :type, :channel, :user, :text, :ts, :edited, :subtype
      # for jsonize
      attr_reader :markdown
      alias to_json_org to_json

      def self.create(hash)
        new.tap do |e|
          hash.each { |k, v| e.instance_variable_set("@#{k}", v) }
        end
      end

      def partial_messages
        @partial_messages ||=
          begin
            ret = []
            tmp = first_partial_message
            while tmp
              ret << tmp
              tmp = tmp.next
            end
            ret
          end
      end

      def first_partial_message
        @first_partial_message ||= PartialMessageFactory.build(text)
      end

      def timestamp
        Time.at(@ts.to_f).strftime('%Y-%m-%d %H:%M:%S')
      end

      def to_markdown
        [
          user.to_markdown,
          name_markdown,
          timestamp_markdown,
          text_markdown,
        ].join("\n")
      end

      def to_json(*args)
        @markdown = to_markdown
        to_json_org(args)
      end

      def name_markdown
        "\t- #{@user.name}"
      end

      def timestamp_markdown
        "\t- #{timestamp}"
      end

      def text_markdown
        t = partial_messages.map(&:markdown).join
        "\t- #{t}"
      end
    end
  end
end
