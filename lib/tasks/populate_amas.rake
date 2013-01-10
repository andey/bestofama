# Populate AMAs over 7 days old with no Responses.
task :populate_amas => :environment do
  require 'api/reddit'
  Ama.where("responses = 0 and date < ?", Time.now - 3.days).order(:date).reverse_order.limit(1).each do |ama|
    Reddit.populate_ama(ama)
    ActionController::Base.new.expire_fragment(ama.key, options = nil)
  end
end