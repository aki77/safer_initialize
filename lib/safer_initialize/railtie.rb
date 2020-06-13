# frozen_string_literal: true

module SaferInitialize
  class Railtie < Rails::Railtie
    ActiveSupport.on_load :active_record do
      require 'safer_initialize/active_record/extensions'
      include SaferInitialize::ActiveRecord::Extensions
    end
  end
end
