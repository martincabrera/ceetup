Warden::Manager.before_logout do |user,auth,opts|
  RedisConnection.connection.del(user.id)
end
