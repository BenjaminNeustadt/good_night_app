Rails.application.routes.draw do
  resources :follows
  resources :users do
    resources :sleeps
    post 'clock_in', to: 'users#clock_in'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
