Guru::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :email_contacts, only: :create
  resources :interests
  resources :users, :only => [:show, :edit, :update]
  resources :user_interests, :only => [:create, :show, :destroy]
  resources :followerships, :only => [:create, :destroy]
  resources :reels
  resources :images
  resources :articles
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
  #get 'projects/:id/addmedia', to: 'projects#add_media', as: 'add_media'
  #put 'projects/:id/addmedia', to: 'projects#add_media', as: 'add_media'
  get 'landing', to: 'pages#landing', as: 'landing'
  get 'about', to: 'pages#about', as: 'about'
  #get 'team', to: 'pages#team', as: 'team'
  get 'style-guide', to: 'styles#guide', as: 'style_guide'

  post 'checkout/create'

  devise_for :users, :path => '', :path_names => { :sign_in => "signin", :sign_out => "signout", :sign_up => "/golden/2014/signup" }, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  root to: "pages#landing"
end
