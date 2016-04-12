class AnalysisController < ApplicationController
  include ChartUtil
  def gym
    #Big3 items id
    push_id = [1,2]
    pull_id = [4,18,5,6]
    leg_id = [9] #19
    analysis_initialize("ジム")#ChartUtilを利用
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'ジムでのトレーニング推移')
      f.xAxis(categories: chart_dates)
      f.series(name: 'Push', data: chart_data(push_id))
      f.series(name: 'Pull', data: chart_data(pull_id))
      f.series(name: 'Leg', data: chart_data(leg_id))
    end
    render :index
  end
  def diet
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
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '食事のバランス推移')
      f.xAxis(categories: dates)
      f.series(name: "野菜[/5g]" ,data: vegetable_data ,type: "column")
      f.series(name: '炭水化物[kca]l', data: carbohydrate_data )
      f.series(name: '脂肪[kcal]', data: fat_data)
      f.series(name: 'たんぱく質[kcal]', data: protein_data)
      f.chart(type: "area")
      f.options[:plotOptions] = { area: { stacking: 'normal'} } 
    end
    render :index
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
      f.series(name: 'Push', data: chart_data(push_id))
      f.series(name: 'Pull', data: chart_data(pull_id))
      f.series(name: 'Leg', data: chart_data(leg_id))
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
