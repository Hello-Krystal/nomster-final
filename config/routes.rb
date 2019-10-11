Rails.application.routes.draw do
  devise_for :users
  root 'places#index' #makes places controller the root/index page
  resources :places do #allows us to create a new place
    resources :comments, only: :create
  end
end
