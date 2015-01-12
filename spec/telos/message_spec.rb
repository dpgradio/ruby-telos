require 'spec_helper'

describe Telos::Message do
  describe ".response_size" do
    it 'should report the correct size' do
      expect(
          Telos::Message.response_size("\x00\x00\x00\x3f\xA5\xA5\x5A\x65")
      ).to eq 63
    end

    it 'should raise an error when the checksum is incorrect' do
      expect {
          Telos::Message.response_size("\x00\x00\x00\x3f\xA5\xA5\x5A\x64")
      }.to raise_error(Telos::Message::ChecksumMismatch)
    end
  end
end

