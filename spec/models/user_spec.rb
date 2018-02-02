# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

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
