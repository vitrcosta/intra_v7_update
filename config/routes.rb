Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  
  root 'intranet/sessions#new'
  post 'interesse' => 'capa#createinteresse'
  post 'update_dashboard' => 'intranet/dashboard#update_index'
  post 'save_image' => 'intranet/dashboard#save_image'
  post 'relatorio' => 'intranet/dashboard#gerar_relatorio'
  get 'intranet' => 'intranet/sessions#new'
  
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :intranet do
    resources :kind_of_posts do
      resources :posts
    end
    resources :users
    resources :posts
    resources :categories
    resources :dashboard
    resources :folhetos
    resources :clientes

    controller :sessions do
      get  'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end

    get 'sessions/create'
    get 'sessions/destroy'

    get 'admin' => 'admin#index'
    get 'logout' => 'sessions#destroy'

  end
  

end
