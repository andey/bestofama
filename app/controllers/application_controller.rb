class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def store_location
    if params[:return_to]
      session[:return_to] = params[:return_to]
    end
  end

  def redirect_back_or_default(default)
    redirect_to (session[:return_to] || default)
    session[:return_to] = nil
  end
end
