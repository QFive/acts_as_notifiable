module ActsAsNotifiable
  module DeliveryMethods
    extend ActiveSupport::Concern

    module ClassMethods

      # Specify a courier to deliver notifications with
      #
      # @param [Symbol] courier The courier name as a symbol
      def notify_via(*couriers)
        couriers.each { |courier| add_courier courier }
      end

      def add_courier(courier_sym)
        courier = courier_by_name(courier_sym)
        couriers << courier
      end

      # Hold onto a collection of couriers that will be in charge of delivering
      # a notification
      #
      # @return <#Array>
      def couriers
        @couriers ||= []
      end

      # Retrieve the courier given by name as a constant within
      # the ActsAsNotifiable namespace
      #
      # @param [Symbol] name The name of the courier to deliver via
      def courier_by_name(name)
        name = name.to_s + "_courier"
        name = name.camelize
        ActsAsNotifiable::Couriers.const_get(name)
      end

    end

    # Delivers a given notification with the courier specified
    #
    # @param [Symbol] courier Courier name as a symbol
    # @param [Notification] notification The notification for the courier to deliver
    def deliver_via(courier, notification)
      self.class.courier(courier)::Courier.deliver notification
    end

  end
end
