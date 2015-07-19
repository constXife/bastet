Rails.application.routes.draw do
  root 'application#home'

  get '/test' => 'application#test'

  namespace :api, defaults: { format: 'json' } do
    resources :sensors
  end
end
