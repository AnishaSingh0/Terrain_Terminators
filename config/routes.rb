Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'

  get 'errors/not_found'
  unauthenticated do
    root to: 'home#index_logged_out', as: :unauthenticated_root
  end


  authenticated :user do
    root to: 'game#index', as: :authenticated_root
  end

  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "squares/:id" => "squares#show"

  # Defines the root path route ("/")
  # root "posts#index"

  #Set the game page as the root route
  root 'game#index'
  get "game" => "game#index"

  post 'squares/:id/', to: 'squares#squares_words_logic', as: 'squares_words_logic'
  # post 'squares/:id/' => "squares#show"

 devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get "sign_up" => "devise/registrations#new" 
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # adds the route for the avatar page
  get "avatar"=> "users#get_avatars"
  post "avatar", to: "avatar#choose_avatar"
  post 'location' , to: 'game#location'
end
