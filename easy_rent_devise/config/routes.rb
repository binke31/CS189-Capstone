EasyRentDevise::Application.routes.draw do
  
    devise_for :users, skip: "registrations", controllers: {
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
    get '/settings/account_settings' => 'user_registrations#edit', :as => 'edit_user_registration'
    #put '/home/account_settings' => 'devise/registrations#update', :as => 'user_registration'
    put '/settings/account_settings' => 'user_registrations#update_user', :as => 'update_user_registration'
    get 'home', to: 'home#show', as: :user_root
  end
    
  
  get '/home', to: 'home#show'
	
  get '/home/pay_rent', to: 'rent_payment#new'
  post '/home/pay_rent', to: 'rent_payment#create'
	
	get '/home/my_info', to: 'rent_payment#show'
    
  get '/home/payment_history', to: 'payment_history#show'
  
  get '/home/maintenance_request', to: 'maintenance_request#new'
  post '/home/maintenance_request', to: 'maintenance_request#create'
    
  get '/home/maintenance_log', to: 'maintenance_log#show'
    
  get '/settings', to: 'settings_home#show'
  
  get '/settings/notification_settings', to: 'notification_settings#edit'
  put '/settings/notification_settings', to: 'notification_settings#update'

end
