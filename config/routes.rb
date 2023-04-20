Rails.application.routes.draw do
  post '/users/:user_id/follow/:follower_id', to: "follows#follow"
  post '/users/:user_id/unfollow/:follower_id', to: "follows#unfollow"

  resources :users do
    get :friends_sleep_records
    resources :sleeps do 
      collection do 
        post "track", action: :track, as: :track
      end
    end
  end

end
