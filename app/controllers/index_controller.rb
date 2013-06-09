class IndexController < ApplicationController
  layout 'v3'

  def show
    @amas = Ama.limit(5).reverse_order
    @upcomings = Upcoming.order(:date).limit(5)
  end
end