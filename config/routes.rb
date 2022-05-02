Rails.application.routes.draw do

  resources :calls
  resources :reports
  resources :pickups
  resources :routes
  resources :routes_and_checkpoints_linkers
  resources :checkpoint_times
  resources :brandings
  resources :events do
    post :make_public, on: :collection
    post :make_private, on: :collection
  end
  resources :checkpoints  
  #resources :participants
  devise_for :users, controllers: { registrations: 'users/registrations' }
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
    get 'requestCall'
    get 'requestPickUp'
    get 'check_in_fail', on: :collection
    get 'checkpoint_info', on: :collection
    get 'help', on: :collection
    get 'drop_out', on: :collection
    get 'search', on: :collection
    post 'saveLocation'
    get 'sign_up_participant'
    post :make_own_way_home, on: :collection
  end

  resources :admins do
    get 'view_marshals', on: :collection
    get 'view_walkers', on: :collection
    get 'view_pickups', on: :collection
    get 'walkers_profile', on: :collection
    get 'view_calls', on: :collection
    post :make_walker_marshal, on: :collection
    post :make_user_admin, on: :collection
  end

  resources :marshals do
    get 'choose_event', on: :collection
    get 'add_shift', on: :member
    get 'view_incoming_walkers', on: :collection
    get 'change_checkpoint', on: :collection
    post :search_checkpoint, on: :collection
    get 'end_marshal_shift', on: :collection
    get 'end_for_the_day', on: :collection
    get 'checkin_walkers', on: :collection
    post :checkin_walker, on: :collection
    
    get 'move_own_way_home', on: :collection
    get 'request_pick_up', on: :collection
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
  get '/marshals/:id', to: 'marshals#index'
  get '/walkers/:id', to: 'walkers#index'


  root :to => redirect("/users/sign_in")
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
