Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :list, path: "list", except: [ :new ] do
    collection do
      get :profile
    end

    member do
      patch :checklist
    end
  end
  match "/newlist", to: "list#create", as: :new_list, via: [ :get, :post ]
  get "calendar", to: "list#calendar", as: :calendar_feed
  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout
  get "/auth/failure", to: redirect("/")
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    # Defines the root path route ("/")
    # root "posts#index"
    root "home#index"
end
