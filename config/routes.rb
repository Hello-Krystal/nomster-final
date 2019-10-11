Rails.application.routes.draw do
  devise_for :users
  root 'places#index' #makes places controller the root/index page
  resources :places #allows us to create a new place
end
