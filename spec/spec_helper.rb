require 'rspec'

ENV['RACK_ENV'] = "test"

require_relative '../initializer/mongoid'
require_relative '../lib/delta_pack_builder'
require_relative 'hoge'
require_relative 'huga'
require_relative '../lib/delta_pack_unpacker'
require_relative '../aggregators/deltas_aggregator'

def valid_hoge
  hoge = Hoge.new
  hoge.deviceToken = "dddddddd-e29b-41d4-a716-446655dd0000"
  hoge.gid = "550e8400-e29b-41d4-a716-446655440000"
  hoge.localTimestamp = 1234567789
  hoge
end

def valid_huga
  huga = Huga.new
  huga.deviceToken = "dddddddd-e29b-41d4-a716-446655dd0000"
  huga.gid = "550e8400-e29b-41d4-a716-446655440000"
  huga.localTimestamp = 1234567789
  huga
end