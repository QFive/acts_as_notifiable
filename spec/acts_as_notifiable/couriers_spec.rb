require 'spec_helper'

class ActsAsNotifiable::Couriers::SpecCourier < ActsAsNotifiable::Couriers::BaseCourier
  include ActsAsNotifiable::DeliveryMethods

  def prepare_notification(notification)
  end
end

describe ActsAsNotifiable::Couriers::BaseCourier do
  it "should deliver a notification" do
    pending
  end
end
