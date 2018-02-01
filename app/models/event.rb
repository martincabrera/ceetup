# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string
#  start_date :datetime
#  end_date   :datetime
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_events_on_city_id  (city_id)
#

class Event < ApplicationRecord
  # callbacks
  after_create :notify_users

  # associations
  belongs_to :city
  has_many :event_topics, dependent: :destroy
  has_many :topics, through: :event_topics

  # validations
  validates :name, presence: true
  validates :name, uniqueness: { scope: :city_id,
                                 message: ' is taken for this city' }
  validates :start_date, presence: true
  validates :end_date, presence: true

  # scopes
  scope :by_city_id, ->(id) { joins(:city).includes(:city).where('cities.id = ?', id) }
  scope :in_date_range, ->(start_date, end_date) { where('start_date >= ? AND end_date <= ?', start_date, end_date) }
  scope :by_topic_id, ->(id) { joins(:event_topics).includes(:event_topics).where('event_topics.topic_id = ?', id) }

  # delegations
  delegate :name, to: :city, prefix: true

  def self.search(city_id, start_date, end_date, topic_id)
    scope = unscoped.by_city_id(city_id)
    scope = scope.in_date_range(start_date, end_date)
    scope = scope.by_topic_id(topic_id)
    scope
  end

  private

  def notify_users
    Notifier.new(self).notify
  end
end
