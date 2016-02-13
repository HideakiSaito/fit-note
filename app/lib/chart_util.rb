module ChartUtil
  @@pages = nil
  #初期化して使い回す。
  def analysis_initialize(search_key)
   @@pages = analysis_pages(search_key)
  end
  def analysis_pages(search_key)
    targets = Page.order(:date) 
    targets.where(place: search_key) if search_key.presence #場所条件を追加
  end
  def chart_dates
    dates = @@pages.map do |page|
      page.date.strftime("%y/%m/%d(%a)") + "[" + page.place + "]"
    end
  end
  def chart_data(key)
    data = @@pages.map do |page|
      line = page.lines.where(item_id: key).first
      datum =  line.this_max_reps.to_i #nil.to_i => 0 を利用 
    end
  end
end
