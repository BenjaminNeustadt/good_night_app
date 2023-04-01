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

  variable = 5

  def friends(user)
    user.followers
  end

  # POST /users/:user_id/friends

  def friends_sleeps
    user = User.find(params[:user_id]) # user 1, name: Jon
    # look at all of Jons followings/friends, 
    # specifically look at their sleeps,
    # now order them by duration of sleep time,
    # and also we only care about the last 7 days

    # DAYS = 7
    # collection_of_relevant_records = []
    # def limit_records_on_date
    # take a sleep record, take the "clock_out" value and store it inside 
    # collection_of_relevant_records if the date on that is between (DateTime.parse(that_date) - DAYS)..DateTime.now

    # end

    # for each sleep record of a friend, do this:
    # the_beginning =  DateTime.parse(clocked_in).to_time.to_i
    # the_end =  DateTime.parse(clocked_out).to_time.to_i
    # duration = the_end - the_beginning

    # minutes = duration/60
    
    # sort.reverse 

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
    @user = User.find(params[:user_id])
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
