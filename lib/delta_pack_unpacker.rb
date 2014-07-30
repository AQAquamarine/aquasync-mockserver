class DeltaPackUnpacker
  attr_accessor :id, :deltas

  def initialize
    self.deltas = {}
  end

  def unpack(delta_pack)
    self.id = delta_pack["_id"]
    delta_pack.each do |key, value|
      next if key == "_id"
      deltas[key] = value
    end
    self
  end
end