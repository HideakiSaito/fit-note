json.array!(@pages) do |page|
  json.extract! page, :id, :date, :place, :start_time, :end_time, :memo, :image
  #json.url page_url(page, format: :json)
end
