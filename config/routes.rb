Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'devise/invitations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get 'admin/users/list', to: 'admin/users#list'
  namespace :admin do
    resources :users
    resources :categories
    resources :products
  end

  resources :users, only: [:edit, :show] do
    collection do
      patch 'update_password'
    end
  end

  resources :products, only: [:index, :show]

end
