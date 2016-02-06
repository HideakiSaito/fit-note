class AnalysisController < ApplicationController
  include ChartUtil
  def index
    #Big3 items id
    push_id = [1,2]
    pull_id = [4,18,5,6]
    leg_id = [9,10]
    #ChartUtil
    analysis_initialize("ジム")
    @graph_gym = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'ジムでのトレーニング推移')
      f.xAxis(categories: chart_dates)
      f.series(name: 'Push', data: chart_data(push_id))
      f.series(name: 'Pull', data: chart_data(pull_id))
      f.series(name: 'Leg', data: chart_data(leg_id))
    end
    #ChartUtil
    analysis_initialize("家")
    @graph_home = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '家でのトレーニング推移')
      f.xAxis(categories: chart_dates)
      f.series(name: 'Push', data: chart_data(push_id))
      f.series(name: 'Pull', data: chart_data(pull_id))
      f.series(name: 'Leg', data: chart_data(leg_id))
    end
    #円のパターン
    data = [['Push', 45.0],['Pull', 55.0],['Leg',30.0]]
    @graph_pie = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'トレーニング部位別バランス')
      f.series(name: 'レップス', data: data, type: 'pie')
    end
  end
end
