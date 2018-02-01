# frozen_string_literal: true

Warden::Manager.before_logout do |user, _auth, _opts|
  RedisConnection.connection.del(user.id)
end
