# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email 'myname@example.com'
    password '123456'
  end
end
