json.array!(@page_images) do |page_image|
  json.extract! page_image, :id, :page_id, :data, :content_type
  json.url page_image_url(page_image, format: :json)
end
