module UserFriendsHelper

  DAYS_LIMIT = 70

  def friends_sleeps_past_week
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