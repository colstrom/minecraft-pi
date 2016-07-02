require 'contracts'
require_relative 'socket'
require_relative 'camera_mode'

module MinecraftPi
  class Camera
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => Camera
    def initialize(socket)
      @socket = socket
      self
    end

    Contract None => CameraMode
    def mode
      @mode ||= CameraMode.new @socket
    end

    Contract RespondTo[:to_f], RespondTo[:to_f], RespondTo[:to_f] => nil
    def setPos(x, y, z)
      @socket.write "camera.setPos(#{x.to_f},#{y.to_f},#{z.to_f})"
    end
  end
end
