# frozen_string_literal: true

Rails.application.routes.draw do
  resources :search_filters
  devise_for :users
  namespace :admin do
    resources :events
  end

  root 'admin/events#index'
end
