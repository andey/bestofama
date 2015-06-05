require 'api/instantlinkindexer.com'

namespace :spam do
  task :links => :environment do
    i = InstantLinkIndexer.new
    5.times do
      i.submit()
    end
  end
end