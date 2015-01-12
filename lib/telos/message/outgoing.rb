module Telos
  class Message
    class Outgoing
      def initialize(command, arguments = {})
        @command = command
        @arguments = arguments
      end

      def to_bytes
        [
            dword(payload_size),
            dword(payload_xor),
            payload
        ].join
      end

      def payload
        [
            dword(@command),
            word(@arguments.size),
            @arguments.map do |name, argument|
              content = case argument
                        when String
                          [
                              "\x02", # Array Type
                              word(argument.length + 1), # Argument length + end
                              argument + "\x00"
                          ]
                        when Integer
                          [
                              "\x01", # DWORD type
                              dword(argument)
                          ]
                        end

              [
                  name.to_s.upcase,
                  content
              ]
            end
        ].flatten.join
      end

      def payload_size
        payload.size
      end

      def payload_xor
        0xA5A55A5A ^ payload_size
      end

      private
      def dword(content)
        [content].pack('N')
      end

      def word(content)
        [content].pack('n')
      end
    end
  end
end