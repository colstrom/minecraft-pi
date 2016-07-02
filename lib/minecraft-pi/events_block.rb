require 'contracts'
require_relative 'socket'

module MinecraftPi
  class EventsBlock
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => EventsBlock
    def initialize(socket)
      @socket = socket
      self
    end

    Contract None => ArrayOf[ArrayOf[Fixnum]]
    def hits
      @socket
        .request('events.block.hits()')
        .split('|')
        .map { |event| event.split(',').map(&:to_i) }
    end
  end
end
