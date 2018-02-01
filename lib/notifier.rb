# frozen_string_literal: true

class Notifier
  include Rails.application.routes.url_helpers

  attr_reader :event

  def initialize(event)
    @event = event
  end

  def notify
    search_filter_scope.each do |search_filter|
      send_notification(search_filter.user_id, event)
    end
  end

  private

  def search_filter_scope
    topic_ids = event.topics.map(&:id)
    SearchFilter.by_city_id(event.city_id).by_topic_ids(topic_ids).in_range(event.start_date, event.end_date)
  end

  def send_notification(user_id, event)
    user = User.find(user_id)
    if user.online?
      send_live_notification(user, event)
    else
      send_mail_notification(user, event)
    end
  end

  def send_live_notification(user, event)
    html = ApplicationController.render partial: 'notification_channel/event_notification_message',
                                        locals: { event: event, url: admin_event_path(event) }, formats: [:html]
    ActionCable.server.broadcast "notifications:#{user.id}", html: html
  end

  def send_mail_notification(user, event)
    NotificationMailer.event_notification_email(user, event).deliver_now
  end
end
