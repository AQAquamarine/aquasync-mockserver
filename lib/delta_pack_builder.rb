require 'simple_uuid'
require 'json'

class DeltaPackBuilder
  # delta_pack: Hash
  attr_accessor :delta_pack

  def initialize
    self.delta_pack = {}
    self.delta_pack["_id"] = uuid
  end

  # @param document [Aquasync::Base] a resource which inherits Aquasync::Base
  def push(document)
    name = document._name
    initialize_array(name)
    self.delta_pack[name].push document.to_h
  end

  # @param document [Collection<Aquasync::Base>] resources which inherits Aquasync::Base
  def push_documents(documents)
    documents.each {|d| push(d)}
  end

  # @return [String] JSON string
  def json
    delta_pack.to_json
  end

  # @return [String] pretty printed JSON
  def pretty_json
    JSON.pretty_generate(delta_pack)
  end

  private

  # @param [String] name model name
  def initialize_array(name)
    self.delta_pack[name] = [] unless self.delta_pack[name]
  end

  # @return UUIDv1
  def uuid
    SimpleUUID::UUID.new.to_guid
  end
end