# frozen_string_literal: true

# == Schema Information
#
# Table name: search_filters
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  city_id    :integer
#  start_date :datetime
#  end_date   :datetime
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_search_filters_on_city_id   (city_id)
#  index_search_filters_on_topic_id  (topic_id)
#  index_search_filters_on_user_id   (user_id)
#

FactoryBot.define do
  factory :search_filter do
    user nil
    city nil
    start_date '2018-01-31 20:22:24'
    end_date '2018-01-31 20:22:24'
    topic nil
  end
end
