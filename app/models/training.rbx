class Training < ActiveRecord::Base
  belongs_to :item
  belongs_to :mode

  #スコープ
  scope :default_order , -> do
    order("day desc , num asc")
  end

  def self.get_now_num 
    t = Training.where("day=?",Date.today).order(:num)
    return 1 if t.size == 0
    t.last.num + 1 #あれば＋１
  end

end

