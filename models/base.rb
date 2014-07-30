require 'mongoid'
require 'active_support/concern'
require 'active_support/core_ext'
require_relative 'concerns/aquasync_model_callbacks'
require_relative 'concerns/aquasync_aggregated_methods'

module Aquasync
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

      validates_presence_of :gid
      validates_format_of :gid, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
      validates_presence_of :ust
      validates_presence_of :deviceToken
      validates_format_of :deviceToken, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
      validates_presence_of :localTimestamp

      include Aquasync::ModelCallbacks
      include Aquasync::AggregatedMethods

      # returns its class name. Hoge for "Hoge".
      # @return [Symbol]
      def _name
        self.class.name
      end

      # returns serialized hash whose _id is excluded.
      # @return [Hash]
      def to_h
        serializable_hash.delete_if {|key| key == "_id" or key == "ust"}
      end
    end
  end
end