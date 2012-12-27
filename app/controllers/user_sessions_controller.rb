class UserSessionsController < ApplicationController
  layout false
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    if params[:user_session][:username] != '' && params[:user_session][:password] != ''
      require 'api/reddit'
      query = {:user => params[:user_session][:username], :passwd => params[:user_session][:password], :api_type => 'json'}
      login = Reddit.post('http://www.reddit.com/api/login/' + params[:user_session][:username], query)
      if login["json"]["errors"].empty?
        user = Reddit.find_user(params[:user_session][:username])
        info = Reddit.get('http://www.reddit.com/user/' + user.username + '/about.json')
        user.update_attributes(:modhash => login["json"]["data"]["modhash"], :active => true, :link_karma => info["data"]["link_karma"], :comment_karma => info["data"]["comment_karma"])
        @user_session = UserSession.create(user, true)
        if @user_session.save
          redirect_to root_path, :notice => "Login successful!"
        else
          redirect_to new_session_path, :notice => "Oops, not sure what went wrong, try again!"
        end
      else
        redirect_to new_session_path, :notice => login["json"]["errors"][0][0]
      end
    else
      redirect_to new_session_path, :notice => "Please enter your username and password"
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_path, :notice => "Logout successful!"
  end
end