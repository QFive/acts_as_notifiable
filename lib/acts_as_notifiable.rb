require 'rails'

require 'acts_as_notifiable/notifiable'
require 'acts_as_notifiable/receiver'

if defined? ActiveRecord::Base
  ActiveRecord::Base.send :include, ActsAsNotifiable::Notifiable
  ActiveRecord::Base.send :include, ActsAsNotifiable::Receiver
end
