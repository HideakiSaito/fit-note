class Page < ActiveRecord::Base
  has_many :lines,->{order("no ASC") } ,dependent: :destroy
  def page_label
    id.to_s + "." + date.to_s + "_" + place
  end
  class << self
    def search(query)
      rel = order("date desc")
      if query.present?
        rel = rel.where("place LIKE ? ", "%#{query}%")
      end
      rel
    end
  end
end

