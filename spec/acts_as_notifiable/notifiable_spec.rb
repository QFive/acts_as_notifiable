require 'spec_helper'

describe ActsAsNotifiable::Notifiable do

  it "has many notifications" do
    message = Message.new
    message.should respond_to :notifications
  end

end
