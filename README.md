RSpec Tests: [![CircleCI](https://circleci.com/gh/patrickclery/tinder_client.svg?style=svg)](https://circleci.com/gh/patrickclery/tinder_client)

Code Coverage: [![codecov](https://codecov.io/gh/patrickclery/tinder_client/branch/master/graph/badge.svg)](https://codecov.io/gh/patrickclery/tinder_client)

# TinderClient

A Ruby gem to interact with Tinder's REST API.

## Usage

### Rake Commands

```ruby
rake tinder:updates          # Fetch updates
rake tinder:profile          # Fetch my profile
rake tinder:recommendations  # Fetch recommendations
rake tinder:save_token       # Save an API token to $token_path ake tinder:get_updates      # Fetch updates
```

To grab a token, call a rake command & specify the `phone_number` or `api_token` in your environment variables.

### `rake tinder:save_token`

```
$ rake tinder:save_token \
phone_number=15556667777 \
tinder_token_path=/tmp
Enter the confirmation code sent to 15556667777> 
123456
Validating...
Done!
Your refresh token is eyJhbGciOiJIUzI1NiJ9.MTc3ODk5MDk4MDM.5q4R0H08rE0Dd9KgxMPp6jcTfIBLCXgEuVZfC9znJTE
Logging in...
Done!
Your tinder API token is 12a3bc45-a123-123a-1a23-1234abc4de5f
Saved to /tmp/tinder_access_token.txt
```


### Use Tinder Test-Helpers in your RSpec Tests 

`tinder_client` has _[webmock](https://github.com/bblimke/webmock) stubs_ you can include in your project to get fake responses back from Tinder:

```ruby
gem_dir = Gem::Specification.find_by_name("tinder_client").gem_dir
require "#{gem_dir}/spec/tinder/contexts/http_request_stubs"

RSpec.describe 'some test' do
  include_context 'http_request_stubs'

  # Your tests that use Tinder HTTP requests go here
end 
```

## Accessing your saved data

`better_tinder` converts responses from Tinder from raw JSON data to `Dry::Struct`, for your convenience.

That means, call the services with your API token to return a struct:  

### `SaveRecommendations.call(api_token:)`

  ```ruby
  class Photo < Dry::Struct
    attribute :id, Types::Nominal::String
    attribute? :crop_info do
      attribute? :user do
        attribute :width_pct, Dry::Types['coercible.float']
        attribute :x_offset_pct, Types.float
        attribute :height_pct, Types.float
        attribute :y_offset_pct, Types.float
      end
      attribute? :algo do
        attribute :width_pct, Types.float
        attribute :x_offset_pct, Types.float
        attribute :height_pct, Types.float
        attribute :y_offset_pct, Types.float
      end
      attribute :processed_by_bullseye, Types::Nominal::Bool
      attribute :user_customized, Types::Nominal::Bool
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
    attribute :photos, Types.array.of(Photo)
    attribute :gender, Types::Nominal::Integer
    attribute :jobs, Types.array
    attribute :schools, Types.array do
      attribute :name, Types::Nominal::String
    end
    attribute? :city do
      attribute :name, Types::Nominal::String
    end
    attribute? :is_traveling, Types::Nominal::Bool
    attribute? :hide_age, Types::Nominal::Bool
    attribute? :hide_distance, Types::Nominal::Bool
  end

  # Return this object
  class Recommendation < Dry::Struct
    attribute :type, Types::Nominal::String
    attribute :user, User
    attribute :facebook do
      attribute :common_connections, Types.array
      attribute :connection_count, Types::Nominal::Integer
      attribute :common_interests, Types.array
    end
    attribute :spotify, Types.hash
    attribute :distance_mi, Types::Nominal::Integer
    attribute :content_hash, Types::Nominal::String
    attribute :s_number, Types::Nominal::Integer
    attribute :teasers, Types.array do
      attribute :type, Types::Nominal::String
      attribute :string, Types::Nominal::String
    end
  end
  ```


### `SaveUpdates.call(api_token:)`

  ```ruby
  class Message < Dry::Struct
    attribute :_id, Types::Nominal::String
    attribute :match_id, Types::Nominal::String
    attribute :sent_date, Types::Nominal::String
    attribute :message, Types::Nominal::String
    attribute :to, Types::Nominal::String
    attribute :from, Types::Nominal::String
    attribute :created_date, Types::Nominal::String
    attribute :timestamp, Types.send('coercible.string')
  end

  class LikedMessage < Dry::Struct
    attribute :message_id, Types::Nominal::String
    attribute :updated_at, Types::Nominal::String
    attribute :liker_id, Types::Nominal::String
    attribute :match_id, Types::Nominal::String
    attribute :is_liked, Types::Nominal::Bool
  end

  class Person < Dry::Struct
    attribute? :bio, Types::Nominal::String
    attribute :birth_date, Types::Nominal::String
    attribute :gender, Types::Nominal::Integer
    attribute :name, Types::Nominal::String
    attribute :ping_time, Types::Nominal::String
    attribute :photos, Types.array
  end

  class Match < Dry::Struct
    attribute :_id, Types::Nominal::String
    attribute :closed, Types::Nominal::Bool
    attribute :common_friend_count, Types::Nominal::Integer
    attribute :common_like_count, Types::Nominal::Integer
    attribute :created_date, Types::Nominal::String
    attribute :dead, Types::Nominal::Bool
    attribute :following, Types::Nominal::Bool
    attribute :following_moments, Types::Nominal::Bool
    attribute :id, Types::Nominal::String
    attribute :is_boost_match, Types::Nominal::Bool
    attribute :is_fast_match, Types::Nominal::Bool
    attribute :is_super_like, Types::Nominal::Bool
    attribute :last_activity_date, Types::Nominal::String
    attribute :message_count, Types::Nominal::Integer
    attribute :messages, Types.array.of(Message)
    attribute :muted, Types::Nominal::Bool
    attribute :participants, Types.array
    attribute :pending, Types::Nominal::Bool
    attribute :person, Person
    attribute :readreceipt, Types.hash
    attribute :seen, Types.hash
  end

  class Updates < Dry::Struct
    attribute :blocks, Types.array.of(Types::Nominal::String)
    attribute :deleted_lists, Types.array
    attribute :goingout, Types.array
    attribute :harassing_messages, Types.array
    attribute :inbox, Types.array.of(Message)
    attribute :poll_interval, Types.hash
    attribute :liked_messages, Types.array.of(LikedMessage)
    attribute :lists, Types.array
    attribute :matches, Types.array.of(Match)
    attribute :squads, Types.array
  end
  ```

