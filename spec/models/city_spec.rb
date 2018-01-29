# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'model is not valid' do
    it 'if name is empty' do
      city = build(:city, name: nil)
      expect(city).to_not be_valid
    end

    it 'if name is already taken' do
      city_name = 'Barcelona'
      create(:city, name: city_name)
      second_city = build(:city, name: city_name)
      expect(second_city).to_not be_valid
    end
  end
end
