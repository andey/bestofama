require 'api/reddit.com'

namespace :find do

  # Create AMA if :
  # * Karma greater than 100
  # * Isn't an AMA Request
  # * Isn't in the Trash
  def create(ama)
    @ama = Ama.new
    @ama.create_by_json(ama["data"]) unless Ama.find_by_key(ama["data"]["id"])
  end

  def process(amas)
    amas["data"]["children"].each do |ama|
      create(ama) if good?(ama)
    end
  end

  def good?(ama)
    return ama["data"]["score"].to_i > 100 && !ama["data"]["title"].to_s.match(/ama request/i) && !Trash.find_by(key: ama["data"]["id"])
  end

  # Find NEW AMAs
  task :new => :environment do
    reddit = Reddit.new
    amas = reddit.getIAMAs()
    process(amas) if amas
  end

  # Find AMAs FROM SPECIFIED URL
  task :in_url, [:count, :after] => :environment do |t, args|
    reddit = Reddit.new
    amas = reddit.get("/r/IAmA.json?count=#{args[:count]}&after=#{args[:after]}")
    process(amas) if amas
  end

  # Find OLD AMAs
  task :old => :environment do

    #get query variables to build reddit query
    count = Metum.find_by_name("find_old_ama-count")
    after = Metum.find_by_name("find_old_ama-after")
    time = Metum.find_by_name("find_old_ama-time")
    category = Metum.find_by_name("find_old_ama-category")

    reddit = Reddit.new
    amas = reddit.get("/r/IAmA/#{category.value}/.json?sort=top&count=" + count.value + "&after=" + after.value + "&t=" + time.value)

    if amas
      process(amas)

      # Update meta the query variables for the next run
      count.update_attribute(:value, count.value.to_i + 25)
      after.update_attribute(:value, result["data"]["after"])
    end
  end

end
