Rails.application.routes.draw do


  resources :systems

  namespace :api do
    resources :projects do
      resources :issues #, only: [:create, :update, :destroy]
    end

    resources :servers do
      resources :services
      resources :connections
      resources :pids
    end


  end

  #
  # get "/login" => "user_sessions#new", as: :login
  # delete "/logout" => "user_sessions#destroy", as: :logout

  #resources :users, except: [:show]
  #resources :user_sessions, only: [:new, :create]
  #resources :password_resets, only: [:new, :create, :edit, :update]

  # resources :projects do
  #   #put :email, on: :member
  #   resources :issues do
  #     member do
  #       patch :complete
  #     end
  #   end
  # end

  get 'progress/main'

  get 'progress/detail'

  get 'progress/graphs'

  get 'progress/statistics'

  get 'files/index'

  get 'files/download'

  get 'files/upload'

  get 'public/index'

  get 'public/show'

   resources :projects do
     resources :issuelists
     resources :tasklists
   end
  resources :notifications
  resources :networks
  resources :network_boxes
  resources :memberships
  resources :logfiles
  resources :logentries
  resources :hardwares
  resources :githubs
  resources :gists
  resources :groups
  resources :domainnames
  resources :networks
  resources :clusters
  resources :services
  resources :infrastructures
  resources :organizations
  resources :labels
  resources :milestones
  resources :todos

  resources :tasklists do
    resources :tasks
  end
  resources :issuelists do
    resources :issues
  end

  resources :ips
  get 'home/slice'

  resources :ips
  resources :reputations
  resources :ips
  resources :organizations
  resources :nodes
  resources :servers
  get 'dashboard/index'

  get 'dashboard/controls'

  get 'dashboard/analysis'

  devise_for :users
  get 'clusterjobs/new'

  get 'clusterjobs/index'

  get 'main/index'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'main#index'
  # You can have the root of your site routed with "root"
  # root 'welcome#index

  #require 'sidekiq/web'

  # Example::Application.routes.draw do



  resources :systems
  get 'progress/main'

  get 'progress/detail'

  get 'progress/graphs'

  get 'progress/statistics'

  get 'files/index'

  get 'files/download'

  get 'files/upload'

  get 'public/index'

  get 'public/show'

  resources :notifications
  resources :networks
  resources :network_boxes
  resources :memberships
  resources :logfiles
  resources :logentries
  resources :hardwares
  resources :githubs
  resources :gists
  resources :groups
  resources :domainnames
  resources :networks
  resources :clusters
  resources :services
  resources :infrastructures
  resources :organizations
  resources :labels
  resources :milestones
  resources :todos
  resources :tasks
  resources :tasklists
  resources :issues
  resources :issuelists
  resources :projects
  resources :ips
  get 'home/slice'

# resources :clusterjobs
# root to: "clusterjobs#new"
# mount Sidekiq::Web, at: "/clusterjobs"
# end

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
