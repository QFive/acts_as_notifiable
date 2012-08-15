class DummyCourier < ActsAsNotifiable::Couriers::BaseCourier
  def deliver
    "#{@notification.inspect} delivered!"
  end

  def prepare
    "#{@notification.inspect} prepared!"
  end
end
