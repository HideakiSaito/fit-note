class Page < ActiveRecord::Base
  has_many :lines , ->{order("no ASC") } 

  def page_label
    id.to_s + "." + date.to_s + "_" + place
  end
end

