class Food < ActiveRecord::Base
  belongs_to :diet
  belongs_to :food_category
  has_many :food_votes, dependent: :destroy
  has_many :voters, through: :food_votes, source: :user

   def disp_memo
    if food_category
    "<" + food_category.no.to_s + "." + food_category.name + ">  " + diet_memo
    else
      diet_memo
    end
  end
  #スコープ
  default_scope  -> do
    #p "default_scope "
    includes(:food_category).order("food_category_id , sort_key desc ,id")
  end
  class << self
    def search(query)
      rel = order("id")
      if query.present?
        rel = rel.where("name LIKE ? ", "%#{query}%")
      end
      rel
    end
    #JSONのインポート
    def import(file)
      s = File.read(file.path, :encoding => Encoding::UTF_8)
      JSON.parse( s ).each do |elem|
        food = find_by(id: elem[:id]) || new
        food.assign_attributes(elem)
        food.save
      end
    end
  end
end
