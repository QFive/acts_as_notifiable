module ActsAsNotifiable
  module Notifiable
    
    # Callbacks for a notifiable object to deliver a notification
    module Callback

      # Create a notification if there is a receiver to receive it
      def notification_callback
        notify if notify?
      end

      # Notify the receiver(s) of what happend
      def notify
        if enumerable_receiver?
          notice_receiver.each &method(:notify!)
        else
          notify! notice_receiver
        end
      end

      # Create a notification for the object to notify
      def notify!(to_notify)
        self.notifications.create :receiver      => to_notify,
                                  :sender        => notice_sender,
                                  :target        => notice_target
      end

      # Determine whether or not the notification should be sent
      def notify?
        !notice_receiver.nil?
      end

      # Interpret a target which can be either a proc or a method
      # evaluating it in the context of the instance of the notifable object
      def interpret_target(method)
        if method.is_a? Proc
          self.instance_eval(&method)
        else
          self.send(method)
        end
      end

      # Interpret the notice receiver
      def notice_receiver
        interpret_target(self.class.receiver)
      end

      # Interpret the notice sender
      def notice_sender
        interpret_target(self.class.sender)
      end

      # Interpret the notice target
      def notice_target
        interpret_target(self.class.target)
      end

      # Determine whether or not a receiver is enumerable
      def enumerable_receiver?
        notice_receiver.is_a? Enumerable
      end

    end

  end
end
