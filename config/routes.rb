Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'devise/invitations', sessions: 'user/session', registrations: 'registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get 'admin/users/list', to: 'admin/users#list'
  namespace :admin do
    resources :users
    resources :categories
    resources :products
    resources :orders, only: [:index]
  end

  resources :users, only: [:edit, :show] do
    collection do
      patch 'update_password'
    end
  end

  resources :order_items
  resource :cards, only: [:show, :update]
  resources :products, only: [:index, :show]
  resource :orders, only: [:update]
end
