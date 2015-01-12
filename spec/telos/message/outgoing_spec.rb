require 'spec_helper'

describe Telos::Message::Outgoing do
  describe "#to_bytes" do
    context "for a command without arguments" do
      subject { Telos::Message::Outgoing.new(1).to_bytes }
      it { is_expected.to byte_eq "\x00\x00\x00\x06\xA5\xA5\x5A\x5C\x00\x00\x00\x01\x00\x00" }
    end

    context "for a command with string arguments" do
      subject { Telos::Message::Outgoing.new(0, {'USER' => 'user', 'PASS' => 'pwd'}).to_bytes }
      it { is_expected.to byte_eq "\x00\x00\x00\x1D\xA5\xA5\x5A\x47\x00\x00\x00\x00\x00\x02\x55\x53\x45\x52\x02\x00\x05\x75\x73\x65\x72\x00\x50\x41\x53\x53\x02\x00\x04\x70\x77\x64\x00" }
    end

    context "for a command with integer arguments" do
      subject { Telos::Message::Outgoing.new(4, 'SSN_' => 1, 'SHOW' => 'show1', 'PASS' => 'pwd', 'HOST' => 'host1').to_bytes }
      it { is_expected.to byte_eq "\x00\x00\x00\x34\xA5\xA5\x5A\x6E\x00\x00\x00\x04\x00\x04\x53\x53\x4E\x5F\x01\x00\x00\x00\x01\x53\x48\x4F\x57\x02\x00\x06\x73\x68\x6F\x77\x31\x00\x50\x41\x53\x53\x02\x00\x04\x70\x77\x64\x00\x48\x4F\x53\x54\x02\x00\x06\x68\x6F\x73\x74\x31\x00" }
    end
  end
end

