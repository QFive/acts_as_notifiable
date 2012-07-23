# Mixin for defining a model as being notifiable or as an object which can receive notifications
#
# Receiver of notifications
# ========================
# has_many :notifications, :foreign_key => :receiver_id
#
# Notifiable
# ==========
# has_many :notifications, :as => :notifiable, :dependent => :destroy
#
# An after_create callback will be added for the notifiable object which will generate a notification
# and default to return true to ensure that the sequence of events continues as required 
#
# Notifications can be flagged as an Apple Push Notification
# @see http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008194-CH1-SW1
module ActsAsNotifiable
  module Notifiable
    extend ActiveSupport::Concern

    module ClassMethods

      # Define a model as being notifiable setting up any relations that are required
      #
      # @param [Hash] opts Options to set up the notification to be sent
      #
      # @option opts [Symbol|Proc] :sender Define who in the model will be responsible to play the role of sender
      # of the notification. This can either be a symbol which defines a method to call on the notifiable model
      # or a proc to call which will be evaluated on the instance of the notifiable model
      #
      # @option opts [Symbol|Proc] :receiver Define who will play the role of receiver. A receiver can only be a
      # user instance or a collection of users. receiver can either be a symbol which corresponds to a method that 
      # can be called on the notifiable model or a proc which should return a user or collection of users
      #
      # @option opts [Symbol|Target] :target (Optional) The target defines the real target the notification action
      # is being performed on in the event that the receiver of the notification is not really the target.
      # For example, a Program cannot receive notifications on its own. Rather a 
      def notifiable(*args)
        opts = args.extract_options!

        @delivery_options = args

        @sender              = opts [:sender]
        @target              = opts [:target] || opts[:receiver]
        @receiver            = opts [:receiver]

        setup_notification
      end

      private 

      def setup_notification
        class_eval do
          class << self
            attr_reader :sender, :receiver, :target
          end

          include ActsAsNotifiable::DeliveryMethods
          include ActsAsNotifiable::Notifiable::Callback

          has_many :notifications, :as => :notifiable, :dependent => :destroy
          after_create :notification_callback
        end
      end
    end

  end
end
