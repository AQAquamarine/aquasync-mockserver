require 'rspec'

ENV['RACK_ENV'] = "test"

require 'database_cleaner'
require 'active_support/core_ext'
require 'factory_girl'

require_relative '../initializer/mongoid'

require_relative 'hoge'
require_relative 'huga'
require_relative 'user'

require_relative 'factories/hoge'
require_relative 'factories/huga'
require_relative 'factories/user'



DatabaseCleaner.strategy = :truncation

def valid_hoge
  FactoryGirl.build :hoge
end

def valid_huga
  FactoryGirl.build :huga
end

def older_ust_delta_pack
  {
      "_id" => "550e8400-e29b-41d4-a716-446655dd0000",
      "Hoge" => [
          {
              "deviceToken" => "550e8400-e29b-41d4-a716-446655440000",
              "gid" => "550e8400-e29b-41d4-a716-446655440000",
              "localTimestamp" => 1034567789,
              "hoge" => "after"
          }
      ]
  }
end

def newer_ust_delta_pack
  {
      "_id" => "550e8400-e29b-41d4-a716-446655dd0000",
      "Hoge" => [
          {
              "deviceToken" => "550e8400-e29b-41d4-a716-446655dd0000",
              "gid" => "550e8400-e29b-41d4-a716-446655440000",
              "localTimestamp" => 2034567789,
              "hoge" => "after"
          }
      ]
  }
end

def new_gid_delta_pack
  {
      "_id" => "550e8400-e29b-41d4-a716-446655440000",
      "Hoge" => [
          {
              "deviceToken" => "550e8400-e29b-41d4-a716-446655dd0000",
              "gid" => "aaaaaaaa-e29b-41d4-a716-446655440000",
              "localTimestamp" => 2034567789,
              "hoge" => "new"
          }
      ]
  }
end

def valid_deltas
  [
      {
          "deviceToken" => "550e8400-e29b-41d4-a716-446655dd0000",
          "gid" => "acaaaaaa-e29b-41d4-a716-446655440000",
          "localTimestamp" => 2034567789,
          "hoge" => "new"
      },
      {
          "deviceToken" => "550f8400-e29b-41d4-a716-446655dd0000",
          "gid" => "acaaaaaa-e29b-41d4-a716-446655440000",
          "localTimestamp" => 2034567789,
          "hoge" => "new"
      },
      {
          "deviceToken" => "550e8400-e29b-41d4-a716-446655dd0000",
          "gid" => "adaaaaaa-e29b-41d4-a716-446655440000",
          "localTimestamp" => 2034567789,
          "hoge" => "new"
      }
  ]
end