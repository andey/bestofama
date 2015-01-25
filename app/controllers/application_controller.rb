class ApplicationController < ActionController::Base
  force_ssl if: :ssl_configured?
  protect_from_forgery
  rescue_from "ActionController::UnknownAction", :with => :raise_404
  rescue_from "ActionController::UnknownFormat", :with => :raise_404
  rescue_from "ActionController::RoutingError",  :with => :raise_404

  def raise_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def ssl_configured?
    Rails.env.production?
  end

end
