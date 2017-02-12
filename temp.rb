
Food.includes(:last_meal).order("last_meals.date DESC")

#最初のユーザのお気に入りの食事、　最後に食べた記録がないのでとりあえず作る
u = User.find 1
u.voted_foods.each do |food| 
    if food.last_meal == nil 
        food.create_last_meal(user: u,date: Date.current - 1)
        food.save
    end
end 

u.voted_foods.includes(:last_meal).order("last_meals.date DESC")
   
TipCategory.create ([
  {name: "トレーニング"},
  {name: "ダイエット（食事）"},
  {name: "休息"},
  {name: "ダイエット（全般）"},
  {name: "プログラム・IT"}
])

TipRecommendation.create ([
  {name: "絶対オススメ", rate: 5 },
  {name: "かなりオススメ", rate: 4 },
  {name: "まあまあオススメ", rate: 3 },
  {name: "できれば", rate: 2 },
  {name: "どっちでもいい", rate: 1 },
  {name: "なし", rate: 0 }
])