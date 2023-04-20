class User < ApplicationRecord
  has_many :sleeps

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

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

=begin
==========================================================================================
WIP ================
==========================================================================================
Below are some additions to DRY the controller,
2 are methods that specifically interact with the database,
on is a method that calls the latter
some of the methods however are helper methods,
following this article: https://dev.to/kputra/rails-skinny-controller-skinny-model-5f2k#phase-3
We could begin to aspire to having skinny controller, skinny model by creacting classes inside the lib directory

----------------------------------------------------------------------
| by placing all of the business logic inside the model,             |
| we will no longer need to make requests in order to test the code, |
| we can simply test the methods                                     |
  ---------------------------------------------------------------------

=end
  def friends
    self.followers
  end

  def friends_sleeps
    sleep_records = []
    friends.each do |friend|
      sleeps_of(friend).each do |sleep|
        length_of(sleep)
        sleep_records << { friend_name: friend.name, sleep_length: length_of(sleep) }
      end
    end
    sleep_records
  end

  def sleeps_of(friend)
    friend.sleeps.where(updated_at: ((DateTime.now - DAYS_LIMIT)..DateTime.now))
  end

  def length_of(sleep)
    (sleep.created_at - sleep.updated_at).abs / 60 
  end 

end
