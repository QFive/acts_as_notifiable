module ActsAsNotifiable
  module Notification
    extend ActiveSupport::Concern

    included do
      class_eval do
        include ActsAsNotifiable::DeliveryMethods

        before_create :notifiable_before_create
        after_create :notifiable_after_create

        scope :apn, where(:apns => true)
        scope :unprocessed, where(:apn_processed => false)
      end
    end

    def notifiable_before_create
      notifiable_callback(notifiable, :before_create)
      notifiable_callback(self, :before_create)

      true
    end

    def notifiable_after_create
      notifiable_callback(notifiable, :after_create)
      notifiable_callback(self, :after_create)

      true
    end

    def notifiable_callback(obj, chain)
      chain = "notification_#{chain}"
      return unless obj.class.respond_to? chain
      obj.class.send(chain).each do |c|
        obj.deliver_via(c, self)
      end
    end

  end
end
