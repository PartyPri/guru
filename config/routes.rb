Guru::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  #root to: "pages#home"
  root to: "pages#landing"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :email_contacts, only: :create
  resources :interests
  resources :users, :only => [:show, :edit] #, :get_upload_token
  resources :user_interests, :only => [:create, :show, :destroy]
  resources :followerships, :only => [:create, :destroy]
  resources :reels
  resources :images
  resources :articles
  resources :claim_users, :only => [:new, :create]
  resources :events do
    resources :registrations, :only => [:create, :new]
  end

  #YouTube video creation:
  post '/videos/get_upload_token', to: 'videos#get_upload_token', as: :get_upload_token
  get '/videos/get_video_uid', to: 'videos#get_video_uid', as: :get_video_uid
  
  resources :videos
  get 'interests/:id/followers', to: 'user_interests#show', as: 'interest_followers'
  get 'users/:id/followers', to: 'followerships#show', as: 'user_followers'
  get 'users/:id/following', to: 'followerships#show_following', as: 'following'
  get 'interests/:id/about', to: 'about_interests#show', as: 'interest_about'
  get 'users/:id/about', to: 'about_users#show', as: 'user_about'
  get 'users/:id/edit_profile', to: 'users#edit_profile', as: 'edit_profile'
  get 'landing', to: 'pages#landing', as: 'landing'
  get 'about', to: 'pages#about', as: 'about'
  get 'style-guide', to: 'styles#guide', as: 'style_guide'

  post 'checkout/create'


end
