require 'active_support/concern'

module Aquasync
  # Has a responsibility to implement Aquasync::DeltasAggregator requirement.
  # @author kaiinui
  module AggregatedMethods
    extend ActiveSupport::Concern

    included do
      # @param [Hash]
      def resolve_conflict(delta)
        self.update_attributes(delta) if delta["localTimestamp"] > self.localTimestamp
      end
    end

    module ClassMethods
      # DeltasAggregator requirement
      # @return [Array<Aquasync::Base>]
      def aq_deltas(ust)
        where(:ust.gt => ust)
      end

      # DeltasAggregator requirement
      # @return [NilClass]
      def aq_commit_deltas(deltas)
        deltas.each {|delta| commit_delta(delta) }
      end

      # commits a delta.
      # @param [Hash]
      def commit_delta(delta)
        record = find_by(gid: delta["gid"])
        if record
          record.resolve_conflict(delta)
        else
          create_record_from_delta(delta)
        end
      end

      # @param [Hash]
      def create_record_from_delta(delta)
        create(delta)
      end
    end
  end
end