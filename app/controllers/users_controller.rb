class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  # :TODO: before_action :set_user

  private
    
  def set_user
    @user = User.find(params[:user_id])
  end

  public

  # GET /users
  def index
    @users = User.all
    render json: @users 
  end

  def friends_sleep_records
    set_user
    render json: {
      user_name: @user.name, sleep_records: @user.friends_sleeps.sort_by { |record| record[:sleep_length] }
    }
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

end
