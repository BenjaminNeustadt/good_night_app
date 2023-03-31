class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all
    render json: @users.as_json(include: { sleeps: {except: :user_id, methods: :updated_at}})
    .map { |user| add_sleep_in_progress(user)}
  end

  def add_sleep_in_progress(user)
    user['sleeps'].each do |sleep|
      sleep['updated_at'] = 'sleep in progress' if sleep['created_at'] == sleep['updated_at']
    end
    user
  end

  # GET /users/1
  def show
    render json: @user
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

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end
end
