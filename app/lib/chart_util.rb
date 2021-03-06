module ChartUtil
  def analysis_initialize(target_place)
    #必ずこのメソッドを呼んで初期化してから使い回す。
    @@pages = analysis_pages(target_place)
  end
  def analysis_pages(target_place)
    #ここを１週間単位
    x_user = params[:user_id]? params[:user_id] : current_user
    targets = Page.where("user_id=?", x_user).order(:date)
    targets = targets.where(place: target_place) if target_place.presence #場所条件を追加
    start_day = params[:start_day] 
    end_day = params[:end_day] 
    targets = targets.where("date >= ? and date <= ?", start_day, end_day)
    targets
  end
  def chart_dates
    #ここを１週間単位
    dates = []
    last_week = ""
    @@pages.map do |page|
      this_week = page.yweek
      dates << page.mweek  if this_week != last_week
      last_week = this_week
    end
    dates
  end
  def chart_data(target_item)
    #ここを１週間単位
    powers = []
    max_power = 0.0
    this_power = 0.0
    last_power = 0.0
    last_week = ""
    @@pages.map do |page|
      this_week = page.yweek
      target = page.lines.where(item_id: target_item).first
      this_power = target.presence ? target.this_max_reps.to_f : last_power
      if this_power >= max_power
        max_power = this_power
      end
      #debug
#      p  page.yweek + ":this" + this_power.to_s + ":max" + max_power.to_s
      if this_week != last_week
        powers << this_power
        last_power = this_power
        max_power = 0.0 #同一週で最大筋力を求めたいのでリセット
      else
        this_week_power = max_power
        this_week_power = last_power if max_power == 0.0 #今回情報がない時は、前回の情報をセットする(比較演算子を勘違い
        this_week_power = this_power if this_power #前回の記録よく下がることを考慮
        powers[-1] = this_week_power #-配列指定は最後から数える
      end
        last_power = this_power
        last_week = this_week
    end
    powers
  end
#page_controller kara
  def day_training_chart(page)
     LazyHighCharts::HighChart.new('graph') do |f|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      f.title(text: label + ' 部位別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_parts(page.id) , type: 'pie')
     end
  end
  def day_diet_chart(page)
     LazyHighCharts::HighChart.new('graph') do |f|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      f.title(text: label + ' 食事 ' + page.tortal_cal.to_s + "kcal")
      f.series(name: 'グラム',
               data: pie_chart_data_diet(page.id) , type: 'pie')
     end
  end
  def day_health_chart(page)
     LazyHighCharts::HighChart.new('graph') do |f|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      f.title(text: label + ' 健康,休養 :睡眠 ' + page.sleep_hour.to_s + "[h]" )
      f.xAxis(categories: ["睡眠","トレ","勉強","TV","仕事"])
      f.series(name: '[h]',
               data: [page.sleep_hour,
                      page.training_hour,
                      page.study_hour,
                      page.tv_hour,
                      page.work_hour] )
      f.chart(type: "bar")
      f.options[:plotOptions] = {bar: {stacking: 'normal'} }
     end
  end
  def day_water_chart(page)
     LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: page.date.strftime("%Y/%m/%d(%a)") + ' 健康,水分、etc :水分 ' + page.water.to_s + "[ml]" )
      f.xAxis(categories: ["水分","カフェイン","アルコール"])
      f.series(name: '[ml]',
               data: [page.water,
                      page.caffeine,
                      page.alcohol ] )
      f.chart(type: "bar")
      f.options[:plotOptions] = {bar: {stacking: 'normal'} }
     end
  end
  def pie_chart_data_diet( page_id = nil )
    data = []
    page = Page.find page_id
    data << ["たんぱく質",page.protein_sum]
    data << ["脂肪",page.fat_sum]
    data << ["炭水化物",page.carbohydrate_sum]
    data << ["野菜",page.vegetable_sum]
  end
  def pie_chart_data_place
    start_day = params[:start_day] != ""? params[:start_day] : Date.current - 30*7
    start_day ||= Date.current - 30*7
    end_day = params[:end_day] != "" ? params[:end_day] : Date.current
    end_day ||= Date.current 
    data = []
    places = %W(ジム 家) # %Wで["hoge","fuga"]を省略
    places.each do |place|
      lines = Line.joins(:page).where(pages: { place: place })
      lines = lines.where("pages.date >= '#{start_day}' and pages.date <= '#{end_day}' " )
      value = lines.collect do |i| i.get_sum_reps end.sum
      data << [place,value.to_i]
    end
    data
  end
  def pie_chart_data_parts( page_id = nil )
    data = []
    parts = Part.order(:id)
    parts.each do |part|
#      lines = Line.joins(:item).where(items: { part_id: part.id })
      lines = Line.joins(:page).joins(:item).where(items: { part_id: part.id })
      if page_id.presence
        lines = lines.where(page_id: page_id) 
      else
        start_day = params[:start_day] != ""? params[:start_day] : Date.current - 30*7
        start_day ||= Date.current - 30*7
        end_day = params[:end_day] != "" ? params[:end_day] : Date.current
        end_day ||= Date.current 
        lines = lines.where("pages.date >= '#{start_day}' and pages.date <= '#{end_day}' " )
      end
      value = lines.collect do |i| i.get_sum_reps end.sum
      data << [part.name,value.to_i] if value.to_i > 0
    end
    data
  end
end
