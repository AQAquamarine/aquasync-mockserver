require_relative '../spec_helper'

describe DeltasAggregator do
  let(:aggregator) { DeltasAggregator.new }

  context "#pack_deltas" do
    let(:delta_pack) {
      aggregator.regist_model_manager(Hoge)
      aggregator.pack_deltas(122345)
    }

    it { expect(delta_pack).to include "_id" }
    it { expect(delta_pack["Hoge"].size).to be > 1 }
  end
end