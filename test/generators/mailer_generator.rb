require 'test_helper'

class MailerGenerator < Rails::Generators::TestCase
  tests ActsAsNotifiable::Generators::MailerGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "Assert files are created properly" do
    run_generator "comment"
    assert_file "app/mailers/comment_notification_mailer.rb"
    asser_file "app/view/comment_notification_mailer/notification.html.erb"
  end
end
