require 'spec_helper'

class CustomNotification; end
class CustomNotificationMailer; end

describe ActsAsNotifiable::Couriers::EmailCourier do
  let(:notification) { Notification.new(notifiable: Message.new) }
  let(:courier) { ActsAsNotifiable::Couriers::EmailCourier.new(notification) }

  describe "#deliver!" do
    it "delivers an email" do
      mail = double("Mail", deliver: nil)
      MessageNotificationMailer.should_receive(:notification).and_return(mail)
      mail.should_receive(:deliver)
      courier.deliver!
    end
  end

  describe "#mailer" do
    context "Notification instance" do
      it "generates a mailer for the notifiable object" do
        courier.mailer.should == MessageNotificationMailer
      end
    end

    context "Custom notification class" do
      let(:notification) { CustomNotification.new }

      it "should call a mailer for a notification" do
        courier.mailer.should == CustomNotificationMailer
      end
    end
  end

end
