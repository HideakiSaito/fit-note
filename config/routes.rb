Rails.application.routes.draw do
  resources :users
  get '/auth/:provider/callback',    to: 'users#create',       as: :auth_callback
  get '/auth/failure',               to: 'users#auth_failure', as: :auth_failurematch 
  get 'signout', to: 'users#destroy', as: 'signout'
  resources :page_images
  resources :food_categories
  resources :foods
  resources :feelings
  resources :conditions
  resources :diets
  root :to => 'welcome#index', :as => 'home'
  get "about" => "welcome#about", as: "about"
  get "developer" => "welcome#developer", as: "developer"
  resources :analysis do
    collection { get :dash_bord,:health,:size,:weight,:water,:feel,
                 :diet,:gym,:home,:pie_parts,:pie_place }
  end
  resources :maintenance do
    collection {get :pages_delete_all,:items_delete_all,:foods_delete_all}
    collection { post :pages_import,:items_import,:foods_import}
  end
  resources :lines do
    collection { post :import }
  end
  resources :pages do
    resources :lines
    collection { get :training_only,:training_only_note ,:hidden_training,:only_chart}
    collection { post :import }
  end
  resources :trainings
  resources :items do
    collection { get "search"}
    collection { post :import }
  end
  resources :equipment
  resources :parts do
    get "search", to: "parts#search", on: :collection
  end
  resources :modes
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
