class Goal < ActiveRecord::Base
  belongs_to :user

  #スコープ
  default_scope -> do
    order("start_date desc")
  end
end
