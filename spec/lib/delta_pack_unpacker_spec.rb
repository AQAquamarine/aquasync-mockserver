require_relative '../spec_helper'

describe DeltaPackUnpacker do
  let(:unpacker) { DeltaPackUnpacker.new }
  let(:delta_pack) {
    {
        "_id" => "hogahoga",
        "Book" => [
            {
                "id" => "1",
                "title" => "The Little Prince"
            }
        ],
        "Author" => [
            {
                "id" => "1",
                "name" => "Some Author"
            }
        ]
    }
  }

  context "#unpack" do
    let(:unpacked_delta) { unpacker.unpack(delta_pack).deltas }
    it { expect(unpacker.unpack(delta_pack).id).to eq "hogahoga" }
    it { expect(unpacked_delta).to include "Book" }
    it { expect(unpacked_delta).to include "Author" }
    it { expect(unpacked_delta["Book"].size).to eq 1 }
    it { expect(unpacked_delta["Author"].size).to eq 1 }
  end
end