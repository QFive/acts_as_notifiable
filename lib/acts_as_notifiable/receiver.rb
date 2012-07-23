module ActsAsNotifiable
  module Receiver
    extend ActiveSupport::Concern

    module ClassMethods
      def receives_notifications(opts={})
        class_eval do
          has_many :notifications,  opts.merge(:foreign_key => :receiver_id, :dependent => :destroy)
        end
      end
    end

  end
end
