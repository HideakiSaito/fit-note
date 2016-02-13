module ChartUtil
  def analysis_initialize(target_place)
   #必ずこのメソッドを呼んで初期化してから使い回す。
   @@pages = analysis_pages(target_place)
  end
  def analysis_pages(target_place)
    targets = Page.order(:date) 
    targets.where(place: target_place) if target_place.presence #場所条件を追加
  end
  def chart_dates
    @@pages.map do |page|
      page.date.strftime("%y/%m/%d(%a)") + "[" + page.place + "]" #チャートのX軸には、日付と場所
    end
  end
  def chart_data(target_item)
     @@pages.map do |page|
      target = page.lines.where(item_id: target_item).first #dataは複数形、datumが単数形
      target.this_max_reps.to_i #nil.to_i => 0 を利用 return省略がruby流 
    end
  end
end
