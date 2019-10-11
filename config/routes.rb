Rails.application.routes.draw do
  root 'places#index' #makes places controller the root/index page
  resources :places #allows us to create a new place
end
