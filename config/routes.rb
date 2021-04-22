Rails.application.routes.draw do
  
  
  root "events#index"

  resources :events do
    resources :comments, only: %i[create destroy]
  end

  resources :users, only: [:show, :edit, :update]
  devise_for :users
end
