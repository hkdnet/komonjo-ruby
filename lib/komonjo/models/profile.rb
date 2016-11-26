module Komonjo
  module Model
    # slack User.profile
    class Profile
      attr_accessor :first_name, :last_name, :real_name, :email, :skype, :phone,
                    :image_24, :image_32, :image_48, :image_72, :image_192

      def self.create(hash)
        new.tap { |e| hash.each { |k, v| e.instance_variable_set("@#{k}", v) } }
      end

      # rubocop:disable Metrics/MethodLength
      def as_json
        {
          first_name: first_name,
          last_name: last_name,
          real_name: real_name,
          email: email,
          skype: skype,
          phone: phone,
          image_24: image_24,
          image_32: image_32,
          image_48: image_48,
          image_72: image_72,
          image_192: image_192,
        }
      end
      # rubocop:enable Metrics/MethodLength

      def to_json(*args)
        as_json.to_json(*args)
      end
    end
  end
end
