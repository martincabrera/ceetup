# frozen_string_literal: true

class EventTopic < ApplicationRecord
  belongs_to :event
  belongs_to :topic
end
