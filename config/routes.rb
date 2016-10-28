Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'tickets', to: 'tickets#index'
  get 'tickets/new', to: 'tickets#new'
  post 'tickets', to: 'tickets#create'
end
