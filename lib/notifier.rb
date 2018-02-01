class Notifier
  include Rails.application.routes.url_helpers

  attr_reader :event

  def initialize(event)
    @event = event
  end

  def notify
    SearchFilter.by_city_id(event.city_id).by_topic_ids(event.topics.map(&:id)).in_range(event.start_date, event.end_date).each do |search_filter|
      send_notification(User.find(search_filter.user_id), event)
    end
  end

  private

  def send_notification(user, event)
    if user.online?
      send_live_notification(user, event)
    else
      send_mail_notification(user, event)
    end

  end

  def send_live_notification(user, event)
    ActionCable.server.broadcast "notifications:#{user.id}",
                                 { html: "<div style='padding-left:5px'>There is the new event called '#{event.name}' in #{event.city_name} that matches your search filters <a href='#{admin_event_path(event)}'>here</a></div>" }
  end

  def send_mail_notification(user, event)
    NotificationMailer.event_notification_email(user, event).deliver_now
  end
end
