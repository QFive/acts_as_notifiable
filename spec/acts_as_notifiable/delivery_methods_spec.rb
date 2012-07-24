require 'spec_helper'

class Deliverable
  include ActsAsNotifiable::DeliveryMethods
end

describe ActsAsNotifiable::DeliveryMethods do
  it "should inject a courier" do
    ActsAsNotifiable::Couriers::Email.should_receive(:inject).with(Deliverable)
    Deliverable.notify_via(:email)
  end
end
