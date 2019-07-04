Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root to: 'boards#index'
  resources :boards
  resources :steps
  resources :tasks do
    member do
      patch 'move-left', to: 'tasks#move_left'
      patch 'move-right', to: 'tasks#move_right'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
