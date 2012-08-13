class Notification < ActiveRecord::Base
  include ActsAsNotifiable::Notification
  belongs_to :notifiable, :polymorphic => true
  attr_accessible :notifiable
  attr_accessor :apns, :apn_processed
end
