require 'rails_helper'

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
  end
end
