# frozen_string_literal: true

# == Schema Information
#
# Table name: event_topics
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_event_topics_on_event_id  (event_id)
#  index_event_topics_on_topic_id  (topic_id)
#

FactoryBot.define do
  factory :event_topic do
    event nil
    topic nil
  end
end
