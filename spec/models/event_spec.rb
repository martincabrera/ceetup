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
      create(:event, name: topic_name, city_id: city.id )
      second_topic = build(:event, name: topic_name, city_id: city.id)
      expect(second_topic).to_not be_valid
    end
  end

  describe 'is valid' do

    let(:first_city) { create(:city) }
    let(:second_city) { create(:city, name: 'Barcelona') }

    it 'if name exits but in another city' do
      topic_name = 'Backend'
      create(:event, name: topic_name, city_id: city_id = first_city.id )
      second_topic = build(:event, name: topic_name, city_id: second_city.id)
      expect(second_topic).to be_valid
    end
  end
end
