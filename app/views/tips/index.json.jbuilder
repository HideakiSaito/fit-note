json.array!(@tips) do |tip|
  json.extract! tip, :id, :tip_category_id, :tip_recommendation_id, :name, :description, :author
  json.url tip_url(tip, format: :json)
end
