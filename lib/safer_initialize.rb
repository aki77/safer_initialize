require 'safer_initialize/version'
require 'safer_initialize/globals'
require 'safer_initialize/configuration'
require 'safer_initialize/railtie'

module SaferInitialize
  class Error < StandardError; end

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  module_function

  def with_safe(&block)
    Globals.set(__safe: true, &block)
  end
end
