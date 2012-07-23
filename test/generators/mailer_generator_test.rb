require 'test_helper'

require 'generators/acts_as_notifiable/mailer_generator'

class MailerGenerator < Rails::Generators::TestCase
  tests ActsAsNotifiable::Generators::MailerGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "Assert files are created properly" do
    run_generator %w(comment)
    assert_file "app/mailers/comment_notification_mailer.rb", /class CommentNotificationMailer < ActionMailer::Base/
    assert_file "app/views/comment_notification_mailer/notification.html.erb"
  end
end
