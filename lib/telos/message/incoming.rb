module Telos
  class Message
    class Incoming
      def initialize(data)
        @data = data
      end

      def command
        from_dword(@data.byteslice(0,4))
      end

      def argument_size
        from_word(@data.byteslice(4,2))
      end

      def arguments
        pos = 6
        arguments = {}
        argument_size.times do
          key = @data.byteslice(pos, 4)
          type = @data.byteslice(pos + 4, 1)
          case type
          when "\x02" # Array / String
            size = from_word(@data.byteslice(pos + 5, 2))
            value = @data.byteslice(pos + 7, size - 1)
            pos += 7 + size
          when "\x01" # DWord
            value = from_dword(@data.byteslice(pos + 5, 4))
            pos += 5 + 4
          end

          arguments[key] = value
        end

        arguments
      end

      def to_hash
        arguments
      end

      private
      def from_dword(string)
        string.unpack('N')[0]
      end

      def from_word(string)
        string.unpack('n')[0]
      end
    end
  end
end