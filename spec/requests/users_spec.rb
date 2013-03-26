require 'spec_helper'

describe "Users" do
  describe "GET /user/:username" do
    it "shows user page" do
      user = FactoryGirl.create(:user)
      get user_path(user.username)
      response.body.should include(user.username)
    end

    it "missing user redirects to root_path()" do
      get user_path('admin')
      response.body.should redirect_to root_path()
    end
  end
end
