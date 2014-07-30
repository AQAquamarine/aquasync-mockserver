require 'rspec'

ENV['RACK_ENV'] = "test"

require_relative '../initializer/mongoid'
require_relative '../models/hoge.rb'
require_relative '../lib/delta_pack_builder'
