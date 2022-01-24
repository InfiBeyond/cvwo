Rails.application.routes.draw do
  devise_for :users
  resources :categories, except: [:index]
  resources :tasks, except: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "tasks#index"
  
  get "/incomplete", to: "tasks#incomplete"
  get "/due", to: "tasks#due"
  get "/overdue", to: "tasks#overdue"
  
end
