require 'rails_helper'

RSpec.describe "UsersModel" do

  context ".friends_sleep_records" do

    before(:each) do
      @current_time = Time.now.floor
    end

    it 'contains the sleep records of friends' do
      
      # Create users
      user1 = User.create(name: 'User 1')
      user2 = User.create(name: 'User 2')
      user3 = User.create(name: 'User 3')

      # Create sleeps for users
      sleep_record1 = Sleep.create(created_at: @current_time - 2.hours, updated_at: @current_time, user: user1)
      sleep_record2 = Sleep.create(created_at: @current_time - 3.hours, updated_at: @current_time, user: user1)

      # Create friend relationships
      Follow.create(follower: user1, followee: user2)
      Follow.create(follower: user1, followee: user3)

      expected_sleep_record = [ {:friend_name=>"User 1", :sleep_length=>120}, {:friend_name=>"User 1", :sleep_length=>2}]

      expect(user2.friends_sleeps.first[:friend_name]).to eq "User 1"
      expect(user2.friends_sleeps.first).to include(expected_sleep_record.first)
    end

    it 'arranges sleeps according to length of sleep' do
      
      user1 = User.create(name: 'User 1')
      user2 = User.create(name: 'User 2')
      user3 = User.create(name: 'User 3')

      # Create sleeps for users
      sleep_record1 = Sleep.create(created_at: @current_time - 2.hours, updated_at: @current_time, user: user1)
      sleep_record2 = Sleep.create(created_at: @current_time - 3.hours, updated_at: @current_time, user: user1)

      # Create friend relationships
      Follow.create(follower: user1, followee: user2)
      Follow.create(follower: user1, followee: user3)

      expected_sleep_record = [{:friend_name=>"User 1", :sleep_length=>120}, {:friend_name=>"User 1", :sleep_length=>180}]

      expect(user2.friends_sleeps.first).to eq(expected_sleep_record[0])
      expect(user2.friends_sleeps.last).to eq(expected_sleep_record[1])
    end
  end

end