require 'generators/acts_as_notifiable/generator_helpers'

module ActsAsNotifiable
  module Generators

    # Generate an ActionMailer dedicated to delivering notifications via email
    class MailerGenerator < Rails::Generators::NamedBase
      include GeneratorHelpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Generate a Rails mailer to deliver an email for a notification"
      def create_mailer_file
        template "mailer.rb", File.join("app/mailers", "#{valid_mailer_file_name}.rb")
        template "mailer_view.html.erb", File.join("app/views/#{valid_mailer_file_name}/notification.html.erb")
      end

      hook_for :test_framework, as: :mailer do |instance, mailer|
        instance.invoke mailer, [instance.mailer_class_name]
      end

      def mailer_class_name
        valid_notification_class_name + 'Mailer'
      end

      def valid_mailer_file_name
        valid_notification_file_name + '_mailer'
      end

    end
  end
end
