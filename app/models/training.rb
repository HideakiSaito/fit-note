class Training < ActiveRecord::Base
  belongs_to :item
  belongs_to :mode

  #スコープ
  scope :default_order , -> do
    order(:day , :num)
  end

end
