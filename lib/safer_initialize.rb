require 'safer_initialize/version'
require 'safer_initialize/globals'
require 'safer_initialize/railtie'

module SaferInitialize
  class Error < StandardError; end

  module_function

  def with_safe(&block)
    Globals.set(__safe: true, &block)
  end
end
