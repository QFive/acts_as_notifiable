require 'spec_helper'

describe ActsAsNotifiable::Courier do
  it "should deliver a notification" do
    notification = double("Notification")

    ActsAsNotifiable::Courier.any_instance.should_receive(:deliver)
    ActsAsNotifiable::Courier.deliver(notification)
  end
end
