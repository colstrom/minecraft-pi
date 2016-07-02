require 'contracts'
require_relative 'socket'

module MinecraftPi
  class Chat
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract Socket => Chat
    def initialize(socket)
      @socket = socket
      self
    end

    Contract RespondTo[:to_s] => nil
    def post(message)
      @socket.write "chat.post(#{message})"
    end
  end
end
