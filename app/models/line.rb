class Line < ActiveRecord::Base
  belongs_to :page
  belongs_to :item
  belongs_to :mode
end
