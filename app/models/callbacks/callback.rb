module Callbacks
  module Callback
    extend ActiveSupport::Concern

    included do
      mattr_accessor :initiator
      self.initiator = true

      attr_accessor :m

      define_method callback do |model|
        return unless initiator
        begin
          self.initiator = false
          self.m = model
          try :init
          __send__ "call"
        ensure
          self.initiator = true
        end
      end
    end

    class_methods do
      def callback
        "#{name.demodulize.underscore.split('_').last(2).join('_')}"
      end
    end
  end
end
