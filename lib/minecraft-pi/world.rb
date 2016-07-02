require 'contracts'
require_relative 'error'
require_relative 'socket'
require_relative 'world_checkpoint'

module MinecraftPi
  class World
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => World
    def initialize(socket)
      @socket = socket
      self
    end

    Contract None => WorldCheckpoint
    def checkpoint
      @checkpoint ||= WorldCheckpoint.new @socket
    end

    # TODO: Should return a collection
    def getPlayerIds
      @socket.request 'world.getPlayerIds()'
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => Fixnum
    def getBlock(x, y, z)
      @socket.request("world.getBlock(#{x.to_i},#{y.to_i},#{z.to_i})").to_i
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => ArrayOf[Fixnum]
    def getBlockWithData(x, y, z)
      @socket
        .request("world.getBlockWithData(#{x.to_i},#{y.to_i},#{z.to_i})")
        .split(',')
        .map(&:to_i)
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => nil
    def setBlock(x, y, z, id, attempt = 1)
      @socket.write "world.setBlock(#{x.to_i},#{y.to_i},#{z.to_i},#{id.to_i})"
      raise SetBlockError if getBlock(x, y, z) != id
    rescue SetBlockError
      STDERR.puts "retry #{attempt}"
      setBlock(x, y, z, id, attempt.to_i + 1)
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => nil
    def setBlockWithData(x, y, z, id, data, attempt = 1)
      @socket.write "world.setBlock(#{x.to_i},#{y.to_i},#{z.to_i},#{id.to_i},#{data.to_i})"
      raise SetBlockError if getBlockWithData(x, y, z) != [id.to_i, data.to_i]
    rescue SetBlockError
      STDERR.puts "retry #{attempt}"
      setBlockWithData(x, y, z, id, data, attempt.to_i + 1)
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => nil
    def setBlocks(x1, y1, z1, x2, y2, z2, id)
      @socket.write "world.setBlocks(#{x1},#{y1},#{z1},#{x2},#{y2},#{z2},#{id})"
    end

    Contract RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i], RespondTo[:to_i] => nil
    def setBlocksWithData(x1, y1, z1, x2, y2, z2, id, data)
      @socket.write "world.setBlocks(#{x1.to_i},#{y1.to_i},#{z1.to_i},#{x2.to_i},#{y2.to_i},#{z2.to_i},#{id.to_i},#{data.to_i})"
    end

    Contract RespondTo[:to_i], RespondTo[:to_i] => Fixnum
    def getHeight(x, z)
      @socket.request("world.getHeight(#{x.to_i},#{z.to_i})").to_i
    end

    Contract Enum[:world_immutable, :nametags_visible], Bool => nil
    def setting(setting, status)
      @socket.write "world.setting(#{setting},#{status ? 1 : 0})"
    end
  end
end
