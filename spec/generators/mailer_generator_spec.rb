require 'spec_helper'
require 'generators/acts_as_notifiable/mailer_generator'

describe ActsAsNotifiable::Generators::MailerGenerator do
  destination File.expand_path("../../tmp", __FILE__)

  describe "mailer" do
    before { run_generator %w(comment) }
    subject { file "app/mailers/comment_notification_mailer.rb" }
    it { should exist }
  end

end
