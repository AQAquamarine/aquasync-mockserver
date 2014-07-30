require 'mongoid'
require 'active_support/concern'

module Aquasync
  module Base
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document

      field :ust, type: Integer
      field :isDirty, type: Boolean
      field :localTimestamp, type: DateTime
      field :gid, type: String
      field :deviceToken, type: String
      field :isDeleted, type: Boolean

      # UUID like 550e8400-e29b-41d4-a716-446655440000
      validates :gid, format: { with: /^([0-9abcdef].*-?)$/}

      before_save do
        downcase_gid
        set_ust
      end

      def downcase_gid
        self.gid.downcase!
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