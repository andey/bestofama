# Populate AMAs over 7 days old with no Responses.
task :populate_amas => :environment do
  require 'api/reddit'
  Ama.where("responses = 0 and date < ?", Time.now - 7.days).order(:date).limit(1).each do |ama|
    ap ama
    Reddit.populate_ama(ama)
  end
end