require_relative '../spec_helper'

describe Hoge do
  let(:hoge) { Hoge.new }

  context "#before_save" do
    before(:each) do
      hoge.gid = "550E8400-E29B-41D4-A716-446655440000"
      hoge.save
    end
    it("ust are set when saved") {
      expect(hoge.ust).to_not eq nil
    }

    it("gid should be lowercase") {
      expect(hoge.gid).to eq "550e8400-e29b-41d4-a716-446655440000"
    }
  end

  context "validation" do
    before(:each) do
      hoge.deviceToken = "dddddddd-e29b-41d4-a716-446655dd0000"
      hoge.gid = "550e8400-e29b-41d4-a716-446655440000"
      hoge.localTimestamp = 1234567789
    end

    it("does not allow nil for :gid") {
      hoge.gid = nil
      expect(hoge.valid?).to eq false
    }

    it("does not allow nil for :deviceToken") {
      hoge.deviceToken = nil
      expect(hoge.valid?).to eq false
    }

    it("does not allow nil for :localTimestamp") {
      hoge.localTimestamp = nil
      expect(hoge.valid?).to eq false
    }
    it("allows lowercase UUID values for :gid") {
      hoge.gid = "550e8400-e29b-41d4-a716-446655440000"
      expect(hoge.valid?).to eq true
    }
    it("does not allow not-UUID value for :gid") {
      hoge.gid = "hugahuga"
      expect(hoge.valid?).to eq false
    }
    it("allows lowercase UUID values for :deviceToken") {
      hoge.deviceToken = "550e8400-e29b-41d4-a716-446655440000"
      expect(hoge.valid?).to eq true
    }
    it("does not allow not-UUID value for :deviceToken") {
      hoge.deviceToken = "hugahuga"
      expect(hoge.valid?).to eq false
    }
  end

  context "#to_h" do
    it("does not include _id") { expect(hoge.to_h).not_to include "_id"}
    it("does not include ust") { expect(hoge.to_h).not_to include "ust" }
  end

  context "#_name" do
    it { expect(hoge._name).to eq "Hoge" }
  end
end