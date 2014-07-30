require 'mongoid'
require 'active_support/concern'

module Aquasync
  module Base
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document

      field :ust, type: Integer

      before_save do
        set_ust
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