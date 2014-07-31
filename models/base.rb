require 'mongoid'
require 'active_support/concern'
require_relative 'concerns/aquasync_callbacks'
require_relative 'concerns/aquasync_aggregated_methods'
require_relative 'concerns/aquasync_delta_pack_methods'
require_relative '../validators/aquasync_validator'

module Aquasync
  # Is a concern to mixin AquasyncModel requirements.
  # @see https://github.com/AQAquamarine/aquasync-protocol/blob/master/aquasync-model.md
  # @author kaiinui
  module Base
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document

      # should be UNIX timestamp
      # @example 1406697904
      field :ust, type: Integer
      # should be UNIX timestamp
      # @example 1406697904
      field :localTimestamp, type: Integer
      # should be UUIDv1
      # @example 550e8400-e29b-41d4-a716-446655440000
      field :gid, type: String
      # should be UUIDv1
      # @example 550e8400-e29b-41d4-a716-446655440000
      field :deviceToken, type: String
      # for paranoid deletion
      # @example false
      field :isDeleted, type: Boolean

      validates_with Aquasync::Validator

      include Aquasync::Callbacks
      include Aquasync::AggregatedMethods
      include Aquasync::DeltaPackMethods
    end
  end
end