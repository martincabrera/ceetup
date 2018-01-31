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

class SearchFilter < ApplicationRecord
  belongs_to :user
  belongs_to :city
  belongs_to :topic
end
