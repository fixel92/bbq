Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  devise_scope :user do get '/users/sign_out' => 'devise/sessions#destroy' end
  
  resources :events
  resources :users, only: [:show, :edit, :update]
end
