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
    # by the given type and the given courier method. By default a receiver will
    # always be marked as able to receive a notification for a given courier.
    #
    # If you are looking to customize this behavior you must define the
    # can_receive_[notification_type]_notification_[courier] method in your model
    # which will allow control of whether or not to deliver the notification by
    # a given courier.
    #
    # For example, if you have a message notification which has custom logic behind
    # when you would want to send a notification via email to the receiver you could define
    # a method named *can_receive_message_notification_email?* on the user which returns true
    # whenever you would like to deliver an email notification.
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
