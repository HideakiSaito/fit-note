class Page < ActiveRecord::Base
  has_many :lines,->{order("no ASC") } ,dependent: :destroy

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

