json.array!(@pages) do |page|
  json.extract! page, :id, :date, :place, :start_time, :end_time, :memo, :image,:diet_id,:carbohydrate_1, :fat_1, :protein_1, :vegetable_1, :diet_memo_1, :carbohydrate_2, :fat_2, :protein_2, :vegetable_2, :diet_memo_2, :carbohydrate_3, :fat_3, :protein_3, :vegetable_3, :diet_memo_3, :carbohydrate_4, :fat_4, :protein_4, :vegetable_4, :diet_memo_4, :carbohydrate_5, :fat_5, :protein_5, :vegetable_5, :diet_memo_5 
  #json.url page_url(page, format: :json)
end
