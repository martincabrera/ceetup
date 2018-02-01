# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  after_action :set_online

  private

  def set_online
    # TTL 10 minutes
    RedisConnection.connection.set(current_user.id, nil, ex: 10 * 60) if current_user
  end
end
