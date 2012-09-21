module ActsAsNotifiable
  module Couriers

    class ApnsCourier < ActsAsNotifiable::Couriers::BaseCourier
      def prepare
        flag_apns
      end

      def flag_apns
        @notification.apns = true
        @notification.apn_processed = false
      end

      def deliver!; end
    end

  end
end
