module ActsAsNotifiable
  module Couriers

    # Base courier class for all couriers to inherit from
    #
    # A courier has 2 main abilities: 
    #
    # 1. Prepare a notification for delivery, allowing the courier to make modifications
    #    to the notification object before it get's created by hooking into ActiveModel's
    #    before_create callback.
    #
    # 2. Deliver the notification in some means. Delivery will be done after a notification
    #    via ActiveModel's after_create callback
    # 
    # Provides a simple organization for delivering notifications
    class BaseCourier

      # Method to deliver a given notification with the courier
      #
      # This will instantiate a courier object and deliver the notification
      #
      # @param [Notification] notification Notification to deliver
      def self.deliver(notification)
        instance = self.new(notification)
        instance.deliver 
      end

      # Method for preparing a given notification with the courier
      #
      # This will instantiate a courier object and call prepare
      #
      # @param [Notification] notification The notification to prepare
      def self.prepare(notification)
        instance = self.new(notification)
        instance.prepare
      end

      def initialize(notification)
        @notification = notification
      end

      def deliver
        deliver! if can_deliver?
      end

      def deliver!
        raise "Deliver must be implemented in child class"
      end

      def prepare; end

      # Determine whether or not the receiver of the notification can
      # actually receive it.
      #
      # @see #delivery_check_metho
      def can_deliver?
        @notification.receiver.send delivery_check_method
      end

      protected

      def notifiable
        @notification.notifiable
      end

      # Build out a method name to call on the notification receiver which can
      # determine whether or not the receiver should receive a notification from the courier
      # for this notification.
      #
      # When using a custom Notification class, the method will be built off the custom notification class
      # 
      # @example NewMessageNotification with EmailCourier
      #   @notification = NewMessageNotification.new
      #   delivery_check_method # => can_receive_new_message_notification_email?
      #
      # @example General notification class with EmailCourier
      #   @notification = Notification.new(notifiable: Message.new)
      #   delivery_check_method # => can_receive_message_notification_email?
      def delivery_check_method
        method = "can_receive_"
        if @notification.instance_of? ::Notification
          method << notifiable.class.to_s.underscore.downcase
          method << '_notification'
        else
          method << @notification.class.to_s.underscore.downcase
        end

        method << "_"
        method << self.class.to_s.demodulize.downcase.gsub('courier', '')
        method << '?'
      end
    end

  end
end
