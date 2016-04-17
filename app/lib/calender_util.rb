module CalenderUtil
  def disp_mweek(date)
      disp_date = self.calc_mweek(date)
      disp_date[:month].to_s + "月" + disp_date[:week].to_s + "週" 
  end
  def calc_mweek(date)
    day = date - (date.cwday - 1)
    base_month = day.month
    week = 0
    (1..5).each do |index|
      day -= 7
      if base_month != day.month
        week = index
        break
      end
    end
    { :month => base_month, :week => week}
  end

end
