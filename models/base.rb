require 'mongoid'
require 'active_support/concern'
require 'active_support/core_ext'

module Aquasync
  module Base
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document

      field :ust, type: Integer
      field :localTimestamp, type: DateTime
      field :gid, type: String
      field :deviceToken, type: String
      field :isDeleted, type: Boolean

      validates_presence_of :gid
      # UUID like 550e8400-e29b-41d4-a716-446655440000
      validates_format_of :gid, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
      validates_presence_of :ust
      validates_presence_of :deviceToken
      # UUID like 550e8400-e29b-41d4-a716-446655440000
      validates_format_of :deviceToken, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
      validates_presence_of :localTimestamp

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

      def set_ust
        self.ust = Time.now.to_i
      end

      def _name
        self.class.collection_name
      end

      def to_h
        serializable_hash.select {|key, value| key != "_id"}
      end
    end
  end
end