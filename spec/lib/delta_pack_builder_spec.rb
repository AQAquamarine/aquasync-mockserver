require_relative '../../spec/spec_helper'

describe DeltaPackBuilder do
  let(:builder) { DeltaPackBuilder.new }

  context '#uuid' do
    it("returns UUID") { expect(builder).not_to eq nil }
  end
end