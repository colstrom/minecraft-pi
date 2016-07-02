require 'contracts'
require 'socket'
require_relative 'error'

module MinecraftPi
  class Socket
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract KeywordArgs[
               address: Optional[RespondTo[:to_s]],
               port: Optional[RespondTo[:to_i]]
             ] => Socket
    def initialize(address: 'localhost', port: 4711)
      @socket = ::TCPSocket.new address.to_s, port.to_i
      self
    end

    Contract RespondTo[:to_s] => nil
    def write(message)
      message.to_s.tap do |m|
        STDERR.puts m
        @socket.puts m
      end
      nil
    end

    Contract None => String
    def read
      @socket.gets.chomp.tap { |reply| STDERR.puts "=> #{reply}" }
    end

    Contract RespondTo[:to_s], Maybe[RespondTo[:to_i]] => String
    def request(message, attempt = 1)
      write message.to_s
      read.tap { |reply| raise FailError if reply == 'Fail' }

    rescue FailError
      STDERR.puts "retry #{attempt}"
      sleep 0.1
      request(message, attempt.to_i + 1)
    end
  end
end
