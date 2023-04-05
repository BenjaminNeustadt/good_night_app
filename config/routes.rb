Rails.application.routes.draw do
  post '/users/:user_id/follow/:follower_id', to: "users#follow"
  post '/users/:user_id/unfollow/:follower_id', to: "users#unfollow"
  resources :users do
    get :friends_sleep_records
    
    resources :sleeps do 
      # this is to not have to give a sleep id
      collection do 
        post "track", action: :track, as: :track
      end
    end

  end

end
