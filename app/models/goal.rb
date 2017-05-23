class Goal < ActiveRecord::Base
  include RepsCalculator
  belongs_to :user
  def memo_br
    memo.gsub(/\r\n|\r|\n/, "<br />")
  end
  def push_power
    max_reps(push_val1,push_val2)
  end
  def pull_power
    max_reps(pull_val1,pull_val2)
  end
  def leg_power
    max_reps(leg_val1,leg_val2)
  end
  def back_power
    max_reps(back_val1,back_val2)
  end
    #スコープ
  default_scope -> do
    order("start_date desc")
  end
end
