CagePrevWeb::Application.routes.draw do

  resources :dependentes do
    collection do
      get :search, to: "dependentes#index"
      get :lista_dependentes, to: 'dependentes#lista_dependentes'
      post :importar_txt, to: 'dependentes#importar_txt'
      get :download_txt, to: 'dependentes#download_txt'
    end
  end

  resources :participantes do 
    collection do
      get :search, to: "participantes#index"
      get :lista_participantes, to: 'participantes#lista_participantes'
      get :buscar_participante, to: 'participantes#buscar_participante'
      post :importar_txt, to: 'participantes#importar_txt'
      get :download_txt, to: 'participantes#download_txt'
    end
  end

  resources :lotacoes do
    collection do
      get :search, to: "lotacoes#index"
      get :buscar_lotacao, to: 'lotacoes#buscar_lotacao'
      get :lista_lotacoes, to: 'lotacoes#lista_lotacoes'
      post :importar_txt, to: 'lotacoes#importar_txt'
    end   
  end

  resources :estados do 
    collection do
      get :search, to: "estados#index"
      get :buscar_estado, to: 'estados#buscar_estado'
      post :importar_txt, to: 'estados#importar_txt'
    end
  end
  resources :usuario_empresas

  resources :empresas do
    collection do 
      get :search, to: 'empresas#index'
    end
  end 
  
  devise_for :users

  resources :control_users, only: [:index, :edit, :update, :show, :destroy], as: :users

  get "home/index"
  get "home/minor"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'home#index'
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
