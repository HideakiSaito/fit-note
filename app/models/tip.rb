class Tip < ActiveRecord::Base
  belongs_to :tip_category
  belongs_to :tip_recommendation

class <<self
  def random_one
    tip = Tip.new
    #rondom １件 http://easyramble.com/get-record-randomly-with-active-record.html
    if Tip.count > 0
     tip = Tip.where( 'id >= ?', rand(Tip.first.id..Tip.last.id) ).first
    end
  end
end
  def grol_mes
    mes = tip_category.name + ":" + star + "　　　　"
    mes += description.gsub(/\r\n|\r|\n/, ",")
  end
  def star
    star = ""
    tip_recommendation.rate.times do
      star += "⭐️"
    end
    star
  end
end
