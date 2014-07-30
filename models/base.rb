require 'mongoid'

module Aquasync
  class Base
    include Mongoid::Document

    field :ust, type: Integer

    before_save do
      set_ust
    end

    def set_ust
      self.ust = Time.now.to_i
    end
  end
end