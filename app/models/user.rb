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
  # Below are some additions to DRY the controller,
  # they are methods that specifically interact with the database,
  # some of the methods however are helper methods,
  # following this article: https://dev.to/kputra/rails-skinny-controller-skinny-model-5f2k#phase-3
  # We could begin to aspire to having skinny controller, skinny model by creacting classes inside the lib directory

    ----------------------------------------------------------------------
  # | by placing all of the business logic inside the model,             |
  # | we will no longer need to make requests in order to test the code, |
  # | we can simply test the methods                                     |
     ---------------------------------------------------------------------

  def friends
    self.followers
  end

  def friends_sleep_records(sleep_records = [], days_limit)
    friends.each do |friend|
      sleeps_of(friend, days_limit).each do |sleep|
        minutes_of_(sleep)
        sleep_records << { friend_name: friend.name, sleep_length: length_of_(sleep) }
      end
    end
    sleep_records
  end

  def sleeps_of(friend, days_limit)
    friend.sleeps.where(updated_at: ((DateTime.now - days_limit)..DateTime.now))
  end

  def length_of_(sleep)
    (sleep.created_at - sleep.updated_at).abs / 60 
  end 

end
