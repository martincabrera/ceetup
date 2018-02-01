include Rails.application.routes.url_helpers

class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def event_notification_email(user, event)
    @user = user
    @event = event
    @url = admin_event_url(event)
    mail(to: @user.email, subject: 'New Event of your interest!')
  end
end
