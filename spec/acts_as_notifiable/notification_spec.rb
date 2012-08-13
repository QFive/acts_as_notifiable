require 'spec_helper'

describe ActsAsNotifiable::Notification do

  describe "#deliver_notification" do
    it "should call deliver on each courier specified on notifiable" do
      message = Message.new
      notification = Notification.new(notifiable: message)

      ActsAsNotifiable::Couriers::EmailCourier.should_receive(:deliver)
      notification.deliver
    end

    it "should call prepare on each courier specified on notifiable" do
      message = Message.new
      notification = Notification.new(notifiable: message)
      ActsAsNotifiable::Couriers::ApnsCourier.should_receive(:prepare)
      notification.prepare
    end
  end

end
