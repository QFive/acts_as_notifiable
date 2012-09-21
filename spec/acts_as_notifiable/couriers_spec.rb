require 'spec_helper'

class TestCourier < ActsAsNotifiable::Couriers::BaseCourier; end

describe ActsAsNotifiable::Couriers::BaseCourier do
  let(:notification) { double("Notification" ) }
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
end
