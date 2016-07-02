require 'contracts'
require_relative 'events_block'
require_relative 'socket'

module MinecraftPi
  class Events
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => Events
    def initialize(socket)
      @socket = socket
      self
    end

    Contract None => EventsBlock
    def block
      @block ||= EventsBlock.new @socket
    end

    Contract None => nil
    def clear
      @socket.write 'events.clear()'
    end
  end
end
