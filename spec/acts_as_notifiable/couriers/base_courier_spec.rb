require 'spec_helper'

class TestCourier < ActsAsNotifiable::Couriers::BaseCourier; end
class NewMessageNotification < Notification
  include ActsAsNotifiable::Notification
end

FactoryGirl.define do
  factory :new_message_notification do
  end
end

describe ActsAsNotifiable::Couriers::BaseCourier do
  let(:receiver) { build_stubbed(:user) }
  let(:notifiable) { build_stubbed(:message) }
  let(:notification) { build_stubbed(:notification, notifiable: notifiable, receiver: receiver) }
  subject { TestCourier.new(notification)  }

  describe ".deliver" do
    it "builds a new instance and delivers the notification with the courier" do
      courier = double("Courier", deliver: nil)
      TestCourier.should_receive(:new).and_return(courier)
      courier.should_receive(:deliver)
      TestCourier.deliver(notification)
    end
  end

  describe ".prepare" do
    it "builds a new instance and prepares the notification with the courier" do
      courier = double('Courier', prepare: nil)
      TestCourier.should_receive(:new).and_return(courier)
      courier.should_receive(:prepare)
      TestCourier.prepare(notification)
    end
  end

  describe "#deliver" do
    context "Can deliver to receiver" do
      it "will call deliver!" do
        subject.stub(:can_deliver?).and_return(true)
        subject.should_receive(:deliver!)
        subject.deliver
      end
    end

    context "Cannot deliver to receiver" do
      it "will not call deliver!" do
        subject.stub(:can_deliver?).and_return(false)
        subject.should_not_receive(:deliver!)
        subject.deliver
      end
    end
  end

  describe "#deliver!" do
    it "must be implemented by an inherited class" do
      expect { subject.deliver! }.to raise_error("Deliver must be implemented in child class")
    end
  end

  describe "#can_deliver?" do
    context "Custom Notification Class" do
      let(:notification) { build_stubbed(:new_message_notification, receiver: receiver) }
      it "checks with the receiver if it can receiver a notification for the custom notification class and courier" do
        receiver.should_receive(:can_receive_notification?).with(:new_message_notification, :test)
        subject.can_deliver?
      end
    end

    context "Generic Notification Class" do
      it "checks with the receiver if it can receive a notification for the notifiable object and courier" do
        receiver.should_receive(:can_receive_notification?).with(:message_notification, :test)
        subject.can_deliver?
      end
    end
  end
end
