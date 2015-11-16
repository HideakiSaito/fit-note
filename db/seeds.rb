# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Part.create([
    {name: "胸"},
    {name: "背中(上)"},
    {name: "背中(下)"},
    {name: "下半身"},
    {name: "臀部"},
    {name: "大腿四頭筋"},
    {name: "ハムストリング"},
    {name: "カーフ"},
    {name: "肩（前）"},
    {name: "肩（中）"},
    {name: "肩（後）"},
    {name: "上腕二頭筋"},
    {name: "上腕三頭筋"},
    {name: "前腕"},
    {name: "腹筋（前）"},
    {name: "腹筋（横）"}
])

Equipment.create([
  {name: "バーベル"},
  {name: "ダンベル"},
  {name: "ケーブル"},
  {name: "トレーニングマシン"},
  {name: "自重"}
])

Mode.create ([
  {name: "トラディショナル", detail: "10reps x 3Set"},
  {name: "ドロップセット", detail: "すぐに１５％ウェイトを落として続ける。３ドロップまで"},
  {name: "パーシャルセット", detail: "次のレップスで限界な時に、できる可動域で行う"},
  {name: "5 by 5", detail: "5reps x 5Set"},
  {NAMEe: "ジャーマン風セット", detail: "8reps x 6set..."}
])
