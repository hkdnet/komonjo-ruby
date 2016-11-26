module Komonjo
  module Model
    # slack user
    class User
      attr_accessor :profile, :id, :name, :deleted, :color, :is_admin,
                    :is_owner, :is_primary_owner, :is_restricted,
                    :is_ultra_restricted, :has_2fa, :has_files

      def self.create(hash)
        new.tap do |e|
          hash.each { |k, v| e.instance_variable_set("@#{k}", v) }
          e.profile = Profile.create(hash[:profile]) if hash[:profile]
        end
      end

      # rubocop:disable Metrics/MethodLength
      def as_json
        {
          profile: profile.as_json,
          id: id,
          name: name,
          deleted: deleted,
          color: color,
          is_admin: is_admin,
          is_owner: is_owner,
          is_primary_owner: is_primary_owner,
          is_restricted: is_restricted,
          is_ultra_restricted: is_ultra_restricted,
          has_2fa: has_2fa,
          has_files: has_files,
        }
      end
      # rubocop:enable Metrics/MethodLength

      def to_json(*args)
        as_json.to_json(*args)
      end

      def to_markdown
        "* ![#{name} icon](#{profile.image_48})"
      end
    end
  end
end
