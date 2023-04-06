require 'rails_helper'

# Integration tests 
RSpec.describe "UsersController", type: :request do
  describe "GET /users" do

    it "works!" do
      get users_path
      expect(response).to have_http_status(200)
    end

    it "returns the data associated with a user" do
      expected =  [{"name"=>"Erin", "id"=>1, "sleeps"=>[], "followers"=>[]}]
      User.create(name: "Erin")
      get users_path
      expect(JSON.parse(response.body)).to eq expected
    end

    it "increments a sleep on user" do
      user = User.create(name: "Erin")
      user.sleeps.create
      get users_path
      sleep_length = JSON.parse(response.body).first["sleeps"].length
      expect(sleep_length).to eq 1
    end

    it "updated_at is initially 'Still sleeping'" do
      user = User.create(name: "Erin")
      user.sleeps.create
      get users_path
      sleep = JSON.parse(response.body).first["sleeps"].first
      #sleep_start = sleep["created_at"]
      sleep_end = sleep["updated_at"]
      expect(sleep_end).to eq  "Still sleeping..."
    end
  end
end