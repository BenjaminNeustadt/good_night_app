class FollowsController < ApplicationController
  before_action :set_user, :set_follower

  # POST users/:user_id/follow/:user_id
  def follow
    @follower.followees << @user
    render json: { status: 'success - user followed'}
  end

  # POST users/:user_id/unfollow/:user_id
  def unfollow
    @follower.followees.delete(@user)
    render json: { status: 'success - user unfollowed'}
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_follower
    @follower = User.find(params[:follower_id])
  end
end
