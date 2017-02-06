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