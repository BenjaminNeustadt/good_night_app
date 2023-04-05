class SleepsController < ApplicationController
  before_action :set_user

  # POST /sleeps/track(params: [user_id])
  def track
      @user.is_still_sleeping? ? @user.end_sleep : @user.start_sleep
      render json: @user, include: :sleeps
  end

  private

  def set_user
      @user = User.find(params[:user_id])
  end
end
