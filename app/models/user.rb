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

end
