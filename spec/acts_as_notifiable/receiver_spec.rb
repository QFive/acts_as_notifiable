require 'spec_helper'

describe ActsAsNotifiable::Receiver do
  let(:user) { build_stubbed(:user) }

  describe "ActiveRecord Associations" do
    it "should have notification associations" do
      user.respond_to?(:notifications).should be_true
    end

    it "should associate a notification with a user based as a receiver" do
      User.reflect_on_association(:notifications).options[:foreign_key].should == :receiver_id
    end

    it "should have notifications dependent on the receiver" do
      User.reflect_on_association(:notifications).options[:dependent].should == :destroy
    end
  end

  describe "#can_receive_notification?" do
    context "Default method" do
      it "returns true when the delivery check method is not defined" do
        user.can_receive_notification?(:message_notification, :email).should be_true
      end

      it "defines a method to handle future calls to the delivery check" do
        user.can_receive_notification?(:message_notification, :email)
        user.should respond_to :can_receive_message_notification_email?
      end
    end

    context "Class defined method" do
      it "uses the class defined instance method" do
        user.class_eval do
          define_method(:can_receive_message_notification_email?) do
            'foo'
          end
        end

        user.can_receive_notification?(:message_notification, :email).should == 'foo'
      end
    end
  end
end
