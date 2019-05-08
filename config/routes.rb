Rails.application.routes.draw do
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

  post 'users/edit/:id', to: 'users#leave', as: 'leave_team'

  patch 'code/:access_level', to: 'users#change_code', as: 'change_code'

  get 'users/EAB_roster', to: 'users#spreadsheet', as: 'users_spreadsheet'

  get 'users/clear', to: 'users#clear', as: 'users_clear'

  get 'teams', to: 'teams#index', as: 'teams'

  get 'teams/show/:id', to: 'teams#show', as: 'team'

  get 'teams/create', to: 'teams#create', as: 'team_create'

  post 'teams/create', to: 'teams#new_team', as: 'new_team'

  patch 'teams/add_member/:id', to: 'teams#add_member', as: 'add_member'

  patch 'teams/promote_to_leader/:id/:user_id', to: 'teams#promote_to_leader', as: 'promote_to_leader'

  get 'teams/edit/:id', to: 'teams#edit', as: 'edit_team'

  patch 'teams/update/:id', to: 'teams#update', as: 'update_team'

  delete 'teams/delete/:id', to: 'teams#delete', as: 'delete_team'

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
