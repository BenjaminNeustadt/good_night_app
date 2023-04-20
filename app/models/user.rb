class User < ApplicationRecord
  has_many :sleeps
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  # the sleeps of friends we are interested is limited to the last week
  DAYS_LIMIT = 70

  def is_still_sleeping?
    self.sleeps&.last.updated_at == self.sleeps&.last.created_at
  end

  def start_sleep
    self.sleeps.create
  end

  def end_sleep
    self.sleeps.last&.touch
  end

  def friends
    self.followers
  end

  def friends_sleeps
    friends.each_with_object([]) do |friend, records|
      sleeps_of(friend).each do |sleep|
        length_of(sleep)
        records << { friend_name: friend.name, sleep_length: length_of(sleep) }
      end
    end
  end

  def sleeps_of(friend)
    friend.sleeps.where(updated_at: ((DateTime.now - DAYS_LIMIT)..DateTime.now))
  end

  def length_of(sleep)
    (sleep.created_at - sleep.updated_at).abs / 60 
  end 

end
