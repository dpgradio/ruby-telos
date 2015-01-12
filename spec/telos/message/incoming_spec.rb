require 'spec_helper'

describe Telos::Message::Incoming do
  describe "#to_hash" do
    subject { Telos::Message::Incoming.new("\x00\x00\x00\x00\x00\x05SHOW\x02\x00\vHybrid 1&2\x00PASS\x01\x00\x00\x00\x00ACTV\x01\x00\x00\x00\x01HOST\x02\x00\x05Nx12\x00LAST\x01\x00\x00\x00\x00").to_hash }
    it "should return a correct hash" do
      is_expected.to eq({
                          "SHOW" => "Hybrid 1&2",
                          "PASS" => 0,
                          "ACTV" => 1,
                          "HOST" => "Nx12",
                          "LAST" => 0
                        })
    end
  end
end

