# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe 'Admin Events request specs', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http status 200 when fetching page' do
      get admin_events_url
      expect(response).to have_http_status(:ok)
    end

    it 'redirects to new_user_session_path if admin is not logged in' do
      sign_out user
      get admin_events_url
      expect(response.status).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    context 'with invalid attributes' do
      it 'does not save the new event in the database if name is empty' do
        expect do
          post admin_events_url, params: {
            event: { name: '' }
          }
        end.not_to change(Event.all, :count)
      end
    end

    context 'with valid attributes' do
      it 'saves the new event in the database' do
        expect do
          event_attributes = attributes_for(:event).merge(city_id: create(:city).id).merge(topic_ids: [create(:topic).id])
          post admin_events_url, params: {
            event: event_attributes
          }
        end.to change(Event.all, :count).by(1)
      end

      it 'redirects to events#index' do
        event_attributes = attributes_for(:event).merge(city_id: create(:city).id)
        post admin_events_url, params: {
          event: event_attributes
        }
        expect(response).to redirect_to admin_events_path
      end

      it 'sends an email to the a user whose search filter matches this event and is not logged in' do
        city = create(:city)
        topic = create(:topic)
        create(:search_filter, user: create(:second_user), city: city, topic: topic, start_date: Time.zone.now - 15.days, end_date: Time.zone.now + 15.days)
        expect do
          event_attributes = attributes_for(:event).merge(city_id: city.id).merge(topic_ids: [topic.id]).merge(start_date: Time.zone.now + 10.minutes, end_date: Time.zone.now + 70.minutes)
          post admin_events_url, params: {
            event: event_attributes
          }
        end.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end
  end

  describe 'PATCH #update' do
    let(:event) { create(:event, city_id: create(:city).id) }

    context 'valid attributes' do
      it "changes event's attributes" do
        event_name = 'New event'
        patch admin_event_url(event), params: {
          event: attributes_for(:event,
                                name: event_name)
        }
        event.reload
        expect(event.name).to eq(event_name)
      end

      it 'redirects to events#index' do
        patch admin_event_url(event), params: { event: attributes_for(:event) }
        expect(response).to redirect_to admin_events_path
      end
    end

    context 'with invalid attributes' do
      it "does not change the event's attributes" do
        patch admin_event_url(event), params: {
          event: attributes_for(:event,
                                name: nil)
        }
        event.reload
        expect(event.name).not_to be nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:event) { create(:event, city_id: create(:city).id) }
    it 'destroys an event' do
      expect do
        delete admin_event_url(event)
      end.to change(Event.all, :count).by(-1)
    end
  end
end
