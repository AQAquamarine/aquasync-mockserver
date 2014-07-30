require_relative '../spec_helper'

describe Hoge do
  let(:hoge) { Hoge.new }

  context "#before_save" do
    it("ust are set when saved") {
      hoge.save
      expect(hoge.ust).to_not eq nil
    }
  end

  context "#to_h" do
    it("does not include _id") { expect(hoge.to_h).not_to include "_id"}
  end

  context "#_name" do
    it { expect(hoge._name).to eq :hoges }
  end
end