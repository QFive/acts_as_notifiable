module ActsAsNotifiable
  module Couriers
    module Email

      def self.inject(notifiable)
        notifiable.notification_after_create << :email
      end

      class Courier < ActsAsNotifiable::Courier

        def deliver
          mailer.delay.notification @notification
        end

        def mailer
          if @notification.instance_of? ::Notification
            notifiable_mailer
          else
            notification_mailer
          end
        end

        def notifiable_mailer
          "#{@notification.notifiable.class}NotificationMailer".safe_constantize
        end

        def notification_mailer
          "#{@notification.class}Mailer".safe_constantize
        end

      end

    end
  end
end
