require 'mongoid'
require 'active_support/concern'
require 'active_support/core_ext'

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

      # MARK - CALLBACKS

      before_validation do
        downcase_gid
        downcase_device_token
        set_ust
      end

      def downcase_gid
        self.gid.try(:downcase!)
      end

      def downcase_device_token
        self.deviceToken.try(:downcase!)
      end

      # sets UST current UNIX timestamp
      def set_ust
        self.ust = Time.now.to_i
      end

      # MARK - Aggregated methods

      class << self
        def aq_deltas(ust)
          where(:ust.gt => ust)
        end

        def aq_commit_deltas(deltas)
          deltas.each {|delta| negotiate_delta(delta) }
        end

        def negotiate_delta(delta)
          record = find_by(gid: delta["gid"])
          if record
            record.resolve_conflict(delta)
          else
            create_record_from_delta(delta)
          end
        end

        def create_record_from_delta(delta)
          create(delta)
        end
      end

      def resolve_conflict(delta)
        # [PLACEHOLD]
      end

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