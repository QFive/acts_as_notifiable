class Notification < ActiveRecord::Base
  include ActsAsNotifiable::Notification
  attr_accessor :apns, :apn_processed
end
