module ActsAsNotifiable
  module Receiver
    extend ActiveSupport::Concern

    module ClassMethods
      def receives_notifications(opts={})
        class_eval do
          has_many :notifications,  opts.merge(:foreign_key => :receiver_id, :dependent => :destroy)

          def method_missing_with_delivery_method_check(method_name, *args, &block)
            if method_name =~ /can_receive_[a-z]+_notification_[a-z]+\?/
              self.class_eval do
                define_method(method_name) do
                  true
                end
              end
            else
              method_missing_without_delivery_method_check(method_name, *args, &block)
            end
          end
          alias_method_chain :method_missing, :delivery_method_check

        end
      end
    end
  end
end
