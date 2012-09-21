module ActsAsNotifiable
  module Couriers

    # Notify a notification receiver via email through ActionMailer 
    #
    # A given notification will be sent to the mailers 'notification' method
    # which will handle the formatting and delivery of the notification.
    #
    # A generator is available to bootstrap notification mailers
    #
    # @see <ActsAsNotifiable::Generators::MailerGenerator>
    class EmailCourier < ActsAsNotifiable::Couriers::BaseCourier

      # Deliver an email for the notification to the receiver
      def deliver!
        mailer.notification(@notification).deliver
      end

      # Retreive the mailer for delivering the notification
      #
      # In order to accomdate custom notification objects we must deliver
      # a mailer based off the notification class and not the notifiable object.
      def mailer
        if @notification.instance_of? ::Notification
          notifiable_mailer
        else
          notification_mailer
        end
      end

      # Retreive a mailer from the notifiable object
      def notifiable_mailer
        "#{@notification.notifiable.class}NotificationMailer".safe_constantize
      end

      # Retreive a mailer from the notification class
      def notification_mailer
        "#{@notification.class}Mailer".safe_constantize
      end

    end

  end
end
