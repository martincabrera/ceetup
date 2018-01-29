# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'model is not valid' do
    it 'if name is empty' do
      topic = build(:topic, name: nil)
      expect(topic).to_not be_valid
    end

    it 'if name is already taken' do
      topic_name = 'Backend'
      create(:topic, name: topic_name)
      second_topic = build(:topic, name: topic_name)
      expect(second_topic).to_not be_valid
    end
  end
end
