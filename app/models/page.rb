class Page < ActiveRecord::Base
  has_many :lines,->{order("no ASC") } ,dependent: :destroy

  def page_label
    id.to_s + "." + date.to_s + "_" + place
  end

  class << self
    #検索
    def search(query)
      rel = order("date desc")
      if query.present?
        rel = rel.where("place LIKE ? ", "%#{query}%")
      end
      rel
    end

    #JSONのインポート
    def import(file)
      s = File.read(file.path, :encoding => Encoding::UTF_8)
      JSON.parse( s ).each { |elem| page = Page.new(elem); page.save }
    end
  end
end

