require 'socket'

module Telos
  class Device
    attr_accessor :host, :port

    def initialize(host:, port: 9998)
      self.host = host
      self.port = port
    end

    def shows
    end

    def connect(reader_thread: false)
      @server = TCPSocket.new host, port
      start_reader_thread if reader_thread
      if block_given?
        yield
        stop_reader_thread if reader_thread
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
      if @mutex
        @mutex.synchronize do
          @messages.shift
        end
      else
        _read
      end
    end

    private
    def _read
      response_size = Message.response_size(@server.read(8))
      Message.incoming(@server.read(response_size))
    end

    def start_reader_thread
      @messages = []
      @mutex = Mutex.new
      @reader_thread ||= Thread.start(@messages) do |messages|
        loop do
          message = _read
          @mutex.synchronize do
            messages << message
          end
        end
      end
      Thread.pass # Make sure the reader thread starts
    end

    def stop_reader_thread
      @reader_thread.terminate if @reader_thread
    end
  end
end