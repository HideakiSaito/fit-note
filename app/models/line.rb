class Line < ActiveRecord::Base
  belongs_to :page
  belongs_to :item
  belongs_to :mode

  validates :page, :item, :mode , presence: true

  def print_label
    page.page_label + '_' + item.name + '_' + no.to_s
  end
end
