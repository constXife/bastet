Rails.application.routes.draw do
  root 'application#home'

  namespace :api, defaults: { format: 'json' } do
    resources :sensors
  end
end
