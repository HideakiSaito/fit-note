class Goal < ActiveRecord::Base
  belongs_to :user
  def memo_br
    memo.gsub(/\r\n|\r|\n/, "<br />")
  end
  #スコープ
  default_scope -> do
    order("start_date desc")
  end
end
