require 'spec_helper'

describe ActsAsNotifiable::Receiver do

  it "should have notification associations" do
    @user = User.new
    @user.respond_to?(:notifications).should be_true
  end

  it "should associate a notification with a user based as a receiver" do
    User.reflect_on_association(:notifications).options[:foreign_key].should == :receiver_id
  end

  it "should have notifications dependent on the receiver" do
    User.reflect_on_association(:notifications).options[:dependent].should == :destroy
  end

end
