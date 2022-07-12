# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  devise_for :users, controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                       passwords: "users/passwords",
                       confirmations: "users/confirmations",
                       omniauth_callbacks: "users/omniauth_callbacks",
                     }

  devise_scope :user do
    get "login", to: "users/sessions#new"
    get "signup", to: "users/registrations#new"
    delete "logout", to: "users/sessions#destroy"
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts do
    resources :comments
  end
  resources :comments, only: [:create, :index]

  resources :relationships, only: [:create, :destroy]

  get "/auth/facebook/callback", to: "sessions#create_facebook"
  get "/auth/google_oauth2/callback", to: "sessions#google_auth"
end
