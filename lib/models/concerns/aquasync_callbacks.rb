require 'active_support/concern'
require 'active_support/core_ext'

module Aquasync
  # Has a responsibility to implement format methods to obey AquasyncModel.
  # @see https://github.com/AQAquamarine/aquasync-protocol/blob/master/aquasync-model.md
  # @author kaiinui
  module Callbacks
    extend ActiveSupport::Concern

    included do
      before_validation do
        downcase_gid
        downcase_device_token
        set_ust
      end

      # gid should be lowercase (https://github.com/AQAquamarine/aquasync-protocol/blob/master/aquasync-model.md#aquasync-model)
      def downcase_gid
        self.gid.try(:downcase!)
      end

      # deviceToken should be lowercase (https://github.com/AQAquamarine/aquasync-protocol/blob/master/aquasync-model.md#aquasync-model)
      def downcase_device_token
        self.deviceToken.try(:downcase!)
      end

      # sets UST current UNIX timestamp
      def set_ust
        self.ust = Time.now.to_i
      end
    end
  end
end