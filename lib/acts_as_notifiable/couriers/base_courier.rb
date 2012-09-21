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

      # Delivery method which should handle delivery of the notification
      def deliver
        deliver! if can_deliver?
      end

      def deliver!
        raise "Deliver must be implemented in child class"
      end

      def prepare; end

      def can_deliver?
        true
      end

      private

      def notifiable
        @notification.notifiable
      end
    end

  end
end
