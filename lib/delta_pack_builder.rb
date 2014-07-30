require 'simple_uuid'

class DeltaPackBuilder
  # delta_pack: Hash
  attr_accessor :delta_pack

  # @return UUIDv1
  def uuid
    SimpleUUID::UUID.new.to_guid
  end
end