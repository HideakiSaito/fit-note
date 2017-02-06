json.extract! last_meal, :id, :user_id, :food_id, :date, :memo, :created_at, :updated_at
json.url last_meal_url(last_meal, format: :json)