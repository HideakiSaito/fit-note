module ChartUtil
  @@pages = nil
  #初期化して使い回す。
  def analysis_initialize(search_key)
   @@pages = analysis_pages(search_key)
  end
  def analysis_pages(search_key)
    #ここは検索 条件つける
    Page.order(:date) 
  end
  def chart_dates
    dates = @@pages.map do |page|
      page.date.strftime("%y/%m/%d(%a)") + "[" + page.place + "]"
    end
  end
  def chart_data(key)
    data = @@pages.map do |page|
      line = page.lines.where(item_id: key).first
      if line != nil
        line.this_max_reps.to_i
      else
        0
      end
    end
  end
end
