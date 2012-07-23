module ActsAsNotifiable
  module Couriers
    module Apns

      def self.inject(notifiable)
        notifiable.notification_before_save << :apns
      end

      class Courier < ActsAsNotifiable::Courier
        def deliver
          flag_apns
        end

        def flag_apns
          @notification.apns = true
          @notification.apn_processed = false
        end
      end

    end
  end
end
