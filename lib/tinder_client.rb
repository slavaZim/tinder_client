require 'dry_helper.rb'
require 'google/protobuf'
require "json"
require 'faraday'
require 'tinder/client'
require 'tinder/profile'
require 'tinder/account_settings'
require 'tinder/get_recommendations'
require 'tinder/get_updates'
require 'tinder/profile'
require 'tinder/like'
require 'tinder/pass'
require 'authgateway_pb'

module Tinder

  class UnexpectedResponse < StandardError
  end
  class RateLimited < StandardError;
  end
  class ClientNotAuthenticated < StandardError;
  end
  class ConnectionTimeout < StandardError;
  end
  class NoResultsLeft < StandardError;
  end
  class OutOfLikes < StandardError;
  end

end
