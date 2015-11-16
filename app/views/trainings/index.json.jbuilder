json.array!(@trainings) do |training|
  json.extract! training, :id, :item_id, :weight, :reps, :set, :mode_id
  json.url training_url(training, format: :json)
end
