namespace :upcoming do

  task :fetch => :environment do
    google = 'http://www.google.com/calendar/feeds/amaverify@gmail.com/public/full?orderby=starttime&max-results=100&singleevents=true&sortorder=ascending&futureevents=true&alt=json'
    http = Net::HTTP.new("www.google.com")
    request = Net::HTTP::Get.new(google)
    response = http.request(request)
    json = JSON.parse(response.read_body)

    json["feed"]["entry"].each do |entry|
      url = entry['id']['$t'].to_s
      title = entry['title']['$t'].to_s
      content = entry['content']['$t'].to_s
      date = entry['gd$when'][0]['startTime']
      Upcoming.create(:title => title, :description => content, :date => date, :url => url)
    end
  end

end