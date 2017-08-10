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

  class << self
    #JSONのインポート
    def import(file)
      s = File.read(file.path, :encoding => Encoding::UTF_8)
      JSON.parse( s ).each do |elem|
        goal = find_by(id: elem["id"]) || new
        goal.assign_attributes(elem)
        goal.save
      end
    end
  end
end
