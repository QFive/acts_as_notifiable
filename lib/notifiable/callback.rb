module ActsAsNotifiable
  module Notifiable
    module Callback

      def notification_callback
        notify
      end

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

      def interpret_target(method)
        if method.is_a? Proc
          self.instance_eval(&method)
        else
          self.send(method)
        end
      end

      def notice_receiver
        interpret_target(self.class.receiver)
      end

      def notice_sender
        interpret_target(self.class.sender)
      end

      def notice_target
        interpret_target(self.class.target)
      end

      def enumerable_receiver?
        notice_receiver.is_a? Enumerable
      end

    end
  end
end
