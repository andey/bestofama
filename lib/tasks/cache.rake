namespace :cache do
  # Build the cache of all AMAs
  task :build => :environment do
    require 'cache_builder'
    offset = ENV['offset'] ? ENV['offset'].to_i : 0

    Ama.order(:date).offset(offset).reverse_order.each do |a|
      puts '--------------'
      begin
        puts a.title
        response = CacheBuilder.build_ama(a)
        puts "Response: #{response.code}"
        puts "Count: #{offset}"
      ensure
        offset += 1
      end
    end
  end
end