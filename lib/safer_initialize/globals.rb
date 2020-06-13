module SaferInitialize
  class Globals < ActiveSupport::CurrentAttributes
    attribute :__safe

    def safe?
      !!__safe
    end
  end
end
