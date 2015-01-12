require 'socket'

module Telos
  class Device
    attr_accessor :host, :port

    def initialize(host:, port: 9998)
      self.host = host
      self.port = port
    end

    def connect
      @server = TCPSocket.new host, port
      if block_given?
        yield
        @server.close
      end
    end

    def disconnect
      @server.close
    end

    def write(command, arguments = {})
      message = Message.outgoing(command, arguments)

      @server.write(message.to_bytes)
    end

    def read
      response_size = Message.response_size(@server.read(8))
      Message.incoming(@server.read(response_size))
    end
  end
end