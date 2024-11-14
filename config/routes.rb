Rails.application.routes.draw do

  resources :users do
    resources :reward_histories, only: [:index, :new, :create, :destroy]
  end
  root 'users#index'
end
