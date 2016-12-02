class AnalysisController < ApplicationController
  before_action :login_required
  before_action :init
  include ChartUtil
  include CalenderUtil
  def dash_bord
    params[:start_day] = Date.current - 35
    params[:end_day] = Date.current
    #chart
    @_class = "col-xs-12 col-sm-12 col-md-6 col-lg-6"
    @gym_chart = self.gym_chart
    @diet_chart = self.diet_chart
    @weight_chart = self.weight_chart
    @health_hour_chart = self.health_hour_chart
    @health_water_chart = self.health_water_chart
    @health_feel_chart = self.health_feel_chart
    @size_chart = self.size_chart
    @parts_chart = self.pie_parts_chart
  end
  def health
     params[:start_day] ||= Date.current - 30*7
     params[:end_day] ||= Date.current
     params[:scope] ||= "week"
     #@scop_day_label = ""
     #@scop_week_label = "1週間"
    @chart = self.health_hour_chart
    render :index
  end
  def water
     params[:start_day] ||= Date.current - 30*7
     params[:end_day] ||= Date.current
     params[:scope] ||= "week"
     #@scop_day_label = ""
     #@scop_week_label = "1週間"
    @chart = self.health_water_chart
    render :index
  end
  def feel
     params[:start_day] ||= Date.current - 30*7
     params[:end_day] ||= Date.current
     params[:scope] ||= "week"
     #@scop_day_label = ""
     #@scop_week_label = "1週間"
    @chart = self.health_feel_chart
    render :index
  end
  def weight
     params[:start_day] = Date.current - 30*7
     params[:end_day] = Date.current
     params[:scope] ||= "week"
     #@scop_day_label = ""
     #@scop_week_label = "1週間"
    @chart = self.weight_chart "all"
    render :index
  end
  def weight_recent
     params[:start_day] ||= Date.current - 30
     params[:end_day] ||= Date.current
     params[:scope] ||= "day"
     #@scop_day_label = ""
     #@scop_week_label = "1週間"
    @chart = self.weight_chart "recent"
    render :index
  end
  def gym
     params[:start_day] ||= Date.current - 30*7
     params[:end_day] ||= Date.current
     params[:scope] ||= "week"
    @scop_day_label = ""
    @scop_week_label = "1週間"
    @chart = self.gym_chart
    render :index
  end
  def size
    params[:start_day] ||= Date.current - 30*7
    params[:end_day] ||= Date.current
    params[:scope] ||= "week"
    @scop_day_label = "全て"
    @scop_week_label = "最初 & 最近"
    @chart = self.size_chart
    render :index
  end
  def diet
    params[:start_day] ||= Date.current - 30*7
    params[:end_day] ||= Date.current
     params[:scope] ||= "week"
     #@scop_day_label = ""
     #@scop_week_label = "1週間"
    @chart = self.diet_chart "all"
    render :index
  end
  def diet_recent
     params[:start_day] ||= Date.current - 30
     params[:end_day] ||= Date.current
     params[:scope] ||= "day"
     #@scop_day_label = ""
     #@scop_week_label = "1週間"
    @chart = self.diet_chart "recent"
    render :index
  end
  def pie_parts
    params[:start_day] ||= Date.current - 30*7
    params[:end_day] ||= Date.current
    @scop_day_label = ""
    @scop_week_label = ""
    @chart = pie_parts_chart
    render :index
  end
  def pie_place
    params[:start_day] ||= Date.current - 30*7
    params[:end_day] ||= Date.current
    @scop_day_label = ""
    @scop_week_label = ""
    @chart = pie_place_chart
    render :index
  end
  def gym_chart
    #Big3 items id
    push_id = [1]
    pull_id = [4,18]
    leg_id = [9] #19
    analysis_initialize("ジム")#ChartUtilを利用
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'ジムでのトレーニング推移')
      f.xAxis(categories: chart_dates)
      f.series(name: 'Push:ベンチプレス[kg]', data: chart_data(push_id))
      f.series(name: 'Pull:デッドリフト[kg]', data: chart_data(pull_id))
      f.series(name: 'Leg:フルスクワット[kg]', data: chart_data(leg_id))
    end
  end
  def size_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    where = search_params_where
    pages = pages.where("body_size_bust is not null #{where}" ).order(:date)
    dates = []
    bust_data=[]
    waist_data=[]
    hip_data = []
    neck_data=[]
    arm_data=[]
    leg_data=[]
    calf_data = []
    
    if params[:scope] == "week"
      temp = pages
      pages = []
      pages << temp.first 
      pages << temp.last
    end
    pages.each do |page|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      dates << label
      bust_data << page.body_size_bust.to_f
      waist_data << page.body_size_waist.to_f
      hip_data << page.body_size_hip.to_f
      neck_data << page.body_size_neck.to_f
      arm_data << (page.body_size_arm_left.to_f + page.body_size_arm_right.to_f)/2
      leg_data << (page.body_size_leg_left.to_f + page.body_size_leg_right.to_f)/2
      calf_data << (page.body_size_calf_left.to_f + page.body_size_calf_right.to_f)/2
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'サイズの推移')
      f.xAxis(categories: dates)
      f.series(name: "ふくらはぎ[cm]" ,data: calf_data )
      f.series(name: "脚[cm]" ,data: leg_data )
      f.series(name: "ヒップ[cm]" ,data: hip_data )
      f.series(name: "ウェイスト[cm]" ,data: waist_data )
      f.series(name: "腕[cm]" ,data: arm_data )
      f.series(name: "バスト[cm]" ,data: bust_data )
      f.series(name: "首[cm]" ,data: neck_data )
      f.chart(type: "bar")
      f.options[:plotOptions] = { area: { stacking: 'normal'} }
    end
  end
  def health_feel_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    where = search_params_where
    pages = pages.where("condition_id is not null
                        and feeling_id is not null #{where}").order(:date)
    dates = []
    condition_data = []
    feeling_data = []
    if params[:scope] == "week"
      #時間は合計がわかりやすいと思うので
      sql = "select to_char(date,'YY/WW') as week, 
             sum(t2.score) as condition,
             sum(t3.score ) as feeling 
             from pages t1
             left join conditions t2
             on t1.condition_id= t2.id
             left join feelings t3
             on t1.feeling_id = t3.id
             where true and wight > 0 #{where}
             group by to_char(date,'YY/WW') 
             order by to_char(date,'YY/WW')"
      pages = Page.find_by_sql(sql).map(&:attributes)
      pages.each { |page| 
        dates << yw_to_date(page["week"])
        condition_data << page["condition"]
        feeling_data << page["feeling"]
      }
    else
      pages.feel_include.each do |page|
        label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
        dates << label + page.sleep_time.strftime("[%H:%M]")
        condition_data << page.condition.score.to_f
        feeling_data << page.feeling.score.to_f
      end
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '体調、気分の推移')
      f.xAxis(categories: dates)
      f.series(name: "体調[点]" ,data: condition_data )
      f.series(name: "気分[点]" ,data: feeling_data)
      f.chart(type: "area")
      f.options[:plotOptions] = { area: { stacking: 'normal'} }
    end
  end
  def health_hour_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    where = search_params_where
    pages = pages.where("water > 0 #{where}").order(:date) #過去データ出したくないだけなので
    dates = []
    sleep_data = []
    training_data = []
    work_data = []
    study_data = []
    tv_data = []
    if params[:scope] == "week"
      #時間は合計がわかりやすいと思うので
      sql = "select to_char(date,'YY/WW') as week, 
             sum(sleep_hour) as sleep_hour,
             sum(work_hour) as work_hour,
             sum(study_hour) as study_hour,
             sum(tv_hour) as tv_hour,
             sum(training_hour) as training_hour
             from pages 
             where true and wight > 0 #{where}
             group by to_char(date,'YY/WW') 
             order by to_char(date,'YY/WW')"
      pages = Page.find_by_sql(sql).map(&:attributes)
      pages.each { |page| 
        dates << yw_to_date(page["week"])
        sleep_data << page["sleep_hour"]
        training_data << page["training_hour"]
        work_data << page["work_hour"]
        study_data << page["study_hour"]
        tv_data << page["tv_hour"]
      }
    else
      pages.each do |page|
        label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
        dates << label 
        sleep_data << page.sleep_hour.to_f
        training_data << page.training_hour.to_f
        work_data << page.work_hour.to_f
        study_data << page.study_hour.to_f
        tv_data << page.tv_hour.to_f
      end
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '健康、休養 [時間]の推移')
      f.xAxis(categories: dates)
      f.series(name: "トレーニング[h]" ,data: training_data,type: "column" )
      f.series(name: "仕事[h]" ,data: work_data,type: "column" )
      f.series(name: "勉強[h]" ,data: study_data )
      f.series(name: "TV[h]" ,data: tv_data )
      f.series(name: '睡眠[h]', data: sleep_data)
      f.chart(type: "area")
      f.options[:plotOptions] = { area: { stacking: 'normal'} }
    end
  end
  def health_water_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    where = search_params_where
    pages = pages.where("water > 0 #{where}").order(:date) #過去データ出したくないだけなので
    dates = []
    water_data = []
    caffe_data = []
    alcohol_data = []
    if params[:scope] == "week"
      #時間は合計がわかりやすいと思うので
      sql = "select to_char(date,'YY/WW') as week, 
             sum(water) as water,
             sum(caffeine) as caffeine,
             sum(alcohol) as alcohol
             from pages 
             where true and wight > 0 #{where}
             group by to_char(date,'YY/WW') 
             order by to_char(date,'YY/WW')"
      pages = Page.find_by_sql(sql).map(&:attributes)
      pages.each { |page| 
        dates << yw_to_date(page["week"])
        water_data << page["water"]
        caffe_data << page["caffeine"]
        alcohol_data << page["alcohol"]
      }
    else
      pages.each do |page|
        label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
        dates << label
        water_data << page.water.to_f
        caffe_data << page.caffeine.to_f
        alcohol_data << page.alcohol.to_f
      end
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '健康、休養 [水分]の推移')
      f.xAxis(categories: dates)
      f.series(name: "アルコール[g]" ,data: alcohol_data)
      f.series(name: "コーヒー[g]" ,data: caffe_data )
      f.series(name: "水[g]" ,data: water_data )
      f.chart(type: "column")
      f.options[:plotOptions] = { column: {stacking: 'normal'} }
    end
  end
  def diet_chart(chart_type = "all")
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    if chart_type == "recent"
      pages = Page.where("date >= ?", Date.current - 28)
    end
    dates = []
    protein_data = []
    fat_data = []
    carbohydrate_data = []
    vegetable_data = []
    where = search_params_where
    if params[:scope] == "week"
      sql = "select 
      to_char(date,'YY/WW') as week, 
      avg( COALESCE(protein_1,0) + COALESCE(protein_2,0) + 
           COALESCE(protein_3,0) + COALESCE(protein_4,0) + COALESCE(protein_5,0) ) as protein,
      avg( COALESCE(fat_1,0) + COALESCE(fat_2,0) + 
           COALESCE(fat_3,0) + COALESCE(fat_4,0) + COALESCE(fat_5,0) ) as fat,
      avg( COALESCE(carbohydrate_1,0) + COALESCE(carbohydrate_2,0) + 
           COALESCE(carbohydrate_3,0) + COALESCE(carbohydrate_4,0) + COALESCE(carbohydrate_5,0) ) as carbohydrate,
      avg( COALESCE(vegetable_1,0) + COALESCE(vegetable_2,0) + 
           COALESCE(vegetable_3,0) + COALESCE(vegetable_4,0) + COALESCE(vegetable_5,0) ) as vegetable 
      from pages 
      where true and wight > 0 #{where}
      group by to_char(date,'YY/WW') 
      order by to_char(date,'YY/WW')"
      pages = Page.find_by_sql(sql).map(&:attributes)
      pages.each { |page| 
        dates << yw_to_date(page["week"])
        protein_data << page["protein"] * 4
        fat_data  << page["fat"] * 9
        carbohydrate_data << page["carbohydrate"] * 4
        vegetable_data << page["vegetable"] * 5
      }
    else
      pages = pages.where("protein_1 > 0 #{where}").order(:date) #過去データ出したくないだけなので
      pages.each do |page|
        label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
        dates << label     #カロリー換算
        protein_data << page.protein_sum * 4
        fat_data  << page.fat_sum * 9
        carbohydrate_data << page.carbohydrate_sum * 4
        vegetable_data << page.vegetable_sum * 5
      end
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '食事のバランス推移')
      f.xAxis(categories: dates)
      f.series(name: "野菜[/5g]" ,data: vegetable_data ,type: "column")
      f.series(name: '炭水化物[kca]l', data: carbohydrate_data )
      f.series(name: '脂肪[kcal]', data: fat_data)
      f.series(name: 'たんぱく質[kcal]', data: protein_data)
      f.chart(type: "area")
      f.options[:plotOptions] = { area: { stacking: 'normal'} }
    end
  end
  def weight_chart(chart_type = "all")
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    if chart_type == "recent"
      pages = Page.where("date >= ?", Date.current - 28)
    end
    dates = []
    weight_data = []
    body_fat_per_data = []
    where = search_params_where
    if params[:scope] == "week"
      sql = " select 
      to_char(date,'YY/WW') as week ,
      avg(wight) as weight,
      avg(body_fat_per) as fat 
      from pages
      where true and wight > 0 #{where} 
      group by to_char(date,'YY/WW') 
      order by to_char(date,'YY/WW') "
      pages = Page.find_by_sql(sql).map(&:attributes)
      pages.each { |page| 
        dates << yw_to_date(page["week"])
        weight_data << page["weight"]  
        body_fat_per_data << page["fat"]  
      }
    else
      pages = pages.where("wight > 0 #{where}").order(:date) #過去データ出したくないだけなので
      pages.each do |page|
        label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
        dates << label
        weight_data << page.wight.to_f
        body_fat_per_data << page.body_fat_per.to_f
      end
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '体重,体脂肪の推移')
      f.xAxis(categories: dates,title:"日付")
      f.yAxis([ {title: "b" , opposite: true},{title: "a"} ] )
      f.series(name: "体脂肪[%]" ,data: body_fat_per_data,yAxis: 0)
      f.series(name: "体重[kg]" ,data: weight_data,yAxis: 1)
      f.chart(type: "line")
#      f.options[:plotOptions] = { area: {stacking: 'normal'}
    end
  end
  def home
    params[:scope] ||= "week"
    @scop_day_label = ""
    @scop_week_label = "1週間"
    #Big3 items id
    push_id = [1]
    pull_id = [8] #ワンハンドローイングで
    leg_id = [9,10]
    analysis_initialize("家") #ChartUtil
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '家でのトレーニング推移')
      f.xAxis(categories: chart_dates)
      f.series(name: 'Push:ダンベルプレス[kg]', data: chart_data(push_id))
      f.series(name: 'Pull:ワンハンドロー[kg]', data: chart_data(pull_id))
      f.series(name: 'Leg:ダンベルスクワット[kg]', data: chart_data(leg_id))
    end
    render :index
  end
  def pie_parts_chart
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_parts , type: 'pie')
    end
  end
  def pie_place_chart
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング場所別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_place , type: 'pie')
    end
  end
  def index
    self.gym
  end
  private
  def yw_to_date(yw)
    y = yw.slice(0,2)
    year = 2000 + y.to_i
    w = yw.slice(3,2)
    day = (w.to_i - 1) * 7
    date = Date.new(year, 1, 1) + day
    disp_mweek date
  end
  def init
   @scop_day_label = "1日"
   @scop_week_label = "1週間"
  end
  def search_params_where
    start_day = params[:start_day] != ""? params[:start_day] : Date.current - 30*7
    start_day ||= Date.current - 30*7
    end_day = params[:end_day] != "" ? params[:end_day] : Date.current
    end_day ||= Date.current 
    where = "and date >= '#{start_day}' and date <= '#{end_day}' "
  end
end
