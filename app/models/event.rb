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
end
