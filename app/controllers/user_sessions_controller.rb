class UserSessionsController < ApplicationController
  layout false
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  before_filter :store_location

  # GET /session/login
  #
  # Displays login form, with notice about the privacy policy
  def new
    @user_session = UserSession.new
  end

  # POST /session
  #
  # Logs a user in using "authlogic" gem.
  def create

    # If a username and password is provided, continue
    if params[:user_session][:username] != '' && params[:user_session][:password] != ''

      # Connect to reddit.com, and send the username and password for authentication.
      require 'api/reddit'
      query = {:user => params[:user_session][:username], :passwd => params[:user_session][:password], :api_type => 'json'}
      login = Reddit.post('http://www.reddit.com/api/login/' + params[:user_session][:username], query)

      # If reddit.com has not given any authentication errors, continute
      if login["json"]["errors"].empty?

        # Find username in our database
        user = Reddit.find_user(params[:user_session][:username])

        # Update users, reddit.com stats
        info = Reddit.get('http://www.reddit.com/user/' + user.username + '/about.json')
        user.update_attributes(:modhash => login["json"]["data"]["modhash"], :active => true, :link_karma => info["data"]["link_karma"], :comment_karma => info["data"]["comment_karma"])

        # Create user session
        @user_session = UserSession.create(user, true)

        if @user_session.save
          flash[:notice] = "Successfully Logged In"

          # will send user to "return_to", if provided
          redirect_back_or_default root_path

        # Session could not be created
        else
          redirect_to new_session_path, :notice => "Oops, not sure what went wrong, try again!"
        end

      # The login credentials are invalid, causing reddit.com to give errors.
      else
        redirect_to new_session_path, :notice => login["json"]["errors"][0][0]
      end

    # No username / Password provided
    else
      redirect_to new_session_path, :notice => "Please enter your username and password"
    end
  end


  # GET /session/logout
  #
  # Destroys the users session.
  def destroy
    current_user_session.destroy
    flash[:notice] = "Successfully Logged Out"

    # Send user back to page viewing, prior to logging out
    redirect_back_or_default root_path
  end
end