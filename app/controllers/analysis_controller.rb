class AnalysisController < ApplicationController
  before_action :login_required
  include ChartUtil
  def dash_bord
    #chart
    @_class = "col-xs-12 col-sm-12 col-md-6 col-lg-6"
    @gym_chart = self.gym_chart
    @diet_chart = self.diet_chart
    @weight_chart = self.weight_chart
    @health_hour_chart = self.health_hour_chart
    @health_water_chart = self.health_water_chart
    @health_feel_chart = self.health_feel_chart
    @size_chart = self.size_chart
  end
  def health
    @chart = self.health_hour_chart
    render :index
  end
  def water
    @chart = self.health_water_chart
    render :index
  end
  def feel
    @chart = self.health_feel_chart
    render :index
  end
  def weight
    @chart = self.weight_chart
    render :index
  end
  def gym
    @chart = self.gym_chart
    render :index
  end
  def size
    @chart = self.size_chart
    render :index
  end
  def diet
    @chart = self.diet_chart
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
    pages = pages.where("body_size_bust is not null" ).order(:date)
    dates = []
    bust_data=[]
    waist_data=[]
    hip_data = []
    neck_data=[]
    arm_data=[]
    leg_data=[]
    calf_data = []
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
      f.series(name: "バスト[cm]" ,data: bust_data )
      f.series(name: "ウェイスト[cm]" ,data: waist_data )
      f.series(name: "ヒップ[cm]" ,data: hip_data )
      f.series(name: "首[cm]" ,data: neck_data )
      f.series(name: "腕[cm]" ,data: arm_data )
      f.series(name: "脚[cm]" ,data: leg_data )
      f.series(name: "ふくらはぎ[cm]" ,data: calf_data )
      f.chart(type: "bar")
      f.options[:plotOptions] = { area: { stacking: 'normal'} }
    end
  end
  def health_feel_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    pages = pages.where("condition_id is not null
                        and feeling_id is not null").order(:date)
    dates = []
    condition_data = []
    feeling_data = []
    pages.feel_include.each do |page|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      dates << label +
               page.sleep_time.strftime("[%H:%M]")
      condition_data << page.condition.score.to_f
      feeling_data << page.feeling.score.to_f
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
    pages = pages.where("water > 0").order(:date) #過去データ出したくないだけなので
    dates = []
    sleep_data = []
    training_data = []
    work_data = []
    study_data = []
    tv_data = []
    pages.each do |page|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      dates << label +
               page.sleep_time.strftime("[%H:%M]")
      sleep_data << page.sleep_hour.to_f
      training_data << page.training_hour.to_f
      work_data << page.work_hour.to_f
      study_data << page.study_hour.to_f
      tv_data << page.tv_hour.to_f
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
    pages = pages.where("water > 0").order(:date) #過去データ出したくないだけなので
    dates = []
    water_data = []
    caffe_data = []
    alcohol_data = []
    pages.each do |page|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      dates << label
      water_data << page.water.to_f
      caffe_data << page.caffeine.to_f
      alcohol_data << page.alcohol.to_f
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
  def diet_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    pages = pages.where("protein_1 > 0").order(:date)
    dates = []
    protein_data = []
    fat_data = []
    carbohydrate_data = []
    vegetable_data = []
    pages.each do |page|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      if page.wight.to_f > 0
        label += "[" + page.wight.to_s + "kg]"
      end
      if page.training_hour.to_f > 0
        label = "*" + label + "*" #training day **
      end
      dates << label     #カロリー換算
      protein_data << page.protein_sum * 4
      fat_data  << page.fat_sum * 9
      carbohydrate_data << page.carbohydrate_sum * 4
      vegetable_data << page.vegetable_sum * 5
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
  def weight_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    pages = pages.where("wight > 0").order(:date) #過去データ出したくないだけなので
    dates = []
    weight_data = []
    body_fat_per_data = []
    pages.each do |page|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      label += "["+ page.body_fat_per.to_f.to_s + "% "+ page.tortal_cal.to_s + "kcal]"
      dates << label
      weight_data << page.wight.to_f
      body_fat_per_data << page.body_fat_per.to_f
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
  def fat_chart
    x_user = params[:user_id]? params[:user_id] : current_user
    pages = Page.where("user_id=?", x_user).order(:date)
    pages = pages.where("body_fat_per > 0").order(:date) #過去データ出したくないだけなので
    dates = []
    body_fat_per_data = []
    pages.each do |page|
      label = page.date.strftime("%m/%d(#{%w(日 月 火 水 木 金 土)[page.date.wday]})")
      label += "["+ page.body_fat_per.to_f.to_s + "% "+ page.tortal_cal.to_s + "kcal]"
      dates << label
      body_fat_per_data << page.body_fat_per.to_f
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '体脂肪の推移')
      f.xAxis(categories: dates)
#      f.yAxis(min:10.0)
      f.series(name: "体脂肪[%]" ,data: body_fat_per_data)
      f.chart(type: "line")
      f.options[:plotOptions] = { area: {stacking: 'normal'} }
    end
  end
  def home
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
  def pie_parts
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_parts , type: 'pie')
    end
    render :index
  end
  def pie_place
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング場所別バランス')
      f.series(name: 'レップス',
               data: pie_chart_data_place , type: 'pie')
    end
    render :index
  end
  def index
#    @chart = LazyHighCharts::HighChart.new('graph')
    self.gym
  end
end
