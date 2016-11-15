json.array!(@page_selfies) do |page_selfy|
  json.extract! page_selfy, :id, :page_id, :data, :content_type
  json.url page_selfy_url(page_selfy, format: :json)
end
