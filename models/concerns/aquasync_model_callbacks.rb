require 'active_support/concern'

module Aquasync
  module ModelCallbacks
    extend ActiveSupport::Concern

    included do
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
    end
  end
end