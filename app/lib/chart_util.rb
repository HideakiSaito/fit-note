module ChartUtil
  def analysis_initialize(search_key)
   #必ずこのメソッドを呼んで初期化してから使い回す。
   @@pages = analysis_pages(search_key)
  end
  def analysis_pages(search_key)
    targets = Page.order(:date) 
    targets.where(place: search_key) if search_key.presence #場所条件を追加
  end
  def chart_dates
    @@pages.map do |page|
      page.date.strftime("%y/%m/%d(%a)") + "[" + page.place + "]" #チャートのX軸には、日付と場所
    end
  end
  def chart_data(key)
     @@pages.map do |page|
      target = page.lines.where(item_id: key).first #dataは複数形、datumが単数形
      target.this_max_reps.to_i #nil.to_i => 0 を利用 return省略がruby流 
    end
  end
end
