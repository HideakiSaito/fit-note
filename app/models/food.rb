class Food < ActiveRecord::Base
  belongs_to :diet
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
