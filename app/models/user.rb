class User < ApplicationRecord
  has_many :sleeps

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users


  def is_still_sleeping?
    self.sleeps&.last.updated_at == self.sleeps&.last.created_at
  end

  def start_sleep
    self.sleeps.create
  end

  def end_sleep
    self.sleeps.last&.touch
  end

  # ==========================================================================================
  # WIP ================
  # ==========================================================================================
  # Below are some additions to DRY the controller
  def friends
    self.followers
  end

  def friends_sleep_records
    sleep_records = []

    friends = @user.followers

    friends.each do |friend|
      # Turn this into a method on the model.
      sleeps_of(friend).each do |sleep|
        minutes_of_(sleep)
      end
    end
  end

  def sleeps_of(friend)
    friend.sleeps.where(updated_at: ((DateTime.now - days_limit)..DateTime.now))
  end

  def minutes_of_(sleep)
    sleep_length = (sleep.created_at - sleep.updated_at).abs / 60 
    sleep_records << { friend_name: friend.name, sleep_length: sleep_length }
  end 

end
