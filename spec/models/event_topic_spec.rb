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


require 'rails_helper'

RSpec.describe EventTopic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
