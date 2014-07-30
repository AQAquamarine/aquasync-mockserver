require 'simple_uuid'

class DeltaPackBuilder
  # delta_pack: Hash
  attr_accessor :delta_pack

  def initialize
    self.delta_pack = {}
    self.delta_pack["_id"] = uuid
  end

  # @return UUIDv1
  def uuid
    SimpleUUID::UUID.new.to_guid
  end
end