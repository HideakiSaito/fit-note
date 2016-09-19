json.array!(@tip_recommendations) do |tip_recommendation|
  json.extract! tip_recommendation, :id, :name, :rate
  #json.url tip_recommendation_url(tip_recommendation, format: :json)
end
