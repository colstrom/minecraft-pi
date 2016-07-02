require 'contracts'
require_relative 'socket'

module MinecraftPi
  class Entity
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => Entity
    def initialize(socket)
      @socket = socket
      self
    end

    Contract RespondTo[:to_i] => ArrayOf[Float]
    def getPos(entity)
      @socket
        .request("entity.getPos(#{entity.to_i})")
        .split(',')
        .map(&:to_f)
    end

    Contract RespondTo[:to_i], RespondTo[:to_f], RespondTo[:to_f], RespondTo[:to_f] => nil
    def setPos(entity, x, y, z)
      @socket
        .write("entity.setPos(#{entity.to_i},#{x.to_f},#{y.to_f},#{z.to_f})")
    end

    Contract RespondTo[:to_i] => ArrayOf[Fixnum]
    def getTile(entity)
      @socket
        .request("entity.getTile(#{entity.to_i})")
        .split(',')
        .map(&:to_i)
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => nil
    def setTile(entity, x, y, z)
      @socket
        .write("entity.setTile(#{entity.to_i},#{x.to_i},#{y.to_i},#{z.to_i})")
    end
  end
end
