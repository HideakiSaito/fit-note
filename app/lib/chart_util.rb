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
  def pie_chart_data_place
    data = []
    places = %W(ジム 家) # %Wで["hoge","fuga"]を省略
    places.each do |place|
      lines = Line.joins(:page).where(pages: { place: place })
      value = lines.collect do |i| i.get_sum_reps end.sum
      data << [place,value.to_i]
    end
    data
  end
  def pie_chart_data_parts( page_id = nil )
    data = []
    parts = Part.order(:id)
    parts.each do |part|
      lines = Line.joins(:item).where(items: { part_id: part.id })
      lines = lines.where(page_id: page_id) if page_id.presence
      value = lines.collect do |i| i.get_sum_reps end.sum
      data << [part.name,value.to_i] if value.to_i > 0
    end
    data
  end
end
