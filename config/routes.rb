# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'y/:id', to: 'api/v1/urls#redirect'
  scope module: 'api' do
    namespace :v1 do
      resources :urls, except: :destroy
      get 'top', to: 'urls#top'
      post 'lookup', to: 'urls#lookup'
      post 'bot', to: 'urls#bot'
    end
  end
end
