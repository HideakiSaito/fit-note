class AnalysisController < ApplicationController
  include ChartUtil
  def dash_bord
    #chart
    @gym_chart = self.gym_chart
    @diet_chart = self.diet_chart
    #latest_page
    @page_class = "" 
    latest_date = Page.maximum(:date) #最新日
    if latest_date 
    @latest_page = Page.where(date: latest_date).first 
    else
     @latest_page = Page.new(date: Time.current,place: "none")
    end
    @chart_pie_parts_index = {}
    @chart_pie_diets_index = {}
    @chart_pie_parts_index[@latest_page.id] = day_training_chart(@latest_page)
    @chart_pie_diets_index[@latest_page.id] = day_diet_chart(@latest_page)
  end
  def health
    @chart = self.health_hour_chart
    @chart2 = self.health_water_chart
    @chart3 = self.health_feel_chart
    render :index
  end
  def gym
    @chart = self.gym_chart
    render :index
  end
  def diet
    @chart = self.diet_chart
    render :index
  end
  def gym_chart
    #Big3 items id
    push_id = [1,2]
    pull_id = [4,18,5,6]
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

  def health_feel_chart
    pages = Page.where("condition_id is not null
                        and feeling_id is not null").order(:date)
    dates = []
    condition_data = []
    feeling_data = []
    pages.each do |page|
      dates << page.date.strftime("%y/%m/%d(%a)") + 
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
    pages = Page.where("sleep_hour > 0").order(:date)
    dates = []
    sleep_data = []
    work_data = []
    study_data = []
    tv_data = []
    pages.each do |page|
      dates << page.date.strftime("%y/%m/%d(%a)") + 
               page.sleep_time.strftime("[%H:%M]")
      sleep_data << page.sleep_hour.to_f
      work_data << page.work_hour.to_f
      study_data << page.study_hour.to_f
      tv_data << page.tv_hour.to_f
    end
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '健康、休養 [時間]の推移')
      f.xAxis(categories: dates)
      f.series(name: "仕事[h]" ,data: work_data,type: "column" )
      f.series(name: "勉強[h]" ,data: study_data )
      f.series(name: "TV[h]" ,data: tv_data )
      f.series(name: '睡眠[h]', data: sleep_data)
      f.chart(type: "area")
      f.options[:plotOptions] = { area: { stacking: 'normal'} }
    end
  end
  def health_water_chart
    pages = Page.where("sleep_hour > 0").order(:date)
    dates = []
    water_data = []
    caffe_data = []
    alcohol_data = []
    pages.each do |page|
      dates << page.date.strftime("%y/%m/%d(%a)") + 
               page.sleep_time.strftime("[%H:%M]")
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
    pages = Page.where("protein_1 > 0").order(:date)
    dates = []
    protein_data = []
    fat_data = []
    carbohydrate_data = []
    vegetable_data = []
    pages.each do |page|
      dates << page.date.strftime("%y/%m/%d(%a)") 
      #カロリー換算
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
  def home
    #Big3 items id
    push_id = [1,2]
    pull_id = [8,5,6] #ワンハンドローイングで
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
