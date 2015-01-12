module Telos
  class Error < StandardError; end

  class Message
    class ChecksumMismatch < Telos::Error; end
    autoload :Outgoing, "telos/message/outgoing"
    autoload :Incoming, "telos/message/incoming"

    class << self
      def outgoing(command, arguments = {})
        Outgoing.new(command, arguments)
      end

      def incoming(data)
        Incoming.new(data)
      end

      def response_size(data)
        size = data.slice(0,4).unpack('N')[0]
        checksum = data.slice(4,4).unpack('N')[0]

        raise(ChecksumMismatch) if size ^ 0xA5A55A5A != checksum

        size
      end
    end
  end
end