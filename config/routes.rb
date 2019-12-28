Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  devise_scope :user do get '/users/sign_out' => 'devise/sessions#destroy' end

  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
end
