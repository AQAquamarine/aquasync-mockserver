require 'active_support/concern'

module Aquasync
  # Has a responsibility to implement DeltaPackBuilder requirement.
  # @author kaiinui
  module DeltaPackMethods
    extend ActiveSupport::Concern

    included do
      # returns its class name. Hoge for "Hoge".
      # *DeltaPackBuilder Requirement
      # @return [Symbol]
      def _name
        self.class.name
      end

      # returns serialized hash whose _id is excluded.
      # *DeltaPackBuilder Requirement
      # @return [Hash]
      def to_h
        serializable_hash.delete_if {|key| key == "_id" or key == "ust"}
      end
    end
  end
end