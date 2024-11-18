# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users do
    member do
      get 'p5', to: 'users#p5_balance'
      get 'rewards', to: 'reward_histories#index'
    end
    resources :reward_histories, only: %i[new create destroy]
  end
  root 'users#index'
end
