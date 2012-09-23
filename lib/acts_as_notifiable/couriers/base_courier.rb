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
        @notification.receiver.can_receive_notification? notification_type, courier_name
      end

      protected

      def notifiable
        @notification.notifiable
      end

      def notification_type
        if @notification.instance_of? ::Notification
          "#{notifiable.class.to_s.underscore.downcase}_notification".to_sym
        else
          @notification.class.to_s.underscore.downcase.to_sym
        end
      end

      def courier_name
        self.class.to_s.demodulize.downcase.gsub('courier', '').to_sym
      end
    end

  end
end
