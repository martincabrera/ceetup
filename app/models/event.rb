# frozen_string_literal: true

class Event < ApplicationRecord
  # associations
  belongs_to :city
  has_many :event_topics, dependent: :destroy
  has_many :topics, through: :event_topics

  # validations
  validates :name, presence: true
  validates :name, uniqueness: { scope: :city_id,
                                 message: ' is taken for this city' }
end
