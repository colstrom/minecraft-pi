require 'contracts'
require_relative 'socket'

module MinecraftPi
  class CameraMode
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => CameraMode
    def initialize(socket)
      @socket = socket
      self
    end

    Contract RespondTo[:to_i] => nil
    def setNormal(entity)
      @socket.write "camera.mode.setNormal(#{entity.to_i})"
    end

    Contract RespondTo[:to_i] => nil
    def setFollow(entity)
      @socket.write "camera.mode.setFollow(#{entity.to_i})"
    end

    Contract None => nil
    def setFixed
      @socket.write 'camera.mode.setFixed()'
    end
  end
end
