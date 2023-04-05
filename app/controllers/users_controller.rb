class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all
    render json: @users 
  end


  # GET /users/:user_id/friends_sleep_records
  def friends_sleep_records(days_limit = 7)
    set_user
    sleep_records = []
    friends = @user.followers

    friends.each do |friend|
      sleeps = friend.sleeps.where(updated_at: ((DateTime.now - days_limit)..DateTime.now))

      sleeps.each do |sleep|
        # It will return the sleep duration in minutes; formatting should be done on the front-end
        sleep_length = (sleep.created_at - sleep.updated_at).abs / 60 
        sleep_records << { friend_name: friend.name, sleep_length: sleep_length }
      end
    end
    # :TODO: If the sleep is not completed, it will render as having a duration of 0
    render json: { user_name: @user.name, sleep_records: sleep_records.sort_by { |record| record[:sleep_length] } }
  end

  # POST users/:user_id/follow/:user_id
  def follow
    set_user and set_follower
    @follower.followees << @user
    render json: { status: 'success - user followed'}
  end

  def unfollow
    set_user and set_follower
    @follower.followees.delete(@user)
    render json: { status: 'success - user unfollowed'}
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_follower
    @follower = User.find(params[:follower_id])
  end

end
