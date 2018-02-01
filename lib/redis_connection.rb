# frozen_string_literal: true

class RedisConnection
  def self.connection
    @connection ||= Redis.new
  end
end
