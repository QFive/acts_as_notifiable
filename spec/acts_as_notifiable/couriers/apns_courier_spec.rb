require 'spec_helper'

describe ActsAsNotifiable::Couriers::ApnsCourier do
  it "should flag a notification as apns" do
    message = Message.new
    notification = Notification.new(:notifiable => message)
    notification.apns.should be_false
    notification.prepare
    notification.apns.should be_true
  end
end
