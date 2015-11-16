json.array!(@modes) do |mode|
  json.extract! mode, :id, :name, :detail
  json.url mode_url(mode, format: :json)
end
