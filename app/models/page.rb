class Page < ActiveRecord::Base
  has_many :lines,->{order("no ASC") } ,dependent: :destroy
  belongs_to :diet
 def diet_summaly
   d = ""
   d += diet.name if diet_id
   d += "</br>"
   d += "c:" + carbohydrate_1.to_s + "g, "
   d += "f:" + fat_1.to_s + "g, "
   d += "p:" + protein_1.to_s + "g, "
   d += "v:" + vegetable_1.to_s + "g, "
   d += diet_memo_1.to_s
   d += "</br>"
   d += "c:" + carbohydrate_2.to_s + "g, "
   d += "f:" + fat_2.to_s + "g, "
   d += "p:" + protein_2.to_s + "g, "
   d += "v:" + vegetable_2.to_s + "g, "
   d += diet_memo_2.to_s
   d += "</br>"
   d += "c:" + carbohydrate_3.to_s + "g, "
   d += "f:" + fat_3.to_s + "g, "
   d += "p:" + protein_3.to_s + "g, "
   d += "v:" + vegetable_3.to_s + "g, "
   d += diet_memo_3.to_s
   d += "</br>"
   d += "c:" + carbohydrate_4.to_s + "g, "
   d += "f:" + fat_4.to_s + "g, "
   d += "p:" + protein_4.to_s + "g, "
   d += "v:" + vegetable_4.to_s + "g, "
   d += diet_memo_4.to_s
   d += "</br>"
   d += "c:" + carbohydrate_5.to_s + "g, "
   d += "f:" + fat_5.to_s + "g, "
   d += "p:" + protein_5.to_s + "g, "
   d += "v:" + vegetable_5.to_s + "g, "
   d += diet_memo_5.to_s
 end

  def page_label
    id.to_s + "." + date.to_s + "_" + place
  end

  class << self
    def search(par_query)
      query = order("date desc,id desc")
      if par_query.present?
        query = query.where("place LIKE ? ", "%#{par_query}%")
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

