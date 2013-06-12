class ApplicationController < ActionController::Base
  protect_from_forgery

  def raise_404
    raise ActionController::RoutingError.new('Not Found')
  end
end
