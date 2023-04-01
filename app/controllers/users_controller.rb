class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all
    render json: @users.as_json(include: { sleeps: {except: :user_id, methods: [:clocked_in, :clocked_out], only: [:id, :clocked_in, :clocked_out]}, followers: {only: [:id, :name]}})
    .map { |user| add_sleep_in_progress(user)}
  end

  def add_sleep_in_progress(user)
    user['sleeps'].each do |sleep|
      sleep['clocked_out'] = 'sleep in progress' if sleep['clocked_in'] == sleep['clocked_out']
    end
    user
  end

  # GET /users/:user_id/friends_sleep_records

  def friends_sleep_records(days_limit = 7)
    set_user
    # @user = User.find(params[:user_id])
    sleep_records = []
    friends = @user.followers

    friends.each do |friend|
      sleeps = friend.sleeps.where(updated_at: ((DateTime.now - days_limit)..DateTime.now))
      #puts "__________SLEEPS FOR_________ #{friend.name}: #{sleeps.inspect}"

      sleeps.each do |sleep|
        # It will return the sleep duration in minutes; formatting should be done on the front-end
        sleep_length = (sleep.created_at - sleep.updated_at).abs / 60 
       # puts "__________SLEEP LENGTH FOR SLEEP__________ ##{sleep.id}: #{sleep_length} minutes"
        sleep_records << { friend_name: friend.name, sleep_length: sleep_length }
      end
    end
    #puts "__________SLEEP RECORDS_________: #{sleep_records.inspect}"
    # If the sleep is not completed, it will render as having a duration of 0
    render json: { user_name: @user.name, sleep_records: sleep_records.sort_by { |record| record[:sleep_length] } }
  end

  def follow
    follower = User.find(params[:follower_id])
    @user = User.find(params[:user_id])
    follower.followees << @user
  end

  def unfollow
    follower = User.find(params[:follower_id])
    @user = User.find(params[:user_id])
    follower.followees.delete(@user)
  end

  def clock_in
    set_user # this is the same as below
    # @user = User.find(params[:user_id])
    if @user.sleeps.last&.updated_at == @user.sleeps.last.created_at
      @user.sleeps.last.touch(:updated_at)
    else
      @user.sleeps.create
    end
    render json: @user, include: :sleeps
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
