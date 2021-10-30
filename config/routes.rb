Rails.application.routes.draw do
  root 'status_messages#index'

  resource :status_message, only: %i[new create]
end
