require 'active_model/validator'

module Aquasync
  # Has a responsibility to implement AquasyncModel validations.
  # @see https://github.com/AQAquamarine/aquasync-protocol/blob/master/aquasync-model.md
  # @author kaiinui
  # @example usage
  #   validates_with Aquasync::Validator
  class Validator < ActiveModel::Validator
    def validate(record)
      record.validates_presence_of :gid
      record.validates_format_of :gid, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
      record.validates_presence_of :ust
      record.validates_presence_of :deviceToken
      record.validates_format_of :deviceToken, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
      record.validates_presence_of :localTimestamp
    end
  end
end