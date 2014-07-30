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
    it("allows lowercase UUID values for :gid") {
      hoge.gid = "550e8400-e29b-41d4-a716-446655440000"
      expect(hoge.valid?).to eq true
    }
    it("does not allow not-UUID value for :gid") {
      hoge.gid = "hugahuga"
      expect(hoge.valid?).to eq false
    }
  end

  context "#to_h" do
    it("does not include _id") { expect(hoge.to_h).not_to include "_id"}
  end

  context "#_name" do
    it { expect(hoge._name).to eq :hoges }
  end
end