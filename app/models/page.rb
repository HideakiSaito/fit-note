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
    h += "体調：" + condition.name + "!? , " if condition
    h += "気分：" + feeling.name + "!? , " if feeling
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
    h += "　TODO:この辺をいい感じにグラフで出す"
  end
  def diet_summaly
    d = ""
    d += "<b>" + diet.name + "</b> " if diet_id
    d += tortal_cal.to_s + "kcal"
    d += "</br>"
    d += " tortal => 炭水化物:" + carbohydrate_sum.to_s + "g , 脂肪:" + fat_sum.to_s + "g , たんぱく質:" + protein_sum.to_s + "g , 野菜:" + vegetable_sum.to_s + "g" 
    d += "</br>"
    if diet_memo_1
      d += "<b>①</b>"
      d += diet_memo_1.to_s
      d += "</br>&nbsp;&nbsp;"
      d += "c:" + carbohydrate_1.to_s + "g, "
      d += "f:" + fat_1.to_s + "g, "
      d += "p:" + protein_1.to_s + "g, "
      d += "v:" + vegetable_1.to_s + "g, "
      d += "</br>"
    end
    if diet_memo_2
      d += "<b>②</b>"
      d += diet_memo_2.to_s
      d += "</br>&nbsp;&nbsp;"
      d += "c:" + carbohydrate_2.to_s + "g, "
      d += "f:" + fat_2.to_s + "g, "
      d += "p:" + protein_2.to_s + "g, "
      d += "v:" + vegetable_2.to_s + "g, "
      d += "</br>"
    end
    if diet_memo_3 && diet_memo_3.size > 0
      d += "<b>③</b>"
      d += diet_memo_3.to_s
      d += "</br>&nbsp;&nbsp;"
      d += "c:" + carbohydrate_3.to_s + "g, "
      d += "f:" + fat_3.to_s + "g, "
      d += "p:" + protein_3.to_s + "g, "
      d += "v:" + vegetable_3.to_s + "g, "
      d += "</br>"
    end
    if diet_memo_4 && diet_memo_4.size > 0
      d += "<b>④</b>"
      d += diet_memo_4.to_s
      d += "</br>&nbsp;&nbsp;"
      d += "c:" + carbohydrate_4.to_s + "g, "
      d += "f:" + fat_4.to_s + "g, "
      d += "p:" + protein_4.to_s + "g, "
      d += "v:" + vegetable_4.to_s + "g, "
      d += "</br>"
    end
    if diet_memo_5 && diet_memo_5.size > 0
      d += "<b>⑤</b>"
      d += diet_memo_5.to_s
      d += "</br>&nbsp;&nbsp;"
      d += "c:" + carbohydrate_5.to_s + "g, "
      d += "f:" + fat_5.to_s + "g, "
      d += "p:" + protein_5.to_s + "g, "
      d += "v:" + vegetable_5.to_s + "g, "
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

