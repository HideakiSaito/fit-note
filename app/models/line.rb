class Line < ActiveRecord::Base

include RepsCalculator
include EmailAddressChecker
include Com

  belongs_to :page
  belongs_to :item
  belongs_to :mode

  validates :page, :no, :item, :mode , presence: true

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
  
  def this_max_reps
    line_max_reps(self)
  end
end
