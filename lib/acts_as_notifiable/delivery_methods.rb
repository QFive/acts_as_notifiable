module ActsAsNotifiable
  module DeliveryMethods
    extend ActiveSupport::Concern

    module ClassMethods

      def notify_via(method)
        delivery_method =  delivery_method(method)
        delivery_method.inject self
      end

      def notification_before_craete
        @before_create ||= []
      end

      def notification_after_create
        @after_create ||= []
      end

      def delivery_method(name)
        name = name.to_s.camelize
        ActsAsNotifiable::Couriers.const_get(name)
      end

    end

    def deliver_via(method, notification)
      self.class.delivery_method(method)::Courier.deliver notification
    end

  end
end
