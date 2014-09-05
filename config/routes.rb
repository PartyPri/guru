Guru::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :email_contacts, only: :create
  resources :interests
  resources :users, :only => [:show]
  resources :user_interests, :only => [:create, :show, :destroy]
  resources :followerships, :only => [:create, :destroy]
  #resources :workshops, :only => [:show]
  #resources :posts
  resources :projects do
    resources :images
  end
  resources :reels
  resources :images
  resources :videos
  get 'interests/:id/followers', to: 'user_interests#show', as: 'interest_followers'
  get 'users/:id/followers', to: 'followerships#show', as: 'user_followers'
  get 'users/:id/following', to: 'followerships#show_following', as: 'following'
  get 'activities/:id', to: 'activities#show', as: 'activity'
  get 'interests/:id/about', to: 'about_interests#show', as: 'interest_about'
  get 'users/:id/about', to: 'about_users#show', as: 'user_about'
  #get 'projects/:id/addmedia', to: 'projects#add_media', as: 'add_media'
  #put 'projects/:id/addmedia', to: 'projects#add_media', as: 'add_media'
  get 'landing', to: 'pages#landing', as: 'landing'
  get 'about', to: 'pages#about', as: 'about'
  #get 'team', to: 'pages#team', as: 'team'

  devise_for :users, :path => '', :path_names => { :sign_in => "signin", :sign_out => "signout", :sign_up => "/golden/2014/signup" }
  ActiveAdmin.routes(self) #did the regenerator accidentally make this twice?

  root to: "pages#home"

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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
