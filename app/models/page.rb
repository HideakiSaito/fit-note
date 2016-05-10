class Page < ActiveRecord::Base
  include CalenderUtil
  has_many :lines,->{order("no ASC") } ,dependent: :destroy
  has_one :image ,class_name: "PageImage",dependent: :destroy
  accepts_nested_attributes_for :image, allow_destroy: true
  belongs_to :diet
  belongs_to :condition
  belongs_to :feeling
  def my_initialize
    sleep_time = Time.local(2000, 1, 1, 22, 30, 00)
    end_time = Time.current + (2.5 * 60 * 60) 
  end
  #####################################
  #decolater like
  #
  def health_summaly
    h = ""
    h += "<b>"
    h += "体調：" + condition.name + "[" + condition.score.to_i.to_s + "] , " if condition
    h += "気分：" + feeling.name + "[" + feeling.score.to_i.to_s + "] , " if feeling
    h += "</b>"
    h += "</br>"
    h += "<b>"
    h += "睡眠時間：" + sleep_hour.to_s + "h , "
    h += "ベッドイン：" + sleep_time.strftime("%H:%M") + " , " if sleep_time
    h += "</b>"
    h += "</br>"
    h += "水分：" + water.to_s + "mg , "
    h += "カフェイン：" + caffeine.to_s + "mg , "
    h += "アルコール：" + alcohol.to_s + "mg , "
    h += "</br>"
  end
  def diet_summaly
    d = ""
    d += "<b>"
    d += diet.name  if diet_id
    d += " _ 運動消費カロリー:" + burn_cal.to_s + "kcal"
    d += " _ 基礎代謝カロリー:" + basic_burn_cal.to_s + "kcal ⬆︎これ以上は摂取する"
    d += "</b>"
    d += "&nbsp;<table border=1><tr>"
    d += "<td><b> 熱量: " + tortal_cal.to_s + "kcal </b></td> "
    d += "<td> 炭水化物: " + carbohydrate_sum.to_s + "g </td><td> 脂肪: " + fat_sum.to_s + "g</td><td><b> たんぱく質 :" + protein_sum.to_s + "g</b></td><td>野菜 :" + vegetable_sum.to_s + "g</td>" 
    d += "</tr></table><br>"
    if diet_memo_1
      d += "<b>①</b>"
      d += diet_memo_1.to_s
      d += "<table border=1><tr>"
      d += "<td> 熱量: " + meal1_cal.to_s + "kcal </td> "
      d += "<td>炭水化物 :" + carbohydrate_1.to_s + "g</td>"
      d += "<td>脂肪 :" + fat_1.to_s + "g</td> "
      d += "<td>たんぱく質 :" + protein_1.to_s + "g</td> "
      d += "<td>野菜 :" + vegetable_1.to_s + "g</td> "
      d += "</tr></table>"
      d += "</br>"
    end
    if diet_memo_2
      d += "<b>②</b>"
      d += diet_memo_2.to_s
      d += "<table border=1><tr>"
      d += "<td> 熱量: " + meal2_cal.to_s + "kcal </td> "
      d += "<td>炭水化物 :" + carbohydrate_2.to_s + "g</td>"
      d += "<td>脂肪 :" + fat_2.to_s + "g</td> "
      d += "<td>たんぱく質 :" + protein_2.to_s + "g</td> "
      d += "<td>野菜 :" + vegetable_2.to_s + "g</td> "
      d += "</tr></table>"
      d += "</br>"
    end
    if diet_memo_3 && diet_memo_3.size > 0.0
      d += "<b>③</b>"
      d += diet_memo_3.to_s
      d += "<table border=1><tr>"
      d += "<td> 熱量: " + meal3_cal.to_s + "kcal </td> "
      d += "<td>炭水化物 :" + carbohydrate_3.to_s + "g</td>"
      d += "<td>脂肪 :" + fat_3.to_s + "g</td> "
      d += "<td>たんぱく質 :" + protein_3.to_s + "g</td> "
      d += "<td>野菜 :" + vegetable_3.to_s + "g</td> "
      d += "</tr></table>"
      d += "</br>"
    end
    if diet_memo_4 && diet_memo_4.size > 0.0
      d += "<b>④</b>"
      d += diet_memo_4.to_s
      d += "<table border=1><tr>"
      d += "<td> 熱量: " + meal4_cal.to_s + "kcal </td> "
      d += "<td>炭水化物 :" + carbohydrate_4.to_s + "g</td>"
      d += "<td>脂肪 :" + fat_4.to_s + "g</td> "
      d += "<td>たんぱく質 :" + protein_4.to_s + "g</td> "
      d += "<td>野菜 :" + vegetable_4.to_s + "g</td> "
      d += "</tr></table>"
      d += "</br>"
    end
    if diet_memo_5 && diet_memo_5.size > 0.0
      d += "<b>⑤</b>"
      d += diet_memo_5.to_s
      d += "<table border=1><tr>"
      d += "<td> 熱量: " + meal5_cal.to_s + "kcal </td> "
      d += "<td>炭水化物 :" + carbohydrate_5.to_s + "g</td>"
      d += "<td>脂肪 :" + fat_5.to_s + "g</td> "
      d += "<td>たんぱく質 :" + protein_5.to_s + "g</td> "
      d += "<td>野菜 :" + vegetable_5.to_s + "g</td> "
      d += "</tr></table>"
    end
    d #最後nilで終わると何も出ないので
  end
  #今年の週
  def yweek
   date.strftime("%W")
  end
  #xx月yy週
  def mweek
    disp_mweek(date)
  end
  def basic_burn_cal
    #ハリス・ベネディクト方程式(改良版)を使って基礎代謝量を計算しています。
    #男性： 13.397×体重kg＋4.799×身長cm－5.677×年齢+88.362
    #女性： 9.247×体重kg＋3.098×身長cm－4.33×年齢+447.593
    hight = 170.0 #ここは後でユーザモデルから取得
    old = 33.0 #ここは後でユーザモデルから取得
    w = 74.0 #ここは後でユーザモデルから取得
    w = wight.to_f if wight.to_f != 0.0  #最新でーたがあれば上書き
    burn_cal = 13.397 * w + 4.799 * hight - 5.866 * old + 88.362
    burn_cal.round 2
  end
  def burn_cal
    mets = 6.0  # ウェイトトレーニング、ズンバを軽く見積もって。種目ごととかは難しいし、ズンバだけ分けるほどでもないので
    w = 70.0 #ここは後でユーザモデルから取得
    w = wight.to_f if wight.to_f != 0.0  #最新でーたがあれば上書き
    ex = mets * training_hour.to_f  
    ex = ex * 0.7  #休み時間を考慮 3割くらいは休んでいる感じ。
    burn_cal = ex * w * 1.05
    burn_cal.round 2
  end
  def tortal_cal
    cal = carbohydrate_sum * 4 + fat_sum * 9 + protein_sum * 4
    cal.round 2
  end
  def meal1_cal
    cal = carbohydrate_1.to_f * 4 + fat_1.to_f * 9 + protein_1.to_f * 4
    cal.round(2)
  end
  def meal2_cal
    cal = carbohydrate_2.to_f * 4 + fat_2.to_f * 9 + protein_2.to_f * 4
    cal.round 2
  end
  def meal3_cal
    cal = carbohydrate_3.to_f * 4 + fat_3.to_f * 9 + protein_3.to_f * 4
    cal.round 2
  end
  def meal4_cal
    cal = carbohydrate_4.to_f * 4 + fat_4.to_f * 9 + protein_4.to_f * 4
    cal.round 2
  end
  def meal5_cal
    cal = carbohydrate_5.to_f * 4 + fat_5.to_f * 9 + protein_5.to_f * 4
    cal.round 2
  end
  def carbohydrate_sum
    sum = carbohydrate_1.to_f + carbohydrate_2.to_f + carbohydrate_3.to_f + carbohydrate_4.to_f + carbohydrate_5.to_f
    sum.round 2
  end
  def fat_sum
    sum = fat_1.to_f + fat_2.to_f + fat_3.to_f + fat_4.to_f + fat_5.to_f
    sum.round 2
  end
  def protein_sum
    sum = protein_1.to_f + protein_2.to_f + protein_3.to_f + protein_4.to_f + protein_5.to_f
    sum.round 2 
  end
  def vegetable_sum
    sum = vegetable_1.to_f + vegetable_2.to_f + vegetable_3.to_f + vegetable_4.to_f + vegetable_5.to_f
    sum.round 2
  end
  def page_label
    id.to_s + "." + date.to_s + "_" + place
  end
  # 
  #decolater like
  ######################################
  scope :training_only, ->do
   #trainig.size > 0
   joins(:lines).distinct 
   end
  scope :default, -> do
    includes(:diet).includes(:feeling).includes(:condition).order("date desc")
  end
  scope :feel_include , -> do
    includes(:feeling).includes(:condition)
  end
  class << self
    def search(par_predicate)
      query = order("date desc,id desc")
      if par_predicate.present?
        predicate = "%#{par_predicate}%"
        query = query.where("place LIKE ? or memo LIKE ? ", predicate , predicate)
      end
    end
    #JSONのインポート
    def import(file)
      s = File.read(file.path, :encoding => Encoding::UTF_8)
      JSON.parse( s ).each do |elem| 
        page = find_by(id: elem[:id]) || new 
        page.assign_attributes(elem)
        page.save 
      end
    end
  end
end

