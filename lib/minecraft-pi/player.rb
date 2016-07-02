require 'contracts'
require_relative 'socket'

module MinecraftPi
  class Player
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => Player
    def initialize(socket)
      @socket = socket
      self
    end

    Contract None => ArrayOf[Float]
    def getPos
      @socket
        .request('player.getPos()')
        .split(',')
        .map(&:to_f)
    end

    Contract RespondTo[:to_f], RespondTo[:to_f], RespondTo[:to_f] => nil
    def setPos(x, y, z)
      @socket.write "player.setPos(#{x.to_f},#{y.to_f},#{z.to_f})"
    end

    Contract None => ArrayOf[Fixnum]
    def getTile
      @socket
        .request('player.getTile()')
        .split(',')
        .map(&:to_i)
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => nil
    def setTile(x, y, z)
      @socket.write "player.setTile(#{x.to_i},#{y.to_i},#{z.to_i})"
    end
  end
end
