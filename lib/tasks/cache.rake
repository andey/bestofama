namespace :cache do

  # Build the cache of all AMA comments
  task :build => :environment do
    require 'cache_builder'

    Ama.order(:updated_at).each do |a|
      puts '--------------'
      puts a.title
      response = CacheBuilder.build_ama(a)
      puts response.code
    end
  end

end