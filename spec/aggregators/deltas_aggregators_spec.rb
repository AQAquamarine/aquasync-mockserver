require_relative '../spec_helper'

describe DeltasAggregator do
  before(:context) do
    DatabaseCleaner.clean
    valid_hoge.save
    valid_hoge.save
    valid_huga.save
  end

  let(:aggregator) {
    aggregator = DeltasAggregator.new
    aggregator.regist_model_manager(Hoge, Huga)
    aggregator
  }

  describe "#pack_deltas" do
    context "when older latestUST is given" do
      let(:delta_pack) { aggregator.pack_deltas(1000000000) }

      it { expect(delta_pack).to include "_id" }
      it { expect(delta_pack["Hoge"].size).to eq 2 }
      it { expect(delta_pack["Huga"].size).to eq 1 }
    end

    context "when same latestUST is given" do
      let(:delta_pack) { aggregator.pack_deltas(1934567789) }

      it { expect(delta_pack).to include "_id" }
      it { expect(delta_pack["Hoge"].try(:size) || 0).to eq 0 }
    end

    context "when newer latestUST is given" do
      let(:delta_pack) { aggregator.pack_deltas(2000000000) }

      it { expect(delta_pack).to include "_id" }
      it { expect(delta_pack["Hoge"].try(:size) || 0).to eq 0 }
      it { expect(delta_pack["Huga"].try(:size) || 0).to eq 0 }
    end
  end
end