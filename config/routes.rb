Rails.application.routes.draw do
  root 'status_messages#index'

  resources :status_messages
end
