Rails.application.routes.draw do

root 'welcome#index'
# go to welcome controllers and looks for method index

#######################################
# this is was add by command in terminal - rails generate clearance:routes
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  
# resource because session has not id, zbytek ma id
  resource :session, controller: "clearance/sessions", only: [:create]
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