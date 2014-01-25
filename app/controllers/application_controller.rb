class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from "ActionController::UnknownAction", :with => :render_404
  rescue_from "ActionController::UnknownFormat", :with => :render_404
  rescue_from "ActionController::RoutingError",  :with => :render_404

  def raise_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_404
    redirect_to '/404'
  end
end
