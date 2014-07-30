require 'simple_uuid'

class DeltaPackBuilder
  # delta_pack: Hash
  attr_accessor :delta_pack

  def initialize
    self.delta_pack = {}
    self.delta_pack["_id"] = uuid
  end

  def push(document)
    name = document._name
    initialize_array(name)
    self.delta_pack[name].push document.to_h
  end

  private

  def initialize_array(name)
    self.delta_pack[name] = [] unless self.delta_pack[name]
  end

  def push_documents(documents)
    documents.each {|d| push(d)}
  end

  # @return UUIDv1
  def uuid
    SimpleUUID::UUID.new.to_guid
  end
end