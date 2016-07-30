json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :name
  json.url equipment_url(equipment, format: :json)
end
