module SaferInitialize
  class Configuration
    attr_accessor :error_handle

    def initialize
      self.error_handle = -> (e) { raise e }
    end
  end
end
