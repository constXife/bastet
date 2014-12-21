Rails.application.routes.draw do
  root 'application#home'

  namespace :api do
    resources :sensors
  end
end
