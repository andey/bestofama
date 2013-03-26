require 'spec_helper'

describe "Pages" do

  it "shows terms page" do
    get page_path('terms')
    response.body.should include('Terms and Conditions of Use')
  end

  it "missing page redirects to root_path()" do
    get page_path('missing')
    response.body.should redirect_to root_path()
  end

  it "Should show YES" do
    activate_authlogic
    user = FactoryGirl.create(:user)
    ap user
    ap @current_user_session
    ap @current_user
    ap UserSession.create(user)


    get page_path('test')
    response.body.should include('YES')
  end

end
