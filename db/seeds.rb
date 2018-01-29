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

City.find_or_create_by(name: 'Madrid')
City.find_or_create_by(name: 'Barcelona')
City.find_or_create_by(name: 'Valencia')
City.find_or_create_by(name: 'Seville')

# Topics

Topic.find_or_create_by(name: 'Back end')
Topic.find_or_create_by(name: 'Front end')
Topic.find_or_create_by(name: 'devops')
Topic.find_or_create_by(name: 'development')
Topic.find_or_create_by(name: 'Ruby')
Topic.find_or_create_by(name: 'JavaScript')
Topic.find_or_create_by(name: 'Java')
