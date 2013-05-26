json.array!(@upcomings) do |upcoming|
  json.extract! upcoming, :who, :date, :description
  json.url upcoming_url(upcoming, format: :json)
end