# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true

  # associations
  has_many :event_topics, dependent: :destroy
  has_many :events, through: :event_topics
end
