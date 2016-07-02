module MinecraftPi
  class Error < ::RuntimeError
  end

  class FailError < Error
  end

  class SetBlockError < Error
  end
end
