Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get 'admin/users/list', to: 'admin/users#list'
  get 'admin/users/update_user_details'
  get 'admin/users/update_user', to: 'admin/users#update_user'
  patch 'admin/users/update_password', to: 'admin/users#update_password'
  delete 'admin/users/destroy'
  namespace :admin do
    resources :users
  end

  resources :users, only: [:edit, :show] do
    collection do
      patch 'update_password'
    end
  end
end
