class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all
    render json: @users 
  end

  # GET /users/:user_id/friends_sleep_records
  def friends_sleep_records(days_limit = 7)
    # Change the name of this method to report_friends_sleeps
    #set_user
    sleep_records = []
    # could we create a friends method on the model that is
    # def friends
    #    self.followers
    # end``
  
    friends = @user.followers

    friends.each do |friend|
      # Turn this into a method on the model.
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

end
