module ChartUtil
  def analysis_initialize(target_place)
    #必ずこのメソッドを呼んで初期化してから使い回す。
    @@pages = analysis_pages(target_place)
  end
  def analysis_pages(target_place)
    #ここを１週間単位
    targets = Page.order(:date) 
    targets.where(place: target_place) if target_place.presence #場所条件を追加
  end
  def chart_dates
    #ここを１週間単位
    dates = []
    last_week = ""
    @@pages.map do |page|
      #page.date.strftime("%y/%m/%d(%a)") + "[" + page.place + "]" #チャートのX軸には、日付と場所
      this_week = page.date.strftime("%W")
      disp_date = self.mweek(page.date)
      dates << disp_date[:month].to_s + "月" + disp_date[:week].to_s + "週"  if this_week != last_week
      last_week = this_week
    end
    dates
  end
  def chart_data(target_item)
    #ここを１週間単位
    data = []
    max_datum = 0
    last_datum = 0
    last_week = ""
    @@pages.map do |page|
      this_week = page.date.strftime("%W") 
      target = page.lines.where(item_id: target_item).first #dataは複数形、datumが単数形
      this_datum = target.presence ? target.this_max_reps.to_i : last_datum  #nil.to_i => 0 を利用 return省略がruby流 
      if this_datum >= max_datum 
        max_datum = this_datum
      end
      if this_week != last_week
        data << max_datum
        last_datum = this_datum
        max_datum = 0
      else
        max_datum = last_datum if max_datum = 0
        data[data.size-1] = max_datum
      end
      last_week = this_week
    end
    data
  end
#page_controller kara
  def day_training_chart(page)
     LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: page.date.strftime("%Y/%m/%d(%a)") + ' 部位別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_parts(page.id) , type: 'pie')
     end
  end
  def day_diet_chart(page)
     LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: page.date.strftime("%Y/%m/%d(%a)") + ' 食事バランス')
      f.series(name: 'グラム',
               data: pie_chart_data_diet(page.id) , type: 'pie')
     end
  end
  def pie_chart_data_diet( page_id = nil )
    data = []
    page = Page.find page_id
    data << ["炭水化物",page.carbohydrate_sum]
    data << ["脂肪",page.fat_sum]
    data << ["たんぱく質",page.protein_sum]
    data << ["野菜",page.vegetable_sum]
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
  def mweek(date)
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
