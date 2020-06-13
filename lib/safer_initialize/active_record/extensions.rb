module SaferInitialize
  module ActiveRecord
    module Extensions
      extend ActiveSupport::Concern

      class_methods do
        def safer_initialize(proc, message: 'initialize error')
          after_initialize -> do
            if !SaferInitialize::Globals.safe? && !instance_exec(&proc)
              raise SaferInitialize::Error, message
            end
          end
        end
      end
    end
  end
end
