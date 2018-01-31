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

  describe '.search' do
    let(:topic) { create(:topic) }
    let(:city) { create(:city) }
    let!(:event) { create(:event, city_id: city.id, start_date: Time.zone.now - 1.hour, end_date: Time.zone.now + 2.hours) }
    let!(:event_topic) { create(:event_topic, event: event, topic: topic) }

    context 'when all params are in range' do
      it 'finds an event' do
        events = described_class.search(city.id, Time.zone.now - 5.days, Time.zone.now + 5.days, topic.id)
        expect(events.count).to eq(1)
      end
    end

    context 'when searching in a different city' do
      it 'does not find an event' do
        different_city = create(:city, name: 'Las Palmas')
        events = described_class.search(different_city.id, Time.zone.now - 5.days, Time.zone.now + 5.days, topic.id)
        expect(city.name).to_not eq(different_city.name)
        expect(events.count.zero?).to be true
      end
    end

    context 'when searching for a different topic' do
      it 'does not find an event' do
        different_topic =  create(:topic, name: 'sysadmin')
        events = described_class.search(city.id, Time.zone.now - 5.days, Time.zone.now + 5.days, different_topic.id)
        expect(topic.name).to_not eq(different_topic.name)
        expect(events.count.zero?).to be true
      end
    end

    context 'when searching in a different date range' do
      it 'does not find an event' do
        events = described_class.search(city.id, Time.zone.now + 5.days, Time.zone.now + 10.days, topic.id)
        expect(events.count.zero?).to be true
      end
    end
  end
end
