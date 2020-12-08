module Tinder

  class Client
    def get_recommendations(&block)
      if block_given?
        yield get_recommendations && return
      end

      data = get(endpoint(:recommendations))

      fail 'Connection Timeout' unless data.dig('data', 'timeout').nil?

      error_message = data.dig('error', 'message')
      fail 'Rate Limited' if error_message == 'RATE_LIMITED'
      return [] if error_message == 'There is no one around you'
      fail error_message unless error_message.nil?

      results = Array(data.dig('data', 'results'))
      return [] if results.first.is_a?(String) && results.first == 'You are out of likes today. Come back later to continue swiping on more people.'

      results.map { |user_data| Recommendation.new(user_data) }
    end

    alias_method :recommendations, :get_recommendations
  end

  class PhotoMetadata < Dry::Struct
    attribute :width_pct, Dry::Types['coercible.integer']
    attribute :x_offset_pct, Dry::Types['coercible.integer']
    attribute :height_pct, Dry::Types['coercible.integer']
    attribute :y_offset_pct, Dry::Types['coercible.integer']
  end

  class Photo < Dry::Struct
    attribute :id, Types::Nominal::String
    attribute? :crop_info do
      attribute? :user, PhotoMetadata
      attribute? :algo, PhotoMetadata
      attribute? :processed_by_bullseye, Types::Nominal::Bool
      attribute? :user_customized, Types::Nominal::Bool
      attribute? :url, Types::Nominal::String
      attribute? :processedFiles, Types.array
      attribute? :fileName, Types::Nominal::String
      attribute? :extension, Types::Nominal::String
    end
  end

  class User < Dry::Struct
    attribute :_id, Types::Nominal::String
    attribute :bio, Types::Nominal::String
    attribute :birth_date, Types::Nominal::String
    attribute :name, Types::Nominal::String
    attribute? :photos, Types.array.of(Photo)
    attribute? :gender, Types::Nominal::Integer
    attribute? :jobs, Types.array
    attribute? :schools, Types.array do
      attribute? :name, Types::Nominal::String
    end
    attribute? :city do
      attribute? :name, Types::Nominal::String
    end
    attribute? :is_traveling, Types::Nominal::Bool
    attribute? :hide_age, Types::Nominal::Bool
    attribute? :hide_distance, Types::Nominal::Bool
  end

  # Return this object
  class Recommendation < Dry::Struct
    attribute :type, Types::Nominal::String
    attribute :user, User
    attribute? :facebook do
      attribute? :common_connections, Types.array
      attribute? :connection_count, Types::Nominal::Integer
      attribute? :common_interests, Types.array
    end
    attribute? :spotify, Types.hash
    attribute? :distance_mi, Types::Nominal::Integer
    attribute? :content_hash, Types::Nominal::String
    attribute? :s_number, Types::Nominal::Integer
    attribute? :teasers, Types.array do
      attribute? :type, Types::Nominal::String
      attribute? :string, Types::Nominal::String
    end
  end
end
