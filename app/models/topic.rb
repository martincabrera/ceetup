# frozen_string_literal: true

class Topic < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
end
