# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#online?' do
    let(:user) { create(:user) }

    before do
      RedisConnection.connection.set(user.id, nil, ex: 10 * 60)
    end

    context 'when user is signed in' do
      it 'returns true' do
        expect(user.online?).to be true
      end
    end

    context 'when user has signed out' do
      it 'returns false' do
        RedisConnection.connection.del(user.id)
        expect(user.online?).to be false
      end
    end
  end
end
