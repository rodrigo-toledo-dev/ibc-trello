Rails.application.routes.draw do
  root to: 'boards#index'
  resources :boards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
