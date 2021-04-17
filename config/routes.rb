Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get 'users/update_user', to: 'users#update_user'

  get 'users/update_user_details'

  get 'users/list'

  delete 'users/destroy'

  resources :users, only: [:edit, :show] do
    collection do
      patch 'update_password'
    end
  end
end
