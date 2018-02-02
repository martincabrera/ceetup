# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

# Cities

madrid = City.find_or_create_by(name: 'Madrid')
barcelona = City.find_or_create_by(name: 'Barcelona')
City.find_or_create_by(name: 'Valencia')
City.find_or_create_by(name: 'Seville')

# Topics

backend = Topic.find_or_create_by(name: 'Back end')
Topic.find_or_create_by(name: 'Front end')
Topic.find_or_create_by(name: 'devops')
Topic.find_or_create_by(name: 'development')
ruby = Topic.find_or_create_by(name: 'Ruby')
javascript = Topic.find_or_create_by(name: 'JavaScript')
java = Topic.find_or_create_by(name: 'Java')

# Users

user1 = User.create!(email: 'user@example.com', password: '123456', password_confirmation: '123456')
user2 = User.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456')

# Events

event1 = Event.find_or_create_by(name: 'Madrid rb', start_date: Time.zone.now + 1.hour, end_date: Time.zone.now + 3.hours, city_id: madrid.id)
event1.topics << backend
event1.topics << ruby
event1.save
event2 = Event.find_or_create_by(name: 'Barcelona Java group', start_date: Time.zone.now + 1.hour, end_date: Time.zone.now + 3.hours, city_id: barcelona.id)
event2.topics << java
event2.save

# Search Filters

SearchFilter.find_or_create_by(user_id: user1.id, city_id: madrid.id, start_date: Time.zone.now - 180.days, end_date: Time.zone.now + 180.days, topic_id: javascript.id)
SearchFilter.find_or_create_by(user_id: user1.id, city_id: madrid.id, start_date: Time.zone.now - 180.days, end_date: Time.zone.now + 180.days, topic_id: ruby.id)

SearchFilter.find_or_create_by(user_id: user2.id, city_id: barcelona.id, start_date: Time.zone.now - 180.days, end_date: Time.zone.now + 180.days, topic_id: ruby.id)
SearchFilter.find_or_create_by(user_id: user2.id, city_id: madrid.id, start_date: Time.zone.now - 180.days, end_date: Time.zone.now + 180.days, topic_id: javascript.id)
