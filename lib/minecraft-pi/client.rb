require 'contracts'
require_relative 'camera'
require_relative 'chat'
require_relative 'entity'
require_relative 'events'
require_relative 'player'
require_relative 'socket'
require_relative 'world'

module MinecraftPi
  class Client
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract KeywordArgs[
               address: Optional[RespondTo[:to_s]],
               port: Optional[RespondTo[:to_i]]
             ] => Client
    def initialize(address: 'localhost', port: 4711)
      @address = address.to_s
      @port = port.to_i
      self
    end

    Contract None => Socket
    def socket
      @socket ||= Socket.new(address: @address, port: @port)
    end

    Contract None => Camera
    def camera
      @camera ||= Camera.new socket
    end

    Contract None => Chat
    def chat
      @chat ||= Chat.new socket
    end

    Contract None => Entity
    def entity
      @entity ||= Entity.new socket
    end

    Contract None => Events
    def events
      @events ||= Events.new socket
    end

    Contract None => Player
    def player
      @player ||= Player.new socket
    end

    Contract None => World
    def world
      @world ||= World.new socket
    end
  end
end
