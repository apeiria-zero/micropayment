Rails.application.routes.draw do
  root to: 'bitcoin#index'
  post 'bitcoin', to: 'bitcoin#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
