# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SearchFilters', type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'returns a 200 http status code' do
      get search_filters_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:city) { create(:city) }
    let(:events_header) { 'List of events that matched this filter:' }
    let(:no_events_header) { 'No events found that matched this filter' }

    before do
      sign_in user
    end

    context 'when we have an event for this search filter' do
      it 'shows the we-have-events header' do
        event = create(:event, city_id: city.id, start_date: Time.zone.now - 1.hour, end_date: Time.zone.now + 2.hours)
        create(:event_topic, event: event, topic: topic)
        search_filter = create(:search_filter, user_id: user.id, city_id: city.id, start_date: Time.zone.now - 10.days,
                                               end_date: Time.zone.now + 10.days, topic_id: topic.id)
        get search_filter_url(search_filter)
        expect(response.body).to include(events_header)
      end
    end

    context 'when we do NOT have an event for this search filter' do
      it 'shows the we-do-not-have-events header' do
        event = create(:event, city_id: city.id, start_date: Time.zone.now - 1.hour, end_date: Time.zone.now + 2.hours)
        create(:event_topic, event: event, topic: topic)
        search_filter = create(:search_filter, user_id: user.id, city_id: city.id, start_date: Time.zone.now + 10.days,
                                               end_date: Time.zone.now + 20.days, topic_id: topic.id)
        get search_filter_url(search_filter)
        expect(response.body).to include(no_events_header)
      end
    end
  end
end
