class <%= mailer_class_name %> < ActionMailer::Base
  def notification(notification)
    subject = "#{notification.sender.name} did something"
    @sender     = notification.sender
    @receiver   = notification.receiver
    @notifiable = notification.notifiable
    mail(to: notification.receiver.email, subject: subject)
  end
end
