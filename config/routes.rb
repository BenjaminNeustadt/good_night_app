Rails.application.routes.draw do
  post '/users/:user_id/follow/:follower_id', to: "users#follow"
  post '/users/:user_id/unfollow/:follower_id', to: "users#unfollow"
  resources :users do
    get :friends_sleep_records
    resources :sleeps
    post 'clock_in', to: 'users#clock_in'
  end
end
