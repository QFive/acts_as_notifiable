module ActsAsNotifiable
  module Receiver
    extend ActiveSupport::Concern

    module ClassMethods
      def receives_notifications(opts={})
        class_eval do
          has_many :notifications,  opts.merge(:foreign_key => :receiver_id, :dependent => :destroy)
        end
      end
    end

    # Determine whether or not a receiver can receive a notification
    # by the given type and the given courier method
    #
    # @param [Symbol] Type of notification to be delivered
    # @param [Symbol] Name of the courier being used to deliver the notification
    def can_receive_notification?(notification_type, courier_name)
      method = "can_receive_#{notification_type}_#{courier_name}?".to_sym
      unless respond_to?(method)
        self.class_eval do
          define_method(method) { true }
        end
      end

      send(method)
    end

  end
end
