# frozen_string_literal: true

class City < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
end
