Treebook::Application.routes.draw do
  # static root config
  get  '/about' => 'pages#about', as: :about

  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    get '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  devise_for :users, skip: [:sessions]

  as :user do
    get "/login" => 'devise/sessions#new', as: :new_user_session
    post "/login" => 'devise/sessions#create', as: :user_session
    delete "/logout" => 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end

  resources :statuses
  get 'feed', to: 'statuses#index', as: :feed
  root to: 'statuses#index'


  scope ":profile_name" do
    resource :albums do
      get 'albums', to: 'albums#index', as: :albums
      resources :pictures
    end
  end

  get '/:id', to: 'profiles#show', as: 'profile'

end