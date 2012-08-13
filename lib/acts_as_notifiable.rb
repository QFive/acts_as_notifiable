require 'rails'

require 'acts_as_notifiable/notifiable'
require 'acts_as_notifiable/receiver'
require 'acts_as_notifiable/couriers'
require 'acts_as_notifiable/delivery_methods'
require 'acts_as_notifiable/notification'
require 'acts_as_notifiable/notifiable/callback'

if defined? ActiveRecord::Base
  ActiveRecord::Base.send :include, ActsAsNotifiable::Notifiable
  ActiveRecord::Base.send :include, ActsAsNotifiable::Receiver
end
