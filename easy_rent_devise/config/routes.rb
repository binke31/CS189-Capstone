EasyRentDevise::Application.routes.draw do
  
    devise_for :users, controllers: {
        sessions: "user_sessions",
        registrations: "user_registrations",
        unlocks: "user_unlocks",
        confirmations: "user_confirmations",
        passwords: "user_passwords"
    }
  
  devise_scope :user do
    root :to => 'user_sessions#new'
    #delete '/logout' => 'user_sessions#destroy'
    get '/login' => 'user_sessions#new'
    #get '/users/sign_out' => 'user_sessions#destroy'  NOTE: uncommenting this line solves the issue of 'No route matches [GET] "/users/sign_out"' but then you have to refresh the login page to be able to successfully login
  end
  
  get '/home', to: 'home#show'
	
  get '/home/pay_rent', to: 'rent_payment#new'
  post '/home/pay_rent', to: 'rent_payment#create'
  
  get '/home/maintenance_request', to: 'maintenance_request#new'
  post '/home/maintenance_request', to: 'maintenance_request#create'
  
end
