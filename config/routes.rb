Rails.application.routes.draw do
  #resources :tips
  #resources :tip_recommendations
  #resources :tip_categories
  namespace :admin do
    root to: "top#index" , :as => "top"
    resources :users
    resources :diets
    resources :feelings
    resources :conditions
    resources :equipment
    resources :parts do
      get "search", to: "parts#search", on: :collection
    end
    resources :modes
    resources :food_categories
    resources :foods do
      collection { get "search"}
    end
    get 'foods/:copy_from/copy', :to => 'foods#new', :as => 'copy_food'
    resources :items do
      collection { get "search"}
      collection { post :import }
    end
    resources :tips
    resources :tip_recommendations
    resources :tip_categories
  end

  resources :feelings
  resources :conditions
  resources :equipment
  resources :parts do
    get "search", to: "parts#search", on: :collection
  end
  resources :modes
  resources :food_categories
  resources :foods do
    member { patch :like, :unlike }
    collection { get "search"}
    collection { get "voted"}
  end
  get 'foods/:copy_from/copy', :to => 'foods#new', :as => 'copy_food'
  resources :items do
    member { patch :like, :unlike }
    collection { get "voted"}
    collection { get "search"}
    collection { post :import }
  end
  
  resources :users ,only: [:create, :destroy ,:show ]  do
    resources :pages do
      resources :lines
      collection { get :training_only,:training_only_note ,:hidden_training,:only_chart}
      collection { post :import }
    end
  end
  resource :session , only: [:create ,  :destroy]
  get '/auth/:provider/callback',    to: 'users#create',       as: :auth_callback
  get '/auth/failure',               to: 'users#auth_failure', as: :auth_failurematch
  get 'signout', to: 'users#destroy', as: 'signout'
  root :to => 'welcome#index', :as => 'root'
  get "about" => "welcome#about", as: "about"
  get "developer" => "welcome#developer", as: "developer"
  resources :analysis do
    collection { get :dash_bord,:health,:size,:weight,:water,:feel,
                 :diet,:gym,:home,:pie_parts,:pie_place,:diet_recent,:weight_recent}
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
    collection { get :training_only,:show_pic ,:hidden_training,:only_chart}
    collection { post :import }
  end
  resources :page_images
  resources :trainings
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
