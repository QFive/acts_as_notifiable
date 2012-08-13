require 'spec_helper'

describe ActsAsNotifiable::Couriers::EmailCourier do
  it "should call a mailer for a notifiable" do
    message = Message.new
    notification = Notification.new(:notifiable => message)

    courier = ActsAsNotifiable::Couriers::EmailCourier.new(notification)
    courier.mailer.should == MessageNotificationMailer
  end

  it "should call a mailer for a notification" do
    pending
  end
end
