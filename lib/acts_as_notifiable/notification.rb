module ActsAsNotifiable
  class Notification < ActiveRecord::Base
    include ActsAsNotifiable::DeliveryMethods

    before_save :notifiable_before_save
    after_create :notifiable_after_create

    def notifiable_before_save
      notifiable_callback(notifiable, :before_save)
      notifiable_callback(self, :before_save)
    end

    def notifiable_after_create
      notifiable_callback(notifiable, :after_create)
      notifiable_callback(self, :after_create)
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
