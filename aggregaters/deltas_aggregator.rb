require_relative '../lib/delta_pack_builder'

# Has responsibility to
# 1. Commit a DeltaPack to registered models.
# 2. Pack a DeltaPack from registered models.
class DeltasAggregator
  attr_accessor :model_managers

  def initialize
    self.model_managers = {}
  end

  # Adds target models to aggregate.
  # @param klass [Aquasync::Base]
  def regist_model_manager(klass)
    name = klass.name
    model_managers[name] = klass
  end

  # Returns registered model manager from name.
  # @param [String] name
  # @return [Aquasync::Base]
  def model_manager_class(name)
    model_managers[name]
  end

  # Unpacks a DeltaPack and delegates #aq_commit_deltas to registered model managers.
  # @param [Hash] A DeltaPack (https://github.com/AQAquamarine/aquasync-protocol/blob/master/deltapack.md)
  def unpack_and_commit_delta_pack(delta_pack)
    unpacked_deltas = DeltaPackUnpacker.new.unpack(delta_pack).deltas
    unpacked_deltas.each do |model_name, deltas|
      manager = model_manager_class(model_name)
      manager.aq_commit_deltas deltas
    end # [TODO] raise error if any commit failed.
  end

  # Packs deltas collected from registered model managers via #aq_deltas to DeltaPack.
  # @param [Integer] from_ust latestUST
  # @return [Hash] A DeltaPack (https://github.com/AQAquamarine/aquasync-protocol/blob/master/deltapack.md)
  def pack_deltas(from_ust)
    builder = DeltaPackBuilder.new
    model_managers.each do |model_name, model_manager|
      builder.push_documents model_manager.aq_deltas(from_ust)
    end
    builder.delta_pack
  end
end