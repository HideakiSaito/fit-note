json.array!(@feelings) do |feeling|
  json.extract! feeling, :id, :name, :score, :memo
  json.url feeling_url(feeling, format: :json)
end
