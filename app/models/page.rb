class Page < ActiveRecord::Base
  include CalenderUtil
  has_many :lines,->{order("no ASC") } ,dependent: :destroy
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
    d += "</b>"
    d += "&nbsp;<table border=1><tr>"
    d += "<td> 熱量: " + tortal_cal.to_s + "kcal </td> "
    d += "<td> 炭水化物: " + carbohydrate_sum.to_s + "g </td><td> 脂肪: " + fat_sum.to_s + "g</td><td> たんぱく質 :" + protein_sum.to_s + "g</td><td>野菜 :" + vegetable_sum.to_s + "g</td>" 
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
    if diet_memo_3 && diet_memo_3.size > 0
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
    if diet_memo_4 && diet_memo_4.size > 0
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
    if diet_memo_5 && diet_memo_5.size > 0
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
  def tortal_cal
    carbohydrate_sum * 4 + fat_sum * 9 + protein_sum * 4
  end
  def meal1_cal
    carbohydrate_1.to_f * 4 + fat_1.to_f * 9 + protein_1.to_f * 4
  end
  def meal2_cal
    carbohydrate_2.to_f * 4 + fat_2.to_f * 9 + protein_2.to_f * 4
  end
  def meal3_cal
    carbohydrate_3.to_f * 4 + fat_3.to_f * 9 + protein_3.to_f * 4
  end
  def meal4_cal
    carbohydrate_4.to_f * 4 + fat_4.to_f * 9 + protein_4.to_f * 4
  end
  def meal5_cal
    carbohydrate_5.to_f * 4 + fat_5.to_f * 9 + protein_5.to_f * 4
  end
  def carbohydrate_sum
    carbohydrate_1.to_i + carbohydrate_2.to_i + carbohydrate_3.to_i + carbohydrate_4.to_i + carbohydrate_5.to_i
  end
  def fat_sum
    fat_1.to_i + fat_2.to_i + fat_3.to_i + fat_4.to_i + fat_5.to_i
  end
  def protein_sum
    protein_1.to_i + protein_2.to_i + protein_3.to_i + protein_4.to_i + protein_5.to_i
  end
  def vegetable_sum
    vegetable_1.to_i + vegetable_2.to_i + vegetable_3.to_i + vegetable_4.to_i + vegetable_5.to_i
  end
  def page_label
    id.to_s + "." + date.to_s + "_" + place
  end
  # 
  #decolater like
  ######################################
  scope :training_only, ->do
   #trainig.size > 0
   joins(:lines) 
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

