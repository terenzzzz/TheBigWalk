Rails.application.routes.draw do


  resources :pickups
  resources :routes
  resources :routes_and_checkpoints_linkers
  resources :checkpoint_times
  resources :brandings
  resources :events
  resources :checkpoints 
  devise_for :users
  resources :users
 
  resources :pages do 
    get 'home', on: :member
    get 'pick_event', on: :collection
    get 'pick_route', on: :member
    get 'leaderboard', on: :collection
    get 'single_user_leaderboard', on: :collection
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
    get 'view_marshals', on: :collection
    get 'view_walkers', on: :collection
    get 'view_pickups', on: :collection
    get 'walkers_profile', on: :collection
  end

  resources :marshals do
    get 'choose_event', on: :collection
    get 'add_shift', on: :collection
    get 'view_incoming_walkers', on: :collection
    get 'change_checkpoint', on: :collection
    get 'end_marshal_shift', on: :collection
    get 'end_for_the_day', on: :collection
    get 'checkin_walkers', on: :collection
    post :checkin_walker, on: :collection
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

  root :to => redirect("/users/sign_in")
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
