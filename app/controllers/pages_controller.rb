#== Static Pages
# Static pages are handled by "high_voltage" gem.
# Pages can be found in views/pages

class PagesController < HighVoltage::PagesController
  layout 'v3'

  private
  def default_url_options
    {:host => "bestofama.com"}
  end
end