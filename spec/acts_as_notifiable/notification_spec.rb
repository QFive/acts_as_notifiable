require 'spec_helper'

class Courier; end
class Notifiable; end
class CommentNotification < Notification
  class << self
    def couriers
      [Courier]
    end
  end
end

describe ActsAsNotifiable::Notification do

  describe "#couriers" do

    let(:message) { Message.new }

    it "should return couriers defined on the notification class" do
      message.class.stub(:couriers).and_return([])
      notification = CommentNotification.new(notifiable: message)
      notification.couriers.should == [Courier]
    end

    it "should return couriers defined on the notifiable class" do
      notification = Notification.new(notifiable: message)
      notification.couriers.should == [ActsAsNotifiable::Couriers::EmailCourier, ActsAsNotifiable::Couriers::ApnsCourier]
    end

    it "should return the combination of notifiable couriers and notification couriers" do
      notification = CommentNotification.new(notifiable: message)
      notification.couriers.should == [ActsAsNotifiable::Couriers::EmailCourier, ActsAsNotifiable::Couriers::ApnsCourier, Courier]
    end
  end

  describe "#deliver_notification" do

    let(:notification) { Notification.new(notifiable: Message.new) }

    context "for notifiable" do
      it "should call deliver on each courier specified on notifiable" do
        ActsAsNotifiable::Couriers::EmailCourier.should_receive(:deliver)
        notification.deliver
      end

      it "should call prepare on each courier specified on notifiable" do
        ActsAsNotifiable::Couriers::ApnsCourier.should_receive(:prepare)
        notification.prepare
      end
    end

    context "Custom notification class" do

      let(:message) { Message.new }
      let(:notification) { CommentNotification.new(notifiable: message) }
      before { notification.stub(:couriers).and_return([Courier]) }

      it "should prepare via couriers specified on the notification class" do
        Courier.should_receive(:prepare)
        notification.prepare
      end

      it "should deliver via couriers specified on the notification class" do
        Courier.should_receive(:deliver)
        notification.deliver
      end

    end
  end

end
