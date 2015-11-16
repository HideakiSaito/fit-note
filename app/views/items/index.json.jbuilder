json.array!(@items) do |item|
  json.extract! item, :id, :name, :reps, :part_id, :mode_id, :equipment_id
  json.url item_url(item, format: :json)
end
