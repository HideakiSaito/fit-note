class Mode < ActiveRecord::Base
  class << self
    def search(query)
      rel = order("id")
      if query.present?
        rel = rel.where("name LIKE ? ", "%#{query}%")
      end
      rel
    end
  end
  #スコープ
  scope :inTheHome , ->  do
    where( )
  end
end
