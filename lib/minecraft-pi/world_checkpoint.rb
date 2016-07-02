require 'contracts'
require_relative 'socket'

module MinecraftPi
  class WorldCheckpoint
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => WorldCheckpoint
    def initialize(socket)
      @socket = socket
      self
    end

    Contract None => nil
    def save
      @socket.write 'world.checkpoint.save()'
    end

    Contract None => nil
    def restore
      @socket.write 'world.checkpoint.restore()'
    end
  end
end
