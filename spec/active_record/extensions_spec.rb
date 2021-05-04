require 'safer_initialize/active_record/extensions'

RSpec.describe SaferInitialize::ActiveRecord::Extensions do
  describe '.safer_initialize' do
    it 'If non active, raise SaferInitialize::Error' do
      class ActiveCheck < DummyRecord
        attr_accessor :deleted_at

        safer_initialize :active?, message: 'Not active project!'

        def active?
          deleted_at.nil?
        end
      end

      expect {
        ActiveCheck.new(deleted_at: nil)
      }.not_to raise_error

      expect {
        ActiveCheck.new(deleted_at: Time.current)
      }.to raise_error(SaferInitialize::Error, 'Not active project!')
    end

    it 'raise SaferInitialize::Error with proc message' do
      class MessageWithProc < DummyRecord
        attr_accessor :deleted_at, :name

        safer_initialize :active?, message: ->(record) { "#{record.name} is not active!" }

        def active?
          deleted_at.nil?
        end
      end

      expect {
        MessageWithProc.new(deleted_at: Time.current, name: 'safer_initialize')
      }.to raise_error(SaferInitialize::Error, 'safer_initialize is not active!')
    end
  end
end
