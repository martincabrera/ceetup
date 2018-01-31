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


FactoryBot.define do
  factory :event do
    name 'Ruby meetup'
    start_date '2018-01-30 21:18:58'
    end_date '2018-01-30 23:18:58'
    city nil
  end
end
