class Message < ActiveRecord::Base
  belongs_to :sender,   class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  notifiable :sender => :sender, :receiver => :receiver
  notify_via :email, :apns
end
