require 'active_support/concern'

module Aquasync
  module AggregatedMethods
    extend ActiveSupport::Concern

    included do
      # @param [Hash] A Delta
      def resolve_conflict(delta)
        self.update_attributes(delta) if delta["localTimestamp"] > self.localTimestamp
      end
    end

    module ClassMethods
      def aq_deltas(ust)
        where(:ust.gt => ust)
      end

      def aq_commit_deltas(deltas)
        deltas.each {|delta| commit_delta(delta) }
      end

      # commits a delta.
      # @param [Hash] A Delta
      def commit_delta(delta)
        record = find_by(gid: delta["gid"])
        if record
          record.resolve_conflict(delta)
        else
          create_record_from_delta(delta)
        end
      end

      # @param [Hash] A Delta
      def create_record_from_delta(delta)
        create(delta)
      end
    end
  end
end