class Line < ActiveRecord::Base
  belongs_to :page
  belongs_to :item
  belongs_to :mode

  validates :page, :item, :mode , presence: true

  #スコープ
  scope :default_order , -> do
    order("page_id desc , no asc")
  end

  def self.get_now_no(page_id) 
    l = Line.where("page_id=?",page_id).order(:no)
    return 1 if l.size == 0
    l.last.no + 1 #あれば＋１
  end

  def print_label
    page.page_label + '_' + item.name + '_' + no.to_s
  end
end
