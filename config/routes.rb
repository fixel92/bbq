Rails.application.routes.draw do
  root 'events#index'
  # devise_for :users
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do get '/users/sign_out' => 'devise/sessions#destroy' end

  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]

    post :show, on: :member
  end
  resources :users, only: [:show, :edit, :update]
end
