class Page < ActiveRecord::Base
  has_many :lines 

  def page_label
    id.to_s + "." + date.to_s + "_" + place
  end
end

