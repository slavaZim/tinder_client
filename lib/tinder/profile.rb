module Tinder

  attr_accessor :active_user

  class Client

    # @return ActiveProfile
    def profile

      data = { include: "account,boost,email_settings,instagram," \
                        "likes,notifications,plus_control,products," \
                        "purchase,spotify,super_likes,tinder_u,"\
                        "travel,tutorials,user" }

      response = get("https://api.gotinder.com/v2/profile", data)

      fail('Unexpected response') if response.dig('data').nil?

      ActiveProfile.new(response['data'])
    end
  end

  class ActiveProfile < Dry::Struct

    attribute? :account do
      attribute? :is_email_verified, Types::Nominal::Bool
      attribute? :account_email, Types::Nominal::String
      attribute? :account_phone_number, Types::Nominal::String
    end
    attribute? :boost do
      attribute? :duration, Types::Nominal::Integer
      attribute? :allotment, Types::Nominal::Integer
      attribute? :allotment_used, Types::Nominal::Integer
      attribute? :allotment_remaining, Types::Nominal::Integer
      attribute? :internal_remaining, Types::Nominal::Integer
      attribute? :purchased_remaining, Types::Nominal::Integer
      attribute? :remaining, Types::Nominal::Integer
      attribute? :super_boost_purchased_remaining, Types::Nominal::Integer
      attribute? :boost_refresh_amount, Types::Nominal::Integer
      attribute? :boost_refresh_interval, Types::Nominal::Integer
      attribute? :boost_refresh_interval_unit, Types::Nominal::String
    end
    attribute? :email_settings do
      attribute? :email, Types::Nominal::String
      attribute? :email_settings do
        attribute? :promotions, Types::Nominal::Bool
        attribute? :messages, Types::Nominal::Bool
        attribute? :new_matches, Types::Nominal::Bool
      end
    end
    attribute? :instagram do
      attribute? :username, Types::Nominal::String
      attribute? :profile_picture, Types::Nominal::String
      attribute? :media_count, Types::Nominal::Integer
      attribute? :last_fetch_time, Types::Nominal::String
      attribute? :completed_initial_fetch, Types::Nominal::Bool
      attribute? :photos, Types.array
      attribute? :should_reauthenticate, Types::Nominal::Bool
    end
    attribute? :likes do
      attribute? :likes_remaining, Types::Nominal::Integer
    end
    attribute? :notifications, Types.array
    attribute? :plus_control do
      attribute? :discoverable_party, Types::Nominal::String
      attribute? :hide_ads, Types::Nominal::Bool
      attribute? :hide_age, Types::Nominal::Bool
      attribute? :hide_distance, Types::Nominal::Bool
      attribute? :blend, Types::Nominal::String
    end
    attribute? :products, Types.hash
    attribute? :purchase, Types.hash
    attribute? :spotify, Types.hash
    attribute? :super_likes do
      attribute? :remaining, Types::Nominal::Integer
      attribute? :alc_remaining, Types::Nominal::Integer
      attribute? :new_alc_remaining, Types::Nominal::Integer
      attribute? :allotment, Types::Nominal::Integer
      attribute? :superlike_refresh_amount, Types::Nominal::Integer
      attribute? :superlike_refresh_interval, Types::Nominal::Integer
      attribute? :superlike_refresh_interval_unit, Types::Nominal::String
      attribute? :resets_at, Types::Nominal::String.optional
    end
    attribute? :tinder_u do
      attribute? :status, Types::Nominal::String
    end
    attribute? :travel do
      attribute? :is_traveling, Types::Nominal::Bool
    end
    attribute? :tutorials, Types.array
    attribute? :user do
      attribute? :_id, Types::Nominal::String
      attribute? :age_filter_max, Types::Nominal::Integer
      attribute? :age_filter_min, Types::Nominal::Integer
      attribute? :bio, Types::Nominal::String
      attribute? :birth_date, Types::Nominal::String
      attribute? :create_date, Types::Nominal::String
      attribute? :crm_id, Types::Nominal::String
      attribute? :discoverable, Types::Nominal::Bool
      attribute? :distance_filter, Types::Nominal::Integer
      attribute? :gender, Types::Nominal::Integer
      attribute? :gender_filter, Types::Nominal::Integer
      attribute? :name, Types::Nominal::String
      attribute? :photos, Types.array
    end
  end

end
