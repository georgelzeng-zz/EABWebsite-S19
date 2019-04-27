Rails.application.routes.draw do
  get 'projects', to: 'projects#index', as: 'projects'

  get 'projects/proj/:id', to: 'projects#show', as: 'project_prof'

  get 'projects/create', to: 'projects#create', as: 'project_create'

  post 'projects/create', to: 'projects#new_project'

  #necessary for sessions(login, registration, etc.)
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # verb 'uri', to: 'controller#action', as: 'name'
  # can refer to as name_path

  get '/', to: 'users#home', as: 'home'

  get 'users', to: 'users#index', as: 'users'

  get 'users/show/:id', to: 'users#show', as: 'user'

  get 'admin', to: 'users#admin_index', as: 'users_admin'

  get 'users/edit', to: 'users/registrations#edit', as: 'edit_page'

  patch 'code/:access_level', to: 'users#change_code', as: 'change_code'

  get 'admin/download_roster', to: 'users#download_roster', as: 'download_roster'

  # get 'users/:id/edit', to: 'users#edit', as: 'edit_page'

  # post 'users/:id/edit', to: 'users#edit', as: 'edit'

  # resources :users

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
