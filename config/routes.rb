Rails.application.routes.draw do
  # routes for authenticate users scope.
  devise_for :users, controllers: { sessions: 'users/sessions'}

  root 'home#index'

  # admin module
  namespace :admin do
    root 'dashboard#index'
    resources :teams, except: %i[show]
    resources :player_records, except: %i[show]
  end
end
