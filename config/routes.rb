Rails.application.routes.draw do

  get "/", to: "welcome#app", constraints: lambda {
    |solicitud| !solicitud.session[:user_id].blank?
  }  

  get "/", to: "welcome#index"

  resources :my_apps, except: [:index, :show]

  # Con los namespace podemos trabajar tranquilament en otras versiones sin romper la incompatibilidad
  # de la API

  namespace :api, defaults: { format: "json" } do
  	namespace :v1 do
  		resources :users, only: [:create]
  		# para que haga esto con la ruta: /polls pero lo manejara el controlador my_polls
  		resources :polls, controller: "my_polls", except: [:new, :edit] do
  			resources :questions, except: [:new, :edit]
        resources :answers, only: [:update, :destroy, :create]
  		end
      match "*unmatched", via: [:options], to: "master_api#xhr_options_request"
  	end
  end
  
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
