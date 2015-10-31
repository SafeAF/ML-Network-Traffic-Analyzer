Rails.application.routes.draw do
  resources :applications
  resources :servers
  resources :serv_services
  resources :clusterbots
  resources :nodes
  resources :nodes
  get 'adminhome/index'

  resources :snippets
  resources :departments
  resources :products
  resources :sources
  get 'logs/index'

  get 'logs/show'

  get 'logs/search'

	root 'home#index'

    ## devise
  resources :users, only: [:index, :show, :edit, :update]
	get 'home/index'
	get 'documentation/index'

	resources :documents

	resources :infrastructures
	resources :networks
	resources :systems
  resources :clusters
	resources :machines
	resources :servers
	resources :nodes
	resources :applications
	resources :services
	resources :connections
	resources :bans
	resources :logs


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
