# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'is not valid' do
    it 'if name is empty' do
      topic = build(:event, name: nil)
      expect(topic).to_not be_valid
    end

    it 'if name is already taken in the same city' do
      topic_name = 'Backend'
      city = create(:city)
      create(:event, name: topic_name, city: city)
      second_topic = build(:event, name: topic_name, city: city)
      expect(second_topic).to_not be_valid
    end
  end

  describe 'is valid' do
    let(:first_city) { create(:city) }
    let(:second_city) { create(:city, name: 'Barcelona') }

    it 'if name exits but in another city' do
      topic_name = 'Backend'
      create(:event, name: topic_name, city: first_city)
      second_topic = build(:event, name: topic_name, city: second_city)
      expect(first_city.name).to_not eq(second_city.name)
      expect(second_topic).to be_valid
    end
  end
end
