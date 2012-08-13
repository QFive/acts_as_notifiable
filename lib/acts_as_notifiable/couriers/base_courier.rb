module ActsAsNotifiable
  module Couriers

    # Base courier class for all couriers to inherit from
    # 
    # Provides a simple organization for delivering notifications
    class BaseCourier

      # Method to deliver a given notification with the courier
      #
      # @param [Notification] notification Notification to deliver
      def self.deliver(notification)
        instance = self.new(notification)
        instance.deliver 
      end

      def self.prepare(notification)
        instance = self.new(notification)
        instance.prepare
      end

      def initialize(notification)
        @notification = notification
      end

      # Delivery method which should handle delivery of the notification
      def deliver
        raise "Deliver must be implemented in child class"
      end

      def prepare; end

      private

      def notifiable
        @notification.notifiable
      end
    end

  end
end
