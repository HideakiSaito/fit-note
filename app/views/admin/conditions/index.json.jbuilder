json.array!(@conditions) do |condition|
  json.extract! condition, :id, :name, :score, :memo
  json.url condition_url(condition, format: :json)
end
