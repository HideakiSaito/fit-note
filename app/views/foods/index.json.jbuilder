json.array!(@foods) do |food|
  json.extract! food, :id, :name, :diet_id, :calorie, :carbohydrate, :fat, :protein, :vegetable, :diet_memo
  json.url food_url(food, format: :json)
end
