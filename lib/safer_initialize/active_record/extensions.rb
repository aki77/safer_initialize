module SaferInitialize
  module ActiveRecord
    module Extensions
      extend ActiveSupport::Concern

      class_methods do
        def safer_initialize(filter = nil, message: 'initialize error', &block)
          after_initialize do |object|
            unless SaferInitialize::Globals.safe?
              result = filter ? object.send(filter) : object.instance_exec(object, &block)
              unless result
                SaferInitialize.configuration.error_handle.call(SaferInitialize::Error.new(message))
              end
            end
          end
        end
      end
    end
  end
end
