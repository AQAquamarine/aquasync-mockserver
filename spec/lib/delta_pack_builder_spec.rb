require_relative '../../spec/spec_helper'

describe DeltaPackBuilder do
  let(:builder) { DeltaPackBuilder.new }

  context "#push" do
    let(:hoge) { valid_hoge }
    let(:huga) { valid_huga }
    before(:each) do
      builder.push hoge
      builder.push hoge
      builder.push hoge
      builder.push huga
    end

    it { expect(builder.delta_pack).to include "_id" }
    it { expect(builder.delta_pack).to include "Hoge" }
    it { expect(builder.delta_pack).to include "Huga" }
    it { expect(builder.delta_pack["Hoge"].size).to eq 3 }
    it { expect(builder.delta_pack["Huga"].size).to eq 1 }
  end

  context '#uuid' do
    it("returns UUID") { expect(builder.send(:uuid)).not_to eq nil }
  end
end