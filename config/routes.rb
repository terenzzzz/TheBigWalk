Rails.application.routes.draw do

  resources :events
  resources :checkpoints 
  devise_for :users
  resources :users
 
  resources :pages do 
    get 'leaderboard', on: :collection

  end

  resources :walkers do
    get 'check_in', on: :collection
    get 'check_in_fail', on: :collection
    get 'checkpoint_info', on: :collection
    get 'help', on: :collection
    get 'drop_out', on: :collection
    get 'search', on: :collection
  end

  resources :admins do
    get 'event_info', on: :collection
    get 'event_main', on: :collection
    get 'manage_checkpoints', on: :collection
    get 'view_marshals', on: :collection
    get 'view_walkers', on: :collection
    get 'view_pickups', on: :collection
    get 'manage_events', on: :collection
    get 'walkers_profile', on: :collection
    get 'create_event_name', on: :collection
    get 'create_event_date', on: :collection
    get 'create_event_checkpoint', on: :collection
    get 'create_event_branding', on: :collection
    
  end

  resources :marshals do
    get 'start_shift', on: :collection
    get 'change_checkpoint', on: :collection
    get 'end_marshal_shift', on: :collection
    get 'end_for_the_day', on: :collection
  end

  resources :profile do
    get 'account', on: :collection
  end
  
  mount EpiCas::Engine, at: "/"
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'

  root to: "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
