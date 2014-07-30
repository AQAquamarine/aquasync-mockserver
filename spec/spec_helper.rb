require 'rspec'

ENV['RACK_ENV'] = "test"

require_relative '../initializer/mongoid'
require_relative '../lib/delta_pack_builder'
require_relative 'hoge'
require_relative 'huga'

def valid_hoge
  hoge = Hoge.new
  hoge.deviceToken = "dddddddd-e29b-41d4-a716-446655dd0000"
  hoge.gid = "550e8400-e29b-41d4-a716-446655440000"
  hoge.localTimestamp = 1234567789
  hoge
end

def valid_huga
  hoge = Huga.new
  hoge.deviceToken = "dddddddd-e29b-41d4-a716-446655dd0000"
  hoge.gid = "550e8400-e29b-41d4-a716-446655440000"
  hoge.localTimestamp = 1234567789
  hoge
end