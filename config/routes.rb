Rails.application.routes.draw do
  root 'users#index'

  get 'sign_up' => 'users#new', as: 'sign_up'
  get 'sign_in' => 'sessions#new', as: 'sign_in'
  get 'sign_out' => 'sessions#destroy', as: 'sign_out'

  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :events
  resources :invites, only: %i[create destroy update]
end
