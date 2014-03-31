class IndexController < ApplicationController
  layout 'v3'

  def show
    @amas = Ama.order(:date).limit(5).reverse_order
    @upcomings = Upcoming.where('date > ?', Time.now).order(:date).limit(5)
  end

  private
  def default_url_options
    {:host => "bestofama.com"}
  end
end