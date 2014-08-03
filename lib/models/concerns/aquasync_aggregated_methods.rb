require 'active_support/concern'
require 'active_support/inflector'

module Aquasync
  # Has a responsibility to implement Aquasync::DeltasAggregator requirement.
  # @author kaiinui
  # @see DeltasAggregator
  module AggregatedMethods
    extend ActiveSupport::Concern

    included do
      # @param [Hash]
      def resolve_conflict(delta)
        raise "localTimestamp is nil" if delta["localTimestamp"] == nil
        self.update_attributes!(delta) if delta["localTimestamp"] > self.localTimestamp
      end
    end

    module ClassMethods
      # DeltasAggregator requirement
      # @return [Array<Aquasync::Base>]
      def aq_deltas(ust, opts = {})
        begin_of_association_chain(opts).where(:ust.gt => ust)
      end

      # DeltasAggregator requirement
      # @return [NilClass]
      def aq_commit_deltas(deltas, opts = {})
        deltas.each {|d|
          delta = append_attributes(d, opts)
          commit_delta(delta, opts)
        }
      end

      # Handle :append_attributes option.
      # @param [Hash]
      def append_attributes(delta, opts)
        return delta unless opts[:append_attributes]
        atr = opts[:append_attributes]
        klass = self.name
        delta.merge!(atr[:all]) if atr[:all]
        delta.merge!(atr[klass]) if atr[klass]
        delta
      end

      # commits a delta.
      # @param [Hash]
      def commit_delta(delta, opts)
        record = begin_of_association_chain(opts).find_by(gid: delta["gid"])
        if record
          record.resolve_conflict(delta)
        else
          create_record_from_delta(delta, opts)
        end
      end

      # @param [Hash]
      def create_record_from_delta(delta, opts)
        begin_of_association_chain(opts).create!(delta)
      end

      def begin_of_association_chain(opts)
        model = opts[:begin_of_association_chain]
        if(model)
          # current_user Book => current_user.books
          model.send(self.name.downcase.pluralize)
        else
          self
        end
      end
    end
  end
end