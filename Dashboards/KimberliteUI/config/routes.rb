Kimberlite3::Application.routes.draw do
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

  resources :users
  resources :machines, :has_many => :instances
  resources :instances, :has_many => :bans

  get 'home', :to => 'home#index'
  get 'statistics', :to => 'statistics#index'
  get 'products', :to => 'products#index'
  get 'pricing', :to => 'pricing#index'
  get 'about', :to => 'about#index'
  get 'contact', :to => 'contact#index'
  get 'profile(/)', :to => 'profile#index'
  get 'profile/edit', :to => 'profile#edit'
  match 'profile/login', :to => 'profile#login', :via => [:get, :post]
  get 'profile/logout', :to => 'profile#logout'
  match 'profile/change_password', :to => 'profile#change_password', :via => [:get, :post]
  match 'profile/signup', :to => 'profile#signup', :as => :signup, :via => [:get, :post]
  #match 'profile/switchyard/:gucid', :to => 'profile#switchyard'
  get 'confs/edit', to: 'confs#edit'
  patch 'confs/update', to: 'confs#update'
  #get 'simple_captcha' , to: 'simple_captcha#show', as: "simple_captcha", require: 'simple_captcha'
  get 'console', to: 'console'
  get 'console/open', to: 'console#open'
  post 'console/terminal', to: 'console#terminal'
  #match '/:controller(/:action(/:id))'
  #match '/:controller(/:action(/:id(.:format)))'
end
