Rails.application.routes.draw do

root 'welcome#index'
# go to users controllers and looks for method show
get "/auth/:provider/callback" => "sessions#create_from_omniauth"
# delete "/sign_out" => "sessions#create_from_omniauth#destroy", as: "sign_out"

get '/listings/:id/verify' => "listings#verify", as: 'verify_listing'

####don't need only: because I have for each function is need it
#### kdyz je to v do, je to nested
get '/listings/:id/reservation' => "listings#reservation", as: 'reservation_listing'

resources :listings do
  resources :reservations, only: [:create, :new, :edit, :update, :destroy]
end

resources :reservations do
    get "payments/new", to: "payments#new", as: "new"
    post 'payments/checkout'
end


####payment


  # "listings/:listing_id/reservations/:reservation_id/payments/checkout"
  #   "listings/:listing_id/reservations/:reservation_id/payments/new"


####predtim jsem to mela a to neni nested
####resources :reservation, controller: "listing/reservation", only: [....]


#######################################
# this is was add by command in terminal - rails generate clearance:routes
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  
# resource because session has not id, zbytek ma id
  resource :session, controller: "sessions", only: [:create]
  # if i want to overrida clearance controller jest remove clearance from controller:
  resources :users do
    # because resource :users and controller: "users" is the same I c an remove controller
    # how it looks before - resources :users, controller: "users", only: [:create] do
    resource :password,
    # /users/:user_id/password(.:format) 
    # kdyz napisu resources prida id do restful routes, to generate id
    # /users/:user_id/:id/password(.:format) 
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  # line above is explanation why is new.,html.erb and in browser I see /sign_in
  # get, go to controler session, method new
  ## as: does name to the route, vidim v html
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #######################################

end

# localhost:3000/rails/info/routes