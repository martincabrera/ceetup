# frozen_string_literal: true

class RedisConnection
  def self.connection
    @connection ||= new_instance
  end

  def self.new_instance
    if Rails.env.test?
      require 'mock_redis'
      MockRedis.new
    else
      Redis.new
    end
  end
end
