Guru::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: "pages#landing"
  get 'landing', to: 'pages#landing', as: 'landing'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :email_contacts, only: :create
  resources :interests
  resources :users, :only => [:show, :edit, :update] do
    member do
      resources :followerships, only: [:create, :index, :destroy]
    end
  end
  resources :reels do
    collection { post :sort }
    resources :credits, except: [:show, :edit, :update] do
      member do
        put "accept", to: "credits#respond_to_invitation"
        put "reject", to: "credits#respond_to_invitation"
        # WARNING: these GETs are not idempotent
        get "accept", to: "credits#respond_to_invitation"
        get "reject", to: "credits#respond_to_invitation"
      end
    end
  end
  resources :stories do
    member do
      put "like", to: "stories#upvote"
    end
  end
  resources :images do
    member do
      put "like", to: "images#upvote"
    end
  end
  resources :claim_users, :only => [:new, :create]
  #resources :events do
  #  resources :registrations, :only => [:create, :new]
  #end

  resources :comments, :only => [:create, :destroy] do
    get :reply, on: :member
  end

  resources :notifications, only: [:update]

  #YouTube video creation:
  post '/videos/get_upload_token', to: 'videos#get_upload_token', as: :get_upload_token
  get '/videos/get_video_uid', to: 'videos#get_video_uid', as: :get_video_uid
  get '/pages/select_media', to: 'pages#select_media'

  resources :videos do
    member do
      put "like", to: "videos#upvote"
    end
  end

  get 'users/:id/edit_profile', to: 'users#edit_profile', as: 'edit_profile'

  get 'about', to: 'pages#about', as: 'about'
  get 'style-guide', to: 'styles#guide', as: 'style_guide'
  get '/video/add', to: 'videos#youtube'
  post '/video/add', to: 'videos#create_youtube_video'

  post 'checkout/create'

  namespace :api do
    resources :tags, only: [:index]
  end

  # Delayed Job Web Route
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
end
