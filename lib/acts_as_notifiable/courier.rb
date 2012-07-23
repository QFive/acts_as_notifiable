module ActsAsNotifiable
  class Courier

    def self.deliver(notification)
      instance = self.new(notification)
      instance.deliver 
    end

    def initialize(notification)
      @notification = notification
    end

    private

    def notifiable
      @notification.notifiable
    end
  end
end
