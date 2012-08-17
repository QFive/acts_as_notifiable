require 'spec_helper'

class Deliverable
  include ActsAsNotifiable::DeliveryMethods
end

class DeliverableWithMultipleCouriers
  include ActsAsNotifiable::DeliveryMethods
end

describe ActsAsNotifiable::DeliveryMethods do
  it "should inject a courier" do
    Deliverable.notify_via(:email)
    Deliverable.couriers.should == [ActsAsNotifiable::Couriers::EmailCourier]
  end

  it "should inject multiple couriers" do
    DeliverableWithMultipleCouriers.notify_via(:email, :dummy)
    DeliverableWithMultipleCouriers.couriers.should == [ActsAsNotifiable::Couriers::EmailCourier, DummyCourier]
  end
end
