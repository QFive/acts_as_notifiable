require 'spec_helper'

class Comment
  include ActsAsNotifiable::DeliveryMethods
end

describe ActsAsNotifiable::Couriers::Email do
  it "should associate itself with the notification's after_create" do
    ActsAsNotifiable::Couriers::Email.inject(Comment)
    Comment.notification_after_create.should == [:email]
  end

  it "should call a mailer for a notifiable" do
    message = Message.new
    notification = Notification.new(:notifiable => message)

    courier = ActsAsNotifiable::Couriers::Email::Courier.new(notification)
    courier.mailer.should == MessageNotificationMailer
  end

  it "should call a mailer for a notification" do
    pending
  end
end
