class Line < ActiveRecord::Base
  belongs_to :page
  belongs_to :item
  belongs_to :mode

  validates :page, :item, :mode , presence: true

end
