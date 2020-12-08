module Tinder
  class Client
    # This includes the matches, as well as the messages, so must be parsed
    # @return Updates a Dry::Struct object based on a JSON response

    def get_updates(since: Time.now)
      response = post(endpoint(:updates))

      fail 'Connection Timeout' unless response.dig('data', 'timeout').nil?
      fail 'Rate Limited' if response.dig('error', 'message') == 'RATE_LIMITED'
      # The next one only occurs without Tinder Plus subscription
      fail 'No Results Left' if response.dig('error', 'message') == 'There is no one around you'

      updates = Updates.new(response['data'])
    end

    alias_method :updates, :get_updates
  end

  class Message < Dry::Struct
    attribute? :_id, Types::Nominal::String
    attribute? :match_id, Types::Nominal::String
    attribute? :sent_date, Types::Nominal::String
    attribute? :message, Types::Nominal::String
    attribute? :to, Types::Nominal::String
    attribute? :from, Types::Nominal::String
    attribute? :created_date, Types::Nominal::String
    attribute? :timestamp, Types.send('coercible.string')
  end

  class LikedMessage < Dry::Struct
    attribute? :message_id, Types::Nominal::String
    attribute? :updated_at, Types::Nominal::String
    attribute? :liker_id, Types::Nominal::String
    attribute? :match_id, Types::Nominal::String
    attribute? :is_liked, Types::Nominal::Bool
  end

  class Person < Dry::Struct
    attribute? :_id, Types::Nominal::String
    attribute? :bio, Types::Nominal::String
    attribute? :birth_date, Types::Nominal::String
    attribute? :gender, Types::Nominal::Integer
    attribute? :name, Types::Nominal::String
    attribute? :ping_time, Types::Nominal::String
    attribute? :photos, Types.array
  end

  class Match < Dry::Struct
    attribute? :_id, Types::Nominal::String
    attribute? :closed, Types::Nominal::Bool
    attribute? :common_friend_count, Types::Nominal::Integer
    attribute? :common_like_count, Types::Nominal::Integer
    attribute? :created_date, Types::Nominal::String
    attribute? :dead, Types::Nominal::Bool
    attribute? :following, Types::Nominal::Bool
    attribute? :following_moments, Types::Nominal::Bool
    attribute? :id, Types::Nominal::String
    attribute? :is_boost_match, Types::Nominal::Bool
    attribute? :is_fast_match, Types::Nominal::Bool
    attribute? :is_super_like, Types::Nominal::Bool
    attribute? :last_activity_date, Types::Nominal::String
    attribute? :message_count, Types::Nominal::Integer
    attribute? :messages, Types.array.of(Message)
    attribute? :muted, Types::Nominal::Bool
    attribute? :participants, Types.array
    attribute? :pending, Types::Nominal::Bool
    attribute? :person, Person
    attribute? :readreceipt, Types.hash
    attribute? :seen, Types.hash
  end

  class Updates < Dry::Struct
    attribute? :blocks, Types.array.of(Types::Nominal::String)
    attribute? :deleted_lists, Types.array
    attribute? :goingout, Types.array
    attribute? :harassing_messages, Types.array
    attribute? :inbox, Types.array.of(Message)
    attribute? :poll_interval, Types.hash
    attribute? :liked_messages, Types.array.of(LikedMessage)
    attribute? :lists, Types.array
    attribute? :matches, Types.array.of(Match)
    attribute? :squads, Types.array
  end
end

